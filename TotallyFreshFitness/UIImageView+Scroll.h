//
//  UIImageView+Scroll.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-10-03.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Scroll)

// Animate notch horizontally
+ (void)animateHorizontalScrollsNotch:(UIImageView *)notch  fromNotch:(CGRect)sourceNotch toNotch:(CGRect)destinationNotch sourceNotchState:(BOOL)state;

@end
