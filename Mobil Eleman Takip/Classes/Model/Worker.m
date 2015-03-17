//
//  Worker.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 08/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "Worker.h"

@implementation Worker



- (NSArray *)datesWorked {
    if (!_datesWorked) {
        _datesWorked = [NSMutableArray array];
        return _datesWorked;
    } else
        return _datesWorked;
}

- (NSNumber *)balance
{
    float balance = 0;
    
    for (DailyWork *dailyWork in _workHistory){
        if (dailyWork.isPaid)
            
            continue;
        else
            balance += dailyWork.workRate.floatValue;
    }
    return [NSNumber numberWithFloat: balance - _advance.floatValue];
}

@end
