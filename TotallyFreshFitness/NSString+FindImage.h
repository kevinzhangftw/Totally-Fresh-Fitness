//
//  NSString+FindImage.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-13.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FindImage)

// Find the right image for the cell for meal plan
+ (NSString *)findImageForMealPlan:(NSString *)possibleImageName;
// Find the right image for the cell for workout
+ (NSString *)findImageForWorkout:(NSString *)possibleImageName;
// Find right image for sub workout
+ (NSString *)findImageForWorkoutSub:(NSString *)possibleImageName;

@end
