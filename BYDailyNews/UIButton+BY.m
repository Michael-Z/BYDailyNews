//
//  UIButton+BY.m
//  BYDailyNews
//
//  Created by bassamyan on 15/1/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIButton+BY.h"
#define Color_gray  [UIColor colorWithRed:111.0/255 green:111.0/255 blue:111.0/255 alpha:1.0]
#define border_gray [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0]
@implementation UIButton (BY)


-(void)deletebuttonClick
{
    //1 view在上方 点击后出现删除按钮  0 view在下方 始终不显示
    if (self.superview.tag == 1)
    {
        self.hidden = !self.hidden;
    }
}

-(void)hidbuttonClick
{
    if (self.tag == 0) {
        self.tag = 1;
        self.hidden = YES;
    }
    else if(self.tag == 1)
    {
        self.tag = 0;
        self.hidden = NO;
    }
}
-(void)longPressChange
{
    [self setTitle:@"完成" forState:0];
}


@end
