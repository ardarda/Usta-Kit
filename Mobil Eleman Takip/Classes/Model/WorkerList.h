//
//  WorkerList.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 08/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseData.h"
@protocol Worker;
@interface WorkerList : BaseData

@property (nonatomic, strong) NSArray<Worker> *workers;

@end
