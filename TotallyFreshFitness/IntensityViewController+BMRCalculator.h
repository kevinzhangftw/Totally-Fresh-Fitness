//
//  IntensityViewController+BMRCalculator.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-02.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import "IntensityViewController.h"

@interface IntensityViewController (BMRCalculator)

// BMR calculation
- (int)calculateBMRSex:(NSString *)sex Weight:(int)weight Age:(int)age Height:(NSString *)height ExerciseIntensity:(NSString *)exerciseItensity;
// Convert pound to kg
- (float)convertPoundsToKgs:(int)pounds;
// Convert feet to inches
- (int)convertFeetToInches:(int)feet;
// Convert inches to cms
- (float)convertInchesToCMs:(int)inches;
// Decimal seperator
- (NSArray *)seperateDigitsAndDecimals:(NSString *)numberString;

@end
