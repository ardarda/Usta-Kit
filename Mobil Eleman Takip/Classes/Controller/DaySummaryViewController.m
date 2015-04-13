//
//  DaySummaryViewController.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 17/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "DaySummaryViewController.h"
#import "DaySummaryTableViewCell.h"
#import "MainViewController.h"

@interface DaySummaryViewController ()

@end

@implementation DaySummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
    [self refreshWith:[[Context sharedContext] dateStringFrom:[NSDate date]]];
    if (!_date)
        _date = [NSDate date];
    self.title = @"Gun Ozetleri";
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didDateChange:(UIDatePicker *)sender {
    _date = sender.date;
    [self refresh];
}

- (void)refresh
{
    [self refreshWith:[[Context sharedContext] dateStringFrom:_date]];
}

- (void)viewWillAppear:(BOOL)animated {
    [self refreshWith:[[Context sharedContext] dateStringFrom:_date]];
}
#pragma mark - Edit
- (IBAction)editDaySummary:(id)sender {
    MainViewController *editVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Summary Edit VC"];
    editVC.date = _date;
    [self.navigationController pushViewController:editVC animated:YES];
}


- (void)refreshWith:(NSString *)dateString {
    _currentSummary = [[Context sharedContext] getDaySummaryWith:dateString];
    if (_currentSummary.workerList.workers.count > 0) {
        

        
        _tableView.hidden = NO;
//        _lblToplamAmount.hidden = NO;
//        _lblToplamTitle.hidden = NO;
        _lblDate.text = dateString;
//        [_tableView reloadData];

        
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        /*
        CATransition *animation = [CATransition animation];
        [animation setType:kCATransitionPush];
        [animation setSubtype:kCATransitionFromRight];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [animation setFillMode:kCAFillModeBackwards];
        [animation setDuration:.3];
        [[_tableView layer] addAnimation:animation forKey:@"UITableViewReloadDataAnimationKey"];
         */
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
