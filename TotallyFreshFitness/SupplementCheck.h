//
//  SupplementCheck.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/2/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SupplementCheck : NSObject

// Singleton SupplementCheck object
+ (SupplementCheck *)sharedInstance;

// Check if supplement item exist
- (BOOL)checkSupplementItemExist:(NSString *)supplementItem;

@end
