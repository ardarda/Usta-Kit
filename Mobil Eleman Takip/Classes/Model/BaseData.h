//
//  BaseData.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 08/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "ACBaseData.h"

@interface BaseData : ACBaseData

@property (nonatomic, strong) NSNumber<Optional> *Id;
@property (nonatomic, strong) NSNumber<Optional> *canDeleted;
@property (nonatomic, strong, getter=isDeleted) NSNumber<Optional> *deleted;

@end
