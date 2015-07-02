//
//  DaySummaryTableViewCell.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 17/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaySummaryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblWorkName;
@property (weak, nonatomic) IBOutlet UILabel *lblWorkerNumber;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end
