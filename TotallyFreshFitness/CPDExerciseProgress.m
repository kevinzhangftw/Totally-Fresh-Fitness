//
//  CPDStockPriceStore.m
//  CorePlotDemo
//
//
//  Created by Steve Baranski on 5/4/12.
//  Copyright (c) 2012 komorka technology, llc. All rights reserved.
//

#import "CPDExerciseProgress.h"
#import "CPDConstants.h"

@interface CPDExerciseProgress ()


@end

@implementation CPDExerciseProgress

#pragma mark - Class methods

+ (CPDExerciseProgress *)sharedInstance
{
    static CPDExerciseProgress *sharedInstance;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];      
    });
    
    return sharedInstance;
}

#pragma mark - API methods

- (NSArray *)tickerSymbols
{
    static NSArray *symbols = nil;
    if (!symbols)
    {
        symbols = [NSArray arrayWithObjects:
                   @"Weight",
                   @"Rep", 
                   nil];
    }
    return symbols;
}

- (NSArray *)eightWeeks
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
