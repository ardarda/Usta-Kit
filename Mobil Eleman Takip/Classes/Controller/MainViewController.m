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
#import "DaySummaryTableViewCell.h"

@implementation MainViewController

-(NSMutableArray *)todaysWorkers {
    if (_todaysWorkers)
        return [NSMutableArray array];
    else
        return _todaysWorkers;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *todaysDate = [calendar dateBySettingHour:10 minute:0 second:0 ofDate:[NSDate date] options:0];
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    NSString *trFormatString = [NSDateFormatter dateFormatFromTemplate:@"dd MMM yyyy" options:0 locale:[NSLocale currentLocale]];
    [df setDateFormat:trFormatString];

    NSString *todaysDateString = @"";
    if(_date) {
        _todaysDate = [[Context sharedContext] dateStringFrom:_date];
        todaysDateString = [df stringFromDate:_date];
    }
    else {
        _todaysDate = [[Context sharedContext] dateStringFrom:todaysDate];
        todaysDateString = [df stringFromDate:todaysDate];
        self.title = @"Bugun";

    }

    
//    NSDate *localeDate = [_todaysDate str]
    _lblDate.text = todaysDateString;

    _daySummary = [[Context sharedContext] getDaySummaryWith:_todaysDate];

    _todaysWorkers = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated {
    [_formContainer addNotifications];
    _daySummary = [[Context sharedContext] getDaySummaryWith:_todaysDate];

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
    } else if (_daySummary) {
        if(_daySummary.workerList.workers)
            _todaysWorkers = [_daySummary.workerList.workers mutableCopy];

    } else {
        _todaysWorkers = [NSMutableArray array];
    }
    [_collectionView reloadData];

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
    DailyWork *dailyWork = [[DailyWork alloc] init];
    if (_dailyWork)
        dailyWork = _dailyWork;
    
    NSMutableArray *dumpWorkers = [NSMutableArray array];
    for (Worker *myWorker in [_todaysWorkers copy]) {
        
        //update worker history?or should do it in context
        NSMutableArray *marray = [myWorker.datesWorked mutableCopy];
        [marray addObject:_todaysDate];
        myWorker.datesWorked = [marray copy];
        
        //array of WorkHistory Objects
        NSMutableArray *workHistoryMarray = [NSMutableArray arrayWithArray:myWorker.workHistory];
        //array of DailyWork Objects
    
        [workHistoryMarray addObject:dailyWork];
        
        myWorker.workHistory = [workHistoryMarray copy];
        [dumpWorkers addObject:myWorker];
    }
    _todaysWorkers = dumpWorkers;
    
    WorkerList *todaysList = [[WorkerList alloc] init];
    todaysList.workers = [_todaysWorkers mutableCopy];
    
    DaySummary *summary = [[DaySummary alloc] init];
    summary.workerList = todaysList;
    summary.date = _todaysDate;
    
    
    if([[Context sharedContext] writeDaySummary:summary]) {
        [self showSelfDestructingAlert:@"Ozet Basariyla Kaydedildi"];

    }else
        [[NetworkManager sharedManager] showErrorMsg:@"Hata: Gun Özeti Kaydedilemedi"];
    
    return;
    
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

#pragma mark - Table View


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _todaysWorkers.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DaySummaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Day Summary Cell"];
    Worker *worker = [_todaysWorkers objectAtIndex:indexPath.row];
    cell.lblWorkerName.text = worker.name;
    cell.lblWorkerRate.text = worker.rate.stringValue;
    return cell;
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
