//
//  MealPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-02-26.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MealPlanManager : NSObject

// Singleton MealPlanManager object
+ (MealPlanManager *)sharedInstance;

// Add meal plan into database
- (void)saveMealPlanInDatabase:(NSMutableArray *)calorieArray;
// Get meal plan from database
- (NSMutableArray *)getMealPlanFromDatabase:(NSString *)mealFromDatabase;

@end
