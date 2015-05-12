//
//  PreWorkoutSupplementPlanManager.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "PreWorkoutSupplementPlanManager.h"

@implementation PreWorkoutSupplementPlanManager

// Database object
Database *m_database;
// Supplement name
NSString *m_supplementName;
// Quantity
NSString *m_quantity;
// User email
NSString *m_user_email;

/*
 Singleton PreWorkoutSupplementPlanManager object
 */
+ (PreWorkoutSupplementPlanManager *)sharedInstance {
	static PreWorkoutSupplementPlanManager *globalInstance;
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
    NSInteger numberOfItems                   = [keys count];
    for (int i = 0; i < numberOfItems; i++) {
        if (([[keys objectAtIndex:i] length] != 0) || [keys objectAtIndex:i] != NULL) {
            m_supplementName                  = [keys objectAtIndex:i]; // Add supplement name
        }
        
        if (([dictionary objectForKey:[keys objectAtIndex:i]] != 0) || [dictionary objectForKey:[keys objectAtIndex:i]] != NULL) {
            m_quantity                  = [dictionary objectForKey:[keys objectAtIndex:i]]; // Add quantity
        }
        [m_database insertIntoSupplementPreWorkout:m_supplementName Quantity:m_quantity forUser:m_user_email];
    }
}

// Add supplement plan into database
- (void)savePreWorkoutSupplementPlanInDatabase:(NSMutableDictionary *)supplementDictionary
{
    if (!m_database) {
        m_database                       = [Database alloc];
    }
    m_user_email                         = [NSString getUserEmail];
    
    // Delete previous supplement plan, if any
    [m_database deleteSupplementPreWorkoutforUser:m_user_email];
    
    [self getSupplementAndQuantityFromPlistDictionaryAndSaveIntoDatabase:supplementDictionary];
}

@end
