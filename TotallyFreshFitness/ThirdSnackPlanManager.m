//
//  ThirdSnackPlanManager.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "ThirdSnackPlanManager.h"

@implementation ThirdSnackPlanManager

// Database object
Database *m_database;
// Food name
NSString *m_foodName;
// Quantity
NSString *m_quantity;
// User email
NSString *m_user_email;

/*
 Singleton ThirdSnackPlanManager object
 */
+ (ThirdSnackPlanManager *)sharedInstance {
	static ThirdSnackPlanManager *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}


/*
 Add images, headings and details into each array
 */
- (void)getFoodAndQuantityFromPlistDictionaryAndSaveIntoDatabase:(NSMutableDictionary *)dictionary
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
        [m_database insertIntoThirdSnackFood:m_foodName Quantity:m_quantity forUser:m_user_email];
    }
}

// Add third snack plan into database
- (void)saveThirdSnackPlanInDatabase:(NSMutableDictionary *)dictionary
{
    if (!m_database) {
        m_database                       = [Database alloc];
    }
    m_user_email                         = [NSString getUserEmail];
    
    // Delete previous meal plan, if any
    [m_database deleteThirdSnackforUser:m_user_email];
    
    [self getFoodAndQuantityFromPlistDictionaryAndSaveIntoDatabase:dictionary];
}

@end