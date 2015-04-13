//
//  EditDaySummaryViewController.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 13/04/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseViewController.h"

@interface EditDaySummaryViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectWork;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@end
