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
#import "BYSelectionView.h"

@interface BYMainController ()
@property (nonatomic, strong) UIScrollView *conditionScroll;
@property (nonatomic, strong) BYSelectionDetails *selection_details;
@property (nonatomic, strong) BYSelectNewBar *selection_newBar;
@property (nonatomic, strong) SelectionButton *arrow;
@end

@implementation BYMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    BYConditionBar *conditionBar = [[BYConditionBar alloc] initWithFrame:CGRectMake(0, 0, BYScreenWidth, conditionScrollH)];
    [self.view addSubview:conditionBar];
    
    
    self.selection_newBar = [[BYSelectNewBar alloc] initWithFrame:conditionBar.frame];
    [self.view addSubview:self.selection_newBar];
    
    
    self.selection_details = [[BYSelectionDetails alloc] initWithFrame:CGRectMake(0, conditionScrollH-BYScreenHeight, BYScreenWidth, BYScreenHeight-conditionScrollH)];
    [self.view insertSubview:self.selection_details belowSubview:conditionBar];
    
    
    self.arrow = [[SelectionButton alloc] initWithFrame:CGRectMake(BYScreenWidth-arrow_width, 0, arrow_width, conditionScrollH)];
    self.arrow -> NewBar = self.selection_newBar;
    self.arrow -> Details = self.selection_details;
    [self.view addSubview:self.arrow];
}




@end
