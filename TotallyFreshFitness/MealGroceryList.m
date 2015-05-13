//
//  MealGroceryList.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-02-09.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "MealGroceryList.h"
#import "Database.h"
#import "MealPlanSelection.h"

@interface MealGroceryList()

@property (nonatomic, strong)Database *m_database;
// MealPlanSelection class object
@property (nonatomic, strong)MealPlanSelection *m_mealPlanSelection;
// Food items in the meal plan
@property (nonatomic, strong)NSMutableArray *m_mealPlanList;
// Food items in the grocery list
@property (nonatomic, strong)NSMutableArray *m_groceryList;

@end

@implementation MealGroceryList


/*
 Singleton MealGroceryList object
 */
+ (MealGroceryList *)sharedInstance {
	static MealGroceryList *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}


/*
 Check if food exist in the grocery list
 */
- (BOOL)checkIfMealAlreadyExistInGroceryList:(NSString *)foodName
{
    // capatilized to match food name
    foodName                    = [foodName capitalizedString];
    BOOL isFoodExisting      = NO;
    if (!self.m_groceryList) {
        self.m_groceryList           = [NSMutableArray mutableArrayObject];
    }
    if (!self.m_database) {
        self.m_database              = [Database alloc];
    }
    self.m_groceryList               = [self.m_database getGroceryList:[NSString getUserEmail]];
    // Check if the index can be got by using foodName
    for (NSString *foodItem in self.m_groceryList) {
        if ([foodItem isEqualToString:foodName]) {
            isFoodExisting   = YES;
            break;
        }
    }
    return isFoodExisting;
}

/*
 Check if the meal already exist in the meal plan
 */
- (BOOL)checkifMealAlreadyExistInMealPlan:(NSString *)foodName
{
    BOOL isMealExisting;
    if (!self.m_mealPlanList) {
        self.m_mealPlanList           = [NSMutableArray mutableArrayObject];
    }
    if (!self.m_database) {
        self.m_database               = [Database alloc];
    }
    self.m_mealPlanList               = [self.m_database getMealPlan:[NSString getUserEmail]];
    
    // Check if the index can be got by using foodName
    NSUInteger index             = [self.m_mealPlanList indexOfObject: foodName];
    if(index == NSNotFound) { // food doesn't exist
        isMealExisting          = NO;
    }
    else {
        isMealExisting          = YES;
    }
    
    return isMealExisting;
}

/*
 Add to grocery list
 */
- (NSString *)addToGroceryList:(NSString *)foodName
{
    NSString *updateStatus;
    NSDate *date                = [NSDate date];
    if ([foodName length] != 0) {
        foodName                = [foodName capitalizedString];
        if (![self checkIfMealAlreadyExistInGroceryList:foodName]) { // food doesn't exist in the grocery list
            if (!self.m_database) {
                self.m_database          = [Database alloc];
            }
            updateStatus            = [self.m_database insertIntoGroceryEmail_Id:[NSString getUserEmail] Date:date food:foodName];
        }
    }
    return updateStatus;
}

// Get grocery list
- (NSMutableArray *)getGroceryList:(NSMutableArray *)calorieArray
{
    if (!calorieArray) {
        for (NSString *foodItem in calorieArray) {
            [self addToGroceryList:foodItem];
        }
    }
    if (!self.m_database) {
        self.m_database          = [Database alloc];
    }
    NSMutableArray *groceryList         = [self.m_database getGroceryList:[NSString getUserEmail]];
    return groceryList;
}
/*
 Select meal plan to add to meal plan
 */
- (NSString *)addToMealPlanList:(NSString *)foodName andQuantity:(NSString *)quantity
{
    NSString *updateStatus;
    NSDate *date                = [NSDate date];
    
    if ([foodName length] != 0) {
        if (!self.m_database) {
            self.m_database          = [Database alloc];
        }
        updateStatus            = [self.m_database insertIntoMealPlanEmail_Id:[NSString getUserEmail] Date:date Meal:foodName Quantity:quantity];
    }
    return updateStatus;
}

@end
