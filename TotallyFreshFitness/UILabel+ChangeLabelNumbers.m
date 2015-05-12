//
//  UILabel+ChangeLabelNumbers.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/30/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "UILabel+ChangeLabelNumbers.h"

@implementation UILabel (ChangeLabelNumbers)

// Increment by 10
+ (NSString *)incrementBy10:(int)labelValue
{
    labelValue                 = labelValue + 10;
    return [NSString stringWithFormat:@"%d", labelValue];
}

// Decrement by 10
+ (NSString *)decrementBy10:(int)labelValue
{
    labelValue                 = labelValue - 10;
    return [NSString stringWithFormat:@"%d", labelValue];
}

// Increment labels by 10
+ (void)incrementBy10OnLabelOne:(UILabel *)labelOne LabelTwo:(UILabel *)labelTwo LabelThree:(UILabel *)labelThree LabelFour:(UILabel *)labelFour LabelFive:(UILabel *)labelFive
{
    labelOne.text               = [self incrementBy10:[labelOne.text intValue]];
    labelTwo.text               = [self incrementBy10:[labelTwo.text intValue]];
    labelThree.text             = [self incrementBy10:[labelThree.text intValue]];
    labelFour.text              = [self incrementBy10:[labelFour.text intValue]];
    labelFive.text              = [self incrementBy10:[labelFive.text intValue]];
}

// Decrement labels by 10
+ (void)decrementBy10OnLabelOne:(UILabel *)labelOne LabelTwo:(UILabel *)labelTwo LabelThree:(UILabel *)labelThree LabelFour:(UILabel *)labelFour LabelFive:(UILabel *)labelFive
{
    labelOne.text               = [self decrementBy10:[labelOne.text intValue]];
    labelTwo.text               = [self decrementBy10:[labelTwo.text intValue]];
    labelThree.text             = [self decrementBy10:[labelThree.text intValue]];
    labelFour.text              = [self decrementBy10:[labelFour.text intValue]];
    labelFive.text              = [self decrementBy10:[labelFive.text intValue]];
}

@end
