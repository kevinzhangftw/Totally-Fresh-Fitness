//
//  CPDWeightProgress.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-02-03.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "CPDWeightProgress.h"
#import "CPDConstants.h"

@interface CPDWeightProgress ()

@end

@implementation CPDWeightProgress

#pragma mark - Class methods

+ (CPDWeightProgress *)sharedInstance
{
    static CPDWeightProgress *sharedInstance;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - API methods

- (NSArray *)weightTickerSymbols
{
    static NSArray *symbols = nil;
    if (!symbols)
    {
        symbols = [NSArray arrayWithObjects:
                   @"Weight",
                   nil];
    }
    return symbols;
}

- (NSArray *)weightEightWeeks
{
    static NSArray *dates = nil;
    if (!dates)
    {
        dates = [NSArray arrayWithObjects:
                 @"Week 1",
                 @"Week 2",
                 @"Week 3",
                 @"Week 4",
                 @"Week 5",
                 @"Week 6",
                 @"Week 7",
                 @"Week 8",
                 nil];
    }
    return dates;
}
@end    
