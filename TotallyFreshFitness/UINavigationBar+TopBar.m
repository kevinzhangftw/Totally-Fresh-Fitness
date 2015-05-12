//
//  UINavigationBar+TopBar.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-10-20.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "UINavigationBar+TopBar.h"

@implementation UINavigationBar (TopBar)

+ (void)setUpTopBar:(id)object
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    }
}

@end
