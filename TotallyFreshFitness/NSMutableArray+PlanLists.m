//
//  NSMutableArray+PlanLists.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-09-21.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "NSMutableArray+PlanLists.h"
#import "NSString+FindImage.h"
#import "MealGroceryList.h"
#import "WorkoutPlanManager.h"


@implementation NSMutableArray (PlanLists)
//HAX
//Database *m_database;
+ (NSMutableArray *) mutableArrayObject {
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    return mutableArray;
}

/*
// Load up plan lists in arrays
*/
+ (NSArray *)setImagesAndetKeyAndsetValueFromStockArray:(NSMutableArray *)stockArray forPlan:(NSString *)plan {
    NSMutableArray *itemImageArray           = [NSMutableArray mutableArrayObject];
    NSMutableArray *itemKeyArray             = [NSMutableArray mutableArrayObject];
    NSMutableArray *itemValueArray           = [NSMutableArray mutableArrayObject];
    NSArray *array;
    if (stockArray) {
        for (int i = 0; i < [stockArray count]; i = i + 2) {
            NSString *keyString                         = [stockArray objectAtIndex:i];
            NSString *imageName                         = [self getImageName:keyString forPlan:plan];
            [itemImageArray addObject:imageName]; // add images
            
            if (([keyString length] == 0) || (keyString == NULL)) {
                [itemKeyArray addObject:@"Empty Space"]; // Add Empty space
            }
            else {
                [itemKeyArray addObject:keyString]; // Add heading
            }
            
            NSString *valueString                        = [stockArray objectAtIndex:i+1];
            if (([valueString length] == 0) || (valueString == NULL)) {
                [itemValueArray addObject:@"Empty Space"];
            }
            else {
                [itemValueArray addObject:valueString]; // Add the details
            }
        }
        
        if (([itemImageArray count] > 0) && ([itemKeyArray count] > 0) && ([itemValueArray count] > 0)) {
            array           = [[NSArray alloc] initWithObjects:itemImageArray, itemKeyArray, itemValueArray, nil];
        }
        else if (([itemImageArray count] > 0) && ([itemKeyArray count] > 0) && ([itemValueArray count] <= 0)) {
            array           = [[NSArray alloc] initWithObjects:itemImageArray, itemKeyArray, nil];
        }
    }
    return array;
}

/*
 // Get image name
 */
+ (NSString *)getImageName:(NSString *)name forPlan:(NSString *)plan
{
    NSString *imageName;
    if ([plan isEqualToString:@"Workout"]) {
        imageName = [NSString findImageForWorkout:name];
    }
//    else if([plan isEqualToString:@"Meal"]) {
//        imageName = [NSString findImageForMealPlan:name];
//    }
    return imageName;
}
/*
 Load up workout plan list
 */
+ (NSMutableArray *) loadUpWorkoutPlan
{
    Database *m_database                  = [Database alloc];
  
    NSMutableArray *workoutArray    = [self mutableArrayObject];
    NSMutableArray *m_daysArray     = [m_database getLatestExerciseDays:[NSString getUserEmail]]; // Get latest selected days
    // Keep track of selected days
    for (int i = 0; i < [m_daysArray count]; i++) {
        if ([[m_daysArray objectAtIndex:i] isEqualToString:@"YES"]) {
            // number of sections
            if (i == 0) {
                [workoutArray addObject:[self setImagesAndetKeyAndsetValueFromStockArray:[m_database  getFirstDayWorkOutforUser:[NSString getUserEmail]] forPlan:@"Workout"]];
            }
            else if (i == 1) {
                [workoutArray addObject:[self setImagesAndetKeyAndsetValueFromStockArray:[m_database  getSecondDayWorkOutforUser:[NSString getUserEmail]] forPlan:@"Workout"]];
            }
            else if (i == 2) {
                [workoutArray addObject:[self setImagesAndetKeyAndsetValueFromStockArray:[m_database getThirdDayWorkOutforUser:[NSString getUserEmail]] forPlan:@"Workout"]];
            }
            else if (i == 3) {
                [workoutArray addObject:[self setImagesAndetKeyAndsetValueFromStockArray:[m_database getFourthDayWorkOutforUser:[NSString getUserEmail]] forPlan:@"Workout"]];
            }
            else if (i == 4) {
                [workoutArray addObject:[self setImagesAndetKeyAndsetValueFromStockArray:[m_database getFifthDayWorkOutforUser:[NSString getUserEmail]] forPlan:@"Workout"]];
            }
            else if (i == 5) {
                [workoutArray addObject:[self setImagesAndetKeyAndsetValueFromStockArray:[m_database getSixthDayWorkOutforUser:[NSString getUserEmail]] forPlan:@"Workout"]];
            }
//            else if (i == 6) {
//                NSString *goal = [m_database getLatestExerciseGoal:[NSString getUserEmail]];
//                if ([goal isEqualToString:@"MUSCLE ISOLATION"]) {
//                    
//                }
//                else {
//                    if (![m_database getSeventhDayWorkOutforUser:[NSString getUserEmail]]) {
//                        [workoutArray addObject:[self setImagesAndetKeyAndsetValueFromStockArray:[m_database getSeventhDayWorkOutforUser:[NSString getUserEmail]] forPlan:@"Workout"]];
//                    }
//                }
//            }
        }
    }
    return workoutArray;
}

