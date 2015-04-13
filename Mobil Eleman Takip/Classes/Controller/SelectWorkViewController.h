//
//  SelectWorkViewController.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 13/04/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseViewController.h"
#import "Context.h"

@interface SelectWorkViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) WorkList *workList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
