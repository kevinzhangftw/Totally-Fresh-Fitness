//
//  MealPlanSelection.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-07.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MealPlanSelection : NSObject

// General plist load up
- (NSMutableArray *)loadUpPlist:(NSString *)plist;
// Load up plist file
- (NSMutableArray *)calorieSelection:(int)calories Gender:(NSString *)gender;

// Singleton MealPlanSelection object
+ (MealPlanSelection *)sharedInstance;

@end
