//
//  MainViewController.h
//  Mobil Eleman Takip
//
//  Created by Arda Cicek on 08/03/15.
//  Copyright (c) 2015 Arda Cicek. All rights reserved.
//

#import "BaseViewController.h"
#import "Context.h"
#import "ACFormContainerView.h"

@interface MainViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet ACFormContainerView *formContainer;

@property (nonatomic, strong) NSDate *date;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *todaysWorkers; //of Worker
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (nonatomic, strong) NSString *todaysDate;
@property (nonatomic, strong) DaySummary *daySummary;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DailyWork *dailyWork;

@end
