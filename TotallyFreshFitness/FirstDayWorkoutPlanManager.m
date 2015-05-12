//
//  FirstDayWorkoutPlanManager.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "FirstDayWorkoutPlanManager.h"

@implementation FirstDayWorkoutPlanManager

// Database object
Database *m_database;
// Exercise name
NSString *m_exercise;
// Quantity
NSString *m_details;
// User email
NSString *m_user_email;

/*
 Singleton FirstDayWorkoutPlanManager object
 */
+ (FirstDayWorkoutPlanManager *)sharedInstance {
	static FirstDayWorkoutPlanManager *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 Add images, headings and details into each array
 */
- (void)getWorkoutFromArrayAndSaveIntoDatabase:(NSMutableArray *)workoutArray
{
    if (!m_database) {
        m_database          = [Database alloc];
    }
    m_user_email                         = [NSString getUserEmail];

    // Get workoutarray count
    NSUInteger numberOfItems                   = [workoutArray count];
    for (int i = 0; i < numberOfItems; i = i+2) {
        if ((([[workoutArray objectAtIndex:i] length] != 0) || [workoutArray objectAtIndex:i] != NULL) && (([workoutArray objectAtIndex:i+1] != 0) || [workoutArray objectAtIndex:i+1] != NULL)) {
            m_exercise                  = [workoutArray objectAtIndex:i]; // Add exercise name
            m_details                   = [workoutArray objectAtIndex:i + 1]; // Add details
        }
        
        [m_database insertIntoFirstDayWorkOut:m_exercise Details:m_details forUser:m_user_email];
    }
}

/*
 Add first day workout plan into database
 */
- (void)saveFirstDayWorkoutPlanInDatabase:(NSMutableArray *)workoutArray
{
    [self getWorkoutFromArrayAndSaveIntoDatabase:workoutArray];
}

@end
