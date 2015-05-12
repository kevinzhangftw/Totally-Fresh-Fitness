//
//  NSMutableArray+SupplementItems.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/2/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "NSMutableArray+SupplementItems.h"

@implementation NSMutableArray (SupplementItems)

static NSMutableArray *m_supplementItems;

/*
 Get Supplement items
 */
+(NSMutableArray *)supplementItems
{
    if (!m_supplementItems) {
        m_supplementItems       = [NSMutableArray mutableArrayObject];
        [m_supplementItems addObject:[NSString stringWithFormat:@"bpi - 1mr"]];
        [m_supplementItems addObject:[NSString stringWithFormat:@"bsn - amino-x"]];
        [m_supplementItems addObject:[NSString stringWithFormat:@"bsn - n.o. xplode 2.0"]];
        [m_supplementItems addObject:[NSString stringWithFormat:@"cellucor c4 extreme"]];
        [m_supplementItems addObject:[NSString stringWithFormat:@"cellucor clk"]];
        [m_supplementItems addObject:[NSString stringWithFormat:@"musclepharm amino"]];
        [m_supplementItems addObject:[NSString stringWithFormat:@"musclepharm casein"]];
        [m_supplementItems addObject:[NSString stringWithFormat:@"musclepharm cla core"]];
        [m_supplementItems addObject:[NSString stringWithFormat:@"musclepharm creatine"]];
        [m_supplementItems addObject:[NSString stringWithFormat:@"optimum 100 whey"]];
        [m_supplementItems addObject:[NSString stringWithFormat:@"optimum fish oils"]];
        [m_supplementItems addObject:[NSString stringWithFormat:@"opti-men multivitamin"]];
        [m_supplementItems addObject:[NSString stringWithFormat:@"opti-women multivitamin"]];
        [m_supplementItems addObject:[NSString stringWithFormat:@"optimum zma"]];
    }
    
    return m_supplementItems;
}


@end
