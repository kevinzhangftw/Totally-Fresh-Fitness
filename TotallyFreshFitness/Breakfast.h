//
//  Breakfast.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-02-25.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Breakfast : NSManagedObject

@property (nonatomic, retain) NSString * food;
@property (nonatomic, retain) NSString * quantity;
@property (nonatomic, retain) NSString * email_id;

@end