/*
 Add images, headings and details into each array
 */
+ (NSArray *)setImagesAndSetKeyAndsetValueFromStockArrayForMealPlan:(NSMutableArray *)stockArray
{
    NSMutableArray *itemImageArray           = [NSMutableArray mutableArrayObject];
    NSMutableArray *itemKeyArray             = [NSMutableArray mutableArrayObject];
    NSMutableArray *itemValueArray           = [NSMutableArray mutableArrayObject];
    
    MealGroceryList *mealGroceryList;
    
    // Add to individual food arrays as well as grocery list
    if (!mealGroceryList) {
        mealGroceryList                = [MealGroceryList sharedInstance];
    }
    
    for (int i = 0; i < [stockArray count]; i = i+2) {
        // First remove whitespace at the end
        [itemImageArray addObject:[NSString findImageForMealPlan:[[stockArray objectAtIndex:i] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]]]; // add meal images
        
        if (([[stockArray objectAtIndex:i] length] == 0) || [stockArray objectAtIndex:i] == NULL) {
            [itemKeyArray addObject:@"Empty Space"]; // Add empty space
        }
        else {
            [itemKeyArray addObject:[stockArray objectAtIndex:i]]; // Add Food Name
            [mealGroceryList addToGroceryList:[stockArray objectAtIndex:i]]; // Add to Gocery list
        }
        [itemValueArray addObject:[stockArray objectAtIndex:i+1]]; // Add Quantity
    }
    NSArray *array;
    
    if (([itemImageArray count] > 0) && ([itemKeyArray count] > 0) && ([itemValueArray count] > 0)) {
        array           = [[NSArray alloc] initWithObjects:itemImageArray, itemKeyArray, itemValueArray, nil];
    }
    return array;
}

/*
 Add images, headings and details into each array
 */
+ (NSArray *)setImagesAndetKeyAndsetValueFromStockArrayForSupplementPlan:(NSMutableArray *)stockArray
{
    NSMutableArray *itemImageArray           = [NSMutableArray mutableArrayObject];
    NSMutableArray *itemKeyArray             = [NSMutableArray mutableArrayObject];
    NSMutableArray *itemValueArray           = [NSMutableArray mutableArrayObject];
    
    for (int i = 0; i < [stockArray count]; i = i+2) {
        // First remove whitespace at the end
        [itemImageArray addObject:[NSString findImageForMealPlan:[[stockArray objectAtIndex:i] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]]]; // add meal images
        
        if (([[stockArray objectAtIndex:i] length] == 0) || [stockArray objectAtIndex:i] == NULL) {
            [itemKeyArray addObject:@"Empty Space"]; // Add empty space
        }
        else {
            [itemKeyArray addObject:[stockArray objectAtIndex:i]]; // Add Food Name
        }
        [itemValueArray addObject:[stockArray objectAtIndex:i+1]]; // Add Quantity
    }
    NSArray *array;
    
    if (([itemImageArray count] > 0) && ([itemKeyArray count] > 0) && ([itemValueArray count] > 0)) {
        array           = [[NSArray alloc] initWithObjects:itemImageArray, itemKeyArray, itemValueArray, nil];
    }
    return array;
}


/*
 Get Food details from the database
 */
