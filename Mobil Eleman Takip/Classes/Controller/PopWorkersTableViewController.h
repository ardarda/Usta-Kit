//
//  PopWorkersTableViewController.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 17/04/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyWork.h"
@interface PopWorkersTableViewController : UITableViewController
@property (nonatomic, strong) DailyWork *currentDailyWork;
@end
