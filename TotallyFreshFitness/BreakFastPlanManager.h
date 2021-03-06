//
//  BreakFastPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BreakFastPlanManager : NSObject

// Singleton BreakFastPlanManager object
+ (BreakFastPlanManager *)sharedInstance;

// Add break fast plan into database
- (void)saveBreakFastPlanInDatabase:(NSMutableArray *)calorieArray;

@end
