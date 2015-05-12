//
//  MealPlanManager.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-02-26.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "MealPlanManager.h"
#import "Database.h"

@implementation MealPlanManager

// Database object
Database *m_database;
// Food name
NSString *m_foodName;
// Quantity
NSString *m_quantity;
// User email
NSString *m_user_email;
// Background Queue to create tables
dispatch_queue_t m_coreDataBackgroundQueue;


/*
 Singleton MealPlanManager object
 */
+ (MealPlanManager *)sharedInstance {
	static MealPlanManager *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}


/*
 Add images, headings and details into each array
 */
- (void)getFoodAndQuantityFromPlistDictionary:(NSMutableDictionary *)dictionary AndSaveIntoDatabase:(NSString *)insertIntoDatabase
{
    if (!m_database) {
        m_database          = [Database alloc];
    }

    // Get all the key first
    NSArray *keys                       = [dictionary allKeys];
    NSUInteger numberOfItems                   = [keys count];
    for (int i = 0; i < numberOfItems; i++) {
        if (([[keys objectAtIndex:i] length] != 0) || [keys objectAtIndex:i] != NULL) {
            m_foodName                  = [keys objectAtIndex:i]; // Add food name
        }
        
        if (([dictionary objectForKey:[keys objectAtIndex:i]] != 0) || [dictionary objectForKey:[keys objectAtIndex:i]] != NULL) {
            m_quantity                  = [dictionary objectForKey:[keys objectAtIndex:i]]; // Add quantity
        }
        if ([insertIntoDatabase isEqualToString:@"insertIntoBreakfastFood"]) {
            [m_database insertIntoBreakfastFood:m_foodName Quantity:m_quantity forUser:m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoFirstSnackFood"]) {
            [m_database insertIntoFirstSnackFood:m_foodName Quantity:m_quantity forUser:m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoLunchFood"]) {
            [m_database insertIntoLunchFood:m_foodName Quantity:m_quantity forUser:m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoSecondSnackFood"]) {
            [m_database insertIntoSecondSnackFood:m_foodName Quantity:m_quantity forUser:m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoDinnerFood"]) {
            [m_database insertIntoDinnerFood:m_foodName Quantity:m_quantity forUser:m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoThirdSnackFood"]) {
            [m_database insertIntoThirdSnackFood:m_foodName Quantity:m_quantity forUser:m_user_email];
        }
    }
}

// Add meal plan into database
- (void)saveMealPlanInDatabase:(NSMutableArray *)calorieArray
{
    // Each meal dictionary
    NSMutableDictionary *dictionary;
        
    if (!m_database) {
        m_database                       = [Database alloc];
    }
    m_user_email                         = [NSString getUserEmail];

    // Delete previous meal plan, if any
    [m_database deleteBreakfastforUser:m_user_email];
    [m_database deleteFirstSnackforUser:m_user_email];
    [m_database deleteLunchforUser:m_user_email];
    [m_database deleteSecondSnackforUser:m_user_email];
    [m_database deleteDinnerforUser:m_user_email];
    [m_database deleteThirdSnackforUser:m_user_email];
    
    for (int i = 0; i < [calorieArray count]; i++) {
        
        dictionary                       = [calorieArray objectAtIndex:i];
        
        if (i == 0) { // save breakfast meal
            [self getFoodAndQuantityFromPlistDictionary:dictionary AndSaveIntoDatabase:@"insertIntoBreakfastFood"];
        }
        else if(i == 1) { // save first snack
            [self getFoodAndQuantityFromPlistDictionary:dictionary AndSaveIntoDatabase:@"insertIntoFirstSnackFood"];
        }
        else if(i == 2) { // save lunch meal
            [self getFoodAndQuantityFromPlistDictionary:dictionary AndSaveIntoDatabase:@"insertIntoLunchFood"];
        }
        else if(i == 3  ) { // save second snack
            [self getFoodAndQuantityFromPlistDictionary:dictionary AndSaveIntoDatabase:@"insertIntoSecondSnackFood"];
        }
        else if(i == 4) { // save dinner meal
            [self getFoodAndQuantityFromPlistDictionary:dictionary AndSaveIntoDatabase:@"insertIntoDinnerFood"];
        }
        else if(i == 5) { // save third snack
            [self getFoodAndQuantityFromPlistDictionary:dictionary AndSaveIntoDatabase:@"insertIntoThirdSnackFood"];
        }
     }
}

// Get meal plan from database
- (NSMutableArray *)getMealPlanFromDatabase:(NSString *)mealFromDatabase
{
    if (!m_database) {
        m_database          = [Database alloc];
    }
    if ([mealFromDatabase isEqualToString:@"Breakfast"]) {
        return [m_database getBreakfastforUser:m_user_email];
    }
    else if ([mealFromDatabase isEqualToString:@"First Snack"]) {
        return [m_database getFirstSnackforUser:m_user_email];
    }
    else if ([mealFromDatabase isEqualToString:@"Lunch"]) {
        return [m_database getLunchforUser:m_user_email];
    }
    else if ([mealFromDatabase isEqualToString:@"Second Snack"]) {
        return [m_database getSecondSnackforUser:m_user_email];
    }
    else if ([mealFromDatabase isEqualToString:@"Dinner"]) {
        return [m_database getDinnerforUser:m_user_email];
    }
    else if ([mealFromDatabase isEqualToString:@"Third Snack"]) {
        return [m_database getThirdSnackforUser:m_user_email];
    }
    return nil;
}

@end
