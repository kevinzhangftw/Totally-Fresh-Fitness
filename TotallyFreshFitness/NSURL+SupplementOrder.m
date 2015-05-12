//
//  NSURL+SupplementOrder.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/10/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "NSURL+SupplementOrder.h"

@implementation NSURL (SupplementOrder)

static NSURL *m_orderUrl;

// Set supplement order url
+ (void)setSupplementOrderUrl:(NSString *)url
{
    m_orderUrl  = [NSURL URLWithString:url];
}

// Get supplement order url
+ (NSURL *)getSupplementOrderUrl
{
    return m_orderUrl;
}

@end
