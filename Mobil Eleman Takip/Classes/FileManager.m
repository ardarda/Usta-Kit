//
//  FileManager.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 13/04/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

+ (instancetype)sharedManager {
    static FileManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[FileManager alloc] init];
    });
    
    return _sharedManager;
}

- (BOOL)updateDaySummariesWith:(NSArray *)dailyWorks {
    BOOL success = YES;
    
    for (DailyWork *dailyWork in dailyWorks){
        DaySummary *daySummary = [[Context sharedContext] getDaySummaryWith:dailyWork.date];
        NSMutableArray *marray = [daySummary.dailyWorks mutableCopy];
        NSInteger counter = 0;
        for (DailyWork *theDailyWork in daySummary.dailyWorks) {
            if ([theDailyWork.name isEqualToString:dailyWork.name]){
                break;
            }
            counter++;
        }
        if (marray.count > 0) {
            [marray replaceObjectAtIndex:counter withObject:dailyWork];
        }
        daySummary.dailyWorks = [marray copy];
        success = [[Context sharedContext] writeDaySummary:daySummary];
    }
    
    return success;
}

- (NSArray *)fetchDailyWorkOfWorker: (Worker *)worker {
    NSFileManager *fileMgr;
    NSString *entry;
    NSString *documentsDir;
    NSDirectoryEnumerator *enumerator;
    BOOL isDirectory;
    
    // Create file manager
    fileMgr = [NSFileManager defaultManager];
    
    // Path to documents directory
    documentsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/daySummaries"];
    
    // Change to Documents directory
    [fileMgr changeCurrentDirectoryPath:documentsDir];
    
    // Enumerator for docs directory
    enumerator = [fileMgr enumeratorAtPath:documentsDir];
    NSMutableArray *marray = [NSMutableArray array];
    // Get each entry (file or folder)
    while ((entry = [enumerator nextObject]) != nil)
    {
        // File or directory
        if ([fileMgr fileExistsAtPath:entry isDirectory:isDirectory] && isDirectory)
            NSLog (@"Directory - %@", entry);
        else {
            JSONModelError *err = nil;

            NSString *jsonString =[[Context sharedContext] readFileAtPath:[documentsDir stringByAppendingPathComponent:entry]];
            DaySummary *daySummary = [[DaySummary alloc] initWithString:jsonString error:&err];
            if (!daySummary.dailyWorks) continue;
            for (DailyWork *dailyWork in daySummary.dailyWorks) {
                for (Worker *myWorker in dailyWork.workerList.workers) {
                    if ([myWorker.name isEqualToString:worker.name]) {
                        NSLog (@"File - %@", entry);
                        [marray addObject:dailyWork];
                    }
                }
            }

        }
    
    }
    
    
    
    return [marray copy];
}

@end
