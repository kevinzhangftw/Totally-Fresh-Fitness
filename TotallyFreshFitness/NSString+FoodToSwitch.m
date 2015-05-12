//
//  NSString+FoodToSwitch.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/30/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "NSString+FoodToSwitch.h"

@implementation NSString (FoodToSwitch)

static NSString *foodItemToSwitch;

// Get user food item to switch
+(NSString *)getFoodItemToSwitch
{
    return foodItemToSwitch;
}

// Set food item to switch
+(void)setFoodItemToSwitch:(NSString *)foodItem
{
    foodItemToSwitch        = foodItem;
}

@end
