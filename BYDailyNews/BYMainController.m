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
{
    CGFloat nav_height;
}
@end

@implementation BYMainController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNaviBar];
    [self makeContent];

}

-(void)setupNaviBar
{
    nav_height = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.view.backgroundColor = Color_main;
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, conditionScrollH+nav_height, BYScreenWidth, BYScreenHeight-conditionScrollH)];
    background.image = [UIImage imageNamed:@"content_bg.png"];
    [self.view addSubview:background];
}


-(void)makeContent
{
    BYConditionBar *conditionBar = [[BYConditionBar alloc] initWithFrame:CGRectMake(0, nav_height, BYScreenWidth, conditionScrollH)];
    [self.view addSubview:conditionBar];
    
    
    BYSelectNewBar *selection_newBar = [[BYSelectNewBar alloc] initWithFrame:conditionBar.frame];
    [self.view addSubview:selection_newBar];
    
    
    BYSelectionDetails *selection_details = [[BYSelectionDetails alloc] initWithFrame:CGRectMake(0, nav_height+conditionScrollH-BYScreenHeight, BYScreenWidth, BYScreenHeight-conditionScrollH)];
    [self.view insertSubview:selection_details belowSubview:conditionBar];
    
    
    SelectionButton *arrow = [[SelectionButton alloc] initWithFrame:CGRectMake(BYScreenWidth-arrow_width, nav_height, arrow_width, conditionScrollH)];
    arrow -> NewBar = selection_newBar;
    arrow -> Details = selection_details;
    [self.view addSubview:arrow];
    
    UIImageView *custom = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BYScreenWidth, nav_height)];
    custom.image = [UIImage imageNamed:@"nav_background2.png"];
    [self.view insertSubview:custom atIndex:100];
}
@end
