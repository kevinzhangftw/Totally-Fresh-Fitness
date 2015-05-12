//
//  IntensityViewController+BMRCalculator.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-02.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//
// Algorithm used is available from http://www.had2know.com/health/basal-metabolic-rate-calories.html

#import "IntensityViewController+BMRCalculator.h"

@implementation IntensityViewController (BMRCalculator)

// Values for calculating BMR
#define kSixty_Six                      66
#define kSix_Hundred_Fifty_Five         655
#define kThirteen_Point_Seven           13.7
#define kFive                           5
#define kNine_Point_Six                 9.6
#define kOne_Point_Eight                1.8
#define kSix_Point_Eight                6.8
#define kFour_Point_Seven               4.7
#define kOne_Point_Three_Seven_Five     1.375
#define kOne_Point_Five_Five            1.55
#define kOne_Point_Seven_Two_Five       1.725

/*
 Convert pound to kg
 */
- (float)convertPoundsToKgs:(int)pounds
{
    float kgs         = pounds / 2.20462;
    
    return kgs;
}

/*
 Convert feet to inches
 */
- (int)convertFeetToInches:(int)feet
{
    int inches      = feet * 12;
    
    return inches;
}

/*
 Convert inches to cms
 */
- (float)convertInchesToCMs:(int)inches
{
    float cms         = inches * 2.54;
    
    return cms;
}

/*
 Digit and Decimal seperator
 */
- (NSArray *)seperateDigitsAndDecimals:(NSString *)numberString
{
    NSArray *array;
    if ([numberString rangeOfString:@"."].location != NSNotFound) { // User may enter "."
        array        =  [numberString componentsSeparatedByString:@"."];
    } else if([numberString rangeOfString:@"/"].location != NSNotFound) { // Use may enter "/"
        array        =  [numberString componentsSeparatedByString:@"/"];
    }
    else {
        array        =  [NSArray arrayWithObject:numberString];
    }
    
    return array;
}

/*
 Calculate BMR
 */
- (int)calculateBMRSex:(NSString *)sex Weight:(int)weight Age:(int)age Height:(NSString *)height ExerciseIntensity:(NSString *)exerciseItensity
{
    // Total BMR
    int BMR         = 0;
    // Weight in kgs
    float weightInKgs;
    // Height in CMs
    float heightInCMs;
    // Array for seperating feet and inches
    NSMutableArray *heightArray;
    // To check if there is a decimal
    NSInteger arrayCount;
    
    weightInKgs                     = [self convertPoundsToKgs:weight];
    
    if (height != 0) { // Height is added
        heightArray         = [NSMutableArray arrayWithArray:[self seperateDigitsAndDecimals:height]];
        arrayCount          = [heightArray count];
        
        if (arrayCount > 1) { // This is a decimal point
            heightInCMs  =  [self convertInchesToCMs:[self convertFeetToInches:[[heightArray objectAtIndex:0] floatValue]]];
            heightInCMs = heightInCMs + [self convertInchesToCMs:[[heightArray objectAtIndex:1] floatValue]];
        }
        else {
            heightInCMs =  [self convertInchesToCMs:[self convertFeetToInches:[[heightArray objectAtIndex:0] floatValue]]];
        }
    }
    else {
        heightInCMs     = [height floatValue];
    }
    
    // Values for man and woman are different
    if ([sex isEqualToString:@"Male"]) {
        BMR         = kSixty_Six + (kThirteen_Point_Seven * weightInKgs) + (kFive * heightInCMs) - (kSix_Point_Eight * age);
    }
    else if([sex isEqualToString:@"Female"]) {
        BMR         = kSix_Hundred_Fifty_Five + (kNine_Point_Six * weightInKgs) + (kOne_Point_Eight * heightInCMs) - (kFour_Point_Seven * age);
    }
    
    // More active you are, more BMR
    if([exerciseItensity isEqualToString:@"light exercise"]) {
        BMR         = BMR * kOne_Point_Three_Seven_Five;
    }
    else if([exerciseItensity isEqualToString:@"active exercise"]) {
        BMR         = BMR * kOne_Point_Five_Five;
    }
    else if ([exerciseItensity isEqualToString:@"beast exercise"]) {
        BMR         = BMR * kOne_Point_Seven_Two_Five;
    }
    
    return BMR;
}

@end
