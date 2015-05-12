//
//  Exercise_Levels.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-07.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Exercise_Levels : NSManagedObject

@property (nonatomic, retain) NSString * level;
@property (nonatomic, retain) NSString * sync;
@property (nonatomic, retain) NSString * email_id;
@property (nonatomic, retain) NSDate * date;

@end
