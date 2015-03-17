//
//  DailyWork.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 17/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseData.h"

@interface DailyWork : BaseData

@property (nonatomic, strong) NSString<Optional> *workName;
@property (nonatomic, strong) NSNumber<Optional> *workRate;
@property (nonatomic, strong) NSString<Optional> *workNote;
@property (nonatomic, strong, getter=isPaid) NSNumber<Optional> *paid;

@end
