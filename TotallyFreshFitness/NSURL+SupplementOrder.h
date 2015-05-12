//
//  NSURL+SupplementOrder.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/10/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (SupplementOrder)

// Set supplement order url
+ (void)setSupplementOrderUrl:(NSString *)url;
// Get supplement order url
+ (NSURL *)getSupplementOrderUrl;

@end
