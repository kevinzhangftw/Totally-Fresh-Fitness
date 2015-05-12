//
//  SupplementCheck.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/2/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "SupplementCheck.h"
#import "NSMutableArray+SupplementItems.h"

@implementation SupplementCheck

NSMutableArray *m_supplementItems;

/*
 Singleton ResultViewController object
 */
+ (SupplementCheck *)sharedInstance {
	static SupplementCheck *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 Check if supplement item exist
 */
- (BOOL)checkSupplementItemExist:(NSString *)supplementItem
{
    BOOL exist = NO;
    
    supplementItem          = [supplementItem stringByReplacingOccurrencesOfString:@"%" withString:@""];
    supplementItem          = [supplementItem stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    if (!m_supplementItems) {
        m_supplementItems       = [NSMutableArray supplementItems];
    }
    for (NSString *item in m_supplementItems)
    {
        if ([item caseInsensitiveCompare:supplementItem] == NSOrderedSame) {
            exist   = YES;
            return exist;
        }
    }
    return exist;
}

@end
