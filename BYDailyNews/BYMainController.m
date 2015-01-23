//
//  BYMainController.m
//  BYDailyNews
//
//  Created by bassamyan on 15/1/17.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BYMainController.h"
#import "BYConditionBar.h"
#import "SelectionButton.h"
#import "BYSelectionDetails.h"
#import "BYSelectNewBar.h"

@interface BYMainController ()

@end

@implementation BYMainController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNaviBar];
    
    [self makeContent];
}

-(void)setupNaviBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    
}


-(void)makeContent
{
    BYConditionBar *conditionBar = [[BYConditionBar alloc] initWithFrame:CGRectMake(0, 0, BYScreenWidth, conditionScrollH)];
    [self.view addSubview:conditionBar];
    
    
    BYSelectNewBar *selection_newBar = [[BYSelectNewBar alloc] initWithFrame:conditionBar.frame];
    [self.view addSubview:selection_newBar];
    
    
    BYSelectionDetails *selection_details = [[BYSelectionDetails alloc] initWithFrame:CGRectMake(0, conditionScrollH-BYScreenHeight, BYScreenWidth, BYScreenHeight-conditionScrollH)];
    [self.view insertSubview:selection_details belowSubview:conditionBar];
    
    
    SelectionButton *arrow = [[SelectionButton alloc] initWithFrame:CGRectMake(BYScreenWidth-arrow_width, 0, arrow_width, conditionScrollH)];
    arrow -> NewBar = selection_newBar;
    arrow -> Details = selection_details;
    [self.view addSubview:arrow];
}
@end
