//
//  SwitchPlanItemSelection.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-03-11.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwitchPlanItemSelection : NSObject

// Category name
@property (strong, nonatomic) NSString *categoryName;

// Singleton SwitchPlanItemSelection object
+ (SwitchPlanItemSelection *)sharedInstance;
// Get Meal Plan Items for selection
- (NSMutableArray *)getMealPanItems:(NSString *)foodItem;
// Get Workout Plan Items for selection
- (NSMutableArray *)getWorkoutPlanItems:(NSString *)workoutItem;

@end
