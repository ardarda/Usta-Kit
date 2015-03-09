//
//  Worker.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 08/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseData.h"

@interface Worker : BaseData

@property (nonatomic, strong) NSString<Optional> *id;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *rate; //daily
@property (nonatomic, strong) NSNumber<Optional> *advance; //avans
@property (nonatomic, strong) NSString<Optional> *phone;

@property (nonatomic, strong) NSNumber<Optional> *numberOfDaysWorked;

@end
