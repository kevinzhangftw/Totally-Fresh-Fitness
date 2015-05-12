//
//  Work_Out_Plan.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-10-30.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Work_Out_Plan : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * day;
@property (nonatomic, retain) NSNumber * day_number;
@property (nonatomic, retain) NSString * email_id;
@property (nonatomic, retain) NSNumber * exercise;
@property (nonatomic, retain) NSNumber * rep;
@property (nonatomic, retain) NSString * sync;
@property (nonatomic, retain) NSNumber * weight;

@end
