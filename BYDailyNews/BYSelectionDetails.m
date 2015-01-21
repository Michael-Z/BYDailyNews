//
//  BYSelectionDetails.m
//  BYDailyNews
//
//  Created by bassamyan on 15/1/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BYSelectionDetails.h"
#import "BYSelectionView.h"
#define BYScreenWidth [UIScreen mainScreen].bounds.size.width
#define BYScreenHeight [UIScreen mainScreen].bounds.size.height
#define Color_maingray [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0]


@implementation BYSelectionDetails


-(void)itemSelect
{
    [UIView animateWithDuration:0.7 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -BYScreenHeight);
    }];
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

-(void)makeMainContentWithlistArray:(NSArray *)listArray
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"otherProperties" ofType:@"plist"];
    NSArray *otherValues = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    
    UIView *bg_view = [[UIView alloc] initWithFrame:CGRectMake(0,5*45+20,BYScreenWidth, 30)];
    bg_view.backgroundColor = Color_maingray;
    [self addSubview:bg_view];
    
    UILabel *morevalue_label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 30)];
    morevalue_label.text = @"点击添加频道";
    morevalue_label.font = [UIFont systemFontOfSize:14];
    [bg_view addSubview:morevalue_label];
    
    NSInteger num = listArray.count;
    CGFloat view_width = (BYScreenWidth - 20*5)/4;
    for (int i =0; i < num; i++) {
        NSInteger row = i/4;
        NSInteger column = i%4;
        BYSelectionView *view = [[BYSelectionView alloc] initWithFrame:CGRectMake(20+(20+view_width)*column, 20+45*row, view_width, 25)];
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
        NSInteger row = i/4;
        NSInteger column = i%4;
        BYSelectionView *view = [[BYSelectionView alloc] initWithFrame:CGRectMake(20+(20+view_width)*column,CGRectGetMaxY(bg_view.frame)+20+45*row, view_width, 25)];
        [view makeSelectionViewWithTitle:otherValues[i]];
        [view setMoreChanelslabel:bg_view];
        [self.views2 addObject:view];
        view.tag = 0;
        view->views_array = self.views2;
        view->views1 = self.views1;
        view->views2 = self.views2;
        [self addSubview:view];
    }
}

@end
