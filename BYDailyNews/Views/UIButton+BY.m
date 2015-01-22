//
//  UIButton+BY.m
//  BYDailyNews
//
//  Created by bassamyan on 15/1/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIButton+BY.h"

@implementation UIButton (BY)

-(void)sortButtonClick
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


@end
