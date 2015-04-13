//
//  WorkerListViewController.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 09/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "WorkerListViewController.h"
#import "WorkerListTableViewCell.h"
#import "WorkerDetailViewController.h"

@interface WorkerListViewController ()

@end

@implementation WorkerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _workerList = [[Context sharedContext] getWorkers];
    [_tableView reloadData];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
}

- (void)viewWillAppear:(BOOL)animated {
    _workerList = [[Context sharedContext] getWorkers];
    [_tableView reloadData];
    
    
}
#pragma mark - UITableView DataSource/Delegate
- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"Düzenle"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Sil"];
    
    return rightUtilityButtons;
}
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
    
    switch (index) {
        case 0:
        {
            //
            break;
        }
        case 1:
        {
            // Delete button was pressed
            Worker *workerToDelete = [_workerList.workers objectAtIndex:cellIndexPath.row];
            if ([[Context sharedContext] removeWorker:workerToDelete]) {
                _workerList = [[Context sharedContext] getWorkers];
                [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];

            }
            break;
        }
        default:
            break;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _selectedWorker = [_workerList.workers objectAtIndex:indexPath.row];
    if (!_pickForToday) {
        [self performSegueWithIdentifier:@"Show Worker Detail" sender:nil];
    } else {
        [Context sharedContext].selectedWorker = [_selectedWorker copy];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    return _workerList.workers.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkerListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Worker List Cell"];
    if (!cell) {
        cell = [[WorkerListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Worker List Cell"];
    }
    
//    cell.leftUtilityButtons = [self leftButtons];
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;

    
    [cell refreshWith:[_workerList.workers objectAtIndex:indexPath.row]];
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Default is 1 if not implemented
    return  1;
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // fixed font style. use custom view
 
}


*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[WorkerDetailViewController class]]) {
        WorkerListTableViewCell *cell = (WorkerListTableViewCell *)sender;
        WorkerDetailViewController* destVC = segue.destinationViewController;
//        destVC.currentWorker = cell.worker;
        destVC.currentWorker = _selectedWorker;

    }
    
}


@end
