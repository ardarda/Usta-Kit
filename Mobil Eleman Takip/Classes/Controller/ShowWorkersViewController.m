//
//  ShowWorkersViewController.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 13/04/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "ShowWorkersViewController.h"
#import "NetworkManager.h"
#import "WorkerListViewController.h"
#import "ShowWorkersTableViewCell.h"

@interface ShowWorkersViewController ()

@end

@implementation ShowWorkersViewController
-(NSMutableArray *)currentWorkers {
    if (_currentWorkers)
        return [NSMutableArray array];
    else
        return _currentWorkers;
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
    
//    _daySummary = [[Context sharedContext] getDaySummaryWith:_todaysDate];
    
    _currentWorkers = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated {
    [_formContainer addNotifications];
//    _daySummary = [[Context sharedContext] getDaySummaryWith:_todaysDate];
    
    Worker *selectedWorker = [Context sharedContext].selectedWorker;
    if (selectedWorker) {
        [_formContainer initialize];
        BOOL unique = YES;
        for (Worker *oldWorker in _currentWorkers) {
            if ([oldWorker.name isEqualToString:selectedWorker.name]) unique = NO;
        }
        if (unique)
            [_currentWorkers addObject:[[Context sharedContext].selectedWorker copy]];
        [Context sharedContext].selectedWorker = nil;
    } else if (_dailyWork) {
        if(_dailyWork.workerList.workers)
            _currentWorkers = [_dailyWork.workerList.workers mutableCopy];
        
    } else {
        _currentWorkers = [NSMutableArray array];
    }
    [_formContainer initialize];
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
    for (Worker *myWorker in [_currentWorkers copy]) {
        
        //update worker history?or should do it in context
        NSMutableArray *marray = [myWorker.datesWorked mutableCopy];
        [marray addObject:_todaysDate];
        myWorker.datesWorked = [marray copy];
        
        //array of WorkHistory Objects
//        NSMutableArray *workHistoryMarray = [NSMutableArray arrayWithArray:myWorker.workHistory];
        //array of DailyWork Objects
        
//        [workHistoryMarray addObject:dailyWork];
        
//        myWorker.workHistory = [workHistoryMarray copy];
        [dumpWorkers addObject:myWorker];
    }
    _currentWorkers = dumpWorkers;
    
    WorkerList *todaysList = [[WorkerList alloc] init];
    todaysList.workers = [_currentWorkers mutableCopy];
    
    _dailyWork.workerList = todaysList;
    
    [Context sharedContext].selecetedDailyWork = _dailyWork;
    [self showSelfDestructingAlert:@"İşçiler İş Özetine Eklendi"];
    [self.navigationController popViewControllerAnimated:YES];
    
    /*
    DaySummary *summary = [[DaySummary alloc] init];
    summary.workerList = todaysList;
    summary.date = _todaysDate;
    */
    
    /*
    
    if([[Context sharedContext] writeDaySummary:summary]) {
        [self showSelfDestructingAlert:@"Ozet Basariyla Kaydedildi"];
        
    }else
        [[NetworkManager sharedManager] showErrorMsg:@"Hata: Gun Özeti Kaydedilemedi"];
    
    return;
     
    /*
    for (Worker *myWorker in [_todaysWorkers copy]) {
        myWorker.numberOfDaysWorked = [NSNumber numberWithInt:myWorker.numberOfDaysWorked.intValue + 1];
    }
    WorkerList *updateList = [[WorkerList alloc] init];
    updateList.workers = [_todaysWorkers mutableCopy];
    if([[Context sharedContext] updateWorkers:updateList]) [[NetworkManager sharedManager] showErrorMsg:@"Günün İşçileri Baaşrıyla Seçilmiştir."];
     */
}

- (IBAction)btnClearSelection:(id)sender {
    _currentWorkers = [NSMutableArray array];
}

#pragma mark - Text Field
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSInteger rate = textField.text.integerValue;
    Worker *worker = [_currentWorkers objectAtIndex:textField.tag];
    worker.rate = [NSNumber numberWithInteger:rate];
}


#pragma mark - Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _currentWorkers.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowWorkersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Show Workers Cell"];
    Worker *worker = [_currentWorkers objectAtIndex:indexPath.row];
    cell.lblName.text = worker.name;
//    cell.lblWorkerRate.text = worker.rate.stringValue;
    cell.tfRate.text = worker.rate.stringValue;
    cell.tfRate.type = kACTextFieldTypeCurrency;
    cell.tfRate.tag = indexPath.row;
    cell.tfRate.delegate = self;
    
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Tamam"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    cell.tfRate.inputAccessoryView = keyboardDoneButtonView;
    
    
    
    return cell;
}
- (void)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
}
@end
