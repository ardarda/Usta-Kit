//
//  AddWorkViewController.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 13/04/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "AddWorkViewController.h"
#import "Context.h"

@interface AddWorkViewController ()

@end

@implementation AddWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Handlers
- (IBAction)btnSaveHandler:(id)sender {
    Work *work = [[Work alloc] init];
    work.name = _tfWorkName.text;
    work.price = [NSNumber numberWithInteger:_tfWorkPrice.text.integerValue];
    if([[Context sharedContext] addWork:work]){
        [self showSelfDestructingAlert:@"İş Kaydedildi."];
        _tfWorkPrice.text = @"";
        _tfWorkName.text = @"";
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
