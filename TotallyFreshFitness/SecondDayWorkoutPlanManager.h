//
//  SecondDayWorkoutPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondDayWorkoutPlanManager : NSObject

// Singleton SecondDayWorkoutPlanManager object
+ (SecondDayWorkoutPlanManager *)sharedInstance;

// Add second day workout plan into database
- (void)saveSecondDayWorkoutPlanInDatabase:(NSMutableArray *)workoutArray;

@end
