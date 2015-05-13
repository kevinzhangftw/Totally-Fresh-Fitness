//
//  WorkoutPlanManager.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-03-02.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "WorkoutPlanManager.h"
#import "Database.h"
@interface WorkoutPlanManager()
// Database object
@property (strong, nonatomic)Database *m_database;
// Exercise name
@property (strong, nonatomic)NSString *m_exercise;
// Quantity
@property (strong, nonatomic)NSString *m_details;
// User email
@property (strong, nonatomic)NSString *m_user_email;
@end

@implementation WorkoutPlanManager



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
    if (!self.m_database) {
        self.m_database          = [Database alloc];
    }

    // Get workoutarray count
    NSUInteger numberOfItems                   = [workoutArray count];
    for (int i = 0; i < numberOfItems; i = i+2) {
        if (([[workoutArray objectAtIndex:i] length] != 0) || [workoutArray objectAtIndex:i] != NULL) {
            self.m_exercise                  = [workoutArray objectAtIndex:i]; // Add exercise name
        }
        
        if (([workoutArray objectAtIndex:i+1] != 0) || [workoutArray objectAtIndex:i+1] != NULL) {
            self.m_details                   = [workoutArray objectAtIndex:i + 1]; // Add details
        }
        if ([insertIntoDatabase isEqualToString:@"insertIntoFirstDayWorkOut"]) {
            [self.m_database insertIntoFirstDayWorkOut:self.m_exercise Details:self.m_details forUser:self.m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoSecondDayWorkOut"]) {
            [self.m_database insertIntoSecondDayWorkOut:self.m_exercise Details:self.m_details forUser:self.m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoThirdDayWorkOut"]) {
            [self.m_database insertIntoThirdDayWorkOut:self.m_exercise Details:self.m_details forUser:self.m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoFourthDayWorkOut"]) {
            [self.m_database insertIntoFourthDayWorkOut:self.m_exercise Details:self.m_details forUser:self.m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoFifthDayWorkOut"]) {
            [self.m_database insertIntoFifthDayWorkOut:self.m_exercise Details:self.m_details forUser:self.m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoSixthDayWorkOut"]) {
            [self.m_database insertIntoSixthDayWorkOut:self.m_exercise Details:self.m_details forUser:self.m_user_email];
        }
        else if([insertIntoDatabase isEqualToString:@"insertIntoSeventhDayWorkOut"]) {
            [self.m_database insertIntoSeventhDayWorkOut:self.m_exercise Details:self.m_details forUser:self.m_user_email];
        }
    }
}

/*
 Delete previous workout plan
 */
- (void)deletePreviousWorkoutPlan
{
    if (!self.m_database) {
        self.m_database                       = [Database alloc];
    }
    self.m_user_email                         = [NSString getUserEmail];

    [self.m_database deleteFirstDayWorkoutforUser:self.m_user_email];
    [self.m_database deleteSecondDayWorkoutforUser:self.m_user_email];
    [self.m_database deleteThirdDayWorkoutforUser:self.m_user_email];
    [self.m_database deleteFourthDayWorkoutforUser:self.m_user_email];
    [self.m_database deleteFifthDayWorkoutforUser:self.m_user_email];
    [self.m_database deleteSixthDayWorkoutforUser:self.m_user_email];
    [self.m_database deleteSeventhDayWorkoutforUser:self.m_user_email];
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
    if (!self.m_database) {
        self.m_database          = [Database alloc];
    }
    if (!self.m_user_email) {
        self.m_user_email        = [NSString getUserEmail];
    }
    if ([workoutFromDatabase isEqualToString:@"One"]) {
        return [self.m_database getFirstDayWorkOutforUser:self.m_user_email];
    }
    else if ([workoutFromDatabase isEqualToString:@"Two"]) {
        return [self.m_database getSecondDayWorkOutforUser:self.m_user_email];
    }
    else if ([workoutFromDatabase isEqualToString:@"Three"]) {
        return [self.m_database getThirdDayWorkOutforUser:self.m_user_email];
    }
    else if ([workoutFromDatabase isEqualToString:@"Four"]) {
        return [self.m_database getFourthDayWorkOutforUser:self.m_user_email];
    }
    else if ([workoutFromDatabase isEqualToString:@"Five"]) {
        return [self.m_database getFifthDayWorkOutforUser:self.m_user_email];
    }
    else if ([workoutFromDatabase isEqualToString:@"Six"]) {
        return [self.m_database getSixthDayWorkOutforUser:self.m_user_email];
    }
    else if ([workoutFromDatabase isEqualToString:@"Seven"]) {
        return [self.m_database getSeventhDayWorkOutforUser:self.m_user_email];
    }
    return nil;
}

@end
