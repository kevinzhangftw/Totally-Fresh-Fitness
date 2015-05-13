//
//  MealPlanManager.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-02-26.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "MealPlanManager.h"
#import "Database.h"

@interface MealPlanManager()

@property (strong, nonatomic)Database *m_database;

@property (strong, nonatomic)NSString *m_foodName;
// Quantity
@property (strong, nonatomic)NSString *m_quantity;
// User email
@property (strong, nonatomic)NSString *m_user_email;
// Background Queue to create tables
@property (strong, nonatomic)dispatch_queue_t m_coreDataBackgroundQueue;

@end

@implementation MealPlanManager



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
    if (!self.m_database) {
        self.m_database          = [Database alloc];
    }

    // Get all the key first
    NSArray *keys                       = [dictionary allKeys];
    NSUInteger numberOfItems                   = [keys count];
    for (int i = 0; i < numberOfItems; i++) {
        if (([[keys objectAtIndex:i] length] != 0) || [keys objectAtIndex:i] != NULL) {
            self.m_foodName                  = [keys objectAtIndex:i]; // Add food name
        }
        
        if (([dictionary objectForKey:[keys objectAtIndex:i]] != 0) || [dictionary objectForKey:[keys objectAtIndex:i]] != NULL) {
            self.m_quantity                  = [dictionary objectForKey:[keys objectAtIndex:i]]; // Add quantity
        }
        if ([insertIntoDatabase isEqualToString:@"insertIntoBreakfastFood"]) {
            [self.m_database insertIntoBreakfastFood:self.m_foodName Quantity:self.m_quantity forUser:self.m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoFirstSnackFood"]) {
            [self.m_database insertIntoFirstSnackFood:self.m_foodName Quantity:self.m_quantity forUser:self.m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoLunchFood"]) {
            [self.m_database insertIntoLunchFood:self.m_foodName Quantity:self.m_quantity forUser:self.m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoSecondSnackFood"]) {
            [self.m_database insertIntoSecondSnackFood:self.m_foodName Quantity:self.m_quantity forUser:self.m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoDinnerFood"]) {
            [self.m_database insertIntoDinnerFood:self.m_foodName Quantity:self.m_quantity forUser:self.m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoThirdSnackFood"]) {
            [self.m_database insertIntoThirdSnackFood:self.m_foodName Quantity:self.m_quantity forUser:self.m_user_email];
        }
    }
}

// Add meal plan into database
- (void)saveMealPlanInDatabase:(NSMutableArray *)calorieArray
{
    // Each meal dictionary
    NSMutableDictionary *dictionary;
        
    if (!self.m_database) {
        self.m_database                       = [Database alloc];
    }
    self.m_user_email                         = [NSString getUserEmail];

    // Delete previous meal plan, if any
    [self.m_database deleteBreakfastforUser:self.m_user_email];
    [self.m_database deleteFirstSnackforUser:self.m_user_email];
    [self.m_database deleteLunchforUser:self.m_user_email];
    [self.m_database deleteSecondSnackforUser:self.m_user_email];
    [self.m_database deleteDinnerforUser:self.m_user_email];
    [self.m_database deleteThirdSnackforUser:self.m_user_email];
    
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
    if (!self.m_database) {
        self.m_database          = [Database alloc];
    }
    if ([mealFromDatabase isEqualToString:@"Breakfast"]) {
        return [self.m_database getBreakfastforUser:self.m_user_email];
    }
    else if ([mealFromDatabase isEqualToString:@"First Snack"]) {
        return [self.m_database getFirstSnackforUser:self.m_user_email];
    }
    else if ([mealFromDatabase isEqualToString:@"Lunch"]) {
        return [self.m_database getLunchforUser:self.m_user_email];
    }
    else if ([mealFromDatabase isEqualToString:@"Second Snack"]) {
        return [self.m_database getSecondSnackforUser:self.m_user_email];
    }
    else if ([mealFromDatabase isEqualToString:@"Dinner"]) {
        return [self.m_database getDinnerforUser:self.m_user_email];
    }
    else if ([mealFromDatabase isEqualToString:@"Third Snack"]) {
        return [self.m_database getThirdSnackforUser:self.m_user_email];
    }
    return nil;
}

@end
