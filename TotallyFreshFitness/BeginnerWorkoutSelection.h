//
//  BeginnerWorkoutSelection.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/19/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeginnerWorkoutSelection : NSObject

// Singleton WorkoutSelection object
+ (BeginnerWorkoutSelection *)sharedInstance;

// Load up workout array
- (NSMutableArray *)beginnerWorkoutGoal:(NSString *)goal WithTheDay:(int)day ForTotalWorkOutDays:(int)totalNumberOfDays;

@end
