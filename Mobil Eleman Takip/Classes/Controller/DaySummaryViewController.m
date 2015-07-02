//
//  DaySummaryViewController.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 17/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "DaySummaryViewController.h"
#import "DaySummaryTableViewCell.h"
#import "EditDaySummaryViewController.h"
#import "Work.h"
#import "FileManager.h"
#import "PopWorkersTableViewController.h"

@interface DaySummaryViewController ()

@end

@implementation DaySummaryViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"kronoloji_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:nil];
    }
    return self;
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
    [self refreshWith:[[Context sharedContext] dateStringFrom:[NSDate date]]];
    if (!_date)
        _date = [NSDate date];
    self.title = @"Gün Özetleri";
//    [[FileManager sharedManager] fetchDailyWorkOfWorker:nil];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Bugün" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonHandler)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [self refreshWith:[[Context sharedContext] dateStringFrom:_date]];
}

#pragma mark - Handlers
- (void)leftBarButtonHandler {
    [_datePicker setDate:[NSDate date] animated:YES];
    [self didDateChange:_datePicker];
}

- (IBAction)editDaySummary:(id)sender {
    EditDaySummaryViewController *editVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Edit Day Summary VC"];
    editVC.date = _date;
    [self.navigationController pushViewController:editVC animated:YES];
}

- (IBAction)didDateChange:(UIDatePicker *)sender {
    _date = sender.date;
    [self refresh];
}

#pragma mark - Live Flow

- (void)refresh
{
    [self refreshWith:[[Context sharedContext] dateStringFrom:_date]];
}

- (void)refreshWith:(NSString *)dateString {
    _currentSummary = [[Context sharedContext] getDaySummaryWith:dateString];
    _lblDate.text = [self dateStringForUI:_date];

    if (_currentSummary.dailyWorks.count > 0) {
        _tableView.hidden = NO;
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
        _tableView.hidden = YES;
        _lblToplamAmount.hidden = YES;
        _lblToplamTitle.hidden = YES;
    }
}

#pragma mark - Table View Del & Dat
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    PopWorkersTableViewController *workerListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Pop Worker List VC"];
    workerListVC.currentDailyWork = [_currentSummary.dailyWorks objectAtIndex:indexPath.row];
    DaySummaryTableViewCell *cell = (DaySummaryTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    FPPopoverController *fpPopOverController = [[FPPopoverController alloc] initWithViewController:workerListVC];
    fpPopOverController.contentSize = CGSizeMake(150, 50+workerListVC.currentDailyWork.workerList.workers.count*35);
    fpPopOverController.delegate = self;
    [fpPopOverController presentPopoverFromView:cell];
     */
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _currentSummary.dailyWorks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DaySummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Day Summary Cell"];
    DailyWork *dailyWork = [_currentSummary.dailyWorks objectAtIndex:indexPath.row];
    cell.lblWorkName.text = dailyWork.name;
//    cell.lblWorkerRate.text = worker.rate.stringValue;
    if (dailyWork.workerList.workers.count < 1) {
        cell.contentView.backgroundColor = [UIColor lightGrayColor];
        cell.lblWorkerNumber.text = @"İşçi yok";

    } else {
        cell.lblWorkerNumber.text = [NSString stringWithFormat:@"%lu İşçi", (unsigned long)dailyWork.workerList.workers.count];
    }
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
