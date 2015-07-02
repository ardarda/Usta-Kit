//
//  WorkerDetailViewController.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 09/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "WorkerDetailViewController.h"
#import "Context.h"
#import "NetworkManager.h"
#import "WorkHistoryViewController.h"
#import "FileManager.h"

@interface WorkerDetailViewController ()

@end

@implementation WorkerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _tfNewAdvance.type = kACTextFieldTypeCurrency;
    [self fetchUnpaidDailyworks];
    self.title = @"İşçi Bilgileri";
}

-(void)viewWillAppear:(BOOL)animated{
    [_formContainer addNotifications];
}

-(void)viewWillDisappear:(BOOL)animated{
    [_formContainer removeNotifications];
}
- (void)refreshFields {
    _tfName.text = _currentWorker.name;
    _tfPhone.text = _currentWorker.phone;
    _tfAdvance.text = _currentWorker.advance.stringValue;
    _tfRate.text = _currentWorker.defaultRate.stringValue;
    _tfDaysWorked.text = _currentWorker.numberOfDaysWorked.stringValue;
    _tfTotal.text = [NSString stringWithFormat:@"%ld",(_unpaidAmount  - _currentWorker.advance.integerValue)];
}

- (void)fetchUnpaidDailyworks {
    NSArray *relatedDailyWorks = [[FileManager sharedManager] fetchDailyWorkOfWorker:_currentWorker];
    NSInteger sum = 0;
    NSMutableArray *marray = [NSMutableArray array];
    for (DailyWork *dailyWork in relatedDailyWorks) {
        for (Worker *worker in dailyWork.workerList.workers) {
            if ([worker.name isEqualToString:_currentWorker.name]) {
                if (!worker.isDailyWorkPaid.boolValue) {
                    sum += worker.rate.integerValue;
                    [marray addObject:dailyWork];
                }
            }
        }
    }
    
    _unpaidAmount = sum;
    _unpaidDailyWorks = [marray copy];
    [self refreshFields];
}


- (IBAction)btnPayTheMan:(id)sender {
    UIActionSheet *popUpSheet = [[UIActionSheet alloc]
                                 initWithTitle:nil
                                 delegate:self
                                 cancelButtonTitle:@"İptal"
                                 destructiveButtonTitle:@"Ödemeyi Tamamla"
                                 otherButtonTitles: nil];
    [popUpSheet showInView:self.view];

}

- (IBAction)btnGiveAdvance:(id)sender {
    if (_tfNewAdvance.text.length>0) {
        [_formContainer resign];
        _currentWorker.advance = [NSNumber numberWithInt:_currentWorker.advance.intValue + _tfNewAdvance.text.intValue];
        WorkerList *updateList = [[WorkerList alloc] init];
        updateList.workers = (NSArray<Worker> *)@[_currentWorker];
        if([[Context sharedContext] updateWorkers:updateList]) {
            [self refreshFields];
            _tfNewAdvance.text = @"";
        }
        else [[NetworkManager sharedManager] showErrorMsg:@"Avans Hatasi"];
        
    }
    
}

- (void)payTheMan {
    _currentWorker.numberOfDaysWorked = @0;
    _currentWorker.advance = @0;
    WorkerList *updateList = [[WorkerList alloc] init];
    updateList.workers = (NSArray<Worker> *)@[_currentWorker];
    if([[Context sharedContext] updateWorkers:updateList]) {
        [self refreshFields];
    }
    
    for (DailyWork *dailyWork in _unpaidDailyWorks) {
        for (Worker *worker in dailyWork.workerList.workers) {
            if ([worker.name isEqualToString:_currentWorker.name]) {
                worker.isDailyWorkPaid = [NSNumber numberWithBool:YES];
            }
        }
    }
    if ([[FileManager sharedManager] updateDaySummariesWith:_unpaidDailyWorks]) {
        [self showSelfDestructingAlert:@"Ödeme kayıtlara geçirildi"];
        _tfTotal.text = @"";
        _currentWorker.advance = [NSNumber numberWithInteger:0];
        WorkerList *workerList = [[WorkerList alloc] init];
        workerList.workers = (NSArray<Worker> *)@[_currentWorker];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[Context sharedContext] updateWorkers:workerList]?[self showSelfDestructingAlert:@"Isci kayitlari yenilendi"]:[self showSelfDestructingAlert:@"Hata: Isci kayitlari yenilenemedi!"];
        });
        
;
    } else
        [self showSelfDestructingAlert:@"Ödeme başarısız!"];

}

#pragma mark - Action Sheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self payTheMan];
            break;
        case 1:
            //
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[WorkHistoryViewController class]]) {
        WorkHistoryViewController *workHistoryVC = (WorkHistoryViewController *)segue.destinationViewController;
        workHistoryVC.currentWorker = _currentWorker;
    }
}


@end
