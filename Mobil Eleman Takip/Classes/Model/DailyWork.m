//
//  DailyWork.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 17/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "DailyWork.h"

@implementation DailyWork

- (NSArray<Optional> *)workDates{
    if (!_workDates)
        _workDates = [NSArray array];
    return _workDates;
}

@end
