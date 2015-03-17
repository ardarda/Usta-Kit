//
//  DaySummary.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 17/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseData.h"
#import "WorkerList.h"
@interface DaySummary : BaseData

@property (nonatomic, strong) WorkerList<Optional> *workerList;
@property (nonatomic, strong) NSString<Optional> *date;


@end
