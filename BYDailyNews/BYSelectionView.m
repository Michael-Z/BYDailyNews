//
//  BYSelectionView.m
//  BYDailyNews
//
//  Created by bassamyan on 15/1/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "BYSelectionView.h"
#define Color_gray  [UIColor colorWithRed:111.0/255 green:111.0/255 blue:111.0/255 alpha:1.0]
#define border_gray [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0]
#define BYScreenWidth [UIScreen mainScreen].bounds.size.width
#define BYScreenHeight [UIScreen mainScreen].bounds.size.height

@interface BYSelectionView()
{
    CGFloat view_width;
}

@end

@implementation BYSelectionView

-(void)makeSelectionViewWithTitle:(NSString *)title
{
    
    self.gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    self.longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress)];
    self.longGesture.minimumPressDuration = 1;
    self.longGesture.allowableMovement = 20;
    [self addGestureRecognizer:self.longGesture];
    
    view_width = ([UIScreen mainScreen].bounds.size.width-20*5)/4;
    [self setTitle:title forState:0];
    [self setTitleColor:Color_gray forState:0];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.layer.cornerRadius = 4;
    self.layer.borderColor = [border_gray CGColor];
    self.layer.borderWidth = 0.5;
    self.backgroundColor = [UIColor whiteColor];
    if ([title isEqualToString:@"推荐"]) {
        [self setTitleColor:[UIColor redColor] forState:0];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeColorWithNoti:)
                                                 name:@"select_items"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addGesture)
                                                 name:@"add_gesture"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addGestureWithLongPress)
                                                 name:@"long_press"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(conditionBarItemClick:)
                                                 name:@"selfBarItemClick"
                                               object:nil];
    
    //删除图标
    if (![title isEqualToString:@"推荐"]) {
        CGFloat delete_btn_width = 6;
        self.delete_btn = [[UIButton alloc] initWithFrame:CGRectMake(-delete_btn_width+2, -delete_btn_width+2, 2*delete_btn_width, 2*delete_btn_width)];
        self.delete_btn.userInteractionEnabled = NO;
        [self.delete_btn setImage:[UIImage imageNamed:@"delete.png"] forState:0];
        self.delete_btn.backgroundColor = Color_gray;
        self.delete_btn.layer.cornerRadius = self.delete_btn.frame.size.width/2;
        self.delete_btn.hidden = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self.delete_btn
                                                 selector:@selector(deletebuttonClick)
                                                     name:@"delete_btn_click"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self.delete_btn
                                                 selector:@selector(deletebuttonClick)
                                                     name:@"long_press"
                                                   object:nil];
        [self addSubview:self.delete_btn];
    }

    //屏蔽按钮
    self.hid_btn = [[UIButton alloc] initWithFrame:self.bounds];
    self.hid_btn.tag = 0;//0 显示  1 隐藏
    self.hid_btn.hidden = NO;
    [self.hid_btn addTarget:self
                     action:@selector(buttonclick)
           forControlEvents:1 << 6];
    [[NSNotificationCenter defaultCenter] addObserver:self.hid_btn
                                             selector:@selector(hidbuttonClick)
                                                 name:@"delete_btn_click"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self.hid_btn
                                             selector:@selector(hidbuttonClick)
                                                 name:@"long_press"
                                               object:nil];
    
    [self addSubview:self.hid_btn];
    
    [self addTarget:self
             action:@selector(addanddelete)
   forControlEvents:1<<6];
}

-(void)conditionBarItemClick:(NSNotification *)noti
{
    NSString *title = [noti.userInfo objectForKey:@"title"];
    if ([self.titleLabel.text isEqualToString:@"推荐"]) {
        [self setTitleColor:border_gray forState:0];
    }
    if ([self.titleLabel.text isEqualToString:title]) {
        [self setTitleColor:[UIColor redColor] forState:0];
    }
    else if (![self.titleLabel.text isEqualToString:title] && ![self.titleLabel.text isEqualToString:@"推荐"])
    {
        [self setTitleColor:Color_gray forState:0];
    }
}


-(void)longPress
{
    if (self.hid_btn.hidden == NO) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"long_press"
                                                            object:self
                                                          userInfo:nil];
    }
}

