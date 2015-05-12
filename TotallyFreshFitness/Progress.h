//
//  Progress.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-10-30.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Progress : NSManagedObject

@property (nonatomic, retain) NSNumber * bmr;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * email_id;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSNumber * rep;
@property (nonatomic, retain) NSString * sync;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSString * workouts;

@end
