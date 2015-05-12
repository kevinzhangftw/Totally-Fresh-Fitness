//
//  SupplementPlanManager.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/16/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "SupplementPlanManager.h"
#import "Database.h"

@implementation SupplementPlanManager

// Database object
Database *m_database;
// Supplement name
NSString *m_supplementName;
// Quantity
NSString *m_quantity;
// User email
NSString *m_user_email;
// Background Queue to create tables
dispatch_queue_t m_coreDataBackgroundQueue;


/*
 Singleton SupplementPlanManager object
 */
+ (SupplementPlanManager *)sharedInstance {
	static SupplementPlanManager *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}


/*
 Add images, headings and details into each array
 */
- (void)getSupplementAndQuantityFromPlistDictionary:(NSMutableDictionary *)dictionary AndSaveIntoDatabase:(NSString *)insertIntoDatabase
{
    if (!m_database) {
        m_database          = [Database alloc];
    }
    // Get all the key first
    NSArray *keys                       = [dictionary allKeys];
    NSUInteger numberOfItems                   = [keys count];
    for (int i = 0; i < numberOfItems; i++) {
        if (([[keys objectAtIndex:i] length] != 0) || [keys objectAtIndex:i] != NULL) {
            m_supplementName                  = [keys objectAtIndex:i]; // Add supplement name
        }
        
        if (([dictionary objectForKey:[keys objectAtIndex:i]] != 0) || [dictionary objectForKey:[keys objectAtIndex:i]] != NULL) {
            m_quantity                  = [dictionary objectForKey:[keys objectAtIndex:i]]; // Add quantity
        }
        if ([insertIntoDatabase isEqualToString:@"insertIntoSupplementBreakfast"]) {
            [m_database insertIntoSupplementBreakfast:m_supplementName Quantity:m_quantity forUser:m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoSupplementPreWorkout"]) {
            [m_database insertIntoSupplementPreWorkout:m_supplementName Quantity:m_quantity forUser:m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoSupplementPostWorkout"]) {
            [m_database insertIntoSupplementPostWorkout:m_supplementName Quantity:m_quantity forUser:m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoSupplementBeforeBed"]) {
            [m_database insertIntoSupplementBeforeBed:m_supplementName Quantity:m_quantity forUser:m_user_email];
        }
    }
}

// Add supplement plan into database
- (void)saveSupplementPlanInDatabase:(NSMutableArray *)supplementArray
{
    // Each meal dictionary
    NSMutableDictionary *dictionary;
    
    if (!m_database) {
        m_database                       = [Database alloc];
    }
    m_user_email                         = [NSString getUserEmail];
    
    // Delete previous supplement plan, if any
    [m_database deleteSupplementBreakfastforUser:m_user_email];
    [m_database deleteSupplementPreWorkoutforUser:m_user_email];
    [m_database deleteSupplementPostWorkoutforUser:m_user_email];
    [m_database deleteSupplementBeforeBedforUser:m_user_email];
    
    for (int i = 0; i < [supplementArray count]; i++) {
        
        dictionary                       = [supplementArray objectAtIndex:i];
        
        if (i == 0) { // save supplement breakfast meal
            [self getSupplementAndQuantityFromPlistDictionary:dictionary AndSaveIntoDatabase:@"insertIntoSupplementBreakfast"];
        }
        else if(i == 1) { // save supplement pre workout
            [self getSupplementAndQuantityFromPlistDictionary:dictionary AndSaveIntoDatabase:@"insertIntoSupplementPreWorkout"];
        }
        else if(i == 2) { // save supplement post workout
            [self getSupplementAndQuantityFromPlistDictionary:dictionary AndSaveIntoDatabase:@"insertIntoSupplementPostWorkout"];
        }
        else if(i == 3  ) { // save supplement before bed
            [self getSupplementAndQuantityFromPlistDictionary:dictionary AndSaveIntoDatabase:@"insertIntoSupplementBeforeBed"];
        }
    }
}

// Get supplement plan from database
- (NSMutableArray *)getSupplementPlanFromDatabase:(NSString *)mealFromDatabase
{
    if (!m_database) {
        m_database          = [Database alloc];
    }
    if ([mealFromDatabase isEqualToString:@"SupplementBreakfast"]) {
        return [m_database getSupplementBreakfastforUser:m_user_email];
    }
    else if ([mealFromDatabase isEqualToString:@"SupplementPreWorkout"]) {
        return [m_database getSupplementPreWorkoutforUser:m_user_email];
    }
    else if ([mealFromDatabase isEqualToString:@"SupplementPostWorkout"]) {
        return [m_database getSupplementPostWorkoutforUser:m_user_email];
    }
    else if ([mealFromDatabase isEqualToString:@"SupplementBeforeBed"]) {
        return [m_database getSupplementBeforeBedforUser:m_user_email];
    }
    return nil;
}

@end
