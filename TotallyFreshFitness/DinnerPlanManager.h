//
//  DinnerPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DinnerPlanManager : NSObject

// Singleton DinnerPlanManager object
+ (DinnerPlanManager *)sharedInstance;

// Add dinner plan into database
- (void)saveDinnerPlanInDatabase:(NSMutableDictionary *)dictionary;

@end
