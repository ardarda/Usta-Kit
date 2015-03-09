//
//  AddWorkerViewController.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 09/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "AddWorkerViewController.h"
#import "Context.h"
#import "NetworkManager.h"

@interface AddWorkerViewController ()

@end

@implementation AddWorkerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tfRate.type = kACTextFieldTypeCurrency;
    _tfPhone.type = kACTextFieldTypeCurrency;
}

- (IBAction)btnAddWorkerHandler:(id)sender {
    if (_tfName.text.length > 3 && _tfRate.text.length > 1) {
        Worker *worker = [[Worker alloc] init];
        worker.name = _tfName.text;
        worker.phone = _tfPhone.text;
        worker.rate = [NSNumber numberWithInt:[_tfRate.text intValue]];
        if ([[Context sharedContext] addWorker:worker]) {
            [[NetworkManager sharedManager] showErrorMsg:@"İşçi Eklendi"];
            _tfName.text = @"";
            _tfPhone.text = @"";
            _tfRate.text = @"";
            
        }else [[NetworkManager sharedManager] showErrorMsg:@"Hata"];
    }
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
