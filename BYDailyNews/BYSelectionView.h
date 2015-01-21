//
//  BYSelectionView.h
//  BYDailyNews
//
//  Created by bassamyan on 15/1/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BYSelectionView : UIButton
{
    @public
    NSMutableArray *views_array;
    NSMutableArray *views1;
    NSMutableArray *views2;
}
@property (nonatomic,strong) UIView   *moreChanelslabel;
@property (nonatomic,strong) UIButton *delete_btn;
@property (nonatomic,strong) UIButton *state_button;
@property (nonatomic,strong) UIButton *hid_btn;
@property (nonatomic,strong) UIPanGestureRecognizer *gesture;
@property (nonatomic,strong) UILongPressGestureRecognizer *longGesture;

-(void)changeColorWithNoti:(NSNotification *)noti;
-(void)makeSelectionViewWithTitle:(NSString *)title;

@end
