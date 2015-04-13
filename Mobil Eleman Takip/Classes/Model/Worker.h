//
//  Worker.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 08/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseData.h"
#import "DailyWork.h"

@protocol DailyWork;

@interface Worker : BaseData

@property (nonatomic, strong) NSString<Optional> *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *rate; //daily
@property (nonatomic, strong) NSNumber<Optional> *defaultRate; //daily
@property (nonatomic, strong) NSNumber<Optional> *advance; //avans
@property (nonatomic, strong) NSString<Optional> *phone;
@property (nonatomic, strong) NSNumber<Optional> *numberOfDaysWorked;
@property (nonatomic, strong) NSString<Optional> *notes;
@property (nonatomic, strong) NSArray<Optional> *datesWorked;
@property (nonatomic, strong) NSArray<Optional,DailyWork> *workHistory;

- (NSNumber *)balance;

//TODO:fix it
@property (nonatomic, strong) NSNumber<Optional> *isDailyWorkPaid;

@end
