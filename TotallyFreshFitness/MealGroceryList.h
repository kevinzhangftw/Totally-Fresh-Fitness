//
//  MealGroceryList.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-02-09.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MealGroceryList : NSObject

// Singleton MealGroceryList object
+ (MealGroceryList *)sharedInstance;

// Add to grocery list
- (NSString *)addToGroceryList:(NSString *)foodName;
// Select meal plan to add to meal plan
- (NSString *)addToMealPlanList:(NSString *)foodName andQuantity:(NSString *)quantity;
// Get grocery list
- (NSMutableArray *)getGroceryList:(NSMutableArray *)calorieArray;
// Check if the meal already exist in the meal plan
- (BOOL)checkifMealAlreadyExistInMealPlan:(NSString *)foodName;
//Check if food exist in the grocery list
- (BOOL)checkIfMealAlreadyExistInGroceryList:(NSString *)foodName;

@end
