//
//  TodaysWorkersCollectionViewCell.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 09/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "TodaysWorkersCollectionViewCell.h"

@implementation TodaysWorkersCollectionViewCell

- (void)refreshWith:(Worker *)worker{
    _lblName.text = worker.name;
    _tfRate.text = worker.rate.stringValue;
}

@end
