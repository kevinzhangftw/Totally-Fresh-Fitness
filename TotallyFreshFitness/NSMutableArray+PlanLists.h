//
//  NSMutableArray+PlanLists.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-09-21.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (PlanLists)

// MutableArray object
+ (NSMutableArray *) mutableArrayObject;
// Load up plan lists in arrays
+ (NSArray *) setImagesAndetKeyAndsetValueFromStockArray:(NSMutableArray *)stockArray forPlan:(NSString *)plan;
// Load up workout plan list
+ (NSMutableArray *) loadUpWorkoutPlan;
// Add images, headings and details into each array
+ (NSArray *) setImagesAndSetKeyAndsetValueFromStockArrayForMealPlan:(NSMutableArray *)stockArray;
// Load up meal plan list
+ (NSMutableArray *) loadUpMealPlan;
// load up the right workout for the user for the day
+ (NSArray *) loadUpWorkoutPlan:(NSString *)day;
// load up images for plan
+ (NSMutableArray *)getImages:(NSMutableArray *)planArray forPlan:(NSString *)plan;
// Add images, headings and details into each array
+ (NSArray *)setImagesAndetKeyAndsetValueFromStockArrayForSupplementPlan:(NSMutableArray *)stockArray;
// Get Supplement details from the database
+ (NSMutableArray *) loadUpSupplementPlan;
// Get Supplement Order list
+ (NSMutableArray *)loadUpSupplementOrder;
// Get Supplement Order images
+ (NSMutableArray *)loadUpSupplementOrderImages;
// Get Supplement Order links
+(NSMutableArray *)loadUpSupplementOrderLinks;

@end
