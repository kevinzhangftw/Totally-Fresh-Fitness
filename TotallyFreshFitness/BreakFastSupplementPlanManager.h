//
//  BreakFastSupplementPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BreakFastSupplementPlanManager : NSObject

// Singleton BreakFastSupplementPlanManager object
+ (BreakFastSupplementPlanManager *)sharedInstance;

// Add supplement plan into database
- (void)saveBreakFastSupplementPlanInDatabase:(NSMutableDictionary *)supplementDictionary;

@end
