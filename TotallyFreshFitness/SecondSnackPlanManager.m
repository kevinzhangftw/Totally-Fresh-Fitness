//
//  SecondSnackPlanManager.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "SecondSnackPlanManager.h"
@interface SecondSnackPlanManager()
// Database object
@property (strong, nonatomic)Database *m_database;
// Exercise name
@property (strong, nonatomic)NSString *m_foodName;
// Quantity
@property (strong, nonatomic)NSString *m_quantity;
// User email
@property (strong, nonatomic)NSString *m_user_email;
@end

@implementation SecondSnackPlanManager


/*
 Singleton SecondSnackPlanManager object
 */
+ (SecondSnackPlanManager *)sharedInstance {
	static SecondSnackPlanManager *globalInstance;
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
    if (!self.m_database) {
        self.m_database          = [Database alloc];
    }
    
    // Get all the key first
    NSArray *keys                       = [dictionary allKeys];
    NSInteger numberOfItems                   = [keys count];
    for (int i = 0; i < numberOfItems; i++) {
        if (([[keys objectAtIndex:i] length] != 0) || [keys objectAtIndex:i] != NULL) {
            self.m_foodName                  = [keys objectAtIndex:i]; // Add food name
        }
        
        if (([dictionary objectForKey:[keys objectAtIndex:i]] != 0) || [dictionary objectForKey:[keys objectAtIndex:i]] != NULL) {
            self.m_quantity                  = [dictionary objectForKey:[keys objectAtIndex:i]]; // Add quantity
        }
        [self.m_database insertIntoSecondSnackFood:self.m_foodName Quantity:self.m_quantity forUser:self.m_user_email];
    }
}

// Add second snack plan into database
- (void)saveSecondSnackPlanInDatabase:(NSMutableDictionary *)dictionary
{
    if (!self.m_database) {
        self.m_database                       = [Database alloc];
    }
    self.m_user_email                         = [NSString getUserEmail];
    
    // Delete previous meal plan, if any
    [self.m_database deleteSecondSnackforUser:self.m_user_email];
    [self getFoodAndQuantityFromPlistDictionaryAndSaveIntoDatabase:dictionary];
}

@end
