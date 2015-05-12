//
//  Terms_And_Conditions.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-01-29.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Terms_And_Conditions : NSManagedObject

@property (nonatomic, retain) NSString *accepted;
@property (nonatomic, retain) NSDate * date;

@end
