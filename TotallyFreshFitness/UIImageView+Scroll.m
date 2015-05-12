//
//  UIImageView+Scroll.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-10-03.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "UIImageView+Scroll.h"

@implementation UIImageView (Scroll)

/*
 Animate image scroll bars
 */
+ (void)animateHorizontalScrollsNotch:(UIImageView *)notch  fromNotch:(CGRect)sourceNotch toNotch:(CGRect)destinationNotch sourceNotchState:(BOOL)state
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration: 0.25];
    
    if (notch.frame.origin.x == sourceNotch.origin.x) {
        notch.frame          = destinationNotch;
        notch.hidden         = state;
    }
    [UIView commitAnimations];
}


@end
