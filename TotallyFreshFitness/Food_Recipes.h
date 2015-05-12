//
//  Food_Recipes.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-19.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Food_Recipes : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * ingredients;
@property (nonatomic, retain) NSString * directions;

@end
