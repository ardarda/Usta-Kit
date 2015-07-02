//
//  BaseViewController.m
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 08/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //add menu button to navcon
    
    if(self.navigationController){
//            [self.revealViewController panGestureRecognizer];
//            [self.revealViewController tapGestureRecognizer];
            self.revealViewController.delegate = self;
            
            if(self.navigationController.viewControllers.count < 2){
                UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_menu_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(sidebarButtonHandler:)];
//                [self.navigationItem setLeftBarButtonItem:menuItem];
        }
    }
    
    /* Nav Bar - Back Button */
    if(self.navigationController.viewControllers.count > 1) {
        //    if (self.showBackButton == YES) {
        UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(popViewControllerAnimated:)];
        [self.navigationItem setLeftBarButtonItem:menuItem];
    }
}

- (void) sidebarButtonHandler:(id) sender{
    [self.revealViewController revealToggleAnimated:YES];
}

- (void)showSelfDestructingAlert:(NSString *)message {
    UIAlertView *myal = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [myal show];
    [self performSelector:@selector(test:) withObject:myal afterDelay:.9];

}

-(void)test:(UIAlertView*)x{
    [x dismissWithClickedButtonIndex:-1 animated:YES];
}
- (NSString *)dateStringFrom:(NSDate *)date {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    return [df stringFromDate:date];
}

- (NSString *)dateStringForUI:(NSDate *)date {
    // Create date formatter
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"d MMMM yyyy EEEE"];
    
    // Set the locale as needed in the formatter (this example uses Japanese)
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"tr_TR"]];
    //    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    //    NSString *trFormatString = [NSDateFormatter dateFormatFromTemplate:@"dd MMM yyyy" options:0 locale:[NSLocale currentLocale]];
    //    [df setDateFormat:trFormatString];
    return [dateFormat stringFromDate:date];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
