//
//  ShowWorkersTableViewCell.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 13/04/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACTextField.h"

@interface ShowWorkersTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet ACTextField *tfRate;

@end
