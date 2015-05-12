//
//  SupplementPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/16/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SupplementPlanManager : NSObject

// Singleton SupplementPlanManager object
+ (SupplementPlanManager *)sharedInstance;

// Add supplement plan into database
- (void)saveSupplementPlanInDatabase:(NSMutableArray *)supplementArray;
// Get supplement plan from database
- (NSMutableArray *)getSupplementPlanFromDatabase:(NSString *)supplementFromDatabase;

@end
