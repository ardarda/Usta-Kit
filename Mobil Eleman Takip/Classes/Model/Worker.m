//
//  Worker.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 08/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "Worker.h"

@implementation Worker

- (NSArray *)workHistory {
    if (!_workHistory) {
        _workHistory = (NSArray<Optional, DailyWork> *)[NSArray array];
    }
    return _workHistory;
}

- (NSArray *)datesWorked {
    if (!_datesWorked) {
        _datesWorked = [NSMutableArray array];
        return _datesWorked;
    } else
        return _datesWorked;
}

- (NSNumber<Optional> *)isDailyWorkPaid {
    if (!_isDailyWorkPaid)
        _isDailyWorkPaid = [NSNumber numberWithBool:NO];
    return _isDailyWorkPaid;
}

- (NSNumber *)balance
{
    float balance = 0;
    
    for (DailyWork *dailyWork in _workHistory){
        if (dailyWork.isPaid)
            
            continue;
        else
            balance += dailyWork.rate.floatValue;
    }
    return [NSNumber numberWithFloat: balance - _advance.floatValue];
}

@end
