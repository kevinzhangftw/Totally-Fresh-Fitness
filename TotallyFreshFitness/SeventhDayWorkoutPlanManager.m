//
//  SeventhDayWorkoutPlanManager.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "SeventhDayWorkoutPlanManager.h"
@interface SeventhDayWorkoutPlanManager()
// Database object
@property (strong, nonatomic)Database *m_database;
// Exercise name
@property (strong, nonatomic)NSString *m_exercise;
// Quantity
@property (strong, nonatomic)NSString *m_details;
// User email
@property (strong, nonatomic)NSString *m_user_email;
@end

@implementation SeventhDayWorkoutPlanManager


/*
 Singleton SeventhDayWorkoutPlanManager object
 */
+ (SeventhDayWorkoutPlanManager *)sharedInstance {
	static SeventhDayWorkoutPlanManager *globalInstance;
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
    if (!self.m_database) {
        self.m_database          = [Database alloc];
    }
    self.m_user_email                         = [NSString getUserEmail];
    
    // Get workoutarray count
    NSUInteger numberOfItems                   = [workoutArray count];
    for (int i = 0; i < numberOfItems; i = i+2) {
        if ((([[workoutArray objectAtIndex:i] length] != 0) || [workoutArray objectAtIndex:i] != NULL) && (([workoutArray objectAtIndex:i+1] != 0) || [workoutArray objectAtIndex:i+1] != NULL)){
            self.m_exercise                  = [workoutArray objectAtIndex:i]; // Add exercise name
            self.m_details                   = [workoutArray objectAtIndex:i + 1]; // Add details
        }
      [self.m_database insertIntoSeventhDayWorkOut:self.m_exercise Details:self.m_details forUser:self.m_user_email];
    }
}

/*
 Add seventh day workout plan into database
 */
- (void)saveSeventhDayWorkoutPlanInDatabase:(NSMutableArray *)workoutArray
{
    [self getWorkoutFromArrayAndSaveIntoDatabase:workoutArray];
}

@end
