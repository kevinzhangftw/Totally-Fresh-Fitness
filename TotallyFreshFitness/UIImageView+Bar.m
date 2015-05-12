//
//  UIImageView+Bar.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-10-20.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "UIImageView+Bar.h"

@implementation UIImageView (Bar)

+ (UIImageView *)topBarImage
{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TFN-topnav.png"]];
}

@end
