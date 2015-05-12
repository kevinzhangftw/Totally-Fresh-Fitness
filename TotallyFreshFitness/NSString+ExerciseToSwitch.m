//
//  NSString+ExerciseToSwitch.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/30/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "NSString+ExerciseToSwitch.h"

@implementation NSString (ExerciseToSwitch)

static NSString *exerciseItemToSwitch;

// Get user exercise item to switch
+(NSString *)getExerciseItemToSwitch
{
    return exerciseItemToSwitch;
}

// Set exercise item to switch
+(void)setExerciseItemToSwitch:(NSString *)exerciseItem
{
    exerciseItemToSwitch        = exerciseItem;
}

@end
