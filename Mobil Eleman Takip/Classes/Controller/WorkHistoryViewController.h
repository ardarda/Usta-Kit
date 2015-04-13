//
//  WorkHistoryViewController.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 23/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseViewController.h"
#import "Context.h"

@interface WorkHistoryViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Worker *currentWorker;
@property (nonatomic, strong) NSArray *dailyWorks; //of DailyWorks of worker
@property (weak, nonatomic) IBOutlet UILabel *lblWorkerName;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
