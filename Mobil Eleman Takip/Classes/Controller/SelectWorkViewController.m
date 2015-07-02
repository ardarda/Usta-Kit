//
//  SelectWorkViewController.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 13/04/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "SelectWorkViewController.h"
#import "SelectWorkTableViewCell.h"
#import "AddWorkViewController.h"

@interface SelectWorkViewController ()

@end

@implementation SelectWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonHandler)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.title = @"İş Seç";
}

- (void)viewWillAppear:(BOOL)animated {
    _workList = [[Context sharedContext] getWorks];
    [_tableView reloadData];
}

#pragma mark - Handlers
- (void)addButtonHandler {
    AddWorkViewController *addWorkVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Add Work VC"];
    [self.navigationController pushViewController:addWorkVC animated:YES];
}
#pragma mark - Table View
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [Context sharedContext].selectedWork = [_workList.works objectAtIndex:indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _workList.works.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectWorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Select Work Cell"];
    Work *work = [_workList.works objectAtIndex:indexPath.row];
    cell.lblName.text = work.name;
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
