//
//  WorkHistoryViewController.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 23/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "WorkHistoryViewController.h"
#import "WorkHistoryTableViewCell.h"

@interface WorkHistoryViewController ()

@end

@implementation WorkHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_currentWorker) {
        _workHistory = _currentWorker.workHistory;
    }
    _lblWorkerName.text = _currentWorker.name;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Work History Cell"];
    
    cell.lblTitle.text = [_currentWorker.datesWorked objectAtIndex:indexPath.row];
    DailyWork *dailyWork = [_workHistory objectAtIndex:indexPath.row];
    
    cell.lblDetail.text = [NSString stringWithFormat:@"%@ - %@ - %@", dailyWork.workName, dailyWork.workRate, dailyWork.workNote];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _currentWorker.datesWorked.count;
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
