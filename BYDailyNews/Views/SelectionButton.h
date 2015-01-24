//
//  SelectionButton.h
//  BYDailyNews
//
//  Created by bassamyan on 15/1/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BYSelectionDetails;
@class BYSelectNewBar;

@interface SelectionButton : UIButton
@property (nonatomic,strong) BYSelectionDetails *Detail;
@property (nonatomic,strong) BYSelectNewBar *Newbar;
@end