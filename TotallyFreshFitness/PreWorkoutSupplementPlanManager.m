//
//  PreWorkoutSupplementPlanManager.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "PreWorkoutSupplementPlanManager.h"
@interface PreWorkoutSupplementPlanManager()
// Database object
@property (strong, nonatomic)Database *m_database;
// Supplement name
@property (strong, nonatomic)NSString *m_supplementName;
// Quantity
@property (strong, nonatomic)NSString *m_quantity;
// User email
@property (strong, nonatomic)NSString *m_user_email;
@end

@implementation PreWorkoutSupplementPlanManager


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
    if (!self.m_database) {
        self.m_database          = [Database alloc];
    }
    // Get all the key first
    NSArray *keys                       = [dictionary allKeys];
    NSInteger numberOfItems                   = [keys count];
    for (int i = 0; i < numberOfItems; i++) {
        if (([[keys objectAtIndex:i] length] != 0) || [keys objectAtIndex:i] != NULL) {
            self.m_supplementName                  = [keys objectAtIndex:i]; // Add supplement name
        }
        
        if (([dictionary objectForKey:[keys objectAtIndex:i]] != 0) || [dictionary objectForKey:[keys objectAtIndex:i]] != NULL) {
            self.m_quantity                  = [dictionary objectForKey:[keys objectAtIndex:i]]; // Add quantity
        }
        [self.m_database insertIntoSupplementPreWorkout:self.m_supplementName Quantity:self.m_quantity forUser:self.m_user_email];
    }
}

// Add supplement plan into database
- (void)savePreWorkoutSupplementPlanInDatabase:(NSMutableDictionary *)supplementDictionary
{
    if (!self.m_database) {
        self.m_database                       = [Database alloc];
    }
    self.m_user_email                         = [NSString getUserEmail];
    
    // Delete previous supplement plan, if any
    [self.m_database deleteSupplementPreWorkoutforUser:self.m_user_email];
    
    [self getSupplementAndQuantityFromPlistDictionaryAndSaveIntoDatabase:supplementDictionary];
}

@end
