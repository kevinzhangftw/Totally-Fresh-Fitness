//
//  SecondSnackPlanManager.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondSnackPlanManager : NSObject

// Singleton SecondSnackPlanManager object
+ (SecondSnackPlanManager *)sharedInstance;

// Add second snack plan into database
- (void)saveSecondSnackPlanInDatabase:(NSMutableDictionary *)dictionary;

@end
