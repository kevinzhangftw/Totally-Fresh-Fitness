//
//  UILabel+ChangeLabelNumbers.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/30/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ChangeLabelNumbers)

// Increment labels by 10
+ (void)incrementBy10OnLabelOne:(UILabel *)labelOne LabelTwo:(UILabel *)labelTwo LabelThree:(UILabel *)labelThree LabelFour:(UILabel *)labelFour LabelFive:(UILabel *)labelFive;

// Decrement labels by 10
+ (void)decrementBy10OnLabelOne:(UILabel *)labelOne LabelTwo:(UILabel *)labelTwo LabelThree:(UILabel *)labelThree LabelFour:(UILabel *)labelFour LabelFive:(UILabel *)labelFive;

@end
