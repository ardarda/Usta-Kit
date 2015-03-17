//
//  DaySummaryViewController.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 17/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "DaySummaryViewController.h"
#import "DaySummaryTableViewCell.h"

@interface DaySummaryViewController ()

@end

@implementation DaySummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refreshWith:[[Context sharedContext] dateStringFrom:[NSDate date]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self refreshWith:[[Context sharedContext] dateStringFrom:[NSDate date]]];
}

- (void)refreshWith:(NSString *)dateString {
    _currentSummary = [[Context sharedContext] getDaySummaryWith:dateString];
    if (_currentSummary) {
        _tableView.hidden = NO;
        _lblToplamAmount.hidden = NO;
        _lblToplamTitle.hidden = NO;
        _lblDate.text = dateString;
        [_tableView reloadData];
    } else {
        _tableView.hidden = YES;
        _lblToplamAmount.hidden = YES;
        _lblToplamTitle.hidden = YES;
    }
}

#pragma mark - Table View Del & Dat
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _currentSummary.workerList.workers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DaySummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Day Summary Cell"];
    Worker *worker = [_currentSummary.workerList.workers objectAtIndex:indexPath.row];
    cell.lblWorkerName.text = worker.name;
    cell.lblWorkerRate.text = worker.rate.stringValue;
    return cell;
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
