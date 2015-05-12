//
//  LunchPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LunchPlanManager : NSObject

// Singleton LunchPlanManager object
+ (LunchPlanManager *)sharedInstance;

// Add lunch plan into database
- (void)saveLunchPlanInDatabase:(NSMutableDictionary *)dictionary;

@end
