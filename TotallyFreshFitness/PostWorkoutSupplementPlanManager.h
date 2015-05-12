//
//  PostWorkoutSupplementPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostWorkoutSupplementPlanManager : NSObject

// Singleton PostWorkoutSupplementPlanManager object
+ (PostWorkoutSupplementPlanManager *)sharedInstance;

// Add post workout supplement plan into database
- (void)savePostWorkoutSupplementPlanInDatabase:(NSMutableDictionary *)supplementDictionary;

@end
