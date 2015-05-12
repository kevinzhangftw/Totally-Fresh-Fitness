//
//  NSString+UserEmail.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-09-21.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "NSString+UserEmail.h"

@implementation NSString (UserEmail)

Database *m_database;
static NSString *m_userEmail    = nil;

/*
 Get user gender
 */
+(NSString *)getUserEmail
{
    if (m_userEmail == nil) {
        m_database       = [Database alloc];
        m_userEmail      = [m_database getEmailId:@"in"];
    }
    return m_userEmail;
}

/*
 Get user gender
 */
+(void)resetEmail
{
    m_userEmail        = nil;
}

@end
