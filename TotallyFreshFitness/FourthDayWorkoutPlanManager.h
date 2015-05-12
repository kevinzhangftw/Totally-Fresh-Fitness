//
//  FourthDayWorkoutPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FourthDayWorkoutPlanManager : NSObject

// Singleton FourthDayWorkoutPlanManager object
+ (FourthDayWorkoutPlanManager *)sharedInstance;

// Add fourth day workout plan into database
- (void)saveFourthDayWorkoutPlanInDatabase:(NSMutableArray *)workoutArray;

@end
