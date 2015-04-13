//
//  DailyWork.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 17/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "DailyWork.h"

@implementation DailyWork

- (WorkerList*)workerList{
    if (!_workerList)
        _workerList = [[WorkerList alloc] init];
    return _workerList;
}

@end
