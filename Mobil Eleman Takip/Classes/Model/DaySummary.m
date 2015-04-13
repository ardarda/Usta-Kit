//
//  DaySummary.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 17/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "DaySummary.h"

@implementation DaySummary

-(WorkerList *)workerList
{
    if(_workerList)
        return _workerList;
    else
        return [[WorkerList alloc] init];
}

@end
