//
//  SelectionButton.m
//  BYDailyNews
//
//  Created by bassamyan on 15/1/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SelectionButton.h"
#define Color_maingray [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0]

@implementation SelectionButton

-(void)arrowChange
{
    [UIView animateWithDuration:0.7 animations:^{
        self.imageView.transform = CGAffineTransformMakeRotation(M_PI*2);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"Arrow.png"] forState:0];
        [self setImage:[UIImage imageNamed:@"Arrow.png"] forState:1<<0];
        self.backgroundColor = Color_maingray;
        [self addTarget:self
                 action:@selector(ArrowClickWithButton:)
       forControlEvents:1 << 6];
    }
    return self;
}
-(void)ArrowClickWithButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(ArrowClickedWithButton:)]) {
        [self.delegate ArrowClickedWithButton:button];
    }
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat width = contentRect.size.width;
    CGFloat image_width = 18;
    return CGRectMake((width-image_width)/2, (30-image_width)/2, image_width, image_width);
}

@end
