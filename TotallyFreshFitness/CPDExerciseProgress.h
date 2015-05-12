//
//  CPDStockPriceStore.h
//  CorePlotDemo
//
//  Created by Steve Baranski on 5/4/12.
//  Copyright (c) 2012 komorka technology, llc. All rights reserved.
//

@interface CPDExerciseProgress : NSObject

+ (CPDExerciseProgress *)sharedInstance;

- (NSArray *)tickerSymbols;

- (NSArray *)eightWeeks;

@end
