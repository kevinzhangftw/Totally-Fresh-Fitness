//
//  SeventhDayWorkoutPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeventhDayWorkoutPlanManager : NSObject

// Singleton SeventhDayWorkoutPlanManager object
+ (SeventhDayWorkoutPlanManager *)sharedInstance;

// Add seventh day workout plan into database
- (void)saveSeventhDayWorkoutPlanInDatabase:(NSMutableArray *)workoutArray;

@end
