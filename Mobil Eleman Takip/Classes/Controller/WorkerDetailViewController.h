//
//  WorkerDetailViewController.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 09/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseViewController.h"
#import "ACTextField.h"
#import "Worker.h"
#import "ACFormContainerView.h"


@interface WorkerDetailViewController : BaseViewController <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet ACFormContainerView *formContainer;
@property (nonatomic, strong) Worker *currentWorker;

@property (weak, nonatomic) IBOutlet ACTextField *tfName;
@property (weak, nonatomic) IBOutlet ACTextField *tfPhone;
@property (weak, nonatomic) IBOutlet ACTextField *tfRate;
@property (weak, nonatomic) IBOutlet ACTextField *tfDaysWorked;
@property (weak, nonatomic) IBOutlet ACTextField *tfAdvance;
@property (weak, nonatomic) IBOutlet ACTextField *tfTotal;
@property (weak, nonatomic) IBOutlet ACTextField *tfNewAdvance;

@end
