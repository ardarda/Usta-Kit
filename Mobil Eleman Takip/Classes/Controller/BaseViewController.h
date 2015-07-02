//
//  BaseViewController.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 08/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "ACBaseViewController.h"
#import "SWRevealViewController.h"

@interface BaseViewController : ACBaseViewController <SWRevealViewControllerDelegate>

- (void)showSelfDestructingAlert:(NSString *)message;
- (NSString *)dateStringFrom:(NSDate *)date;
- (NSString *)dateStringForUI:(NSDate *)date;

@end
