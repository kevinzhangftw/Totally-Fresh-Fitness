//
//  SupplementPlanSelection.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/16/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "SupplementPlanSelection.h"

@implementation SupplementPlanSelection

/*
 Singleton SupplementPlanSelection object
 */
+ (SupplementPlanSelection *)sharedInstance {
	static SupplementPlanSelection *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 General plist load up
 */
- (NSMutableArray *)loadUpPlistArray:(NSString *)plist
{
    NSMutableArray  *plistArray;
    // load our data for background image from a plist file
	NSString *path                          = [[NSBundle mainBundle] pathForResource:plist ofType:@"plist"];
	plistArray                              = [NSMutableArray arrayWithContentsOfFile:path];
    
    return plistArray;
}

- (NSMutableDictionary *)loadUpPlist:(NSString *)plist
{
    NSMutableDictionary  *plistDictionary;
    // load our data for background image from a plist file
	NSString *path                      = [[NSBundle mainBundle] pathForResource:plist ofType:@"plist"];
	plistDictionary                     = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    return plistDictionary;
}

/*
 Select the plist based on goal
 */
- (NSMutableArray *)selectSupplementPlistBasedonGoal:(NSString *)goal
{
    NSString *plistName;
    if ([goal isEqualToString:@"Shred Fat"]) {
        plistName         = [[NSString stringWithFormat:@"shred_fat_%@",[NSString getGenderOfUser]] lowercaseString];
    }
    else {
        plistName         = [[NSString stringWithFormat:@"build_muscle_%@",[NSString getGenderOfUser]] lowercaseString];
    }
    
    return [self loadUpPlistArray:plistName];
}

@end
