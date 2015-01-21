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


#define BYScreenWidth [UIScreen mainScreen].bounds.size.width
#define BYScreenHeight [UIScreen mainScreen].bounds.size.height
#define conditionScrollH 30

@interface BYMainController () <SelectionButtonDelegate>
@property (nonatomic, strong) UIScrollView *conditionScroll;
@property (nonatomic, assign) CGFloat max_width;
@property (nonatomic, assign) CGFloat original_x;
@property (nonatomic, strong) BYSelectionDetails *selection_details;
@property (nonatomic, strong) BYSelectNewBar *selection_newBar;
@end

@implementation BYMainController

- (void)viewDidLoad {
    
    NSArray *property = @[@"推荐",@"热点",@"社会",@"娱乐",@"科技",@"财经",@"汽车",@"体育",@"军事",@"正能量",@"段子",@"趣图",@"美女",@"国际",@"健康",@"教育",@"特卖"];
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    BYConditionBar *conditionBar = [[BYConditionBar alloc] initWithFrame:CGRectMake(0, 0, BYScreenWidth, conditionScrollH)];
    [[NSNotificationCenter defaultCenter] addObserver:conditionBar
                                             selector:@selector(selectItemsWithNoti:)
                                                 name:@"select_items"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:conditionBar
                                             selector:@selector(addNewItemWithNoti:)
                                                 name:@"addNewItem"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:conditionBar
                                             selector:@selector(removeItemWithNoti:)
                                                 name:@"removeItem"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:conditionBar
                                             selector:@selector(changeItemPositionWithNoti:)
                                                 name:@"changeItemsPosition"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:conditionBar
                                             selector:@selector(changeItemPositionWithPositionWithNoti:)
                                                 name:@"changeItemPositionWithPosition"
                                               object:nil];
    
    
    
    [self.view addSubview:conditionBar];
    
    self.selection_newBar = [[BYSelectNewBar alloc] initWithFrame:CGRectMake(0, 0, BYScreenWidth, conditionScrollH)];
    [self.selection_newBar makeNewBar];
    [[NSNotificationCenter defaultCenter] addObserver:self.selection_newBar
                                             selector:@selector(newBarHidden)
                                                 name:@"select_items"
                                               object:nil];
    [self.view addSubview:self.selection_newBar];
    self.selection_newBar.hidden= YES;
    
    SelectionButton *arrow = [[SelectionButton alloc] initWithFrame:CGRectMake(BYScreenWidth-40, 0, 40, conditionScrollH)];
    [[NSNotificationCenter defaultCenter] addObserver:arrow
                                             selector:@selector(arrowChange)
                                                 name:@"select_items"
                                               object:nil];
    arrow.delegate = self;
    [self.view addSubview:arrow];
    
    
    self.selection_details = [[BYSelectionDetails alloc] initWithFrame:CGRectMake(0, conditionScrollH-BYScreenHeight, BYScreenWidth, BYScreenHeight-conditionScrollH)];
    [[NSNotificationCenter defaultCenter] addObserver:self.selection_details
                                             selector:@selector(itemSelect)
                                                 name:@"select_items"
                                               object:nil];
    [self.selection_details makeMainContentWithlistArray:property];
    [self.view insertSubview:self.selection_details belowSubview:conditionBar];
}


-(void)ArrowClickedWithButton:(UIButton *)button
{
    self.selection_newBar.hidden = (self.selection_details.frame.origin.y<0)?NO:YES;
    
    [UIView animateWithDuration:0.7 animations:^{
        CGAffineTransform rotation = button.imageView.transform;
        button.imageView.transform = CGAffineTransformRotate(rotation,M_PI);
        
        self.selection_details.transform = (self.selection_details.frame.origin.y<0)?CGAffineTransformMakeTranslation(0, BYScreenHeight):CGAffineTransformMakeTranslation(0, -BYScreenHeight);
    }];
}


@end
