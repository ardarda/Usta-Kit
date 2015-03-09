//
//  WorkerListTableViewCell.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 09/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Worker.h"
#import <SWTableViewCell/SWTableViewCell.h>
@interface WorkerListTableViewCell : SWTableViewCell

- (void)refreshWith:(Worker *)worker;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (nonatomic, strong) Worker* worker;
@end
