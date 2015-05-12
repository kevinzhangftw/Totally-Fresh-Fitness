//
//  MealPlanSelection.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-07.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import "MealPlanSelection.h"

@implementation MealPlanSelection

/*
 Singleton MealPlanSelection object
 */
+ (MealPlanSelection *)sharedInstance {
	static MealPlanSelection *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 General plist load up
 */
- (NSMutableArray *)loadUpPlist:(NSString *)plist
{
    NSMutableArray  *plistArray;
    // load our data for background image from a plist file
	NSString *path                          = [[NSBundle mainBundle] pathForResource:plist ofType:@"plist"];
	plistArray                              = [NSMutableArray arrayWithContentsOfFile:path];
    
    return plistArray;
}

/*
 Load up plist file
 */
- (NSMutableArray *)calorieSelection:(int)calories Gender:(NSString *)gender
{
    NSMutableArray  *plistArray;
    // Calorie plan
    NSString *caloriePlist          = @"";
    
    if ([gender isEqualToString:@"Male"]) {
        if (calories <= 1600) {
            caloriePlist    = @"1500 Calorie";
        }
        else if(((calories > 1600) && (calories < 1801))) {
            caloriePlist    = @"1700 Calorie";
        }
        else if((calories > 1800) && (calories < 2001)) {
            caloriePlist    = @"1900 Calorie";
        }
        else if((calories > 2000) && (calories < 2201)) {
            caloriePlist    = @"2100 Calorie";
        }
        else if((calories > 2200) && (calories < 2401)) {
            caloriePlist    = @"2300 Calorie";
        }
        else if((calories > 2400) && (calories < 2601)) {
            caloriePlist    = @"2500 Calorie";
        }
        else if((calories > 2600) && (calories < 2801)) {
            caloriePlist    = @"2700 Calorie";
        }
        else if((calories > 2800) && (calories < 3001)) {
            caloriePlist    = @"2900 Calorie";
        }
        else if((calories > 3000) && (calories < 3201)) {
            caloriePlist    = @"3100 Calorie";
        }
        else if((calories > 3200) && (calories < 3401)) {
            caloriePlist    = @"3300 Calorie";
        }
        else if((calories > 3400) && (calories < 3601)) {
            caloriePlist    = @"3500 Calorie";
        }
        else if((calories > 3600) && (calories < 3801)) {
            caloriePlist    = @"3700 Calorie";
        }
        else if((calories > 3800) && (calories < 4001)) {
            caloriePlist    = @"3900 Calorie";
        }
        else if((calories > 4000) && (calories < 4201)) {
            caloriePlist    = @"4100 Calorie";
        }
        else if((calories > 4200) && (calories < 4401)) {
            caloriePlist    = @"4300 Calorie";
        }
        else if((calories > 4400) && (calories < 4601)) {
            caloriePlist    = @"4500 Calorie";
        }
        else if((calories > 4600) && (calories < 4801)) {
            caloriePlist    = @"4700 Calorie";
        }
        else if((calories > 4800) && (calories < 5001)) {
            caloriePlist    = @"4900 Calorie";
        }
        else if(calories > 5000) { // 4900 is the maximum calorie plan for men
            caloriePlist    = @"4900 Calorie";
        }
    }
    else if([gender isEqualToString:@"Female"]) {
        if (calories <= 1300) {
            caloriePlist    = @"1200 Calorie";
        }
        else if((calories > 1300) && (calories < 1501)) {
            caloriePlist    = @"1400 Calorie";
        }
        else if((calories > 1500) && (calories < 1701)) {
            caloriePlist    = @"1600 Calorie";
        }
        else if((calories > 1700) && (calories < 1901)) {
            caloriePlist    = @"1800 Calorie";
        }
        else if((calories > 1900) && (calories < 2101)) {
            caloriePlist    = @"2000 Calorie";
        }
        else if((calories > 2100) && (calories < 2301)) {
            caloriePlist    = @"2200 Calorie";
        }
        else if((calories > 2300) && (calories < 2501)) {
            caloriePlist    = @"2400 Calorie";
        }
        else if((calories > 2500) && (calories < 2701)) {
            caloriePlist    = @"2600 Calorie";
        }
        else { // 2600 is the maximum calories plan for women
            caloriePlist    = @"2600 Calorie";
        }
    }
    // load our data for background image from a plist file
	NSString *path          = [[NSBundle mainBundle] pathForResource:caloriePlist ofType:@"plist"];
	plistArray              = [NSMutableArray arrayWithContentsOfFile:path];
    return plistArray;
}

@end