-(void)addGestureWithLongPress
{
    if (self.tag == 1) {
        [self addGestureRecognizer:self.gesture];
    }
}

-(void)addGesture
{
    if (self.gestureRecognizers != nil) {
        [self removeGestureRecognizer:self.gesture];
    }
    if (self.tag == 1 && self.hid_btn.hidden == YES && ![self.titleLabel.text isEqualToString:@"推荐"]) {
        [self addGestureRecognizer:self.gesture];
    }
}

-(void)changeColorWithNoti:(NSNotification *)noti
{
    NSString *title = [noti.userInfo objectForKey:@"title"];
    if (![self.titleLabel.text isEqualToString:title]) {
        [self setTitleColor:Color_gray forState:0];
        if ([self.titleLabel.text isEqualToString:@"推荐"]) {
            [self setTitleColor:border_gray forState:0];
        }
    }
}

-(void)buttonclick//self tag  1 位于上方  0 位于下方
{
    if (self.tag == 1 && self.hid_btn.hidden == NO) {//self 位于上方 点击直接选择
        [self setTitleColor:[UIColor redColor] forState:0];
        NSString *title = self.titleLabel.text;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"select_items"
                                                            object:self
                                                          userInfo:@{@"title":title}];
    }
    else if (self.tag == 0 && self.hid_btn.hidden == NO)//self 位于下方 点击无删除按钮
    {
        if (views_array == views2) {
            [views_array removeObject:self];
            [views1 insertObject:self atIndex:views1.count];
            views_array = views1;
            self.tag = 1;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"addNewItem"
                                                                object:self
                                                              userInfo:@{@"title":self.titleLabel.text}];
        }
    }
    [self animationActionFinal];
}


-(void)addanddelete//self tag  1 位于上方  0 位于下方
{
    if (self.tag == 1 && self.hid_btn.hidden == YES && ![self.titleLabel.text isEqualToString:@"推荐"])//self 位于上方 且hid_btn 已隐藏 本身可移动 可点击删除
    {
        if (views_array == views1) {
            [views_array removeObject:self];
            [views2 insertObject:self atIndex:0];
            views_array = views2;
            self.tag = 0;
            self.delete_btn.hidden = YES;
            [self removeGestureRecognizer:self.gesture];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"removeItem"
                                                                object:self
                                                              userInfo:@{@"title":self.titleLabel.text}];
        }
    }
    else if (self.tag == 0 && self.hid_btn.hidden == YES) { // self 位于下方 且 hid_btn 已隐藏 本身可点击
        if (views_array == views2) {
            [views_array removeObject:self];
            [views1 insertObject:self atIndex:views1.count];
            views_array = views1;
            self.tag = 1;
            self.delete_btn.hidden = NO;
            [self addGestureRecognizer:self.gesture];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"addNewItem"
                                                                object:self
                                                              userInfo:@{@"title":self.titleLabel.text}];
        }
    }
    [self animationActionFinal];
}

