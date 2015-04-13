//
//  DaySummary.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 17/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "DaySummary.h"

@implementation DaySummary

-(NSArray *)dailyWorks
{
    if(!_dailyWorks) {
        _dailyWorks =  (NSArray<Optional, DailyWork> *)[NSArray array];
    }
    return _dailyWorks;
}
    
@end
