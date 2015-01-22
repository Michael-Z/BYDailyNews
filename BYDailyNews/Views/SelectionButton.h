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

typedef void (^arrowChange)(BYSelectionDetails *details , BYSelectNewBar *newBar);
@interface SelectionButton : UIButton
{
    @public
    BYSelectNewBar *NewBar;
    BYSelectionDetails *Details;
}
@property (nonatomic,copy) arrowChange change;
@end