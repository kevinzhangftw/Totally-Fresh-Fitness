//
//  Exercise_Report.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-03-29.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Exercise_Report : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * email_id;
@property (nonatomic, retain) NSString * exercise;
@property (nonatomic, retain) NSNumber * set_five_rep;
@property (nonatomic, retain) NSNumber * set_five_weight;
@property (nonatomic, retain) NSNumber * set_four_rep;
@property (nonatomic, retain) NSNumber * set_four_weight;
@property (nonatomic, retain) NSNumber * set_one_rep;
@property (nonatomic, retain) NSNumber * set_one_weight;
@property (nonatomic, retain) NSNumber * set_three_rep;
@property (nonatomic, retain) NSNumber * set_three_weight;
@property (nonatomic, retain) NSNumber * set_two_rep;
@property (nonatomic, retain) NSNumber * set_two_weight;
@property (nonatomic, retain) NSNumber * set_one_time;
@property (nonatomic, retain) NSNumber * set_two_time;
@property (nonatomic, retain) NSNumber * set_two_three;
@property (nonatomic, retain) NSNumber * set_three_time;
@property (nonatomic, retain) NSNumber * set_four_time;
@property (nonatomic, retain) NSNumber * set_five_time;

@end
