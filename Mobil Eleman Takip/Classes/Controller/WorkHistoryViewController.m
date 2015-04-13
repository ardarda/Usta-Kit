//
//  WorkHistoryViewController.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 23/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "WorkHistoryViewController.h"
#import "WorkHistoryTableViewCell.h"
#import "FileManager.h"

@interface WorkHistoryViewController ()

@end

@implementation WorkHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_currentWorker) {
        [self fetchWorkHistory];
    }
    _lblWorkerName.text = _currentWorker.name;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}


- (void)fetchWorkHistory {
    _dailyWorks = [[FileManager sharedManager] fetchDailyWorkOfWorker:_currentWorker];
    [_tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Work History Cell"];
    DailyWork *dailyWork = [_dailyWorks objectAtIndex:indexPath.row];
    NSNumber *rate;
    cell.lblTitle.text = dailyWork.date;
    for (Worker *worker in dailyWork.workerList.workers) {
        if ([worker.name isEqualToString:_currentWorker.name]) {
            rate = worker.rate;
        }
    }
    cell.lblDetail.text = [NSString stringWithFormat:@"%@ - %@", dailyWork.name, rate.stringValue];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dailyWorks.count;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
