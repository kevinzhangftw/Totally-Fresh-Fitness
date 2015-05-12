//
//  NSString+Gender.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-09-21.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "NSString+Gender.h"

@implementation NSString (Gender)

Database *m_database;
static NSString *m_gender   = nil;

/*
 Get user gender
 */
+(NSString *)getGenderOfUser
{
    if (m_gender == nil) {
        m_database       = [Database alloc];
        m_gender         = [m_database getGender:[NSString getUserEmail]];
    }
    return [m_gender lowercaseString];
}

/*
 Set user gender
 */
+(void)setGenderOfUser:(NSString *)gender
{
    m_gender        = gender;
}

/*
 Get user gender
 */
+(void)resetGender
{
    m_gender        = nil;
    if (m_gender == nil) {
        m_database       = [Database alloc];
        m_gender         = [m_database getGender:[NSString getUserEmail]];
    }
}
@end
