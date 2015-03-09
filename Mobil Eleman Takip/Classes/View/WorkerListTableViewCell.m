//
//  WorkerListTableViewCell.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 09/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "WorkerListTableViewCell.h"

@implementation WorkerListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshWith:(Worker *)worker {
    _worker = worker;
    _lblName.text = worker.name;
}

@end
