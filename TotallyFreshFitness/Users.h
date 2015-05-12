//
//  Users.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-21.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Users : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * email_id;
@property (nonatomic, retain) NSString * log;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * sync;

@end
