//
//  NSMutableArray+SportsList.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/1/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "NSMutableArray+SportsList.h"

@implementation NSMutableArray (SportsList)

static NSMutableArray *m_sportsList     = nil;

/*
 Get lists of sports
 */
+(NSMutableArray *)sportsList
{
    // initialize the sports list array
    if (!m_sportsList) {
        m_sportsList                = [NSMutableArray mutableArrayObject];
        
        [m_sportsList addObject:@"Basketball"];
        [m_sportsList addObject:@"Cycling"];
        [m_sportsList addObject:@"Hockey"];
        [m_sportsList addObject:@"Rowing"];
        [m_sportsList addObject:@"Running"];
        [m_sportsList addObject:@"Skiing"];
        [m_sportsList addObject:@"Snowboarding"];
        [m_sportsList addObject:@"Soccer"];
        [m_sportsList addObject:@"Swimming"];
        [m_sportsList addObject:@"Tennis"];
        [m_sportsList addObject:@"Sleep Benefits"];
    }
    return m_sportsList;
}

@end
