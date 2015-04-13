//
//  DailyWork.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 17/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseData.h"
#import "WorkerList.h"

@interface DailyWork : BaseData

@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString<Optional> *date;
@property (nonatomic, strong) NSString<Optional> *notes;
@property (nonatomic, strong) WorkerList<Optional> *workerList;

@property (nonatomic, strong) NSNumber<Optional> *rate;
@property (nonatomic, strong, getter=isPaid) NSNumber<Optional> *paid;

@end
