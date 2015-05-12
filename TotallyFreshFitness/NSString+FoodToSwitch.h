//
//  NSString+FoodToSwitch.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/30/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FoodToSwitch)

// Get user food item to switch
+(NSString *)getFoodItemToSwitch;
// Set food item to switch
+(void)setFoodItemToSwitch:(NSString *)foodItem;

@end
