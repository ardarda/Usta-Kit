//
//  Context.m
//  Arazi Ol 2
//
//  Created by Arda Cicek on 29/12/13.
//  Copyright (c) 2013 Arda Cicek. All rights reserved.
//

#import "Context.h"

@implementation Context

+(Context *) sharedContext
{
    static dispatch_once_t pred;
    static Context *_sharedInstance = nil;
    dispatch_once(&pred, ^{
        _sharedInstance = [[Context alloc] init];
//        BOOL didRunBefore = [[[NSUserDefaults standardUserDefaults] objectForKey:kAOUserDefaultDidRunBefore] boolValue];
//        if(!didRunBefore) [_sharedInstance setInitialValues];
//        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:kAOUserDefaultDidRunBefore];
//        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    return _sharedInstance;
}

#pragma mark - Day Summary

- (DaySummary *)getDaySummaryWith:(NSString *)dateString {
    NSString *pathComponent = [NSString stringWithFormat:@"daySummaries/%@.json",dateString];
    NSString *path = [[self getDocumentsPath] stringByAppendingPathComponent:pathComponent];
    return [self getSummaryAtPath:path];
}

- (BOOL) writeDaySummary:(DaySummary *) summary{
#warning unfinished implementation
    //    [self updateWorkers:summary];//TODO:fix it
    NSString *pathComponent = [NSString stringWithFormat:@"daySummaries/%@.json",summary.date];
    NSString *path = [[self getDocumentsPath] stringByAppendingPathComponent:pathComponent];
    return [self writeDaySummary:summary toPath:path];
}

#pragma mark - Works

- (WorkList *) getWorks{
    NSString *path = [[self getDocumentsPath] stringByAppendingPathComponent:@"works/works.json"];
    return [self getWorkListAtPath:path];
}

- (BOOL) writeWorks:(WorkList *) list{
    NSString *path = [[self getDocumentsPath] stringByAppendingPathComponent:@"works/works.json"];
    return [self writeWorkList:list toPath:path];
}

- (BOOL) addWork:(Work *) work{
    NSString *path = [[self getDocumentsPath] stringByAppendingPathComponent:@"works/works.json"];
    return [self addWork:work toListAtPath:path];
}

- (BOOL) removeWork:(Work *) work{
    NSString *path = [[self getDocumentsPath] stringByAppendingPathComponent:@"works/works.json"];
    return [self removeWork:work fromListAtPath:path];
}

#pragma mark - Workers

- (WorkerList *) getWorkers{
    NSString *path = [[self getDocumentsPath] stringByAppendingPathComponent:@"workers/workers.json"];
    return [self getListAtPath:path];
}

- (BOOL) writeWorkers:(WorkerList *) list{
    NSString *path = [[self getDocumentsPath] stringByAppendingPathComponent:@"workers/workers.json"];
    return [self writeList:list toPath:path];
}

- (BOOL) addWorker:(Worker *) worker{
    NSString *path = [[self getDocumentsPath] stringByAppendingPathComponent:@"workers/workers.json"];
    return [self addWorker:worker toListAtPath:path];
}

- (BOOL) removeWorker:(Worker *) worker{
    NSString *path = [[self getDocumentsPath] stringByAppendingPathComponent:@"workers/workers.json"];
    return [self removeWorker:worker fromListAtPath:path];
}

#pragma mark - Helpers
- (NSString *)dateStringFrom:(NSDate *)date {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    return [df stringFromDate:date];
}


/*
- (BOOL)updateWorkers:(WorkerList *)list {
    
    NSString *path = [[self getDocumentsPath] stringByAppendingPathComponent:@"workers/workers.json"];
    return [self updateList:list toPath:path];
}
*/

//update workers flow will decided, implemented later

- (BOOL)updateWorkers:(WorkerList *)workerList {

    NSString *path = [[self getDocumentsPath] stringByAppendingPathComponent:@"workers/workers.json"];
    return [self updateList:workerList toPath:path];
}




#pragma mark - Util
- (NSString *) createFileName{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM_dd_HH_mm_ss"];
    NSString *fileName = [formatter stringFromDate:[NSDate date]];
    
    NSString *path = [[self getDocumentsPath] stringByAppendingPathComponent:fileName];
    
    return path;
}
- (NSString *) getDocumentsPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}
- (NSString *) readFileAtPath:(NSString *)path{
    NSError *err = nil;
    NSString *result = [[NSString alloc] initWithContentsOfFile:path
                                                       encoding:NSUTF8StringEncoding
                                                          error:&err];
    if(err){
        //
    }
    else{
        return result;
    }
    return nil;
}
- (BOOL) writeString:(NSString *) content toFileAtPath:(NSString *) path{
    if(![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:NO]){
        NSMutableArray *paths = [[path componentsSeparatedByString:@"/"] mutableCopy];
        [paths removeLastObject];
        NSString *directoryPath = [NSString pathWithComponents:paths];
        if(![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]){
            
            [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
        
    }
    NSError *err = nil;
    BOOL success = [content writeToFile:path
                             atomically:YES
                               encoding:NSUTF8StringEncoding
                                  error:&err];
    
    if(err){
        DDLogError(@"Cannot write file to path %@ err=> %@", path, err);
    }
    
    return success;
}
#pragma mark -
- (WorkerList *) getListAtPath:(NSString *) path{
    NSString *jsonStr = [self readFileAtPath:path];
    
    if(jsonStr){
        JSONModelError *err = nil;
        WorkerList *list = [[WorkerList alloc] initWithString:jsonStr error:&err];
        if(err){
            DDLogError(@"Cannot convert to CallerList ==> %@", err);
        }
        else{
            return list;
        }
    }
    return nil;
}
- (WorkList *) getWorkListAtPath:(NSString *) path{
    NSString *jsonStr = [self readFileAtPath:path];
    
    if(jsonStr){
        JSONModelError *err = nil;
        WorkList *list = [[WorkList alloc] initWithString:jsonStr error:&err];
        if(err){
            DDLogError(@"Cannot convert to CallerList ==> %@", err);
        }
        else{
            return list;
        }
    }
    return nil;
}
- (DaySummary *) getSummaryAtPath:(NSString *) path{
    NSString *jsonStr = [self readFileAtPath:path];
    
    if(jsonStr){
        JSONModelError *err = nil;
        DaySummary *summary = [[DaySummary alloc] initWithString:jsonStr error:&err];
        if(err){
            DDLogError(@"Cannot convert to DaySummary ==> %@", err);
        }
        else{
            return summary;
        }
    }
    return nil;
}

- (BOOL) writeList:(WorkerList *) list toPath:(NSString *) path{
    NSString *jsonStr = [list toJSONString];
    BOOL success = [self writeString:jsonStr toFileAtPath:path];
    return success;
}

- (BOOL) writeWorkList:(WorkList *) list toPath:(NSString *) path{
    NSString *jsonStr = [list toJSONString];
    BOOL success = [self writeString:jsonStr toFileAtPath:path];
    return success;
}

- (BOOL) writeDaySummary:(DaySummary *) summary toPath:(NSString *) path{
    NSString *jsonStr = [summary toJSONString];
    BOOL success = [self writeString:jsonStr toFileAtPath:path];
    return success;
}

- (BOOL) updateList:(WorkerList *) list toPath:(NSString *) path{
    WorkerList *oldList = [self getListAtPath:path];
    NSMutableArray<Worker> *oldWorkers = [oldList.workers mutableCopy];

    NSUInteger count = 0;
    for (Worker *replaceWorker in oldList.workers) {
        for (Worker *updatedWorker in list.workers) {
            if ([updatedWorker.name isEqualToString:replaceWorker.name]) {
                [oldWorkers replaceObjectAtIndex:count withObject:updatedWorker];
            }
        }
        count ++;
    }

    WorkerList *newList = [[WorkerList alloc] init];
    newList.workers = [oldWorkers mutableCopy];
    return [self writeList:newList toPath:path];
    
}

- (BOOL) addWorker:(Worker *) worker toListAtPath:(NSString *) path{
    WorkerList *list = [self getListAtPath:path];
    if(list){
            list.workers = (NSArray<Worker>*)[[list.workers mutableCopy] arrayByAddingObject:worker];
            [self writeList:list toPath:path];
            return YES;
    }
    else{
        WorkerList *list = [[WorkerList alloc] init];
        list.workers = (NSArray<Worker>*)@[worker];
        BOOL success = [self writeList:list toPath:path];
        return success;
    }
}

- (BOOL) addWork:(Work *) work toListAtPath:(NSString *) path{
    WorkList *list = [self getWorkListAtPath:path];
    if(list){
        list.works = (NSArray<Work>*)[[list.works mutableCopy] arrayByAddingObject:work];
        [self writeWorkList:list toPath:path];
        
        return YES;
    } else {
        WorkList *list = [[WorkList alloc] init];
        list.works = (NSArray<Work>*)@[work];
        BOOL success = [self writeWorkList:list toPath:path];
        
        return success;
    }
}


- (Worker *) getCallerWithID:(NSString *) workerID fromArray:(NSArray *) list{
    NSArray *filteredList = [list filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"id == %@", workerID]];
    
    if(filteredList.count > 0){
        return [filteredList firstObject];
    }
    return nil;
}

- (BOOL) removeWork:(Work *) work fromListAtPath:(NSString *) path{
    WorkList *list = [self getWorkListAtPath:path];
    NSMutableArray<Work> *newWorks = [list.works mutableCopy];
    [newWorks removeObject:work];
    WorkList *newList = [[WorkList alloc] init];
    newList.works = newWorks;
    
    return [self writeWorkList:newList toPath:path];
}

- (BOOL) removeWorker:(Worker *) worker fromListAtPath:(NSString *) path{
    WorkerList *list = [self getListAtPath:path];
    NSMutableArray<Worker> *newWorkers = [list.workers mutableCopy];
    
    for (Worker *myWorker in list.workers) {
        if ([worker.name isEqualToString:myWorker.name]) {
            [newWorkers removeObject:myWorker];
        }
    }
    WorkerList *newList = [[WorkerList alloc] init];
    newList.workers = [newWorkers copy];
    
    return [self writeList:newList toPath:path];
}

@end
