//
//  ThirdSnackPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThirdSnackPlanManager : NSObject

// Singleton ThirdSnackPlanManager object
+ (ThirdSnackPlanManager *)sharedInstance;

// Add third snack plan into database
- (void)saveThirdSnackPlanInDatabase:(NSMutableDictionary *)dictionary;

@end
