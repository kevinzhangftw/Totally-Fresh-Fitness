//
//  WorkoutPlanManager.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-03-02.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "WorkoutPlanManager.h"
#import "Database.h"

@implementation WorkoutPlanManager

// Database object
Database *m_database;
// Exercise name
NSString *m_exercise;
// Quantity
NSString *m_details;
// User email
NSString *m_user_email;

/*
 Singleton WorkoutPlanManager object
 */
+ (WorkoutPlanManager *)sharedInstance {
	static WorkoutPlanManager *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 Add images, headings and details into each array
 */
- (void)getWorkoutFromArray:(NSMutableArray *)workoutArray AndSaveIntoDatabase:(NSString *)insertIntoDatabase
{
    if (!m_database) {
        m_database          = [Database alloc];
    }

    // Get workoutarray count
    NSUInteger numberOfItems                   = [workoutArray count];
    for (int i = 0; i < numberOfItems; i = i+2) {
        if (([[workoutArray objectAtIndex:i] length] != 0) || [workoutArray objectAtIndex:i] != NULL) {
            m_exercise                  = [workoutArray objectAtIndex:i]; // Add exercise name
        }
        
        if (([workoutArray objectAtIndex:i+1] != 0) || [workoutArray objectAtIndex:i+1] != NULL) {
            m_details                   = [workoutArray objectAtIndex:i + 1]; // Add details
        }
        if ([insertIntoDatabase isEqualToString:@"insertIntoFirstDayWorkOut"]) {
            [m_database insertIntoFirstDayWorkOut:m_exercise Details:m_details forUser:m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoSecondDayWorkOut"]) {
            [m_database insertIntoSecondDayWorkOut:m_exercise Details:m_details forUser:m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoThirdDayWorkOut"]) {
            [m_database insertIntoThirdDayWorkOut:m_exercise Details:m_details forUser:m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoFourthDayWorkOut"]) {
            [m_database insertIntoFourthDayWorkOut:m_exercise Details:m_details forUser:m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoFifthDayWorkOut"]) {
            [m_database insertIntoFifthDayWorkOut:m_exercise Details:m_details forUser:m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoSixthDayWorkOut"]) {
            [m_database insertIntoSixthDayWorkOut:m_exercise Details:m_details forUser:m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoSeventhDayWorkOut"]) {
            [m_database insertIntoSeventhDayWorkOut:m_exercise Details:m_details forUser:m_user_email];
        }
    }
}

/*
 Delete previous workout plan
 */
- (void)deletePreviousWorkoutPlan
{
    if (!m_database) {
        m_database                       = [Database alloc];
    }
    m_user_email                         = [NSString getUserEmail];

    [m_database deleteFirstDayWorkoutforUser:m_user_email];
    [m_database deleteSecondDayWorkoutforUser:m_user_email];
    [m_database deleteThirdDayWorkoutforUser:m_user_email];
    [m_database deleteFourthDayWorkoutforUser:m_user_email];
    [m_database deleteFifthDayWorkoutforUser:m_user_email];
    [m_database deleteSixthDayWorkoutforUser:m_user_email];
    [m_database deleteSeventhDayWorkoutforUser:m_user_email];
}

/*
 Add workout plan into database
 */
- (void)saveWorkoutPlanInDatabase:(NSMutableArray *)workoutArray forWorkoutDay:(int)day
{
    [self deletePreviousWorkoutPlan];
    
    // Delete previous workout plan, if any, than add new ones    
    if (day == 0) { // save first day workout
        [self getWorkoutFromArray:workoutArray AndSaveIntoDatabase:@"insertIntoFirstDayWorkOut"];
    }
    else if(day == 1) { // save second day workout
        [self getWorkoutFromArray:workoutArray AndSaveIntoDatabase:@"insertIntoSecondDayWorkOut"];
    }
    else if(day == 2) { // save third day workout
        [self getWorkoutFromArray:workoutArray AndSaveIntoDatabase:@"insertIntoThirdDayWorkOut"];
    }
    else if(day == 3) { // save fourth day workout
        [self getWorkoutFromArray:workoutArray AndSaveIntoDatabase:@"insertIntoFourthDayWorkOut"];
    }
    else if(day == 4) { // save fifth day workout
        [self getWorkoutFromArray:workoutArray AndSaveIntoDatabase:@"insertIntoFifthDayWorkOut"];
    }
    else if(day == 5) { // save sixth day workout
        [self getWorkoutFromArray:workoutArray AndSaveIntoDatabase:@"insertIntoSixthDayWorkOut"];
    }
    else if(day == 6) { // save seventh day workout
        [self getWorkoutFromArray:workoutArray AndSaveIntoDatabase:@"insertIntoSeventhDayWorkOut"];
    }
}


/*
 Get workout plan from database
 */
- (NSMutableArray *)getWorkoutPlanFromDatabase:(NSString *)workoutFromDatabase
{
    if (!m_database) {
        m_database          = [Database alloc];
    }
    if (!m_user_email) {
        m_user_email        = [NSString getUserEmail];
    }
    if ([workoutFromDatabase isEqualToString:@"One"]) {
        return [m_database getFirstDayWorkOutforUser:m_user_email];
    }
    else if ([workoutFromDatabase isEqualToString:@"Two"]) {
        return [m_database getSecondDayWorkOutforUser:m_user_email];
    }
    else if ([workoutFromDatabase isEqualToString:@"Three"]) {
        return [m_database getThirdDayWorkOutforUser:m_user_email];
    }
    else if ([workoutFromDatabase isEqualToString:@"Four"]) {
        return [m_database getFourthDayWorkOutforUser:m_user_email];
    }
    else if ([workoutFromDatabase isEqualToString:@"Five"]) {
        return [m_database getFifthDayWorkOutforUser:m_user_email];
    }
    else if ([workoutFromDatabase isEqualToString:@"Six"]) {
        return [m_database getSixthDayWorkOutforUser:m_user_email];
    }
    else if ([workoutFromDatabase isEqualToString:@"Seven"]) {
        return [m_database getSeventhDayWorkOutforUser:m_user_email];
    }
    return nil;
}

@end
