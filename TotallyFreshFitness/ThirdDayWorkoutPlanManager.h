//
//  ThirdDayWorkoutPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdDayWorkoutPlanManager : NSObject

// Singleton ThirdDayWorkoutPlanManager object
+ (ThirdDayWorkoutPlanManager *)sharedInstance;

// Add third day workout plan into database
- (void)saveThirdDayWorkoutPlanInDatabase:(NSMutableArray *)workoutArray;

@end
