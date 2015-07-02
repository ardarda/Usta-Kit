//
//  DaySummaryViewController.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 17/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseViewController.h"
#import "ACFormContainerView.h"
#import "Context.h"
#import <FPPopover/FPPopoverController.h>

@interface DaySummaryViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate, FPPopoverControllerDelegate>

@property (nonatomic, strong) NSDate *date;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnForward;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEdıt;
@property (weak, nonatomic) IBOutlet UILabel *lblToplamTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblToplamAmount;
@property (weak, nonatomic) IBOutlet UIButton *btnPay;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet ACFormContainerView *viewFormContainer;
@property (nonatomic, strong) DaySummary *currentSummary;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
