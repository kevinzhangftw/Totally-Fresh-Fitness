//
//  NSString+ExerciseToSwitch.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/30/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ExerciseToSwitch)

// Get user exercise item to switch
+(NSString *)getExerciseItemToSwitch;
// Set exercise item to switch
+(void)setExerciseItemToSwitch:(NSString *)exerciseItem;

@end
