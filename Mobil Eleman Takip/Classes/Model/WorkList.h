//
//  WorkList.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 13/04/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseData.h"
#import "Work.h"
@protocol Work;

@interface WorkList : BaseData

@property (nonatomic, strong) NSArray<Work> *works;

@end
