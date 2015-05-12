//
//  FirstDayWorkoutPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstDayWorkoutPlanManager : NSObject

// Singleton FirstDayWorkoutPlanManager object
+ (FirstDayWorkoutPlanManager *)sharedInstance;

// Add first day workout plan into database
- (void)saveFirstDayWorkoutPlanInDatabase:(NSMutableArray *)workoutArray;

@end