+ (NSMutableArray *) loadUpMealPlan
{
        Database *m_database                   = [Database alloc];
  
    NSMutableArray *mealPlanArray    = [[NSMutableArray alloc] initWithObjects:
                                        [NSMutableArray setImagesAndSetKeyAndsetValueFromStockArrayForMealPlan:[m_database  getBreakfastforUser:[NSString getUserEmail]]],
                                        [NSMutableArray setImagesAndSetKeyAndsetValueFromStockArrayForMealPlan:[m_database  getFirstSnackforUser:[NSString getUserEmail]]],
                                        [NSMutableArray setImagesAndSetKeyAndsetValueFromStockArrayForMealPlan:[m_database getLunchforUser:[NSString getUserEmail]]],
                                        [NSMutableArray setImagesAndSetKeyAndsetValueFromStockArrayForMealPlan:[m_database getSecondSnackforUser:[NSString getUserEmail]]],
                                        [NSMutableArray setImagesAndSetKeyAndsetValueFromStockArrayForMealPlan:[m_database getDinnerforUser:[NSString getUserEmail]]],
                                        [NSMutableArray setImagesAndSetKeyAndsetValueFromStockArrayForMealPlan:[m_database getThirdSnackforUser:[NSString getUserEmail]]], nil];
    
    return mealPlanArray;
    
}

/*
 load up the right workout for the user for the day
 */
+ (NSArray *) loadUpWorkoutPlan:(NSString *)day;
{
    WorkoutPlanManager *workoutPlanManager        = [WorkoutPlanManager sharedInstance];
    
    // index of daysSelected is the day number
    NSMutableArray *workoutArray                  = [workoutPlanManager getWorkoutPlanFromDatabase:day];

    NSArray *workoutForDay                        = [NSMutableArray setImagesAndetKeyAndsetValueFromStockArray:workoutArray forPlan:@"Workout"];
    return workoutForDay;
}

/*
 load up images for plan
 */
+ (NSMutableArray *)getImages:(NSMutableArray *)planArray forPlan:(NSString *)plan
{
    NSMutableArray *imagesArray                     = [NSMutableArray mutableArrayObject];
    NSUInteger numberOfItems                               = [planArray count];
    for (int i = 0; i < numberOfItems; i++) {
        NSString *keyString                         = [planArray objectAtIndex:i];
        [imagesArray addObject:[NSString findImageForWorkout:[NSString stringWithFormat:@"%@",keyString]]]; // add images
    }
    return imagesArray;
}

/*
 Get Supplement details from the database
 */
+ (NSMutableArray *) loadUpSupplementPlan
{
    Database *m_database                   = [Database alloc];
  
    
    NSMutableArray *supplementPlanArray    = [[NSMutableArray alloc] initWithObjects:
                                        [NSMutableArray setImagesAndetKeyAndsetValueFromStockArrayForSupplementPlan:[m_database  getSupplementBreakfastforUser:[NSString getUserEmail]]],
                                        [NSMutableArray setImagesAndetKeyAndsetValueFromStockArrayForSupplementPlan:[m_database  getSupplementPreWorkoutforUser:[NSString getUserEmail]]],
                                        [NSMutableArray setImagesAndetKeyAndsetValueFromStockArrayForSupplementPlan:[m_database getSupplementPostWorkoutforUser:[NSString getUserEmail]]],
                                        [NSMutableArray setImagesAndetKeyAndsetValueFromStockArrayForSupplementPlan:[m_database getSupplementBeforeBedforUser:[NSString getUserEmail]]],nil];
    return supplementPlanArray;
    
}

/*
 Get Supplement Order list
 */
+(NSMutableArray *)loadUpSupplementOrder
{
    NSMutableArray *m_supplementOrderArray = [[NSMutableArray alloc] initWithObjects:@"Shred Fat Women", @"Build Muscle Women", @"Build Muscle Men", @"Shred Fat Men", nil];
    return m_supplementOrderArray;
}

/*
 Get Supplement Order images
 */
+(NSMutableArray *)loadUpSupplementOrderImages
{
    NSMutableArray *m_supplementOrderImagesArray = [[NSMutableArray alloc] initWithObjects: @"shredfat_women_thumb.jpg", @"buildmuscle_women_thumb.jpg", @"buildmuscle_men_thumb.jpg", @"shredfat_men_thumb.jpg", nil];
    return m_supplementOrderImagesArray;
}

/*
 Get Supplement Order links
 */
+(NSMutableArray *)loadUpSupplementOrderLinks {
    NSMutableArray *m_supplementLinks   = [[NSMutableArray alloc] initWithObjects:@"http://totalfitness.com/shop/shredfatwomen",@"http://totalfitness.com/shop/gettonedwomen",@"http://totalfitness.com/shop/buildmusclemen",@"http://totalfitness.com/shop/shredfatmen", nil];
    return m_supplementLinks;
}

@end
