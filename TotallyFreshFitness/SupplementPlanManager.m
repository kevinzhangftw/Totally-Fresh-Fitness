//
//  SupplementPlanManager.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/16/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "SupplementPlanManager.h"
#import "Database.h"
@interface SupplementPlanManager()

// Database object
@property (strong, nonatomic)Database *m_database;

// Supplement name
@property (strong, nonatomic)NSString *m_supplementName;
// Quantity
@property (strong, nonatomic)NSString *m_quantity;
// User email
@property (strong, nonatomic)NSString *m_user_email;
// Background Queue to create tables
@property (strong, nonatomic)dispatch_queue_t m_coreDataBackgroundQueue;
@end

@implementation SupplementPlanManager




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
    if (!self.m_database) {
        self.m_database          = [Database alloc];
    }
    // Get all the key first
    NSArray *keys                       = [dictionary allKeys];
    NSUInteger numberOfItems                   = [keys count];
    for (int i = 0; i < numberOfItems; i++) {
        if (([[keys objectAtIndex:i] length] != 0) || [keys objectAtIndex:i] != NULL) {
            self.m_supplementName                  = [keys objectAtIndex:i]; // Add supplement name
        }
        
        if (([dictionary objectForKey:[keys objectAtIndex:i]] != 0) || [dictionary objectForKey:[keys objectAtIndex:i]] != NULL) {
            self.m_quantity                  = [dictionary objectForKey:[keys objectAtIndex:i]]; // Add quantity
        }
        if ([insertIntoDatabase isEqualToString:@"insertIntoSupplementBreakfast"]) {
            [self.m_database insertIntoSupplementBreakfast:self.m_supplementName Quantity:self.m_quantity forUser:self.m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoSupplementPreWorkout"]) {
            [self.m_database insertIntoSupplementPreWorkout:self.m_supplementName Quantity:self.m_quantity forUser:self.m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoSupplementPostWorkout"]) {
            [self.m_database insertIntoSupplementPostWorkout:self.m_supplementName Quantity:self.m_quantity forUser:self.m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoSupplementBeforeBed"]) {
            [self.m_database insertIntoSupplementBeforeBed:self.m_supplementName Quantity:self.m_quantity forUser:self.m_user_email];
        }
    }
}

// Add supplement plan into database
- (void)saveSupplementPlanInDatabase:(NSMutableArray *)supplementArray
{
    // Each meal dictionary
    NSMutableDictionary *dictionary;
    
    if (!self.m_database) {
        self.m_database                       = [Database alloc];
    }
    self.m_user_email                         = [NSString getUserEmail];
    
    // Delete previous supplement plan, if any
    [self.m_database deleteSupplementBreakfastforUser:self.m_user_email];
    [self.m_database deleteSupplementPreWorkoutforUser:self.m_user_email];
    [self.m_database deleteSupplementPostWorkoutforUser:self.m_user_email];
    [self.m_database deleteSupplementBeforeBedforUser:self.m_user_email];
    
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
    if (!self.m_database) {
        self.m_database          = [Database alloc];
    }
    if ([mealFromDatabase isEqualToString:@"SupplementBreakfast"]) {
        return [self.m_database getSupplementBreakfastforUser:self.m_user_email];
    }
    else if ([mealFromDatabase isEqualToString:@"SupplementPreWorkout"]) {
        return [self.m_database getSupplementPreWorkoutforUser:self.m_user_email];
    }
    else if ([mealFromDatabase isEqualToString:@"SupplementPostWorkout"]) {
        return [self.m_database getSupplementPostWorkoutforUser:self.m_user_email];
    }
    else if ([mealFromDatabase isEqualToString:@"SupplementBeforeBed"]) {
        return [self.m_database getSupplementBeforeBedforUser:self.m_user_email];
    }
    return nil;
}

@end
