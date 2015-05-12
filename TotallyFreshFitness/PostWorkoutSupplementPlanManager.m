//
//  PostWorkoutSupplementPlanManager.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "PostWorkoutSupplementPlanManager.h"

@implementation PostWorkoutSupplementPlanManager

// Database object
Database *m_database;
// Supplement name
NSString *m_supplementName;
// Quantity
NSString *m_quantity;
// User email
NSString *m_user_email;

/*
 Singleton PostWorkoutSupplementPlanManager object
 */
+ (PostWorkoutSupplementPlanManager *)sharedInstance {
	static PostWorkoutSupplementPlanManager *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}


/*
 Add images, headings and details into each array
 */
- (void)getSupplementAndQuantityFromPlistDictionaryAndSaveIntoDatabase:(NSMutableDictionary *)dictionary
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
        [m_database insertIntoSupplementPostWorkout:m_supplementName Quantity:m_quantity forUser:m_user_email];
    }
}

// Add post workout supplement plan into database
- (void)savePostWorkoutSupplementPlanInDatabase:(NSMutableDictionary *)supplementDictionary
{
    if (!m_database) {
        m_database                       = [Database alloc];
    }
    m_user_email                         = [NSString getUserEmail];
    
    // Delete previous supplement plan, if any
    [m_database deleteSupplementPostWorkoutforUser:m_user_email];
    
    [self getSupplementAndQuantityFromPlistDictionaryAndSaveIntoDatabase:supplementDictionary];
}

@end
