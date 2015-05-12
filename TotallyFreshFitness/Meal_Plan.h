//
//  Meal_Plan.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-02-09.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Meal_Plan : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * email_id;
@property (nonatomic, retain) NSString * meal;
@property (nonatomic, retain) NSString * quantity;
@property (nonatomic, retain) NSString * sync;

@end
