//
//  ShowWorkersViewController.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 13/04/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseViewController.h"
#import "Context.h"
#import "ACFormContainerView.h"

@interface ShowWorkersViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet ACFormContainerView *formContainer;

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSMutableArray *currentWorkers; //of Worker
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (nonatomic, strong) NSString *todaysDate;
//@property (nonatomic, strong) DaySummary *daySummary;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DailyWork *dailyWork;

@end
