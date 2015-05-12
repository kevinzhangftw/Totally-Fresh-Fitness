//
//  SupplementPlanSelection.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/16/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SupplementPlanSelection : NSObject

// Singleton SupplementPlanSelection object
+ (SupplementPlanSelection *)sharedInstance;
// General plist load up
- (NSMutableDictionary *)loadUpPlist:(NSString *)plist;
// Select the plist based on goal
- (NSMutableArray *)selectSupplementPlistBasedonGoal:(NSString *)goal;

@end
