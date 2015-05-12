//
//  FirstSnackPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstSnackPlanManager : NSObject

// Singleton FirstSnackPlanManager object
+ (FirstSnackPlanManager *)sharedInstance;

// Add first snack plan into database
- (void)saveFirstSnackPlanInDatabase:(NSMutableDictionary *)dictionary;

@end
