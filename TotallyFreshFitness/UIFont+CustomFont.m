//
//  UIFont+CustomFont.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-10-20.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "UIFont+CustomFont.h"

@implementation UIFont (CustomFont)

+(UIFont *)customFontWithSize:(int)fontSize
{
    return [UIFont fontWithName:@"Lato-Regular" size:fontSize];
}

@end
