//
//  SixthDayWorkoutPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SixthDayWorkoutPlanManager : NSObject

// Singleton SixthDayWorkoutPlanManager object
+ (SixthDayWorkoutPlanManager *)sharedInstance;

// Add sixth day workout plan into database
- (void)saveSixthDayWorkoutPlanInDatabase:(NSMutableArray *)workoutArray;

@end
