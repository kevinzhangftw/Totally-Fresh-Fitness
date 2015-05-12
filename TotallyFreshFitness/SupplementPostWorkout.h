//
//  SupplementPostWorkout.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/16/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SupplementPostWorkout : NSManagedObject

@property (nonatomic, retain) NSString * email_id;
@property (nonatomic, retain) NSString * supplement;
@property (nonatomic, retain) NSString * quantity;

@end
