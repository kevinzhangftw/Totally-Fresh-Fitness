//
//  IntermediateWorkoutSelection.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/18/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntermediateWorkoutSelection : NSObject

// Singleton IntermediateWorkoutSelection object
+ (IntermediateWorkoutSelection *)sharedInstance;

// Load up workout array
- (NSMutableArray *)intermediateWorkoutGoal:(NSString *)goal WithTheDay:(int)day ForTotalWorkOutDays:(int)totalNumberOfDays;

@end
