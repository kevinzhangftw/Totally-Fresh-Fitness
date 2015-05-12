//
//  PreWorkoutSupplementPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PreWorkoutSupplementPlanManager : NSObject

// Singleton PreWorkoutSupplementPlanManager object
+ (PreWorkoutSupplementPlanManager *)sharedInstance;

// Add pre workout supplement plan into database
- (void)savePreWorkoutSupplementPlanInDatabase:(NSMutableDictionary *)supplementDictionary;

@end