- (void)panView:(UIPanGestureRecognizer *)pan
{
    [self.superview exchangeSubviewAtIndex:[self.superview.subviews indexOfObject:self] withSubviewAtIndex:[[self.superview subviews] count] - 1];
    
    CGPoint translation = [pan translationInView:pan.view];
    CGPoint center = pan.view.center;
    center.x += translation.x;
    center.y += translation.y;
    pan.view.center = center;
    [pan setTranslation:CGPointZero inView:pan.view];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: // 开始触发手势
            break;
        case UIGestureRecognizerStateChanged:
            if (views_array == views1) {
                if ([self whetherInAreaWithArray:views1 Point:center]) {
                    
                    NSInteger indexX;
                    if (center.x <= view_width+40) {
                        indexX = 0;
                    }
                    else
                    {
                        indexX = (center.x - view_width-40)/(20+view_width) + 1;
                    }
                    
                    NSInteger indexY;
                    if (center.y <= 65) {
                        indexY = 0;
                    }
                    else
                    {
                        indexY = (center.y - 65)/45 + 1;
                    }
                    
                    NSInteger index = indexX + indexY*4;

                    [views_array removeObject:self];
                    if (index == 0) {//使第一个不能移动
                        index = 1;
                    }
                    [views1 insertObject:self atIndex:index];
                    views_array = views1;
                    [self animationAction11];
                    
                    //移动中更改frame
                    //传递位置 index 和 标题 title
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeItemPositionWithPosition"
                                                                        object:self
                                                                      userInfo:@{@"title":self.titleLabel.text,
                                                                                 @"index":[NSString stringWithFormat:@"%d",(int)index]}];
                    
                }
                else if (![self whetherInAreaWithArray:views1 Point:center] && center.y < [self array1MaxY]+50) {
                    [views_array removeObject:self];
                    [views1 insertObject:self atIndex:views1.count];
                    views_array = views1;
                    [self animationAction11];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeItemsPosition"
                                                                        object:self
                                                                      userInfo:@{@"title":self.titleLabel.text}];
                    
                }
                else if (center.y > [self array1MaxY]+50 && views_array == views1)
                {
                    [views_array removeObject:self];
                    [views2 insertObject:self atIndex:0];
                    views_array = views2;
                    [self animationAction22];
                    self.tag = 0;
                    self.delete_btn.hidden = YES;
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeItem"
                                                                        object:self
                                                                      userInfo:@{@"title":self.titleLabel.text}];
                }
            }
            break;
        case UIGestureRecognizerStateEnded: // 手势结束
            [self animationActionFinal];
            break;
        default:
            break;
    }
}


- (BOOL)whetherInAreaWithArray:(NSMutableArray *)array Point:(CGPoint)point{
    int row =  array.count%4;
    if (row == 0) {
        row = 4;
    }
    int column =  (int)(array.count-1)/4+1;
    if ((point.x > 0 && point.x <=BYScreenWidth &&point.y > 0 && point.y <= 45*(column-1)+20 )||
        (point.x > 0 && point.x <= (row*(20+view_width)+20 )&& point.y > 45*(column -1)+20 && point.y <= 45 * column+20))
    {
        return YES;
    }
    return NO;
}


- (unsigned long)array1MaxY{
    unsigned long y = 0;
    y = ((views1.count-1)/4+1)*45 +20;
    return y;
}


- (void)animationAction11
{
    for (int i = 0; i < views1.count; i++){
        if ([views1 objectAtIndex:i] != self){
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                [[views1 objectAtIndex:i] setFrame:CGRectMake(20+(20+view_width)*(i%4), 20+45*(i/4), view_width, 25)];
                
            } completion:^(BOOL finished){
            }];
        }
    }
}

- (void)animationAction2{
    for (int i = 0; i < views2.count; i++) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [[views2 objectAtIndex:i] setFrame:CGRectMake(20+(20+view_width)*(i%4), [self array1MaxY]+50+45*(i/4), view_width, 25)];
        } completion:^(BOOL finished){
        }];
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self.moreChanelslabel setFrame:CGRectMake(0,[self array1MaxY],BYScreenWidth,30)];
    } completion:^(BOOL finished){
        
    }];
}

- (void)animationAction22{
    for (int i = 0; i < views2.count; i++) {
        if ([views2 objectAtIndex:i] != self) {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                [[views2 objectAtIndex:i] setFrame:CGRectMake(20+(20+view_width)*(i%4), [self array1MaxY]+50+45*(i/4), view_width, 25)];
            } completion:^(BOOL finished){
            }];
        }
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self.moreChanelslabel setFrame:CGRectMake(0,[self array1MaxY],BYScreenWidth,30)];
    } completion:^(BOOL finished){
        
    }];
}

- (void)animationActionFinal
{
    for (int i = 0; i <views1.count; i++) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [[views1 objectAtIndex:i] setFrame:CGRectMake(20+(20+view_width)*(i%4), 20+45*(i/4), view_width, 25)];
        } completion:^(BOOL finished){
            
        }];
    }
    for (int i = 0; i < views2.count; i++) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [[views2 objectAtIndex:i] setFrame:CGRectMake(20+(20+view_width)*(i%4), [self array1MaxY]+50+45*(i/4), view_width, 25)];
        } completion:^(BOOL finished){
            
        }];
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self.moreChanelslabel setFrame:CGRectMake(0,[self array1MaxY],BYScreenWidth,30)];
    } completion:^(BOOL finished){
        
    }];
}

@end
