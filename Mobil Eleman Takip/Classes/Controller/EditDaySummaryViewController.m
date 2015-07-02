//
//  EditDaySummaryViewController.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 13/04/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "EditDaySummaryViewController.h"
#import "EditDaySummaryTableViewCell.h"
#import "ShowWorkersViewController.h"

@interface EditDaySummaryViewController ()

@end

@implementation EditDaySummaryViewController

- (DaySummary *)currentDaySummary {
    if (!_currentDaySummary)
        _currentDaySummary = [[DaySummary alloc] init];
    return _currentDaySummary;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!_date) {
        _date = [NSDate date];
    } else {
        _currentDaySummary = [[Context sharedContext] getDaySummaryWith:[self dateStringFrom:_date]];
    }
    if (!_currentDaySummary) {
        _currentDaySummary = [[DaySummary alloc] init];
        _currentDaySummary.date = [[Context sharedContext] dateStringFrom:_date];
    }
    self.title = @"Gün Özeti Düzenle";
    _lblDate.text = [self dateStringForUI:_date];
}

- (void)viewWillAppear:(BOOL)animated {
    
    if ([Context sharedContext].selecetedDailyWork) {
        [self updateDailyWork:[Context sharedContext].selecetedDailyWork];
    }
    
    Work *selectedWork = [Context sharedContext].selectedWork;
    if (selectedWork) {
        BOOL unique = YES;
        for (DailyWork *dailyWork in _currentDaySummary.dailyWorks) {
            if ([dailyWork.name isEqualToString:selectedWork.name]) {
                unique = NO;
            }
        }
        if (unique) {
            NSMutableArray *marray = [_currentDaySummary.dailyWorks mutableCopy];
            DailyWork *dailyWork = [[DailyWork alloc] init];
            dailyWork.name = selectedWork.name;
            dailyWork.date = [self dateStringFrom:_date];
            [marray addObject:dailyWork];
            _currentDaySummary.dailyWorks = [marray copy];
            [_tableView reloadData];
            [Context sharedContext].selectedWork = nil;
        }
    }
}

- (void)updateDailyWork:(DailyWork *)dailyWork {
    NSMutableArray *marray = [_currentDaySummary.dailyWorks mutableCopy];
    NSInteger counter = 0;
    for (DailyWork *myDailyWork in [_currentDaySummary.dailyWorks copy]) {
        if ([myDailyWork.name isEqualToString:dailyWork.name]) {
            [marray replaceObjectAtIndex:counter withObject:dailyWork];
        }
        counter++;
    }
    _currentDaySummary.dailyWorks = [marray copy];
    [Context sharedContext].selecetedDailyWork = nil;
}

#pragma mark - Handlers
- (IBAction)btnSubmitHandler:(id)sender {
    if([[Context sharedContext] writeDaySummary:_currentDaySummary])
       [self showSelfDestructingAlert:@"Gün Özeti kaydedildi"];
}

#pragma mark - Table View
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ShowWorkersViewController *showWorkersVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Show Workers VC"];
    showWorkersVC.dailyWork = [_currentDaySummary.dailyWorks objectAtIndex:indexPath.row];
    showWorkersVC.date = _date;
    [self.navigationController pushViewController:showWorkersVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _currentDaySummary.dailyWorks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EditDaySummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Edit Day Summary Cell"];
    DailyWork *dailyWork = [_currentDaySummary.dailyWorks objectAtIndex:indexPath.row];
    cell.lblName.text = dailyWork.name;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
