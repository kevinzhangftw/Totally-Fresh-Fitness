//
//  UILabel+Scroll.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-10-05.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "UILabel+Scroll.h"

@implementation UILabel (Scroll)

// Animate label horizontally
+ (void)animateHorizontalScrollsLabel:(UILabel *)label  fromLabel:(CGRect)sourceLabel toLabel:(CGRect)destinationLabel sourceLabelState:(BOOL)state
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration: 0.25];
    
    if (label.frame.origin.x == sourceLabel.origin.x) {
        label.frame          = destinationLabel;
        label.hidden         = state;
    }
    [UIView commitAnimations];
}

@end
