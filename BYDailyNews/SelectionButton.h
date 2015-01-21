//
//  SelectionButton.h
//  BYDailyNews
//
//  Created by bassamyan on 15/1/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SelectionButtonDelegate <NSObject>

@optional
-(void)ArrowClickedWithButton:(UIButton *)button;
@end

@interface SelectionButton : UIButton
-(void)arrowChange;
@property (nonatomic,weak) id<SelectionButtonDelegate> delegate;
@end
