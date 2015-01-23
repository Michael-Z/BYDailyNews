//
//  BYSelectionDetails.m
//  BYDailyNews
//
//  Created by bassamyan on 15/1/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BYSelectionDetails.h"
#import "BYSelectionView.h"

@implementation BYSelectionDetails

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeMainContent];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(NSMutableArray *)views1
{
    if (_views1 == nil) {
        _views1 = [NSMutableArray array];
    }
    return _views1;
}

-(NSMutableArray *)views2
{
    if (_views2 == nil) {
        _views2 = [NSMutableArray array];
    }
    return _views2;
}

-(void)makeMainContent
{
    
    NSString *plistPath1 = [[NSBundle mainBundle] pathForResource:@"properties" ofType:@"plist"];
    NSMutableArray *listArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath1];
    
    NSString *plistPath2 = [[NSBundle mainBundle] pathForResource:@"otherProperties" ofType:@"plist"];
    NSArray *otherValues = [[NSArray alloc] initWithContentsOfFile:plistPath2];
    
    //点击添加频道的label和他的背景色
    UIView *bg_view = [[UIView alloc] initWithFrame:CGRectMake(0,20+45*((listArray.count -1)/4+1),BYScreenWidth, 30)];
    bg_view.backgroundColor = Color_maingray;
    UILabel *morevalue_label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 30)];
    morevalue_label.text = @"点击添加频道";
    morevalue_label.font = [UIFont systemFontOfSize:14];
    [bg_view addSubview:morevalue_label];
    [self addSubview:bg_view];
    
    NSInteger num = listArray.count;
    for (int i =0; i <num; i++) {
        BYSelectionView *view = [[BYSelectionView alloc] init];
        view.frame = CGRectMake(20+(20+view_width)*(i%4), 20+45*(i/4), view_width, 25);
        [view makeSelectionViewWithTitle:listArray[i]];
        [self.views1 addObject:view];
        view.tag = 1;
        view->views_array = self.views1;
        view->views1 = self.views1;
        view->views2 = self.views2;
        [view setMoreChanelslabel:bg_view];
        [self addSubview:view];
    }
    
    NSInteger num2 = otherValues.count;
    for (int i=0; i<num2; i++) {
        BYSelectionView *view = [[BYSelectionView alloc] initWithFrame:CGRectMake(20+(20+view_width)*(i%4),CGRectGetMaxY(bg_view.frame)+20+45*(i/4), view_width, 25)];
        [view makeSelectionViewWithTitle:otherValues[i]];
        [view setMoreChanelslabel:bg_view];
        [self.views2 addObject:view];
        view.tag = 0;
        view->views_array = self.views2;
        view->views1 = self.views1;
        view->views2 = self.views2;
        [self addSubview:view];
    }
    
    self.contentSize = CGSizeMake(BYScreenWidth, CGRectGetMaxY(bg_view.frame)+20+45*((num2-1)/4+1) + 50);

}

@end
