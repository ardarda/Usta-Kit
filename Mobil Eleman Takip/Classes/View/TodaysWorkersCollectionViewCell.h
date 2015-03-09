//
//  TodaysWorkersCollectionViewCell.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 09/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Worker.h"
#import "ACTextField.h"
@interface TodaysWorkersCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblName;
- (void)refreshWith:(Worker *)worker;
@property (weak, nonatomic) IBOutlet ACTextField *tfRate;
@end
