//
//  CPDWeightProgress.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-02-03.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

@interface CPDWeightProgress : NSObject

+ (CPDWeightProgress *)sharedInstance;

- (NSArray *)weightTickerSymbols;

- (NSArray *)weightEightWeeks;

@end
