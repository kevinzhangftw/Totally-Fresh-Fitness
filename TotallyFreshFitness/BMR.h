//
//  BMR.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-02-10.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BMR : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSNumber * bmr;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * email_id;
@property (nonatomic, retain) NSString * exercise_mode;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * sync;
@property (nonatomic, retain) NSNumber * weight;

@end
