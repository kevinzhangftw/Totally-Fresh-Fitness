//
//  Exercise_Days.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-07.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Exercise_Days : NSManagedObject

@property (nonatomic, retain) NSString * friday;
@property (nonatomic, retain) NSString * monday;
@property (nonatomic, retain) NSString * saturday;
@property (nonatomic, retain) NSString * sunday;
@property (nonatomic, retain) NSString * sync;
@property (nonatomic, retain) NSString * thursday;
@property (nonatomic, retain) NSString * tuesday;
@property (nonatomic, retain) NSString * wednesday;
@property (nonatomic, retain) NSString * email_id;
@property (nonatomic, retain) NSDate * date;

@end
