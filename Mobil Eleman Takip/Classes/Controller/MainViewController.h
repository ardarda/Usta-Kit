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

@interface MainViewController : BaseViewController
@property (weak, nonatomic) IBOutlet ACFormContainerView *formContainer;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *todaysWorkers; //of Worker

@end
