//
//  NSString+Gender.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-09-21.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Gender)

// Get user gender
+(NSString *)getGenderOfUser;
// Set user gender
+(void)setGenderOfUser:(NSString *)gender;
// Reset user gender
+(void)resetGender;

@end
