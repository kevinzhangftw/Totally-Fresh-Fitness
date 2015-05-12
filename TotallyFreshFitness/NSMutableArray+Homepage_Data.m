//
//  NSMutableArray+Homepage_Data.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/20/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "NSMutableArray+Homepage_Data.h"

@implementation NSMutableArray (Homepage_Data)

static NSMutableArray *m_homepageData;

+ (NSMutableArray *)getHomePageData
{
    return m_homepageData;
}

// Set exercise item to switch
+ (void)setHomePageData:(NSMutableArray *)homepageData
{
    m_homepageData        = homepageData;
}

@end
