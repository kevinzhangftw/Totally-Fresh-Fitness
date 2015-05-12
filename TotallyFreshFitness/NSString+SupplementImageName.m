//
//  NSString+SupplementImageName.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/16/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "NSString+SupplementImageName.h"

@implementation NSString (SupplementImageName)

static NSString *m_supplementImageName;

// Set Image
+(void)setSupplementImageName:(NSString *)imageName
{
    m_supplementImageName   = imageName;
}

// GetImage
+(NSString *)getSupplementImageName
{
    return m_supplementImageName;
}

@end
