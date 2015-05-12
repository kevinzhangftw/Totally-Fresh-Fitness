//
//  BeforeBedSupplementPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeforeBedSupplementPlanManager : NSObject

// Singleton BeforeBedSupplementPlanManager object
+ (BeforeBedSupplementPlanManager *)sharedInstance;

// Add before bed supplement plan into database
- (void)saveBeforeBedSupplementPlanInDatabase:(NSMutableDictionary *)supplementDictionary;

@end
