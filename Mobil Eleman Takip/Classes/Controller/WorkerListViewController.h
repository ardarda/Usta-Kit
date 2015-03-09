//
//  WorkerListViewController.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 09/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseViewController.h"
#import "Context.h"
#import <SWTableViewCell.h>

@interface WorkerListViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) WorkerList *workerList;
@property (nonatomic, strong) Worker *selectedWorker;
@property (nonatomic) BOOL pickForToday;
@end
