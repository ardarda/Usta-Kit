//
//  AddWorkViewController.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 13/04/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseViewController.h"
#import "ACTextField.h"

@interface AddWorkViewController : BaseViewController
@property (weak, nonatomic) IBOutlet ACTextField *tfWorkName;
@property (weak, nonatomic) IBOutlet ACTextField *tfWorkPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@end
