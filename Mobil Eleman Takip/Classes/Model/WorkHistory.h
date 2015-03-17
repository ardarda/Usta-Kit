//
//  WorkHistory.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 17/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseData.h"
#import "DailyWork.h"

@protocol DailyWork;

@interface WorkHistory : BaseData

@property (nonatomic, strong) NSArray<Optional, DailyWork> *dailyWorks;

@end
