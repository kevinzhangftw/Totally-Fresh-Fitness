//
//  WorkoutPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-03-02.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkoutPlanManager : NSObject

// Singleton WorkoutPlanManager object
+ (WorkoutPlanManager *)sharedInstance;

// Add workout plan into database
- (void)saveWorkoutPlanInDatabase:(NSMutableArray *)workoutArray forWorkoutDay:(int)day;
// Get workout plan from database
- (NSMutableArray *)getWorkoutPlanFromDatabase:(NSString *)workoutFromDatabase;
// Delete previous workout plan
- (void)deletePreviousWorkoutPlan;

@end
