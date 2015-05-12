//
//  UILabel+Scroll.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-10-05.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Scroll)

// Animate label horizontally
+ (void)animateHorizontalScrollsLabel:(UILabel *)label  fromLabel:(CGRect)sourceLabel toLabel:(CGRect)destinationLabel sourceLabelState:(BOOL)state;

@end
