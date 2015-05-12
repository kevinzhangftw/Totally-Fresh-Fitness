//
//  FifthDayWorkoutPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FifthDayWorkoutPlanManager : NSObject

// Singleton FifthDayWorkoutPlanManager object
+ (FifthDayWorkoutPlanManager *)sharedInstance;

// Add fifth day workout plan into database
- (void)saveFifthDayWorkoutPlanInDatabase:(NSMutableArray *)workoutArray;

@end
