//
//  MainViewController.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 08/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "MainViewController.h"
#import "TodaysWorkersCollectionViewCell.h"
#import "WorkerListViewController.h"
#import "NetworkManager.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _todaysWorkers = [NSMutableArray array];

}

- (void)viewWillAppear:(BOOL)animated {
    [_formContainer addNotifications];
    Worker *selectedWorker = [Context sharedContext].selectedWorker;
    if (selectedWorker) {
        [_formContainer initialize];
        BOOL unique = YES;
        for (Worker *oldWorker in _todaysWorkers) {
            if ([oldWorker.name isEqualToString:selectedWorker.name]) unique = NO;
        }
        if (unique)
            [_todaysWorkers addObject:[[Context sharedContext].selectedWorker copy]];
        [Context sharedContext].selectedWorker = nil;
        [_collectionView reloadData];
    }
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [_formContainer removeNotifications];
}

- (IBAction)btnPickWorker:(id)sender {
    WorkerListViewController *workerListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Worker List"];
    workerListVC.pickForToday = YES;
    [self.navigationController pushViewController:workerListVC animated:YES];
}
- (IBAction)btnSubmitSelection:(id)sender {
    for (Worker *myWorker in [_todaysWorkers copy]) {
        myWorker.numberOfDaysWorked = [NSNumber numberWithInt:myWorker.numberOfDaysWorked.intValue + 1];
    }
    WorkerList *updateList = [[WorkerList alloc] init];
    updateList.workers = [_todaysWorkers mutableCopy];
    if([[Context sharedContext] updateWorkers:updateList]) [[NetworkManager sharedManager] showErrorMsg:@"Günün İşçileri Baaşrıyla Seçilmiştir."];
}
- (IBAction)btnClearSelection:(id)sender {
    _todaysWorkers = [NSMutableArray array];
    [_collectionView reloadData];
}



#pragma mark - Collectionview Data Source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return _todaysWorkers.count;
}

/*
 Autolayout with collection view delegate methods
 */

#pragma mark - AutoLayout forced:)
/*
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
 //    double kx = self.view.frame.size.width/ 320;
 //    double height = 300* kx;
 //TODO:FIX THIS!
 return CGSizeMake(self.collectionView.frame.size.width, 300);
 }*/
#pragma mark -

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TodaysWorkersCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Todays Workers Cell" forIndexPath:indexPath];
    [cell refreshWith:[_todaysWorkers objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}


@end
