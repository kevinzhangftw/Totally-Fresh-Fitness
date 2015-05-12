//
//  WorkoutSelection.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-17.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkoutSelection : NSObject

// General plist load up
- (NSMutableDictionary *)loadUpPlist:(NSString *)plist;
// Load up plist file
- (NSMutableArray *)workoutGoal:(NSString *)goal WithTheDay:(int)day ForTotalWorkOutDays:(int)totalNumberOfDays;

// Singleton WorkoutSelection object
+ (WorkoutSelection *)sharedInstance;

@end
