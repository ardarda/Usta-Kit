//
//  AddWorkerViewController.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 09/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseViewController.h"
#import "ACTextField.h"

@interface AddWorkerViewController : BaseViewController

@property (weak, nonatomic) IBOutlet ACTextField *tfName;

@property (weak, nonatomic) IBOutlet ACTextField *tfPhone;

@property (weak, nonatomic) IBOutlet ACTextField *tfRate;

@end
