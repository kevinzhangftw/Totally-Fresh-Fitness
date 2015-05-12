//
//  FirstSnackPlanManager.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "FirstSnackPlanManager.h"

@interface FirstSnackPlanManager()
@property (strong, nonatomic) Database *m_database;
@property (strong, nonatomic) NSString *m_foodName;
@property (strong, nonatomic) NSString *m_quantity;
@property (strong, nonatomic) NSString *m_user_email;
@end

@implementation FirstSnackPlanManager


/*
 Singleton FirstSnackPlanManager object
 */
+ (FirstSnackPlanManager *)sharedInstance {
	static FirstSnackPlanManager *globalInstance;
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
    NSUInteger numberOfItems                   = [keys count];
    for (int i = 0; i < numberOfItems; i++) {
        if (([[keys objectAtIndex:i] length] != 0) || [keys objectAtIndex:i] != NULL) {
            self.m_foodName                  = [keys objectAtIndex:i]; // Add food name
        }
        
        if (([dictionary objectForKey:[keys objectAtIndex:i]] != 0) || [dictionary objectForKey:[keys objectAtIndex:i]] != NULL) {
            self.m_quantity                  = [dictionary objectForKey:[keys objectAtIndex:i]]; // Add quantity
        }
        [self.m_database insertIntoFirstSnackFood:self.m_foodName Quantity:self.m_quantity forUser:self.m_user_email];
    }
}

// Add meal plan into database
- (void)saveFirstSnackPlanInDatabase:(NSMutableDictionary *)dictionary
{
    if (!self.m_database) {
        self.m_database                       = [Database alloc];
    }
    self.m_user_email                         = [NSString getUserEmail];
    
    // Delete previous meal plan, if any
    [self.m_database deleteFirstSnackforUser:self.m_user_email];
    // save first snack meal
    [self getFoodAndQuantityFromPlistDictionaryAndSaveIntoDatabase:dictionary];
}

@end
