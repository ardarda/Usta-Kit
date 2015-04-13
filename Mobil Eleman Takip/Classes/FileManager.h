//
//  FileManager.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 13/04/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Context.h"

@interface FileManager : NSObject

+ (instancetype)sharedManager;
- (NSArray *)fetchDailyWorkOfWorker: (Worker *)worker;
- (BOOL)updateDaySummariesWith:(NSArray *)dailyWorks;

@end
