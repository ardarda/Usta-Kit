//
//  EditDaySummaryViewController.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 13/04/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseViewController.h"
#import "DaySummary.h"
#import "Context.h"

@interface EditDaySummaryViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectWork;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) DaySummary *currentDaySummary;

@end
