//
//  Database.m
//  Total Fitness and Nutrition
//
//  Created by Namgyal Damdul on 2012-10-25.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import "Database.h"
#import "Work_Out_Plan.h"
#import "Meal_Plan.h"
#import "Progress.h"
#import "Users.h"
#import "BMR.h"
#import "Grocery.h"
#import "Exercises.h"
#import "Exercise_Days.h"
#import "Exercise_Levels.h"
#import "Goals.h"
#import "Grocery.h"
#import "Food_Recipes.h"
#import "Exercise_Report.h"
#import "Terms_And_Conditions.h"
#import "Breakfast.h"
#import "First_Snack.h"
#import "Lunch.h"
#import "Second_Snack.h"
#import "Dinner.h"
#import "Third_Snack.h"
#import "Workout_Day_One.h"
#import "Workout_Day_Two.h"
#import "Workout_Day_Three.h"
#import "Workout_Day_Four.h"
#import "Workout_Day_Five.h"
#import "Workout_Day_Six.h"
#import "Workout_Day_Seven.h"
#import "SupplementBreakfast.h"
#import "SupplementPreWorkout.h"
#import "SupplementPostWorkout.h"
#import "SupplementBeforeBed.h"
#import <Parse/Parse.h>

@interface Database ()

// Due to no registration page, login page is both for registration and login
- (BOOL)checkIfUserIsAlreadyRegistered:(NSString *)email_Id Password:(NSString *)password;

@end

@implementation Database

// Work_Out_Plan object
Work_Out_Plan *m_Work_Out_Plan;
// Meal_Plan object
Meal_Plan *m_Meal_Plan;
// Progress object
Progress *m_Progress;
// User object
Users *m_User;
// User object
BMR *m_BMR;
// Grocery object
Grocery *m_Grocery;
// Exercise object
Exercises *m_Exercise;
// Exercise object
Exercise_Days *m_Exercise_Days;
// Exercise object
Exercise_Levels *m_Exercise_Levels;
// Exercise goals object
Goals *m_Goals;
// Food_Recipes object
Food_Recipes *m_food_Recipes;
// Exercise_Report object
Exercise_Report *m_exercise_Report;
// Terms And Conditions object
Terms_And_Conditions *m_terms_And_Conditions;
// Breakfast object
Breakfast *m_breakfast;
// First snack object
First_Snack *m_first_Snack;
// Lunch object
Lunch *m_lunch;
// Second snack object
Second_Snack *m_second_Snack;
// Dinner object
Dinner *m_dinner;
// Third snack object
Third_Snack *m_third_Snack;
// Workout first day
Workout_Day_One *m_workout_day_one;
// Workout second day
Workout_Day_Two *m_workout_day_two;
// Workout third day
Workout_Day_Three *m_workout_day_three;
// Workout fourth day
Workout_Day_Four *m_workout_day_four;
// Workout fifth day
Workout_Day_Five *m_workout_day_five;
// Workout sixth day
Workout_Day_Six *m_workout_day_six;
// Workout seventh day
Workout_Day_Seven *m_workout_day_seven;
// Supplement Breakfast object
SupplementBreakfast *m_supplement_breakfast;
// Supplement Pre workout object
SupplementPreWorkout *m_supplement_pre_workout;
// Supplement Post Workout object
SupplementPostWorkout *m_supplement_post_workout;
// Supplement Before Bed object
SupplementBeforeBed *m_supplement_before_bed;

// Request for all entities
NSFetchRequest *m_Request;

// Used for data retreival from Work_Out_Plan model
NSEntityDescription *m_Meal_PlanEntity;
// Used for data retreival from Meal_Plan model
NSEntityDescription *m_Meal_PlanEntity;
// Used for data retreival from Progress model
NSEntityDescription *m_ProgressEntity;
// Used for data retreival from Users model
NSEntityDescription *m_UsersEntity;
// Used for data retreival from Profile model
NSEntityDescription *m_BMREntity;
// Used for data retreival from Grocery model
NSEntityDescription *m_GroceryEntity;
// Used for data retreival from Nutrition_Benefits_One model
NSEntityDescription *m_Nutrition_Benefits_One_Entity;
// Used for data retreival from Nutrition_Benefits_One model
NSEntityDescription *m_Nutrition_Benefits_Two_Entity;
// Used for data retreival from Meal model
NSEntityDescription *m_WorkOutPlanEntity;
// Used for data retreival from Exercise model
NSEntityDescription *m_ExerciseEntity;
// Used for data retreival from Exercise_Days model
NSEntityDescription *m_Exercise_DaysEntity;
// Used for data retreival from Exercise Levels model
NSEntityDescription *m_Exercise_LevelsEntity;
// Used for data retreival from Goals model
NSEntityDescription *m_GoalsEntity;
// Used for data retreival from Food_Recipes model
NSEntityDescription *m_food_RecipesEntity;
// Used for data retreival from Exercise_Report model
NSEntityDescription *m_exercise_ReportEntity;
// Used for data retreival from Terms And Conditions model
NSEntityDescription *m_terms_And_Conditions_Entity;
// Used for data retreival from Breakfast model
NSEntityDescription *m_breakfast_Entity;
// Used for data retreival from first snack model
NSEntityDescription *m_first_Snack_Entity;
// Used for data retreival from Lunch model
NSEntityDescription *m_lunch_Entity;
// Used for data retreival from second snack model
NSEntityDescription *m_second_Snack_Entity;
// Used for data retreival from dinner model
NSEntityDescription *m_dinner_Entity;
// Used for data retreival from third snack model
NSEntityDescription *m_third_Snack_Entity;
// Used for data retreival from workout first day model
NSEntityDescription *m_workout_Day_One_Entity;
// Used for data retreival from workout second day model
NSEntityDescription *m_workout_Day_Two_Entity;
// Used for data retreival from workout third day model
NSEntityDescription *m_workout_Day_Three_Entity;
// Used for data retreival from workout fourth day model
NSEntityDescription *m_workout_Day_Four_Entity;
// Used for data retreival from workout fifth day model
NSEntityDescription *m_workout_Day_Five_Entity;
// Used for data retreival from workout sixth day model
NSEntityDescription *m_workout_Day_Six_Entity;
// Used for data retreival from workout seventh day model
NSEntityDescription *m_workout_Day_Seven_Entity;
// Used for data retreival from Supplement Breakfast model
NSEntityDescription *m_supplement_breakfast_Entity;
// Used for data retreival from Supplement Pre Workout model
NSEntityDescription *m_supplement_pre_workout_Entity;
// Used for data retreival from Supplement Post workout model
NSEntityDescription *m_supplement_post_workout_Entity;
// Used for data retreival from Supplement before bed model
NSEntityDescription *m_supplement_before_bed_Entity;

@synthesize managedObjectContext            = _managedObjectContext;
@synthesize managedObjectModel              = _managedObjectModel;
@synthesize persistentStoreCoordinator      = _persistentStoreCoordinator;

/*
 Get current local time and date
 */
- ( NSString * ) getCurrentLocalDateAndTime
{
    // Get current date/time
    NSDate *today                       = [ NSDate date ];
    NSDateFormatter *dateFormatter      = [ [ NSDateFormatter alloc ] init ];
    // Display in 12HR/24HR format according to User Settings
    [ dateFormatter setTimeStyle : NSDateFormatterShortStyle ];
    NSString *currentTime               = [ dateFormatter stringFromDate : today ];
    return currentTime;
}

/*
 Due to no registration page, login page is both for registration and login
 */
- (BOOL)checkIfUserIsAlreadyRegistered:(NSString *)email_Id Password:(NSString *)password
{
    NSError *error;
    
    // If the value is not changed to true when matched below, the email_id is new
    BOOL isUserAlreadyRegisteredOrNot     = FALSE;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_UsersEntity ) {
        m_UsersEntity               = [ NSEntityDescription entityForName : @"Users" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_UsersEntity ];
    
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSArray *usersArray             = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( usersArray != nil ) {
        for ( Users *user in usersArray ) {
            
            if ([user.email_id isEqualToString:email_Id]) { // Is an existing user
                
                if ([user.password isEqualToString:password]) {
                    
                    // Existing user's password is validated
                    isUserAlreadyRegisteredOrNot     = TRUE;
                    
                }
            }
        }
    }
    else {
        // Deal with error.
    }
    return isUserAlreadyRegisteredOrNot;
}

/*
 Work out record maintained
 */
- (void)insertIntoWorkOutPlanEmail_Id:(NSString *)email_id Exercise:(NSNumber *)exercise Date:(NSDate *)date Day:(NSString *)day Day_Number:(NSNumber *)day_number Weight:(NSNumber *)weight Rep:(NSNumber *)rep
{
    // Create a return string
    // No need for date to be assigned at the point of method call
    date    = [ NSDate date ];
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    // Clean up the m_Work_Out_Plan first
    m_Work_Out_Plan                     = nil;
    if ( !m_Work_Out_Plan ) {
        m_Work_Out_Plan                     = [ NSEntityDescription insertNewObjectForEntityForName : @"Work_Out_Plan" inManagedObjectContext : _managedObjectContext ];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_Work_Out_Plan.email_id        = email_id;
    }
    // Give out message if null
    
    if (exercise != NULL) {
        m_Work_Out_Plan.exercise        = exercise;
    }
    
    if ((date != NULL)) {
        m_Work_Out_Plan.date            = date;
    }
    
    if ((day != NULL) && (day.length != 0)) {
        m_Work_Out_Plan.day             = day;
    }
    
    if ((day_number != NULL)) {
        m_Work_Out_Plan.day_number      = day_number;
    }
    
    if ((weight != NULL)) {
        m_Work_Out_Plan.weight          = weight;
    }
    
    if (rep != NULL) {
        m_Work_Out_Plan.rep             = rep;
    }
    
    NSError *error;
    
    if ( ![ _managedObjectContext save:&error] ) {
        NSLog(@"Error on insert into Work_Out_Plan table");
    }
}

/*
 Meal plan record maintiaed
 */
- (NSString *)insertIntoMealPlanEmail_Id:(NSString *)email_id Date:(NSDate *)date Meal:(NSString *)meal Quantity:(NSString *)quantity;
{
    // update status
    NSString *updateStatus;
    // No need for date to be assigned at the point of method call
    date    = [ NSDate date ];

    // Clean up the _managedObjectContext first
    _managedObjectContext       = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext   = [self managedObjectContext];
    }
    
    // Clean up the m_Meal_Plan first
    m_Meal_Plan                 = nil;
    if (!m_Meal_Plan) {
        m_Meal_Plan             = [NSEntityDescription  insertNewObjectForEntityForName:@"Meal_Plan" inManagedObjectContext:_managedObjectContext];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_Meal_Plan.email_id            = email_id;
    }
    
    if (date != NULL) {
        m_Meal_Plan.date                = date;
    }
        
    if ((meal != NULL) && (meal.length != 0)) {
        m_Meal_Plan.meal                = meal;
    }
    
    if ((quantity != NULL) && (quantity.length != 0) ) {
        m_Meal_Plan.quantity            = quantity;
    }
    
    NSError *error;
    
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Error on insert into Meal_Plan table");
        updateStatus            = @"update failed";
    }
    else {
        updateStatus            = @"updated";
    }
    return updateStatus;
}

/*
 User registration
 */
- (NSString *)insertIntoUserEmail_Id:(NSString *)email_id Password:(NSString *)password Log:(NSString *)log
{
    NSString *userStatus;
    
    BOOL isUserAlreadyRegistered = [self checkIfUserIsAlreadyRegistered:email_id Password:password];
    if (isUserAlreadyRegistered) {
        
        // Log the user in
        [self logInUser:email_id];
        // Do nothing, no need to registered again
        // Existing user
        userStatus      =   [[NSString alloc] initWithFormat:@"Existing User"];
        
    }
    else
    {
        // Initial registration is same as log in, will change when logged out
        log = @"in";
        // No need for date to be assigned at the point of method call
        NSDate *date    = [ NSDate date ];

        //Clean up the _managedObjectContext first
        _managedObjectContext       = nil;
        if ( !_managedObjectContext ) {
            _managedObjectContext   = [self managedObjectContext];
        }
        
        // Clean up the m_User first
        m_User                      = nil;
        if (!m_User) {
            m_User                  = [NSEntityDescription  insertNewObjectForEntityForName:@"Users" inManagedObjectContext:_managedObjectContext];
        }
        
        if ((email_id != NULL) && (email_id.length != 0)) {
            m_User.email_id                = email_id;
        }
        else {
            return userStatus                     = @"Email id is null or empty";
        }
        
        if ((password != NULL) && (password.length != 0)) {
            m_User.password                = password;   
        }
        else {
            return userStatus                     = @"Password is null or empty";
        }

        if ((log != NULL) && (log.length != 0)) {
            m_User.log                     = log;
        }
        else {
            return userStatus                     = @"Log is null or empty";
        }
        
        if (date != NULL) {
            m_User.date                    = date;
        }
        else {
            return userStatus                     = @"Date is null";
        }
        
        NSError *error;
        
        if (![_managedObjectContext save:&error]) {
            NSLog(@"Error on insert into Users table");
        }
        else {
            userStatus      =   [[NSString alloc] initWithFormat:@"New User"];
        }
    }
    // Log out other users
    [ self logOutOtherUsers:email_id ];
    return userStatus;
}

/*
 Progress record maintained
 */
- (NSString *)insertIntoProgressEmail_Id:(NSString *)email_id Weight:(NSNumber *)weight Height:(NSNumber *)height Workouts:(NSString *)workout BMR:(NSNumber *)bmr Date:(NSDate *)date;
{
    NSString *progressUpdateStatus;
    
    // No need for date to be assigned at the point of method call
    date    = [ NSDate date ];
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [self managedObjectContext];
    }
    // Clean up the m_Progress first
    m_Progress                          = nil;
    if (!m_Progress) {
        m_Progress                      = [NSEntityDescription  insertNewObjectForEntityForName:@"Progress" inManagedObjectContext:_managedObjectContext];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_Progress.email_id             = email_id;
    }
    else {
        return progressUpdateStatus     = @"Email Id is null or empty";
    }
    
    if (date != NULL) {
        m_Progress.date                 = date;
    }
    else {
        return progressUpdateStatus     = @"Date is null";
    }
    
    if ((weight != NULL)) {
        m_Progress.weight               = weight;
    }
    else {
        return progressUpdateStatus     = @"Weight is null";
    }
    
    if (height != NULL) {
        m_Progress.height               = height;
    }
    else {
        return progressUpdateStatus     = @"Height is null";
    }
    
    if ((workout != NULL) && (workout.length != 0)) {
        m_Progress.workouts            = workout;
    }
    else {
        return progressUpdateStatus    = @"Work out is null or empty";
    }
    
    if (bmr != NULL) {
        m_Progress.bmr                 = bmr;
    }
    else {
        return progressUpdateStatus    = @"BMR is null";
    }
    
    NSError *error;
    
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Error on insert into Progress table");
    }
    else {
        progressUpdateStatus      = @"Updated";
    }
    return progressUpdateStatus;
}

/*
 User BMR details maintained
 */
- (NSString *)insertIntoBMREmail_Id:(NSString *)email_id Sex:(NSString *)sex Age:(NSNumber *)age Weight:(NSNumber *)weight Height:(NSNumber *)height BMR:(NSNumber *)bmr Date:(NSDate *)date Exercise_Mode:(NSString *)exercise_mode;
{
    NSString *bmrStatus;
    // No need for date to be assigned at the point of method call
    date    = [ NSDate date ];
    
    // Clean up the _managedObjectContext first
    _managedObjectContext           = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [self managedObjectContext];
    }
    
    // Clean up the m_BMR first
    m_BMR                           = nil;
    if (!m_BMR) {
        m_BMR                       = [NSEntityDescription  insertNewObjectForEntityForName:@"BMR" inManagedObjectContext:_managedObjectContext];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_BMR.email_id              = email_id;
    }
    else {
        bmrStatus                   = @"Email Id is null or empty";
    }
    
    if ((sex != NULL) && (sex.length != 0)) {
        m_BMR.sex                   = sex;
    }
    else {
        bmrStatus                   = @"Sex is null or empty";
    }
    
    if (age != NULL) {
        m_BMR.age                   = age;
    }
    else {
        bmrStatus                   = @"Age is null";
    }
    
    if ((date != NULL)) {
        m_BMR.date                = date;
    }
    else {
        bmrStatus                   = @"Date is null";
    }
    
    if (weight != NULL) {
        m_BMR.weight                = weight;
    }
    else {
        bmrStatus                   = @"Weight is null";
    }
    
    if (height != NULL) {
        m_BMR.height                = height;
    }
    else {
        bmrStatus                   = @"Height is null";
    }
    
    if (bmr != NULL) {
        m_BMR.bmr                   = bmr;
    }
    else {
        bmrStatus                   = @"BMR is null";
    }
    
    if ((exercise_mode != NULL) && (exercise_mode.length != 0)) {
        m_BMR.exercise_mode         = exercise_mode;
    }
    else {
        bmrStatus                   = @"Exercise Mode is null or empty";
    }
    
    NSError *error;
    
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Error on insert into Profile table");
    }
    else {
        bmrStatus       = @"live";
    }
    return bmrStatus;
}

/*
 Exercise Days maintined
 */
- (NSString *)insertIntoExerciseDaysEmail_Id:(NSString *)email_id Date:(NSDate *)date Monday:(NSString *)monday Tuesday:(NSString *)tuesday Wednesday:(NSString *)wednesday Thursday:(NSString *)thursday Friday:(NSString *)friday Saturday:(NSString *)saturday Sunday:(NSString *)sunday
{
    // set the current date and time
    date      = [NSDate date];

    NSString *daysStatus;
    
    // Clean up the _managedObjectContext first
    _managedObjectContext           = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [self managedObjectContext];
    }
    
    // Clean up the m_Exercise_Days first
    m_Exercise_Days                 = nil;
    if (!m_Exercise_Days) {
        m_Exercise_Days             = [NSEntityDescription  insertNewObjectForEntityForName:@"Exercise_Days" inManagedObjectContext:_managedObjectContext];
    }

    if ((email_id != NULL) && (email_id.length != 0)) {
        m_Exercise_Days.email_id            = email_id;
    }
    else {
        daysStatus                          = @"Email Id is null or empty";
    }
    
    if (date != NULL) {
        m_Exercise_Days.date                = date;
    }
    else {
        daysStatus                          = @"Date is null";
    }
    
    if ((monday != NULL) && (monday.length != 0)) {
        m_Exercise_Days.monday              = monday;
    }
    else {
        daysStatus                          = @"Monday is null or empty";
    }
    
    if ((tuesday != NULL) && (tuesday.length != 0)) {
        m_Exercise_Days.tuesday             = tuesday;
    }
    else {
        daysStatus                          = @"Tuesday is null or empty";
    }
    
    if ((wednesday != NULL) && (wednesday.length != 0)) {
        m_Exercise_Days.wednesday           = wednesday;
    }
    else {
        daysStatus                          = @"Wednesday is null or empty";
    }
    
    if ((thursday != NULL) && (thursday.length != 0)) {
        m_Exercise_Days.thursday            = thursday;
    }
    else {
        daysStatus                          = @"Thursday is null or empty";
    }

    if ((friday != NULL) && (friday.length != 0)) {
        m_Exercise_Days.friday              = friday;
    }
    else {
        daysStatus                          = @"Friday is null or empty";
    }

    if ((saturday != NULL) && (saturday.length != 0)) {
        m_Exercise_Days.saturday            = saturday;
    }
    else {
        daysStatus                          = @"Saturday is null or empty";
    }

    if ((sunday != NULL) && (sunday.length != 0)) {
        m_Exercise_Days.sunday              = sunday;
    }
    else {
        daysStatus                          = @"Sunday is null or empty";
    }
    
    NSError *error;
    
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Error on insert into Exercise_Days table");
    }
    else {
        daysStatus       = @"updated";
    }
    return daysStatus;
}

/*
 Exercise Level maintained
 */
- (NSString *)insertIntoExerciseLevelEmail_Id:(NSString *)email_id Date:(NSDate *)date Level:(NSString *)level
{
    // set the current date and time
    date      = [NSDate date];
    NSString *levelStatus;
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext   = [self managedObjectContext];
    }
    
    //Clean up the m_Exercise_Levels first
    m_Exercise_Levels                   = nil;
    if (!m_Exercise_Levels) {
        m_Exercise_Levels       = [NSEntityDescription  insertNewObjectForEntityForName:@"Exercise_Levels" inManagedObjectContext:_managedObjectContext];
    }

    if ((email_id != NULL) && (email_id.length != 0)) {
        m_Exercise_Levels.email_id            = email_id;
    }
    else {
        return levelStatus                    = @"Email Id is null or empty";
    }
    
    if (date != NULL) {
        m_Exercise_Levels.date                = date;
    }
    else {
        return levelStatus                    = @"Date is null";
    }
    
    if ((level != NULL) && (level.length != 0)) {
        m_Exercise_Levels.level               = level;
    }
    else {
        return levelStatus                    = @"Level is null or empty";
    }
    
    NSError *error;
    
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Error on insert into Exercise_Levels table");
    }
    else {
        levelStatus       = @"updated";
    }
    return levelStatus;
}

// Exercise goals maintained
- (NSString *)insertIntoGoalsEmail_Id:(NSString *)email_id Date:(NSDate *)date Goal:(NSString *)goal
{
    NSString *goalStatus;

    // set the current date and time
    date      = [NSDate date];
    
    // Clean up the _managedObjectContext first
    _managedObjectContext           = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [self managedObjectContext];
    }
    
    // Clean up the m_Goals first
    m_Goals                         = nil;
    if (!m_Goals) {
        m_Goals                 = [NSEntityDescription  insertNewObjectForEntityForName:@"Goals" inManagedObjectContext:_managedObjectContext];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_Goals.email_id            = email_id;
    }
    else {
        return goalStatus                  = @"Email Id is null or empty";
    }
    
    if (date != NULL) {
        m_Goals.date                       = date;
    }
    else {
        return goalStatus                  = @"Date is null";
    }
    
    if ((goal != NULL) && (goal.length != 0)) {
        m_Goals.goal                       = goal;
    }
    else {
        return goalStatus                  = @"Goal is null or empty";
    }
    
    NSError *error;
    
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Error on insert into Exercise_Levels table");
    }
    else {
        goalStatus       = @"updated";
    }
    return goalStatus;
}

/*
 Grocery list maintained
 */
- (NSString *)insertIntoGroceryEmail_Id:(NSString *)email_id Date:(NSDate *)date food:(NSString *)food
{
    NSString *groceryUpdate;
    
    // No need for date to be assigned at the point of method call
    date    = [ NSDate date ];
    
    // Need to clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [self managedObjectContext];
    }
    
    // Need to clean up the grocery first
    m_Grocery                           = nil;
    
    if (!m_Grocery) {
        m_Grocery                       = [NSEntityDescription  insertNewObjectForEntityForName:@"Grocery" inManagedObjectContext:_managedObjectContext];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_Grocery.email_id              = email_id;
    }
    else {
        return groceryUpdate            = @"Email Id is null or empty";
    }
    
    if (date != NULL) {
        m_Grocery.date                  = date;
    }
    else {
        return groceryUpdate            = @"Date is null";
    }
    
    if ((food != NULL) && (food.length != 0)) {
        m_Grocery.food                  = food;
    }
    else {
        return groceryUpdate            = @"Food is null or empty";
    }
    
    NSError *error;
    
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Error on insert into Grocery table");
    }
    else {
        groceryUpdate   =   @"updated";
    }
return groceryUpdate;
}


// Food Recipes Transit
- (NSString *)insertIntoFoodRecipesTitle:(NSString *)title Image:(NSString *)image Ingredients:(NSString *)ingredients Directions:(NSString *)directions
{
    NSString *foodRecipesUpdate;
        
    // Need to clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [self managedObjectContext];
    }
    
    // Need to clean up the food recipes first
    m_food_Recipes                           = nil;
    
    if (!m_food_Recipes) {
        m_food_Recipes                       = [NSEntityDescription  insertNewObjectForEntityForName:@"Food_Recipes" inManagedObjectContext:_managedObjectContext];
    }
    if ((title != NULL) && (title.length != 0)) {
        m_food_Recipes.title                 = title;
    }
    else {
        return foodRecipesUpdate             = @"Title is null or empty";
    }
    
    if ((image != NULL) && (image.length != 0)) {
        m_food_Recipes.image                 = image;
    }
    else {
        return foodRecipesUpdate             = @"Image is null or empty";
    }

    if ((ingredients != NULL) && (ingredients.length != 0)) {
        m_food_Recipes.ingredients           = ingredients;
    }
    else {
        return foodRecipesUpdate             = @"Ingredients is null or empty";
    }

    if ((directions != NULL) && (directions.length != 0)) {
        m_food_Recipes.directions            = directions;
    }
    else {
        return foodRecipesUpdate             = @"Directions is null or empty";
    }
    
    NSError *error;
    
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Error on insert into Food_Recipes table");
    }
    else {
        foodRecipesUpdate   =   @"updated";
    }
    return foodRecipesUpdate;

}

// Exercise Report Maintain
- (NSString *)insertIntoExerciseReport:(NSString *)exercise Email_Id:(NSString *)email_id Date:(NSDate *)date SetOneWeight:(NSNumber *)set_one_weight SetOneRep:(NSNumber *)set_one_rep SetTwoWeight:(NSNumber *)set_two_weight SetTwoRep:(NSNumber *)set_two_rep SetThreeWeight:(NSNumber *)set_three_weight SetThreeRep:(NSNumber *)set_three_rep SetFourWeight:(NSNumber *)set_four_weight SetFourRep:(NSNumber *)set_four_rep SetFiveWeight:(NSNumber *)set_five_weight SetFiveRep:(NSNumber *)set_five_rep;
{
    NSString *exerciseReportUpdate;
    
    // Need to clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [self managedObjectContext];
    }
    
    // Need to clean up the food recipes first
    m_exercise_Report                   = nil;
    
    if (!m_exercise_Report) {
        m_exercise_Report               = [NSEntityDescription  insertNewObjectForEntityForName:@"Exercise_Report" inManagedObjectContext:_managedObjectContext];
    }
    
    // Make sure that data to be inserted are set first
    if (([email_id length] != 0) && (email_id != NULL)) {
        m_exercise_Report.email_id                          = email_id;
    }
    if (([exercise length] != 0) && (exercise != NULL)) {
        m_exercise_Report.exercise                          = exercise;
    }
    
    m_exercise_Report.date                                  = date;
    
    if ((set_one_weight) && (set_one_weight != NULL)) {
        m_exercise_Report.set_one_weight                    = set_one_weight;
    }
    if ((set_one_rep) && (set_one_rep != NULL)) {
        m_exercise_Report.set_one_rep                       = set_one_rep;
    }
    if ((set_two_weight) && (set_two_weight != NULL)) {
        m_exercise_Report.set_two_weight                    = set_two_weight;
    }
    if ((set_two_rep) && (set_two_rep != NULL)) {
        m_exercise_Report.set_two_rep                       = set_two_rep;
    }
    if ((set_three_weight) && (set_three_weight != NULL)) {
        m_exercise_Report.set_three_weight                  = set_three_weight;
    }
    if ((set_three_rep) && (set_three_rep != NULL)) {
        m_exercise_Report.set_three_rep                     = set_three_rep;
    }
    if ((set_four_weight) && (set_four_weight != NULL)) {
        m_exercise_Report.set_four_weight                   = set_four_weight;
    }
    if ((set_four_rep) && (set_four_rep != NULL)) {
        m_exercise_Report.set_four_rep                      = set_four_rep;
    }
    if ((set_five_weight) && (set_five_weight != NULL)) {
        m_exercise_Report.set_five_weight                   = set_five_weight;
    }
    if ((set_five_rep) && (set_five_rep != NULL)) {
        m_exercise_Report.set_five_rep                      = set_five_rep;
    }
    
    NSError *error;
    
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Error on insert into Exercise_Report table");
    }
    else {
        exerciseReportUpdate   =   @"updated";
    }
    return exerciseReportUpdate;

}

// Exercise Report Maintain
- (NSString *)insertIntoExerciseReport:(NSString *)exercise Email_Id:(NSString *)email_id Date:(NSDate *)date SetOneWeight:(NSNumber *)set_one_weight SetOneTime:(NSNumber *)set_one_time SetOneRep:(NSNumber *)set_one_rep
{
    NSString *exerciseReportUpdate;
    
    // Need to clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [self managedObjectContext];
    }
    
    // Need to clean up the food recipes first
    m_exercise_Report                   = nil;
    
    if (!m_exercise_Report) {
        m_exercise_Report               = [NSEntityDescription  insertNewObjectForEntityForName:@"Exercise_Report" inManagedObjectContext:_managedObjectContext];
    }

    // Make sure that data to be inserted are set first
    if (([email_id length] != 0) && (email_id != NULL)) {
        m_exercise_Report.email_id                          = email_id;
    }
    if (([exercise length] != 0) && (exercise != NULL)) {
        m_exercise_Report.exercise                          = exercise;
    }
    
    m_exercise_Report.date                                  = date;

    if (set_one_weight != NULL) {
        m_exercise_Report.set_one_weight                    = set_one_weight;
    }
    if (set_one_time != NULL) {
        m_exercise_Report.set_one_time                      = set_one_time;
    }
    if ((set_one_rep) && (set_one_rep != NULL)) {
        m_exercise_Report.set_one_rep                       = set_one_rep;
    }
    // Just put zero to avoid crashes when accessing by having null if done nothing
    m_exercise_Report.set_two_weight                    = [NSNumber numberWithInt:0];
    m_exercise_Report.set_two_rep                       = [NSNumber numberWithInt:0];
    m_exercise_Report.set_three_weight                  = [NSNumber numberWithInt:0];
    m_exercise_Report.set_three_rep                     = [NSNumber numberWithInt:0];
    m_exercise_Report.set_four_weight                   = [NSNumber numberWithInt:0];
    m_exercise_Report.set_four_rep                      = [NSNumber numberWithInt:0];
    m_exercise_Report.set_five_weight                   = [NSNumber numberWithInt:0];
    m_exercise_Report.set_five_rep                      = [NSNumber numberWithInt:0];
    
    NSError *error;
    
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Error on insert into Exercise_Report table");
    }
    else {
        exerciseReportUpdate   =   @"updated";
    }
    return exerciseReportUpdate;
}

// Exercise Report Maintain by updating
- (NSString *)updateExerciseReport:(NSString *)exercise Email_Id:(NSString *)email_id Date:(NSDate *)date Set:(NSNumber *)set_number SetTheWeight:(NSNumber *)set_the_weight SetTheTime:(NSNumber *)set_the_time SetTheRep:(NSNumber *)set_the_rep;
{
    NSString *exerciseReportUpdate;
   
    NSError *error;
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    // Need to clean up the _managedObjectContext first
    _managedObjectContext                   = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [self managedObjectContext];
    }
    
    if ( !m_exercise_ReportEntity ) {
        m_exercise_ReportEntity             = [ NSEntityDescription entityForName : @"Exercise_Report" inManagedObjectContext : _managedObjectContext ];
    }
    
    NSMutableArray *predicates              = nil;
    if (!predicates) {
        predicates                          = [NSMutableArray mutableArrayObject];
    }
    
    // Make sure that data to be inserted are set first
    if (([email_id length] != 0) && (email_id != NULL) && ([exercise length] != 0) && (exercise != NULL)) {
        // find all the entries with email_id
        [predicates addObject:[ NSPredicate predicateWithFormat : @"(email_id == %@) AND (exercise == %@)", email_id, exercise ]];
    }
    
    // build the compound predicate
    NSPredicate *predicate                  = nil;
    if (!predicate) {
        predicate                           = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    }
    
    [m_Request setPredicate:predicate];

    // Retreive the streams in descending order., to get the latest only
    NSSortDescriptor *sortDescriptor        = [ [ NSSortDescriptor alloc ] initWithKey:@"date"
                                                                            ascending : NO ];
    NSArray *sortDescriptors                = [ [ NSArray alloc ] initWithObjects : &sortDescriptor count : 1 ];
    
    [ m_Request setSortDescriptors : sortDescriptors ];
    [ m_Request setFetchLimit : 1 ];    
    [ m_Request setEntity:m_exercise_ReportEntity ];

    NSArray *exerciseReportArray           = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if (exerciseReportArray != nil) { // If the array is not null
        for (Exercise_Report *exercise_report in exerciseReportArray) {
            if ((set_number) && (set_number != NULL)) { // Set should not be null or empty
                if (set_number == [NSNumber numberWithInt:2 ]) { // if this set is second set
                    if (set_the_weight != NULL) {
                        exercise_report.set_one_weight  = set_the_weight;
                    }
                    if (set_the_time != NULL) {
                        
                        exercise_report.set_one_time    = set_the_time;
                    }
                    if ((set_the_rep) && (set_the_rep != NULL)) {
                        exercise_report.set_one_rep     = set_the_rep;
                    }
                }
                else if (set_number == [NSNumber numberWithInt:3 ]) { // if this set is third set
                    if (set_the_weight != NULL) {
                        exercise_report.set_one_weight  = set_the_weight;
                    }
                    if (set_the_time != NULL) {
                        exercise_report.set_one_time    = set_the_time;
                    }
                    if ((set_the_rep) && (set_the_rep != NULL)) {
                        exercise_report.set_one_rep     = set_the_rep;
                    }
                }
                else if (set_number == [NSNumber numberWithInt:4 ]) { // if this set is four set
                    if (set_the_weight != NULL) {
                        exercise_report.set_one_weight  = set_the_weight;
                    }
                    if (set_the_time != NULL) {
                        exercise_report.set_one_time    = set_the_time;
                    }
                    if ((set_the_rep) && (set_the_rep != NULL)) {
                        exercise_report.set_one_rep     = set_the_rep;
                    }
                }
                else if (set_number == [NSNumber numberWithInt:5 ]) { // if this set is five set
                    if (set_the_weight != NULL) {
                        exercise_report.set_one_weight  = set_the_weight;
                    }
                    if (set_the_time != NULL) {
                        exercise_report.set_one_time    = set_the_time;
                    }
                    if ((set_the_rep) && (set_the_rep != NULL)) {
                        exercise_report.set_one_rep     = set_the_rep;
                    }
                }
                // save the managedObjectContext to save the update
                [ self.managedObjectContext save : nil ];
                exerciseReportUpdate                        = @"updated";
            }
        }
    }
    return exerciseReportUpdate;
}

// Exercise Report Maintain
- (NSString *)insertIntoExerciseReportWeight:(NSNumber *)weight Email_Id:(NSString *)email_id
{
    NSString *exerciseReportUpdate;
    
    // Today's date
    NSDate *date                        = [NSDate date];
    
    // Need to clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [self managedObjectContext];
    }
    
    // Need to clean up the food recipes first
    m_exercise_Report                   = nil;
    
    if (!m_exercise_Report) {
        m_exercise_Report               = [NSEntityDescription  insertNewObjectForEntityForName:@"Exercise_Report" inManagedObjectContext:_managedObjectContext];
    }
    
    // Make sure that data to be inserted are set first
    if (([email_id length] != 0) && (email_id != NULL)) {
        m_exercise_Report.email_id                      = email_id;
    }
    
    m_exercise_Report.date                              = date;
    
    if ((weight) && (weight != NULL)) {
        m_exercise_Report.set_one_weight                = weight;
    }

    // Just put zero to avoid crashes when accessing by having null if done nothing
    m_exercise_Report.set_one_rep                       = [NSNumber numberWithInt:0];
    m_exercise_Report.set_two_weight                    = [NSNumber numberWithInt:0];
    m_exercise_Report.set_two_rep                       = [NSNumber numberWithInt:0];
    m_exercise_Report.set_three_weight                  = [NSNumber numberWithInt:0];
    m_exercise_Report.set_three_rep                     = [NSNumber numberWithInt:0];
    m_exercise_Report.set_four_weight                   = [NSNumber numberWithInt:0];
    m_exercise_Report.set_four_rep                      = [NSNumber numberWithInt:0];
    m_exercise_Report.set_five_weight                   = [NSNumber numberWithInt:0];
    m_exercise_Report.set_five_rep                      = [NSNumber numberWithInt:0];
    
    NSError *error;
    
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Error on insert into Exercise_Report table");
    }
    else {
        exerciseReportUpdate                            = @"inserted";
    }
    return exerciseReportUpdate;

}

/*
 Terms And Conditions accepted
 */
- (NSString *)insertIntoTermsAndConditionsToAccept:(NSString *)yes
{
    // Terms And Conditions insert status
    NSString *status;
    // No need for date to be assigned at the point of method call
    NSDate *date    = [ NSDate date ];
    
    // Clean up the _managedObjectContext first
    _managedObjectContext                          = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext                      = [self managedObjectContext];
    }
    
    // Clean up the m_terms_And_Conditions first
    m_terms_And_Conditions                         = nil;
    if (!m_terms_And_Conditions) {
        m_terms_And_Conditions                     = [NSEntityDescription  insertNewObjectForEntityForName:@"Terms_And_Conditions" inManagedObjectContext:_managedObjectContext];
    }
    
    if ((yes != NULL) && (yes.length != 0)) {
        m_terms_And_Conditions.accepted            = yes;
    }
    
    if (date != NULL) {
        m_terms_And_Conditions.date                = date;
    }
    
    NSError *error;
    
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Error on insert into Terms_And_Conditions table");
    }
    else {
        status                                     = @"inserted";
    }
    return status;
}

// insert into breakfast
- (NSString *)insertIntoBreakfastFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;

    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    // Clean up the m_Work_Out_Plan first
    m_breakfast                         = nil;
    if ( !m_breakfast ) {
        m_breakfast                     = [ NSEntityDescription insertNewObjectForEntityForName : @"Breakfast" inManagedObjectContext : _managedObjectContext ];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_breakfast.email_id            = email_id;
    }
    // Give out message if null
    
    if ((food != NULL) && (food.length != 0)) {
        m_breakfast.food                 = food;
    }
    
    if ((quantity != NULL) && (quantity.length != 0)) {
        m_breakfast.quantity             = quantity;
    }
    
    NSError *error;
    
    if ( ![ _managedObjectContext save:&error] ) {
        NSLog(@"Error on insert into Breakfast table");
    }
    else {
        status                           = @"inserted";
    }
    return status;
}

// update into breakfast
- (NSString *)updateBreakfastFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( !m_breakfast_Entity ) {
        m_breakfast_Entity              = [ NSEntityDescription entityForName : @"Breakfast" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_breakfast_Entity ];
    
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];

    NSError *error;

    NSArray *breakfastArray             = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    // Object to delete
    NSManagedObject *objectIDToDelete;

    for ( Breakfast *breakfast in breakfastArray ) { // Loop through each object in a row of the "Users" table
        // Delete "food" object which is to be replaced
        if ([breakfast.food isEqualToString:food]) {
            objectIDToDelete            = [_managedObjectContext objectWithID:breakfast.objectID];
            [_managedObjectContext deleteObject:objectIDToDelete];
            // Must save the managedobjectcontext to delete
            [ self.managedObjectContext save : nil ];
            status                      = @"deleted";
            break;
        }
        else {
            // Deal with error.
        }
    }
    return status;
}

// insert into first snack
- (NSString *)insertIntoFirstSnackFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;

    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    // Clean up the m_Work_Out_Plan first
    m_first_Snack                       = nil;
    if ( !m_first_Snack ) {
        m_first_Snack                   = [ NSEntityDescription insertNewObjectForEntityForName : @"First_Snack" inManagedObjectContext : _managedObjectContext ];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_first_Snack.email_id          = email_id;
    }
    // Give out message if null
    
    if ((food != NULL) && (food.length != 0)) {
        m_first_Snack.food              = food;
    }
    
    if ((quantity != NULL) && (quantity.length != 0)) {
        m_first_Snack.quantity          = quantity;
    }
    
    NSError *error;
    
    if ( ![ _managedObjectContext save:&error] ) {
        NSLog(@"Error on insert into First Snack table");
    }
    else {
        status                           = @"inserted";
    }
    return status;
}

// update into breakfast
- (NSString *)updateFirstSnackFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( !m_first_Snack_Entity ) {
        m_first_Snack_Entity            = [ NSEntityDescription entityForName : @"First_Snack" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_first_Snack_Entity ];
    
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSError *error;
    
    NSArray *firstSnackArray            = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    // Object to delete
    NSManagedObject *objectIDToDelete;
    
    for ( First_Snack *first_snack in firstSnackArray ) { // Loop through each object in a row of the "Users" table
        // Delete "food" object which is to be replaced
        if ([first_snack.food isEqualToString:food]) {
            objectIDToDelete            = [_managedObjectContext objectWithID:first_snack.objectID];
            [_managedObjectContext deleteObject:objectIDToDelete];
            // Must save the managedobjectcontext to delete
            [ self.managedObjectContext save : nil ];
            status                      = @"deleted";
            break;
        }
        else {
            // Deal with error.
        }
    }
    return status;
}

// insert into lunch
- (NSString *)insertIntoLunchFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;

    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    // Clean up the m_Work_Out_Plan first
    m_lunch                             = nil;
    if ( !m_lunch ) {
        m_lunch                         = [ NSEntityDescription insertNewObjectForEntityForName : @"Lunch" inManagedObjectContext : _managedObjectContext ];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_lunch.email_id                = email_id;
    }
    // Give out message if null
    
    if ((food != NULL) && (food.length != 0)) {
        m_lunch.food                    = food;
    }
    
    if ((quantity != NULL) && (quantity.length != 0)) {
        m_lunch.quantity                = quantity;
    }
    
    NSError *error;
    
    if ( ![ _managedObjectContext save:&error] ) {
        NSLog(@"Error on insert into Lunch table");
    }
    else {
        status                           = @"inserted";
    }
    return status;

}

// update into lunch
- (NSString *)updateLunchFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( !m_lunch_Entity ) {
        m_lunch_Entity                  = [ NSEntityDescription entityForName : @"Lunch" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_lunch_Entity ];
    
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSError *error;
    
    NSArray *lunchArray                 = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    // Object to delete
    NSManagedObject *objectIDToDelete;
    
    for ( Lunch *lunch in lunchArray ) {
        // Delete "food" object which is to be replaced
        if ([lunch.food isEqualToString:food]) {
            objectIDToDelete            = [_managedObjectContext objectWithID:lunch.objectID];
            [_managedObjectContext deleteObject:objectIDToDelete];
            // Must save the managedobjectcontext to delete
            [ self.managedObjectContext save : nil ];
            status                      = @"deleted";
            break;
        }
        else {
            // Deal with error.
        }
    }
    return status;
}

// insert into second snack
- (NSString *)insertIntoSecondSnackFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;

    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    // Clean up the m_Work_Out_Plan first
    m_second_Snack                      = nil;
    if ( !m_second_Snack ) {
        m_second_Snack                  = [ NSEntityDescription insertNewObjectForEntityForName : @"Second_Snack" inManagedObjectContext : _managedObjectContext ];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_second_Snack.email_id         = email_id;
    }
    // Give out message if null
    
    if ((food != NULL) && (food.length != 0)) {
        m_second_Snack.food             = food;
    }
    
    if ((quantity != NULL) && (quantity.length != 0)) {
        m_second_Snack.quantity         = quantity;
    }
    
    NSError *error;
    
    if ( ![ _managedObjectContext save:&error] ) {
        NSLog(@"Error on insert into Second_Snack table");
    }
    else {
        status                           = @"inserted";
    }
    return status;
}

// update into second snack
- (NSString *)updateSecondSnackFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( !m_second_Snack_Entity ) {
        m_second_Snack_Entity           = [ NSEntityDescription entityForName : @"Second_Snack" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_second_Snack_Entity ];
    
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSError *error;
    
    NSArray *secondSnackArray           = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    // Object to delete
    NSManagedObject *objectIDToDelete;
    
    for ( Second_Snack *secondSnack in secondSnackArray ) {
        // Delete "food" object which is to be replaced
        if ([secondSnack.food isEqualToString:food]) {
            objectIDToDelete            = [_managedObjectContext objectWithID:secondSnack.objectID];
            [_managedObjectContext deleteObject:objectIDToDelete];
            // Must save the managedobjectcontext to delete
            [ self.managedObjectContext save : nil ];
            status                      = @"deleted";
            break;
        }
        else {
            // Deal with error.
        }
    }
    return status;
}

// insert into dinner
- (NSString *)insertIntoDinnerFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;

    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    // Clean up the m_Work_Out_Plan first
    m_dinner                            = nil;
    if ( !m_dinner ) {
        m_dinner                        = [ NSEntityDescription insertNewObjectForEntityForName : @"Dinner" inManagedObjectContext : _managedObjectContext ];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_dinner.email_id               = email_id;
    }
    // Give out message if null
    
    if ((food != NULL) && (food.length != 0)) {
        m_dinner.food                   = food;
    }
    
    if ((quantity != NULL) && (quantity.length != 0)) {
        m_dinner.quantity               = quantity;
    }
    
    NSError *error;
    
    if ( ![ _managedObjectContext save:&error] ) {
        NSLog(@"Error on insert into Dinner table");
    }
    else {
        status                           = @"inserted";
    }
    return status;
}

// update into dinner
- (NSString *)updateDinnerFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( !m_dinner_Entity ) {
        m_dinner_Entity                 = [ NSEntityDescription entityForName : @"Dinner" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_dinner_Entity ];
    
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSError *error;
    
    NSArray *dinnerArray                = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    // Object to delete
    NSManagedObject *objectIDToDelete;
    
    for ( Dinner *dinner in dinnerArray ) {
        // Delete "food" object which is to be replaced
        if ([dinner.food isEqualToString:food]) {
            objectIDToDelete            = [_managedObjectContext objectWithID:dinner.objectID];
            [_managedObjectContext deleteObject:objectIDToDelete];
            // Must save the managedobjectcontext to delete
            [ self.managedObjectContext save : nil ];
            
            status                      = @"deleted";
            break;
        }
        else {
            // Deal with error.
        }
    }
    return status;
}

// insert into third snack
- (NSString *)insertIntoThirdSnackFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;

    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    // Clean up the m_Work_Out_Plan first
    m_third_Snack                       = nil;
    if ( !m_third_Snack ) {
        m_third_Snack                   = [ NSEntityDescription insertNewObjectForEntityForName : @"Third_Snack" inManagedObjectContext : _managedObjectContext ];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_third_Snack.email_id          = email_id;
    }
    // Give out message if null
    
    if ((food != NULL) && (food.length != 0)) {
        m_third_Snack.food              = food;
    }
    
    if ((quantity != NULL) && (quantity.length != 0)) {
        m_third_Snack.quantity          = quantity;
    }
    
    NSError *error;
    
    if ( ![ _managedObjectContext save:&error] ) {
        NSLog(@"Error on insert into Third_Snack table");
    }
    else {
        status                           = @"inserted";
    }
    return status;
}

/*
 update into third snack
 */
- (NSString *)updateThirdSnackFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( !m_third_Snack_Entity ) {
        m_third_Snack_Entity            = [ NSEntityDescription entityForName : @"Third_Snack" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_third_Snack_Entity ];
    
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSError *error;
    
    NSArray *thirdSnackArray            = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    // Object to delete
    NSManagedObject *objectIDToDelete;
    
    for ( Third_Snack *third_snack in thirdSnackArray ) {
        // Delete "food" object which is to be replaced
        if ([third_snack.food isEqualToString:food]) {
            objectIDToDelete            = [_managedObjectContext objectWithID:third_snack.objectID];
            [_managedObjectContext deleteObject:objectIDToDelete];
            // Must save the managedobjectcontext to delete
            [ self.managedObjectContext save : nil ];
            status                      = @"deleted";
            break;
        }
        else {
            // Deal with error.
        }
    }
    return status;
}

/*
 Get Workout plan
 */
- (NSMutableArray *)getWorkOutPlan:(NSString *)email_Id
{
    NSError *error;
    NSMutableArray *workOutPlanStreamsMutableArray = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) { 
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_WorkOutPlanEntity ) {
        m_WorkOutPlanEntity                   = [ NSEntityDescription entityForName : @"Work_Out_Plan" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_WorkOutPlanEntity ];
        
    NSArray *workOutPlanStreamsArray        = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( workOutPlanStreamsArray != nil ) {
        for ( Work_Out_Plan *work_out_plan in workOutPlanStreamsArray ) {
            [ workOutPlanStreamsMutableArray addObject:work_out_plan.email_id ];
            [ workOutPlanStreamsMutableArray addObject:work_out_plan.exercise ];
            [ workOutPlanStreamsMutableArray addObject:work_out_plan.date ];
            [ workOutPlanStreamsMutableArray addObject:work_out_plan.day ];
            [ workOutPlanStreamsMutableArray addObject:work_out_plan.day_number ];
            [ workOutPlanStreamsMutableArray addObject:work_out_plan.weight ];
            [ workOutPlanStreamsMutableArray addObject:work_out_plan.rep ];
        }
    }
    else {
        // Deal with error.
    }
    return workOutPlanStreamsMutableArray;
}

/*
 Get meal plan
 */
- (NSMutableArray *)getMealPlan:(NSString *)email_Id
{
    NSError *error;
    NSMutableArray *mealPlanStreamsMutableArray         = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                       = nil;
    }

    if ( !m_Request ) {
        m_Request                       = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_Meal_PlanEntity ) {
        m_Meal_PlanEntity               = [ NSEntityDescription entityForName : @"Meal_Plan" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_Meal_PlanEntity ];
    
    NSArray *mealPlanStreamsArray        = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( mealPlanStreamsArray != nil ) {
        for ( Meal_Plan *meal_plan in mealPlanStreamsArray ) {
            [ mealPlanStreamsMutableArray addObject:meal_plan.email_id ];
            [ mealPlanStreamsMutableArray addObject:meal_plan.date ];
            [ mealPlanStreamsMutableArray addObject:meal_plan.meal ];
            [ mealPlanStreamsMutableArray addObject:meal_plan.quantity ];
        }
    }
    else {
        // Deal with error.
    }
    return mealPlanStreamsMutableArray;
}

/*
 Get User Info
 */
- (NSMutableArray *)getUserInfo:(NSString *)email_Id
{
    NSError *error;
    NSMutableArray *usersMutableArray       = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                       = nil;
    }

    if ( !m_Request ) {
        m_Request                       = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_UsersEntity ) {
        m_UsersEntity                   = [ NSEntityDescription entityForName : @"Users" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_UsersEntity ];
    
    NSArray *usersArray                 = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( usersArray != nil ) {
        for ( Users *user in usersArray ) {
            [ usersMutableArray addObject:user.email_id ];
            [ usersMutableArray addObject:user.password ];
            [ usersMutableArray addObject:user.log ];
        }
    }
    else {
        // Deal with error.
    }
    return usersMutableArray;
}

/*
 Get Progress Report
 */
- (NSMutableArray *)getProgressReport:(NSString *)email_Id
{
    NSError *error;
    NSMutableArray *progressMutableArray        = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_ProgressEntity ) {
        m_ProgressEntity            = [ NSEntityDescription entityForName : @"Progress" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_ProgressEntity ];
    
    NSArray *progressArray          = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( progressArray != nil ) {
        for ( Progress *progress in progressArray ) {
            [ progressMutableArray addObject:progress.email_id ];
            [ progressMutableArray addObject:progress.weight ];
            [ progressMutableArray addObject:progress.height ];
            [ progressMutableArray addObject:progress.bmr ];
            [ progressMutableArray addObject:progress.workouts ];
        }
    }
    else {
        // Deal with error.
    }
    return progressMutableArray;
}

// Get BMR
- (int)getBMR:(NSString *)email_Id
{
    NSError *error;
    int latestBMR;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_BMREntity ) {
        m_BMREntity                 = [ NSEntityDescription entityForName : @"BMR" inManagedObjectContext : _managedObjectContext ];
    }
    
    // Retrieve only this user's BMR
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    [ m_Request setPredicate : predicate ];
    
    // Retreive the streams in descending order.
    NSSortDescriptor *sortDescriptor        = [ [ NSSortDescriptor alloc ] initWithKey:@"date"
                                                                            ascending : NO ];
    NSArray *sortDescriptors                = [ [ NSArray alloc ] initWithObjects : &sortDescriptor count : 1 ];
    
    [ m_Request setSortDescriptors : sortDescriptors ];
    [ m_Request setFetchLimit : 1 ];
    [ m_Request setEntity:m_BMREntity ];
    
    NSArray *bmrArray          = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    {
        for ( BMR *bmr in bmrArray ) {
            latestBMR   = [bmr.bmr intValue];
            break;
        }
    }
    return latestBMR;
}

/*
 Get Profile Details
 */
- (NSMutableArray *)getBMRDetails:(NSString *)email_Id
{
    NSError *error;
    NSMutableArray *bmrMutableArray        = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_BMREntity ) {
        m_BMREntity                 = [ NSEntityDescription entityForName : @"BMR" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_BMREntity ];
    
    // Retrieve only this user's BMR
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    [ m_Request setPredicate : predicate ];

    NSArray *bmrArray               = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( bmrArray != nil ) {
        for ( BMR *bmr in bmrArray ) {
            [ bmrMutableArray addObject:bmr.email_id ];
            [ bmrMutableArray addObject:bmr.sex ];
            [ bmrMutableArray addObject:bmr.age ];
            [ bmrMutableArray addObject:bmr.weight ];
            [ bmrMutableArray addObject:bmr.height ];
            [ bmrMutableArray addObject:bmr.bmr ];
            [ bmrMutableArray addObject:bmr.date ];
            [ bmrMutableArray addObject:bmr.exercise_mode ];
        }
    }
    else {
        // Deal with error.
    }
    return bmrMutableArray;
}

/*
 Get latest BMR details
 */
- (NSMutableArray *)getLatestBMR:(NSString *)email_Id
{
    NSError *error;
    NSMutableArray *bmrMutableArray        = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_BMREntity ) {
        m_BMREntity            = [ NSEntityDescription entityForName : @"BMR" inManagedObjectContext : _managedObjectContext ];
    }
    
    // Retrieve only this user's BMR
    NSPredicate *predicate         = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    [ m_Request setPredicate : predicate ];
    
    // Retreive the streams in descending order.
    NSSortDescriptor *sortDescriptor    = [ [ NSSortDescriptor alloc ] initWithKey:@"date"
                                                                            ascending : NO ];
    NSArray *sortDescriptors            = [ [ NSArray alloc ] initWithObjects : &sortDescriptor count : 1 ];
    
    [ m_Request setSortDescriptors : sortDescriptors ];
    [ m_Request setFetchLimit : 1 ];    
    [ m_Request setEntity:m_BMREntity ];
    
    NSArray *bmrArray                   = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( bmrArray != nil ) {
        for ( BMR *bmr in bmrArray ) {
            [ bmrMutableArray addObject:bmr.email_id ];
            [ bmrMutableArray addObject:bmr.sex ];
            [ bmrMutableArray addObject:bmr.age ];
            [ bmrMutableArray addObject:bmr.weight ];
            [ bmrMutableArray addObject:bmr.height ];
            [ bmrMutableArray addObject:bmr.bmr ];
            [ bmrMutableArray addObject:bmr.date ];
            [ bmrMutableArray addObject:bmr.exercise_mode ];
        }
    }
    else {
        // Deal with error.
    }
    return bmrMutableArray;
}

/*
 Get gender
 */
- (NSString *)getGender:(NSString *)email_Id
{
    NSError *error;
    NSString *gender        = @"";
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_BMREntity ) {
        m_BMREntity                 = [ NSEntityDescription entityForName : @"BMR" inManagedObjectContext : _managedObjectContext ];
    }
    
    // Retrieve only this user's BMR
    NSPredicate *predicate         = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    [ m_Request setPredicate : predicate ];
    
    [ m_Request setEntity:m_BMREntity ];
    
    // Retreive the streams in descending order.
    NSSortDescriptor *sortDescriptor        = [ [ NSSortDescriptor alloc ] initWithKey:@"date"
                                                                            ascending : NO ];
    NSArray *sortDescriptors                = [ [ NSArray alloc ] initWithObjects : &sortDescriptor count : 1 ];
    
    [ m_Request setSortDescriptors : sortDescriptors ];
    [ m_Request setFetchLimit : 1 ];
    [ m_Request setEntity:m_BMREntity ];

    NSArray *bmrArray              = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( bmrArray != nil ) {
        for ( BMR *bmr in bmrArray ) {
            gender      = bmr.sex;
            break;
        }
    }
    else {
        // Deal with error.
    }
    return gender;
}

/*
 Get Exercise days details
 */
- (NSMutableArray *)getExerciseDays:(NSString *)email_Id
{
    NSError *error;
    NSMutableArray *exerciseDaysMutableArray        = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_Exercise_DaysEntity ) {
        m_Exercise_DaysEntity           = [ NSEntityDescription entityForName : @"Exercise_Days" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_Exercise_DaysEntity ];

    // Retrieve only this user's days
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    [ m_Request setPredicate : predicate ];

    
    NSArray *exerciseDaysArray          = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( exerciseDaysArray != nil ) {
        for ( Exercise_Days *exerciseDays in exerciseDaysArray ) {
            [ exerciseDaysMutableArray addObject:exerciseDays.monday ];
            [ exerciseDaysMutableArray addObject:exerciseDays.tuesday ];
            [ exerciseDaysMutableArray addObject:exerciseDays.wednesday ];
            [ exerciseDaysMutableArray addObject:exerciseDays.thursday ];
            [ exerciseDaysMutableArray addObject:exerciseDays.friday ];
            [ exerciseDaysMutableArray addObject:exerciseDays.saturday ];
            [ exerciseDaysMutableArray addObject:exerciseDays.sunday ];
        }
    }
    else {
        // Deal with error.
    }
    return exerciseDaysMutableArray;
}

/*
 Get Latest exercise days
 */
- (NSMutableArray *)getLatestExerciseDays:(NSString *)email_Id
{
    NSError *error;
    NSMutableArray *exerciseDaysMutableArray        = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_Exercise_DaysEntity ) {
        m_Exercise_DaysEntity       = [ NSEntityDescription entityForName : @"Exercise_Days" inManagedObjectContext : _managedObjectContext ];
    }
    // Retrieve only this user's days
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    [ m_Request setPredicate : predicate ];

    // Retreive the streams in descending order.
    NSSortDescriptor *sortDescriptor        = [ [ NSSortDescriptor alloc ] initWithKey:@"date"
                                                                            ascending : NO ];
    NSArray *sortDescriptors                = [ [ NSArray alloc ] initWithObjects : &sortDescriptor count : 1 ];
    
    [ m_Request setSortDescriptors : sortDescriptors ];
    [ m_Request setFetchLimit : 1 ];
    [ m_Request setEntity:m_Exercise_DaysEntity ];
    
    NSArray *exerciseDaysArray              = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( exerciseDaysArray != nil ) {
        for ( Exercise_Days *exerciseDays in exerciseDaysArray ) {
            [ exerciseDaysMutableArray addObject:exerciseDays.monday ];
            [ exerciseDaysMutableArray addObject:exerciseDays.tuesday ];
            [ exerciseDaysMutableArray addObject:exerciseDays.wednesday ];
            [ exerciseDaysMutableArray addObject:exerciseDays.thursday ];
            [ exerciseDaysMutableArray addObject:exerciseDays.friday ];
            [ exerciseDaysMutableArray addObject:exerciseDays.saturday ];
            [ exerciseDaysMutableArray addObject:exerciseDays.sunday ];
        }
    }
    else {
        // Deal with error.
    }
    return exerciseDaysMutableArray;
}

/*
 Check if the user has a selected exercise
 */
- (NSString *)hasUserSelectedDays:(NSString *)email_Id
{
    NSError *error;
    NSString *hasUserSelectedExerciseDays        = @"";
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_Exercise_DaysEntity ) {
        m_Exercise_DaysEntity       = [ NSEntityDescription entityForName : @"Exercise_Days" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_Exercise_DaysEntity ];
    
    // Retrieve only this user's days
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *exerciseDaysArray          = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( exerciseDaysArray != nil ) {
        for ( Exercise_Days *exerciseDays in exerciseDaysArray ) {
            if ([exerciseDays.email_id isEqualToString:email_Id]) {
                hasUserSelectedExerciseDays  = @"YES";
                break;
            }
        }
    }
    else {
        // Deal with error.
    }
    return hasUserSelectedExerciseDays;
}

/*
 Get Exercise level details
 */
- (NSMutableArray *)getExerciseLevel:(NSString *)email_Id
{
    NSError *error;
    NSMutableArray *exerciseLevelMutableArray        = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_Exercise_LevelsEntity ) {
        m_Exercise_LevelsEntity     = [ NSEntityDescription entityForName : @"Exercise_Levels" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_Exercise_LevelsEntity ];
    
    // Retrieve only this user's levels
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    [ m_Request setPredicate : predicate ];
    
    NSArray *exerciseDaysArray          = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( exerciseDaysArray != nil ) {
        for ( Exercise_Levels *exerciseLevels in exerciseDaysArray ) {
            [ exerciseLevelMutableArray addObject:exerciseLevels.level ];
        }
    }
    else {
        // Deal with error.
    }
    return exerciseLevelMutableArray;
}
/*
 // Get Latest Exercise level
 */
- (NSMutableArray *)getLatestExerciseLevel:(NSString *)email_Id
{
    NSError *error;
    NSMutableArray *exerciseLevelMutableArray        = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_Exercise_LevelsEntity ) {
        m_Exercise_LevelsEntity            = [ NSEntityDescription entityForName : @"Exercise_Levels" inManagedObjectContext : _managedObjectContext ];
    }
    
    // Retrieve only this user's levels
    NSPredicate *predicate         = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    [ m_Request setPredicate : predicate ];
    
    // Retreive the streams in descending order.
    NSSortDescriptor *sortDescriptor        = [ [ NSSortDescriptor alloc ] initWithKey:@"date"
                                                                            ascending : NO ];
    NSArray *sortDescriptors                = [ [ NSArray alloc ] initWithObjects : &sortDescriptor count : 1 ];
    
    [ m_Request setSortDescriptors : sortDescriptors ];
    [ m_Request setFetchLimit : 1 ];
    [ m_Request setEntity:m_Exercise_LevelsEntity ];
    
    NSArray *exerciseDaysArray          = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( exerciseDaysArray != nil ) {
        for ( Exercise_Levels *exerciseLevels in exerciseDaysArray ) {
            [ exerciseLevelMutableArray addObject:exerciseLevels.level ];
        }
    }
    else {
        // Deal with error.
    }
    return exerciseLevelMutableArray;
}

/*
 Check if the user has a selected exercise
 */
- (NSString *)hasUserSelectedLevel:(NSString *)email_Id
{
    NSError *error;
    NSString *hasUserSelectedLevel        = @"";
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_Exercise_LevelsEntity ) {
        m_Exercise_LevelsEntity            = [ NSEntityDescription entityForName : @"Exercise_Levels" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_Exercise_LevelsEntity ];
    
    // Retrieve only this user's levels
    NSPredicate *predicate         = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    [ m_Request setPredicate : predicate ];
    
    NSArray *exerciseDaysArray          = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( exerciseDaysArray != nil ) {
        for ( Exercise_Levels *exerciseLevels in exerciseDaysArray ) {
            if ([exerciseLevels.email_id isEqualToString:email_Id]) {
                hasUserSelectedLevel    = @"YES";
                break;
            }
        }
    }
    else {
        // Deal with error.
    }
    return hasUserSelectedLevel;
}

// Get Exercise goal
- (NSMutableArray *)getGoal:(NSString *)email_Id
{
    NSError *error;
    NSMutableArray *goalMutableArray        = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                       = nil;
    }
    
    if ( !m_Request ) {
        m_Request                       = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_GoalsEntity ) {
        m_GoalsEntity                   = [ NSEntityDescription entityForName : @"Goals" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_GoalsEntity ];
    
    // Retrieve only this user's goals
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    [ m_Request setPredicate : predicate ];
    
    NSArray *exerciseDaysArray          = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( exerciseDaysArray != nil ) {
        for ( Goals *goals in exerciseDaysArray ) {
            [ goalMutableArray addObject:goals.goal ];
        }
    }
    else {
        // Deal with error.
    }
    return goalMutableArray;
}

/*
 Get Latest Exercise goal
 */
- (NSString *)getLatestExerciseGoal:(NSString *)email_Id
{
    NSError *error;
    NSString *goal                  = @"";
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_GoalsEntity ) {
        m_GoalsEntity            = [ NSEntityDescription entityForName : @"Goals" inManagedObjectContext : _managedObjectContext ];
    }
    
    // Retrieve only this user's goals
    NSPredicate *predicate         = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    [ m_Request setPredicate : predicate ];
    
    // Retreive the streams in descending order.
    NSSortDescriptor *sortDescriptor        = [ [ NSSortDescriptor alloc ] initWithKey:@"date"
                                                                            ascending : NO ];
    NSArray *sortDescriptors                = [ [ NSArray alloc ] initWithObjects : &sortDescriptor count : 1 ];
    
    [ m_Request setSortDescriptors : sortDescriptors ];
    [ m_Request setFetchLimit : 1 ];
    [ m_Request setEntity:m_GoalsEntity ];
    
    NSArray *exerciseDaysArray          = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( exerciseDaysArray != nil ) {
        for ( Goals *goals in exerciseDaysArray ) {
            goal            = goals.goal;
            break;
        }
    }
    else {
        // Deal with error.
    }
    return goal;
}

/*
 Check if the user has a selected exercise
 */
- (NSString *)hasUserSelectedGoal:(NSString *)email_Id
{
    NSError *error;
    NSString *hasUserSelectedGoal       = @"";
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_GoalsEntity ) {
        m_GoalsEntity               = [ NSEntityDescription entityForName : @"Goals" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_GoalsEntity ];
    
    // Retrieve only this user's goals
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    [ m_Request setPredicate : predicate ];
    
    NSArray *goalsArray             = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( goalsArray != nil ) {
       for ( Goals *goals in goalsArray ) {
           if ([goals.email_id isEqualToString:email_Id]) {
               hasUserSelectedGoal      = @"YES";
           }
       }
    }
    else {
        // Deal with error.
    }
    return hasUserSelectedGoal;
}

/*
 Check if the user has a selected exercise level
 */
- (NSString *)hasUserSelectedExerciseLevel:(NSString *)email_Id
{
    NSError *error;
    NSString *hasUserSelectedLevel       = @"";
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_Exercise_LevelsEntity ) {
        m_Exercise_LevelsEntity         = [ NSEntityDescription entityForName : @"Exercise_Levels" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_Exercise_LevelsEntity ];
    
    // Retrieve only this user's goals
    NSPredicate *predicate               = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    [ m_Request setPredicate : predicate ];
    
    NSArray *exerciseLevelArray          = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( exerciseLevelArray != nil ) {
        for ( Exercise_Levels *exercise_levels in exerciseLevelArray ) {
            if ([exercise_levels.email_id isEqualToString:email_Id]) {
                hasUserSelectedLevel      = @"YES";
            }
        }
    }
    else {
        // Deal with error.
    }
    return hasUserSelectedLevel;
}

/*
 Get User Id
 */
- (NSString *)getEmailId:(NSString *)log
{
    // May be useful to log as argument to check for any other possibilities
    NSString *logString            = @"in";
    log                            = logString;

    NSString *email_ID             = @"";
    
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext      = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                  = nil;
    }
    
    if ( !m_Request ) {
        m_Request                  = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_UsersEntity ) {
        m_UsersEntity              = [ NSEntityDescription entityForName : @"Users" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_UsersEntity ];
    
    NSPredicate *predicate         = [ NSPredicate predicateWithFormat : @"log == %@", log ];
    
    [ m_Request setPredicate : predicate ];
    
    NSArray *userArray             = [ _managedObjectContext executeFetchRequest : m_Request error : &error ];

    if ( userArray != nil ) {
        for ( Users *user in userArray ) {
            // Get email_id
            email_ID            = user.email_id;
            break;
        }
    }
    else {
        // Deal with error.
    }
    return email_ID;
}

/*
 Get User Id
 */
- (NSString *)getPassword:(NSString *)email
{    
    NSString *password;
    
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext      = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                  = nil;
    }
    
    if ( !m_Request ) {
        m_Request                  = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_UsersEntity ) {
        m_UsersEntity              = [ NSEntityDescription entityForName : @"Users" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_UsersEntity ];
    
    NSPredicate *predicate         = [ NSPredicate predicateWithFormat : @"email_id == %@", email ];
    
    [ m_Request setPredicate : predicate ];
    
    NSArray *userArray             = [ _managedObjectContext executeFetchRequest : m_Request error : &error ];
    if ( userArray != nil ) {
        for ( Users *user in userArray ) {
            // Get email_id
            password            = user.password;
            break;
        }
    }
    else {
        // Deal with error.
    }
    return password;
}


// Get Users' Email Ids
- (NSMutableArray *)getAllEmailIds
{
    // All email ids
    NSMutableArray *emailIDsArray  = [NSMutableArray mutableArrayObject];

    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext      = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                  = nil;
    }
    
    if ( !m_Request ) {
        m_Request                  = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_UsersEntity ) {
        m_UsersEntity              = [ NSEntityDescription entityForName : @"Users" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_UsersEntity ];
        
    NSArray *userArray             = [ _managedObjectContext executeFetchRequest : m_Request error : &error ];
    if ( userArray != nil ) {
        for ( Users *user in userArray ) {
            // Get all email_ids
            [emailIDsArray addObject:user.email_id ];
        }
    }
    else {
        // Deal with error.
    }
    return emailIDsArray;
}

/*
 Count number of users
 */
- (int)countNumberOfUsers
{
    
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext      = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                  = nil;
    }
    
    if ( !m_Request ) {
        m_Request                  = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_UsersEntity ) {
        m_UsersEntity              = [ NSEntityDescription entityForName : @"Users" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_UsersEntity ];
    
   int numberOfUsers            =(uintptr_t *)[_managedObjectContext countForFetchRequest:m_Request error:&error];
    //if (numberOfUsers == NSNotFound) {
        // Error
    //}
return numberOfUsers;
}

/*
 Check Email Id from BMR details
 */
- (BOOL)checkEmailIDInBMR:(NSString *)email_Id
{
    // Default is FALSE
    BOOL isEmailIdInBMR             = FALSE;
    
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_BMREntity ) {
        m_BMREntity                 = [ NSEntityDescription entityForName : @"BMR" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_BMREntity ];
    
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSArray *bmrArray               = [ _managedObjectContext executeFetchRequest : m_Request error : &error ];
    if ( bmrArray != nil ) {
        for ( BMR *bmr in bmrArray ) {
            // Get email_id
            if ([bmr.email_id isEqualToString:email_Id]) {
                isEmailIdInBMR      = TRUE;
                break;
            }
        }
    }
    else {
        // Deal with error.
    }
    return isEmailIdInBMR;
}

/*
 Get Food Recipes
 */
- (NSMutableArray *)getFoodRecipes
{
    NSError *error;
    NSMutableArray *foodRecipesMutableArray        = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                       = nil;
    }
    
    if ( !m_Request ) {
        m_Request                       = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_food_RecipesEntity ) {
        m_food_RecipesEntity            = [ NSEntityDescription entityForName : @"Food_Recipes" inManagedObjectContext : _managedObjectContext ];
    }
            
    [ m_Request setFetchLimit : 1 ];
    [ m_Request setEntity:m_food_RecipesEntity ];
    
    NSArray *foodRecipesArray           = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( foodRecipesArray != nil ) {
            for ( Food_Recipes *foodRecipes in foodRecipesArray ) {
                if ((foodRecipes.title.length != 0)) {
                    [ foodRecipesMutableArray addObject:foodRecipes.title ];
                }
                if (foodRecipes.image.length != 0) {
                    [ foodRecipesMutableArray addObject:foodRecipes.image ];
                }
                if (foodRecipes.ingredients.length != 0) {
                    [ foodRecipesMutableArray addObject:foodRecipes.ingredients ];
                }
                if (foodRecipes.directions.length != 0) {
                    [ foodRecipesMutableArray addObject:foodRecipes.directions ];
                }
                break;
            }
    }
    else {
        // Deal with error.
    }
    return foodRecipesMutableArray;
}

/*
 Get Exercise Report
 */
- (NSMutableArray *)getExerciseReport:(NSString *)email_Id
{
    NSError *error;
    NSMutableArray *exerciseReportMutableArray        = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_exercise_ReportEntity ) {
        m_exercise_ReportEntity            = [ NSEntityDescription entityForName : @"Exercise_Report" inManagedObjectContext : _managedObjectContext ];
    }
    
    [ m_Request setEntity:m_exercise_ReportEntity ];
    
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    
    [ m_Request setPredicate : predicate ];

    NSArray *exerciseReportArray          = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( exerciseReportArray != nil ) {
        for ( Exercise_Report *exerciseReport in exerciseReportArray ) {
            [ exerciseReportMutableArray addObject:exerciseReport.email_id ];
            [ exerciseReportMutableArray addObject:exerciseReport.date ];
            [ exerciseReportMutableArray addObject:exerciseReport.set_one_weight ];
            [ exerciseReportMutableArray addObject:exerciseReport.set_one_rep ];
            [ exerciseReportMutableArray addObject:exerciseReport.set_two_weight ];
            [ exerciseReportMutableArray addObject:exerciseReport.set_two_rep ];
            [ exerciseReportMutableArray addObject:exerciseReport.set_three_weight ];
            [ exerciseReportMutableArray addObject:exerciseReport.set_three_rep ];
            [ exerciseReportMutableArray addObject:exerciseReport.set_four_weight ];
            [ exerciseReportMutableArray addObject:exerciseReport.set_four_rep ];
            [ exerciseReportMutableArray addObject:exerciseReport.set_five_weight ];
            [ exerciseReportMutableArray addObject:exerciseReport.set_five_rep ];

        }
    }
    else {
        // Deal with error.
    }
    return exerciseReportMutableArray;
}

// Get A Week's Average Exercise Report for a particular exercise
- (NSMutableArray *)getAverageExerciseReport:(NSString *)exercise ForAWeek:(NSString *)email_Id StartDate:(NSDate *)startDate EndDate:(NSDate *)endDate;
{
    NSError *error;
    NSMutableArray *exerciseReportMutableArray        = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_exercise_ReportEntity ) {
        m_exercise_ReportEntity             = [ NSEntityDescription entityForName : @"Exercise_Report" inManagedObjectContext : _managedObjectContext ];
    }
    
    [ m_Request setEntity:m_exercise_ReportEntity ];
    
    NSMutableArray *predicates              = nil;
    if (!predicates) {
     predicates                             = [NSMutableArray mutableArrayObject];   
    }

    // find all the entries with email_id
    [predicates addObject:[ NSPredicate predicateWithFormat : @"(email_id == %@) AND (exercise == %@)", email_Id, exercise ]];
    
    // find all entries of the email id between the below dates
    [predicates addObject:[ NSPredicate predicateWithFormat : @"(date <= %@) AND (date > %@)", startDate, endDate ]];
    
    // build the compound predicate
    NSPredicate *predicate                  = nil;
    if (!predicate) {
        predicate                           = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];        
    }

    [m_Request setPredicate:predicate];

    NSArray *exerciseReportArray            = nil;
    if (!exerciseReportArray) {
        exerciseReportArray                 = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    }
    
    if ( exerciseReportArray != nil ) {
        for ( Exercise_Report *exerciseReport in exerciseReportArray ) {
            // Retreive weight or time records (if weight is present then time cannot be present)
            if ((exerciseReport.set_one_weight != NULL) && (exerciseReport.set_one_weight != NULL) && (exerciseReport.set_one_weight != [NSNumber numberWithInt:0]) ) {
                [ exerciseReportMutableArray addObject:exerciseReport.set_one_weight ];
            }
            else if ((exerciseReport.set_one_time != NULL) && (exerciseReport.set_one_time != NULL) && (exerciseReport.set_one_time != [NSNumber numberWithInt:0]) ) {
                [ exerciseReportMutableArray addObject:exerciseReport.set_one_time ];
            }
            
            if (exerciseReport.set_one_rep != [NSNumber numberWithInt:0]) {
                if (exerciseReport.set_one_rep != NULL) {
                    [ exerciseReportMutableArray addObject:exerciseReport.set_one_rep ];
                }
            }

            if ((exerciseReport.set_two_weight != NULL) && (exerciseReport.set_two_weight != NULL) && (exerciseReport.set_two_weight != [NSNumber numberWithInt:0])) {
                [ exerciseReportMutableArray addObject:exerciseReport.set_two_weight ];
            }
            else if((exerciseReport.set_two_time != NULL) && (exerciseReport.set_two_time != NULL) && (exerciseReport.set_two_time != [NSNumber numberWithInt:0])) {
                [ exerciseReportMutableArray addObject:exerciseReport.set_two_time ];
            }
            
            if (exerciseReport.set_two_rep != [NSNumber numberWithInt:0]) {
                if (exerciseReport.set_two_rep != NULL) {
                    [ exerciseReportMutableArray addObject:exerciseReport.set_two_rep ];
                }
            }
            
            if ((exerciseReport.set_three_weight != NULL) && (exerciseReport.set_three_weight != NULL) && (exerciseReport.set_three_weight != [NSNumber numberWithInt:0])) {
                [ exerciseReportMutableArray addObject:exerciseReport.set_three_weight ];
            }
            else if((exerciseReport.set_three_time != NULL) && (exerciseReport.set_three_time != NULL) && (exerciseReport.set_three_time != [NSNumber numberWithInt:0])) {
                [ exerciseReportMutableArray addObject:exerciseReport.set_three_time ];
            }
            
            if (exerciseReport.set_three_rep != [NSNumber numberWithInt:0]) {
                if (exerciseReport.set_three_rep != NULL) {
                    [ exerciseReportMutableArray addObject:exerciseReport.set_three_rep ];
                }
            }

            if ((exerciseReport.set_four_weight != NULL) && (exerciseReport.set_four_weight != NULL) && (exerciseReport.set_four_weight != [NSNumber numberWithInt:0])) {
                [ exerciseReportMutableArray addObject:exerciseReport.set_four_weight ];
            }
            else if ((exerciseReport.set_four_time != NULL) && (exerciseReport.set_four_time != NULL) && (exerciseReport.set_four_time != [NSNumber numberWithInt:0])) {
                [ exerciseReportMutableArray addObject:exerciseReport.set_four_time ];
            }
            
            if (exerciseReport.set_four_rep != [NSNumber numberWithInt:0]) {
                if (exerciseReport.set_four_rep != NULL) {
                    [ exerciseReportMutableArray addObject:exerciseReport.set_four_rep ];
                }
            }
            
            if ((exerciseReport.set_five_weight != NULL) && (exerciseReport.set_five_weight != NULL) && (exerciseReport.set_five_weight != [NSNumber numberWithInt:0])) {
                [ exerciseReportMutableArray addObject:exerciseReport.set_five_weight ];
            }
            else if ((exerciseReport.set_five_time != NULL) && (exerciseReport.set_five_time != NULL) && (exerciseReport.set_five_time != [NSNumber numberWithInt:0])) {
                [ exerciseReportMutableArray addObject:exerciseReport.set_five_time ];
            }
            
            if (exerciseReport.set_five_rep != [NSNumber numberWithInt:0]) {
                if (exerciseReport.set_five_rep != NULL) {
                    [ exerciseReportMutableArray addObject:exerciseReport.set_five_rep ];
                }
            }
        }
    }
    else {
        // Deal with error.
    }
    return exerciseReportMutableArray;
}

// Get A Week's overall Average Exercise Report
- (NSMutableArray *)getAverageExerciseReportForAWeek:(NSString *)email_Id StartDate:(NSDate *)startDate EndDate:(NSDate *)endDate;
{
    NSError *error;
    NSMutableArray *exerciseReportMutableArray        = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_exercise_ReportEntity ) {
        m_exercise_ReportEntity             = [ NSEntityDescription entityForName : @"Exercise_Report" inManagedObjectContext : _managedObjectContext ];
    }
    
    [ m_Request setEntity:m_exercise_ReportEntity ];
    
    NSMutableArray *predicates              = nil;
    if (!predicates) {
        predicates                          = [NSMutableArray mutableArrayObject];
    }
    
    // find all the entries with email_id
    [predicates addObject:[ NSPredicate predicateWithFormat : @"(email_id == %@)", email_Id ]];
    
    // find all entries of the email id between the below dates
    [predicates addObject:[ NSPredicate predicateWithFormat : @"(date <= %@) AND (date > %@)", startDate, endDate ]];
    
    // build the compound predicate
    NSPredicate *predicate                  = nil;
    if (!predicate) {
        predicate                           = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    }
    
    [m_Request setPredicate:predicate];
    
    NSArray *exerciseReportArray            = nil;
    if (!exerciseReportArray) {
        exerciseReportArray                 = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    }
    
    if ( exerciseReportArray != nil ) {
        for ( Exercise_Report *exerciseReport in exerciseReportArray ) {
            if (exerciseReport.set_one_weight != NULL && (exerciseReport.set_one_weight != [NSNumber numberWithInt:0])) {
                [ exerciseReportMutableArray addObject:exerciseReport.set_one_weight ];
            }
        }        
    }
    else {
        // Deal with error.
    }
    return exerciseReportMutableArray;
}


/*
 Log in User
 */
- (void)logInUser:(NSString *)email_Id
{
    
    NSString *logString            =  @"out";
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext      = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                  = nil;
    }
    
    if ( !m_Request ) {
        m_Request                  = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_UsersEntity ) {
        m_UsersEntity              = [ NSEntityDescription entityForName : @"Users" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_UsersEntity ];
    
    NSPredicate *predicate         = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSArray *userArray             = [ _managedObjectContext executeFetchRequest : m_Request error : &error ];
    if ( userArray != nil ) {
        // Users should be logged in
        logString   = @"in";
        for ( Users *user in userArray ) {
            // Update the log status to "in"
            user.log       = logString;
            [ self.managedObjectContext save : nil ];
            break;
        }
    }
    else {
        // Deal with error.
    }
    
}

/*
 Log out User
 */
- (void)logOutUser:(NSString *)email_Id
{
    
    NSString *logString            =   @"in";
    NSError *error;
    
    // Clean up the managed object context first
    _managedObjectContext          = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext      = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                  = nil;
    }
    
    if ( !m_Request ) {
        m_Request                  = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_UsersEntity ) {
        m_UsersEntity              = [ NSEntityDescription entityForName : @"Users" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_UsersEntity ];
    
    NSPredicate *predicate         = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSArray *userArray             = [ _managedObjectContext executeFetchRequest : m_Request error : &error ];
    if ( userArray != nil ) {
        // Users should be logged out
        logString           = @"out";
        for ( Users *user in userArray ) {
            // Update the log status to "out"
            if ((logString != NULL) && (logString.length != 0)) {
                user.log        = logString;
            }
            [ self.managedObjectContext save : nil ];
        }
    }
    else {
        // Deal with error.
    }

}

// Log out other User
- (void)logOutOtherUsers:(NSString *)email_Id
{
    NSString *logString            =  @"in";
    NSError *error;
    
    // Clean ip the managed object context first
    _managedObjectContext          = nil;

    if ( !_managedObjectContext ) {
        _managedObjectContext      = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                  = nil;
    }
    
    if ( !m_Request ) {
        m_Request                  = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_UsersEntity ) {
        m_UsersEntity              = [ NSEntityDescription entityForName : @"Users" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_UsersEntity ];
        
    NSArray *userArray             = [ _managedObjectContext executeFetchRequest : m_Request error : &error ];
    if ( userArray != nil ) {
        // Users should be logged out
        logString   = @"out";
        for ( Users *user in userArray ) {
            if ((logString != NULL) && (logString.length != 0)) {
                if ([user.email_id isEqualToString:email_Id]) {
                    // If this is current user do not log out, do nothing
                }
                else {
                    // Update the log status to "out"
                    user.log       = logString;
                }
            
            }
            // save the managedObjectContext to save the update
            [ self.managedObjectContext save : nil ];
        }
    }
    else {
        // Deal with error.
    }

}


/*
 Check user login status
 */
- (NSString *)checkUserLogInStatus:(NSString *)email_Id
{
    NSString *logString;
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                       = nil;
    }
    
    if ( !m_Request ) {
        m_Request                       = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_UsersEntity ) {
        m_UsersEntity                   = [ NSEntityDescription entityForName : @"Users" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_UsersEntity ];

    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    
    [ m_Request setPredicate : predicate ];

    NSArray *usersArray                 = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( usersArray != nil ) {
        for ( Users *user in usersArray ) {
            logString       =   user.log;   
        }
    }
    else {
        // Deal with error.
    }
    return logString;
}

/*
 Check login status any user
 */
- (NSString *)checkUserLogInStatus
{
    NSString *logString     = @"out";
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_UsersEntity ) {
        m_UsersEntity               = [ NSEntityDescription entityForName : @"Users" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_UsersEntity ];
    
    NSArray *usersArray             = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( usersArray != nil ) {
        for ( Users *user in usersArray ) {
            if ([user.log isEqualToString:@"in"]) {
                logString       =   user.log;
                // break, because there cannot be more than one logged in user
                break;
            }
        }
    }
    else {
        // Deal with error.
    }
    return logString;
}

/*
 Is user man or woman?
 */
- (NSString  *)sexOfUser:(NSString *)email_Id
{
    NSString *sex;
    
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext      = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                  = nil;
    }
    
    if ( !m_Request ) {
        m_Request                  = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_BMREntity ) {
        m_BMREntity                = [ NSEntityDescription entityForName : @"BMR" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_BMREntity ];
    
    NSPredicate *predicate         = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    
    [ m_Request setPredicate : predicate ];
    
    // Retreive the streams in descending order.
    NSSortDescriptor *sortDescriptor        = [ [ NSSortDescriptor alloc ] initWithKey:@"date"
                                                                            ascending : NO ];
    NSArray *sortDescriptors                = [ [ NSArray alloc ] initWithObjects : &sortDescriptor count : 1 ];
    
    [ m_Request setSortDescriptors : sortDescriptors ];
    [ m_Request setFetchLimit : 1 ];
    [ m_Request setEntity:m_BMREntity ];

    NSArray *bmrArray             = [ _managedObjectContext executeFetchRequest : m_Request error : &error ];
    if ( bmrArray != nil ) {
        for ( BMR *bmr in bmrArray ) {
            // Get email_id
            sex            = bmr.sex;
            break;
        }
    }
    else {
        // Deal with error.
    }
    return sex;
}

/*
 Delete the empty user created by facebook login
 */
- (void)deleteDummyUsers
{
    NSString *emptyString     = @"";
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_UsersEntity ) {
        m_UsersEntity                       = [ NSEntityDescription entityForName : @"Users" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_UsersEntity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", emptyString ];
    
    [ m_Request setPredicate : predicate ];

    NSArray *usersArray                     = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    // Object to delete
    NSManagedObject *objectIDToDelete;
    
    if ( usersArray != nil ) {
        // The last object position in the arrray is used to compare for the do-while loop.
        NSInteger positionofLastObject            = [ usersArray indexOfObject : [ usersArray lastObject ] ];
        // The current object position in the arrray is used to compare for the do-while loop.
        NSInteger currentObjectPosition           = 0;
        do {
            for ( Users *user in usersArray ) { // Loop through each object in a row of the "Users" table
                currentObjectPosition                   = [ usersArray indexOfObject:user.email_id ];
                
                // Delete "user" object which has empty entries in it
                objectIDToDelete                        = [_managedObjectContext objectWithID:user.objectID];
                [_managedObjectContext deleteObject:objectIDToDelete];
                // Must save the managedobjectcontext to delete
                [_managedObjectContext save:nil];
                
                // break, because there cannot be more than one logged in user
                break;
            }
        }while ( positionofLastObject == currentObjectPosition );
    }
    else {
        // Deal with error.
    }
}

/*
 Delete the empty user created by facebook login
 */
- (void)deleteFoodRecipes
{
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_food_RecipesEntity ) {
        m_food_RecipesEntity                       = [ NSEntityDescription entityForName : @"Food_Recipes" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_food_RecipesEntity ];
    
    NSArray *foodRecipesArray                     = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    // Object to delete
    NSManagedObject *objectIDToDelete;
    
    if ( foodRecipesArray != nil ) {
        for ( Food_Recipes *foodRecipes in foodRecipesArray ) { // Loop through each object in a row of the "Users" table
            
            // Delete "foodRecipes" object which has empty entries in it
            objectIDToDelete                        = [_managedObjectContext objectWithID:foodRecipes.objectID];
            [_managedObjectContext deleteObject:objectIDToDelete];
            // Must save the managedobjectcontext to delete
            [_managedObjectContext save:nil];
            
            // break, because there cannot be more than one logged in user
            break;
        }
    }
    else {
        // Deal with error.
    }
}

/*
 Get grocery list
 */
- (NSMutableArray *)getGroceryList:(NSString *)email_Id
{
    // grocery list
    NSMutableArray *groceryList    = [NSMutableArray mutableArrayObject];
    
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext      = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                  = nil;
    }
    
    if ( !m_Request ) {
        m_Request                  = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_GroceryEntity ) {
        m_GroceryEntity            = [ NSEntityDescription entityForName : @"Grocery" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_GroceryEntity ];
    
    NSPredicate *predicate         = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSArray *groceryListArray      = [ _managedObjectContext executeFetchRequest : m_Request error : &error ];
    if ( groceryListArray != nil ) {
        for ( Grocery *grocery in groceryListArray ) {
            // add foods to the list
            [groceryList addObject:grocery.food ];
        }
    }
    else {
        // Deal with error.
    }
    return groceryList;
}

/*
 Check if food is already in the list
 */
- (BOOL)checkFood:(NSString *)food AlreadyIntheList:(NSString *)email_Id
{
    // Default is FALSE
    BOOL checkFoodAlreadyintheList  = FALSE;
    
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_GroceryEntity ) {
        m_GroceryEntity             = [ NSEntityDescription entityForName : @"Grocery" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_GroceryEntity ];
    
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_Id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSArray *groceryArray           = [ _managedObjectContext executeFetchRequest : m_Request error : &error ];
    if ( groceryArray != nil ) {
        for ( Grocery *grocery in groceryArray ) {
            // check food in the list
            if ([grocery.food isEqualToString:food]) {
                checkFoodAlreadyintheList      = TRUE;
                break;
            }
        }
    }
    else {
        // Deal with error.
    }
    return checkFoodAlreadyintheList;
}

/*
 Get Terms And Conditions
 */
- (NSString *)checkIfTermsAndConditionsAccepted
{
    NSError *error;
    NSString *status        = @"No";
    
    if ( !_managedObjectContext ) {
        _managedObjectContext       = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_terms_And_Conditions_Entity ) {
        m_terms_And_Conditions_Entity                 = [ NSEntityDescription entityForName : @"Terms_And_Conditions" inManagedObjectContext : _managedObjectContext ];
    }
    
    // Retrieve only this user's BMR
    [ m_Request setEntity:m_terms_And_Conditions_Entity ];
    
    NSArray *termsAndConditionsArray              = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( termsAndConditionsArray != nil ) {
        for ( Terms_And_Conditions *terms_And_Conditions in termsAndConditionsArray ) {
            status                  = terms_And_Conditions.accepted;
            break;
        }
    }
    else {
        // Deal with error.
    }
    return status;
}

// get breakfast
- (NSMutableArray *)getBreakfastforUser:(NSString *)email_id
{
    NSError *error;
    NSMutableArray *breakfastMutableArray = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_breakfast_Entity ) {
        m_breakfast_Entity                  = [ NSEntityDescription entityForName : @"Breakfast" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_breakfast_Entity ];
    
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];

    
    NSArray *breakfastArray        = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( breakfastArray != nil ) {
        for ( Breakfast *breakfast in breakfastArray ) {
            [ breakfastMutableArray addObject:breakfast.food ];
            [ breakfastMutableArray addObject:breakfast.quantity ];
        }
    }
    else {
        // Deal with error.
    }
    return breakfastMutableArray;

}

// get breakfast
- (void)deleteBreakfastforUser:(NSString *)email_id
{
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_breakfast_Entity ) {
        m_breakfast_Entity                  = [ NSEntityDescription entityForName : @"Breakfast" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_breakfast_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *breakfastArray                 = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( breakfastArray != nil ) {
        for ( Breakfast *breakfast in breakfastArray ) {
            [_managedObjectContext deleteObject:breakfast];
        }
        NSError *saveError = nil;
        [_managedObjectContext save:&saveError];
    }
    else {
        // Deal with error.
    }
}

// get first snack
- (NSMutableArray *)getFirstSnackforUser:(NSString *)email_id
{
    NSError *error;
    NSMutableArray *firstSnackMutableArray = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_first_Snack_Entity ) {
        m_first_Snack_Entity                = [ NSEntityDescription entityForName : @"First_Snack" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_first_Snack_Entity ];
    
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *firstSnackArray        = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( firstSnackArray != nil ) {
        for ( First_Snack *first_Snack in firstSnackArray ) {
            [ firstSnackMutableArray addObject:first_Snack.food ];
            [ firstSnackMutableArray addObject:first_Snack.quantity ];
        }
    }
    else {
        // Deal with error.
    }
    return firstSnackMutableArray;
}

// get breakfast
- (void)deleteFirstSnackforUser:(NSString *)email_id
{
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_first_Snack_Entity ) {
        m_first_Snack_Entity                = [ NSEntityDescription entityForName : @"First_Snack" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_first_Snack_Entity ];
    
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *firstSnackArray        = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( firstSnackArray != nil ) {
        for ( First_Snack *first_Snack in firstSnackArray ) {
            [_managedObjectContext deleteObject:first_Snack];
        }
        NSError *saveError = nil;
        [_managedObjectContext save:&saveError];
    }
    else {
        // Deal with error.
    }
}

// get lunch
- (NSMutableArray *)getLunchforUser:(NSString *)email_id
{
    NSError *error;
    NSMutableArray *lunchMutableArray = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_lunch_Entity ) {
        m_lunch_Entity                      = [ NSEntityDescription entityForName : @"Lunch" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_lunch_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *lunchArray                     = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( lunchArray != nil ) {
        for ( Lunch *lunch in lunchArray ) {
            [ lunchMutableArray addObject:lunch.food ];
            [ lunchMutableArray addObject:lunch.quantity ];
        }
    }
    else {
        // Deal with error.
    }
    return lunchMutableArray;

}

// delete lunch
- (void)deleteLunchforUser:(NSString *)email_id
{
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_lunch_Entity ) {
        m_lunch_Entity                      = [ NSEntityDescription entityForName : @"Lunch" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_lunch_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *lunchArray                     = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( lunchArray != nil ) {
        for ( Lunch *lunch in lunchArray ) {
            [_managedObjectContext deleteObject:lunch];
        }
        NSError *saveError = nil;
        [_managedObjectContext save:&saveError];
    }
    else {
        // Deal with error.
    }
}

// get second snack
- (NSMutableArray *)getSecondSnackforUser:(NSString *)email_id
{
    NSError *error;
    NSMutableArray *secondSnackMutableArray = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_second_Snack_Entity ) {
        m_second_Snack_Entity               = [ NSEntityDescription entityForName : @"Second_Snack" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_second_Snack_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *secondSnackArray                = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( secondSnackArray != nil ) {
        for ( Second_Snack *second_Snack in secondSnackArray ) {
            [ secondSnackMutableArray addObject:second_Snack.food ];
            [ secondSnackMutableArray addObject:second_Snack.quantity ];
        }
    }
    else {
        // Deal with error.
    }
    return secondSnackMutableArray;
}

// delete second snack
- (void)deleteSecondSnackforUser:(NSString *)email_id
{
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_second_Snack_Entity ) {
        m_second_Snack_Entity               = [ NSEntityDescription entityForName : @"Second_Snack" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_second_Snack_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *secondSnackArray                = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( secondSnackArray != nil ) {
        for ( Second_Snack *second_Snack in secondSnackArray ) {
            [_managedObjectContext deleteObject:second_Snack];
        }
        NSError *saveError = nil;
        [_managedObjectContext save:&saveError];
    }
    else {
        // Deal with error.
    }
}

// get dinner
- (NSMutableArray *)getDinnerforUser:(NSString *)email_id
{
    NSError *error;
    NSMutableArray *dinnerMutableArray      = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_dinner_Entity ) {
        m_dinner_Entity                     = [ NSEntityDescription entityForName : @"Dinner" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_dinner_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *dinnerArray                     = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( dinnerArray != nil ) {
        for ( Dinner *dinner in dinnerArray ) {
            [ dinnerMutableArray addObject:dinner.food ];
            [ dinnerMutableArray addObject:dinner.quantity ];
        }
    }
    else {
        // Deal with error.
    }
    return dinnerMutableArray;
}

// get dinner
- (void)deleteDinnerforUser:(NSString *)email_id
{
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_dinner_Entity ) {
        m_dinner_Entity                     = [ NSEntityDescription entityForName : @"Dinner" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_dinner_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *dinnerArray                     = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( dinnerArray != nil ) {
        for ( Dinner *dinner in dinnerArray ) {
            [_managedObjectContext deleteObject:dinner];
        }
        NSError *saveError = nil;
        [_managedObjectContext save:&saveError];
    }
    else {
        // Deal with error.
    }
}

// get third snack
- (NSMutableArray *)getThirdSnackforUser:(NSString *)email_id
{
    NSError *error;
    NSMutableArray *thirdSnackMutableArray = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_third_Snack_Entity ) {
        m_third_Snack_Entity               = [ NSEntityDescription entityForName : @"Third_Snack" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_third_Snack_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *thirdSnackArray                = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( thirdSnackArray != nil ) {
        for ( Third_Snack *third_Snack in thirdSnackArray ) {
            [ thirdSnackMutableArray addObject:third_Snack.food ];
            [ thirdSnackMutableArray addObject:third_Snack.quantity ];
        }
    }
    else {
        // Deal with error.
    }
    return thirdSnackMutableArray;
}

// get third snack
- (void)deleteThirdSnackforUser:(NSString *)email_id
{
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_third_Snack_Entity ) {
        m_third_Snack_Entity               = [ NSEntityDescription entityForName : @"Third_Snack" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_third_Snack_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *thirdSnackArray                = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( thirdSnackArray != nil ) {
        for ( Third_Snack *third_Snack in thirdSnackArray ) {
            [_managedObjectContext deleteObject:third_Snack];
        }
        NSError *saveError = nil;
        [_managedObjectContext save:&saveError];
    }
    else {
        // Deal with error.
    }
}

// insert into workout first day
- (NSString *)insertIntoFirstDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_id
{
    NSString *status;
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    // Clean up the m_Workout_Day_One first
    m_workout_day_one                   = nil;
    if ( !m_workout_day_one ) {
        m_workout_day_one               = [ NSEntityDescription insertNewObjectForEntityForName : @"Workout_Day_One" inManagedObjectContext : _managedObjectContext ];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_workout_day_one.email_id            = email_id;
    }
    // Give out message if null
    
    if ((exercise != NULL) && (exercise.length != 0) && (details != NULL) && (details.length != 0)) {
        m_workout_day_one.exercise            = exercise;
        m_workout_day_one.details             = details;
    }
    
    NSError *error;
    
    if ( ![ _managedObjectContext save:&error] ) {
        NSLog(@"Error on insert into Workout_Day_One table");
    }
    else {
        status                           = @"inserted";
    }
    return status;

}

/*
 update into First Day Work Out
 */
- (NSString *)updateFirstDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_id
{
    NSString *status;
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( !m_workout_Day_One_Entity ) {
        m_workout_Day_One_Entity        = [ NSEntityDescription entityForName : @"Workout_Day_One" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_One_Entity ];
    
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSError *error;
    
    NSArray *workout_Day_One_Array      = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    // Object to delete
    NSManagedObject *objectIDToDelete;
    
    for ( Workout_Day_One *workout_Day_One in workout_Day_One_Array ) { // Loop through each object in a row of the "Users" table
        // Delete "exercise" object which is to be replaced
        if ([workout_Day_One.exercise isEqualToString:exercise]) {
            objectIDToDelete            = [_managedObjectContext objectWithID:workout_Day_One.objectID];
            [_managedObjectContext deleteObject:objectIDToDelete];
            // Must save the managedobjectcontext to delete
            [ self.managedObjectContext save : nil ];
            status                      = @"deleted";
            break;
        }
        else {
            // Deal with error.
        }
    }
    return status;
}

// insert into workout second day
- (NSString *)insertIntoSecondDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_id
{
    NSString *status;
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    // Clean up the m_Work_Out_Plan first
    m_workout_day_two                   = nil;
    if ( !m_workout_day_two ) {
        m_workout_day_two               = [ NSEntityDescription insertNewObjectForEntityForName : @"Workout_Day_Two" inManagedObjectContext : _managedObjectContext ];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_workout_day_two.email_id            = email_id;
    }
    // Give out message if null
    
    if ((exercise != NULL) && (exercise.length != 0) && (details != NULL) && (details.length != 0)) {
        m_workout_day_two.exercise            = exercise;
        m_workout_day_two.details             = details;
    }
    
    NSError *error;
    
    if ( ![ _managedObjectContext save:&error] ) {
        NSLog(@"Error on insert into Workout_Day_Two table");
    }
    else {
        status                           = @"inserted";
    }
    return status;
}

/*
 update into Second Day Work Out
 */
- (NSString *)updateSecondDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_id
{
    NSString *status;
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }

    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( !m_workout_Day_Two_Entity ) {
        m_workout_Day_Two_Entity        = [ NSEntityDescription entityForName : @"Workout_Day_Two" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_Two_Entity ];
    
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSError *error;
    
    NSArray *workout_Day_Two_Array      = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];

    // Object to delete
    NSManagedObject *objectIDToDelete;
    
    for ( Workout_Day_Two *workout_Day_Two in workout_Day_Two_Array ) { // Loop through each object in a row of the "Users" table
        // Delete "exercise" object which is to be replaced
        if ([workout_Day_Two.exercise isEqualToString:exercise]) {
            objectIDToDelete            = [_managedObjectContext objectWithID:workout_Day_Two.objectID];
            [_managedObjectContext deleteObject:objectIDToDelete];
            // Must save the managedobjectcontext to delete
            [ self.managedObjectContext save : nil ];
            status                      = @"deleted";
            break;
        }
        else {
            // Deal with error.
        }
    }
    return status;
}

// insert into workout third day
- (NSString *)insertIntoThirdDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_id
{
    NSString *status;
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    // Clean up the m_workout_day_three first
    m_workout_day_three                 = nil;
    if ( !m_workout_day_three ) {
        m_workout_day_three             = [ NSEntityDescription insertNewObjectForEntityForName : @"Workout_Day_Three" inManagedObjectContext : _managedObjectContext ];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_workout_day_three.email_id            = email_id;
    }
    
    if ((exercise != NULL) && (exercise.length != 0) && (details != NULL) && (details.length != 0)) {
        m_workout_day_three.exercise            = exercise;
        m_workout_day_three.details             = details;
    }
   
    NSError *error;
    
    // Give out message if null

    if ( ![ _managedObjectContext save:&error] ) {
        NSLog(@"Error on insert into Workout_Day_Three table");
    }
    else {
        status                           = @"inserted";
    }
    return status;
}

/*
 update into Third Day Work Out
 */
- (NSString *)updateThirdDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_id
{
    NSString *status;
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( !m_workout_Day_Three_Entity ) {
        m_workout_Day_Three_Entity        = [ NSEntityDescription entityForName : @"Workout_Day_Three" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_Three_Entity ];
    
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSError *error;
    
    NSArray *workout_Day_Three_Array      = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    // Object to delete
    NSManagedObject *objectIDToDelete;
    
    for ( Workout_Day_Three *workout_Day_Three in workout_Day_Three_Array ) { // Loop through each object in a row of the "Users" table
        // Delete "exercise" object which is to be replaced
        if ([workout_Day_Three.exercise isEqualToString:exercise]) {
            objectIDToDelete            = [_managedObjectContext objectWithID:workout_Day_Three.objectID];
            [_managedObjectContext deleteObject:objectIDToDelete];
            // Must save the managedobjectcontext to delete
            [ self.managedObjectContext save : nil ];
            status                      = @"deleted";
            break;
        }
        else {
            // Deal with error.
        }
    }
    return status;
}

// insert into workout fourth day
- (NSString *)insertIntoFourthDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_id
{
    NSString *status;
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    // Clean up the m_workout_day_four first
    m_workout_day_four                  = nil;
    if ( !m_workout_day_four ) {
        m_workout_day_four              = [ NSEntityDescription insertNewObjectForEntityForName : @"Workout_Day_Four" inManagedObjectContext : _managedObjectContext ];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_workout_day_four.email_id            = email_id;
    }
    // Give out message if null
    
    if ((exercise != NULL) && (exercise.length != 0) && (details != NULL) && (details.length != 0)) {
        m_workout_day_four.exercise            = exercise;
        m_workout_day_four.details             = details;
    }
    
    NSError *error;
    
    if ( ![ _managedObjectContext save:&error] ) {
        NSLog(@"Error on insert into Workout_Day_Four table");
    }
    else {
        status                           = @"inserted";
    }
    return status;

}

/*
 update into Fourth Day Work Out
 */
- (NSString *)updateFourthDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_id
{
    NSString *status;
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( !m_workout_Day_Four_Entity ) {
        m_workout_Day_Four_Entity       = [ NSEntityDescription entityForName : @"Workout_Day_Four" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_Four_Entity ];
    
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSError *error;
    
    NSArray *workout_Day_Four_Array     = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    // Object to delete
    NSManagedObject *objectIDToDelete;
    
    for ( Workout_Day_Four *workout_Day_Four in workout_Day_Four_Array ) { // Loop through each object in a row of the "Users" table
        // Delete "exercise" object which is to be replaced
        if ([workout_Day_Four.exercise isEqualToString:exercise]) {
            objectIDToDelete            = [_managedObjectContext objectWithID:workout_Day_Four.objectID];
            [_managedObjectContext deleteObject:objectIDToDelete];
            // Must save the managedobjectcontext to delete
            [ self.managedObjectContext save : nil ];
            status                      = @"deleted";
            break;
        }
        else {
            // Deal with error.
        }
    }
    return status;
}

// insert into workout fifth day
- (NSString *)insertIntoFifthDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_id
{
    NSString *status;
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    // Clean up the m_workout_day_five first
    m_workout_day_five                  = nil;
    if ( !m_workout_day_five ) {
        m_workout_day_five              = [ NSEntityDescription insertNewObjectForEntityForName : @"Workout_Day_Five" inManagedObjectContext : _managedObjectContext ];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_workout_day_five.email_id            = email_id;
    }
    // Give out message if null
    
    if ((exercise != NULL) && (exercise.length != 0) && (details != NULL) && (details.length != 0)) {
        m_workout_day_five.exercise            = exercise;
        m_workout_day_five.details             = details;
    }
    
    NSError *error;
    
    if ( ![ _managedObjectContext save:&error] ) {
        NSLog(@"Error on insert into Workout_Day_Five table");
    }
    else {
        status                           = @"inserted";
    }
    return status;
}

/*
 update into Fifth Day Work Out
 */
- (NSString *)updateFifthDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_id
{
    NSString *status;
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( !m_workout_Day_Five_Entity ) {
        m_workout_Day_Five_Entity       = [ NSEntityDescription entityForName : @"Workout_Day_Five" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_Five_Entity ];
    
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSError *error;
    
    NSArray *workout_Day_Five_Array     = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    // Object to delete
    NSManagedObject *objectIDToDelete;
    
    for ( Workout_Day_Five *workout_Day_Five in workout_Day_Five_Array ) { // Loop through each object in a row of the "Users" table
        // Delete "exercise" object which is to be replaced
        if ([workout_Day_Five.exercise isEqualToString:exercise]) {
            objectIDToDelete            = [_managedObjectContext objectWithID:workout_Day_Five.objectID];
            [_managedObjectContext deleteObject:objectIDToDelete];
            // Must save the managedobjectcontext to delete
            [ self.managedObjectContext save : nil ];
            status                      = @"deleted";
            break;
        }
        else {
            // Deal with error.
        }
    }
    return status;
}

// insert into workout sixth day
- (NSString *)insertIntoSixthDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_id
{
    NSString *status;
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    // Clean up the m_workout_day_six first
    m_workout_day_six                   = nil;
    if ( !m_workout_day_six ) {
        m_workout_day_six               = [ NSEntityDescription insertNewObjectForEntityForName : @"Workout_Day_Six" inManagedObjectContext : _managedObjectContext ];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_workout_day_six.email_id            = email_id;
    }
    // Give out message if null
    
    if ((exercise != NULL) && (exercise.length != 0) && (details != NULL) && (details.length != 0)) {
        m_workout_day_six.exercise            = exercise;
        m_workout_day_six.details             = details;
    }
    
    NSError *error;
    
    if ( ![ _managedObjectContext save:&error] ) {
        NSLog(@"Error on insert into Workout_Day_Six table");
    }
    else {
        status                           = @"inserted";
    }
    return status;
}

/*
 update into Sixth Day Work Out
 */
- (NSString *)updateSixthDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_id
{
    NSString *status;
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( !m_workout_Day_Six_Entity ) {
        m_workout_Day_Six_Entity       = [ NSEntityDescription entityForName : @"Workout_Day_Six" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_Six_Entity ];
    
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSError *error;
    
    NSArray *workout_Day_Six_Array     = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    // Object to delete
    NSManagedObject *objectIDToDelete;
    
    for ( Workout_Day_Six *workout_Day_Six in workout_Day_Six_Array ) { // Loop through each object in a row of the "Users" table
        // Delete "exercise" object which is to be replaced
        if ([workout_Day_Six.exercise isEqualToString:exercise]) {
            objectIDToDelete            = [_managedObjectContext objectWithID:workout_Day_Six.objectID];
            [_managedObjectContext deleteObject:objectIDToDelete];
            // Must save the managedobjectcontext to delete
            [ self.managedObjectContext save : nil ];
            status                      = @"deleted";
            break;
        }
        else {
            // Deal with error.
        }
    }
    return status;
}

// insert into workout seventh day
- (NSString *)insertIntoSeventhDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_id
{
    NSString *status;
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    // Clean up the m_workout_day_seven first
    m_workout_day_seven                   = nil;
    if ( !m_workout_day_seven ) {
        m_workout_day_seven               = [ NSEntityDescription insertNewObjectForEntityForName : @"Workout_Day_Seven" inManagedObjectContext : _managedObjectContext ];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_workout_day_seven.email_id            = email_id;
    }
    // Give out message if null
    
    if ((exercise != NULL) && (exercise.length != 0) && (details != NULL) && (details.length != 0)) {
        m_workout_day_seven.exercise            = exercise;
        m_workout_day_seven.details             = details;
    }
    
    NSError *error;
    
    if ( ![ _managedObjectContext save:&error] ) {
        NSLog(@"Error on insert into Workout_Day_Seven table");
    }
    else {
        status                           = @"inserted";
    }
    return status;
}

/*
 update into Seventh Day Work Out
 */
- (NSString *)updateSeventhDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_id
{
    NSString *status;
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( !m_workout_Day_Seven_Entity ) {
        m_workout_Day_Seven_Entity       = [ NSEntityDescription entityForName : @"Workout_Day_Seven" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_Seven_Entity ];
    
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSError *error;
    
    NSArray *workout_Day_Seven_Array     = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    // Object to delete
    NSManagedObject *objectIDToDelete;
    
    for ( Workout_Day_Seven *workout_Day_Seven in workout_Day_Seven_Array ) { // Loop through each object in a row of the "Users" table
        // Delete "exercise" object which is to be replaced
        if ([workout_Day_Seven.exercise isEqualToString:exercise]) {
            objectIDToDelete            = [_managedObjectContext objectWithID:workout_Day_Seven.objectID];
            [_managedObjectContext deleteObject:objectIDToDelete];
            // Must save the managedobjectcontext to delete
            [ self.managedObjectContext save : nil ];
            status                      = @"deleted";
            break;
        }
        else {
            // Deal with error.
        }
    }
    return status;
}

// get workout first day
- (NSMutableArray *)getFirstDayWorkOutforUser:(NSString *)email_id
{
    NSError *error;
    NSMutableArray *firstDayWorkoutMutableArray = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_workout_Day_One_Entity ) {
        m_workout_Day_One_Entity            = [ NSEntityDescription entityForName : @"Workout_Day_One" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_One_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *workoutDayOneArray             = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( workoutDayOneArray != nil ) {
        for ( Workout_Day_One *workout_day_one in workoutDayOneArray ) {
            [ firstDayWorkoutMutableArray addObject:workout_day_one.exercise ];
            [ firstDayWorkoutMutableArray addObject:workout_day_one.details ];
        }
    }
    else {
        // Deal with error.
    }
    return firstDayWorkoutMutableArray;

}

// get workout second day
- (NSMutableArray *)getSecondDayWorkOutforUser:(NSString *)email_id
{
    NSError *error;
    NSMutableArray *secondDayWorkoutMutableArray = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_workout_Day_Two_Entity ) {
        m_workout_Day_Two_Entity            = [ NSEntityDescription entityForName : @"Workout_Day_Two" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_Two_Entity ];
    
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *workoutDayTwoArray        = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( workoutDayTwoArray != nil ) {
        for ( Workout_Day_Two *workout_day_two in workoutDayTwoArray ) {
            [ secondDayWorkoutMutableArray addObject:workout_day_two.exercise ];
            [ secondDayWorkoutMutableArray addObject:workout_day_two.details ];
        }
    }
    else {
        // Deal with error.
    }
    return secondDayWorkoutMutableArray;

}

// get workout third day
- (NSMutableArray *)getThirdDayWorkOutforUser:(NSString *)email_id
{
    NSError *error;
    NSMutableArray *thirdDayWorkoutMutableArray = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_workout_Day_Three_Entity ) {
        m_workout_Day_Three_Entity            = [ NSEntityDescription entityForName : @"Workout_Day_Three" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_Three_Entity ];
    
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *workoutDayThreeArray        = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( workoutDayThreeArray != nil ) {
        for ( Workout_Day_Three *workout_day_three in workoutDayThreeArray ) {
            [ thirdDayWorkoutMutableArray addObject:workout_day_three.exercise ];
            [ thirdDayWorkoutMutableArray addObject:workout_day_three.details ];
        }
    }
    else {
        // Deal with error.
    }
    return thirdDayWorkoutMutableArray;
}

// get workout fourth day
- (NSMutableArray *)getFourthDayWorkOutforUser:(NSString *)email_id
{
    NSError *error;
    NSMutableArray *fourthDayWorkoutMutableArray = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_workout_Day_Four_Entity ) {
        m_workout_Day_Four_Entity            = [ NSEntityDescription entityForName : @"Workout_Day_Four" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_Four_Entity ];
    
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *workoutDayFourArray        = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( workoutDayFourArray != nil ) {
        for ( Workout_Day_Four *workout_day_four in workoutDayFourArray ) {
            [ fourthDayWorkoutMutableArray addObject:workout_day_four.exercise ];
            [ fourthDayWorkoutMutableArray addObject:workout_day_four.details ];
        }
    }
    else {
        // Deal with error.
    }
    return fourthDayWorkoutMutableArray;
}

// get workout fifth day
- (NSMutableArray *)getFifthDayWorkOutforUser:(NSString *)email_id
{
    NSError *error;
    NSMutableArray *fifthDayWorkoutMutableArray = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_workout_Day_Five_Entity ) {
        m_workout_Day_Five_Entity            = [ NSEntityDescription entityForName : @"Workout_Day_Five" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_Five_Entity ];
    
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *workoutDayFiveArray        = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( workoutDayFiveArray != nil ) {
        for ( Workout_Day_Five *workout_day_five in workoutDayFiveArray ) {
            [ fifthDayWorkoutMutableArray addObject:workout_day_five.exercise ];
            [ fifthDayWorkoutMutableArray addObject:workout_day_five.details ];
        }
    }
    else {
        // Deal with error.
    }
    return fifthDayWorkoutMutableArray;
}

// get workout sixth day
- (NSMutableArray *)getSixthDayWorkOutforUser:(NSString *)email_id
{
    NSError *error;
    NSMutableArray *sixthDayWorkoutMutableArray = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_workout_Day_Six_Entity ) {
        m_workout_Day_Six_Entity            = [ NSEntityDescription entityForName : @"Workout_Day_Six" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_Six_Entity ];
    
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *workoutDaySixArray        = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( workoutDaySixArray != nil ) {
        for ( Workout_Day_Six *workout_day_six in workoutDaySixArray ) {
            [ sixthDayWorkoutMutableArray addObject:workout_day_six.exercise ];
            [ sixthDayWorkoutMutableArray addObject:workout_day_six.details ];
        }
    }
    else {
        // Deal with error.
    }
    return sixthDayWorkoutMutableArray;
}

// get workout seventh day
- (NSMutableArray *)getSeventhDayWorkOutforUser:(NSString *)email_id
{
    NSError *error;
    NSMutableArray *seventhDayWorkoutMutableArray = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_workout_Day_Seven_Entity ) {
        m_workout_Day_Seven_Entity            = [ NSEntityDescription entityForName : @"Workout_Day_Seven" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_Seven_Entity ];
    
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *workoutDaySeventhArray        = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( workoutDaySeventhArray != nil ) {
        for ( Workout_Day_Seven *workout_day_seven in workoutDaySeventhArray ) {
            [ seventhDayWorkoutMutableArray addObject:workout_day_seven.exercise ];
            [ seventhDayWorkoutMutableArray addObject:workout_day_seven.details ];
        }
    }
    else {
        // Deal with error.
    }
    return seventhDayWorkoutMutableArray;
}

// delete workout first day
- (void)deleteFirstDayWorkoutforUser:(NSString *)email_id
{
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_workout_Day_One_Entity ) {
        m_workout_Day_One_Entity            = [ NSEntityDescription entityForName : @"Workout_Day_One" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_One_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *workoutDayOneArray             = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( workoutDayOneArray != nil ) {
        for ( Workout_Day_One *workout_day_one in workoutDayOneArray ) {
            [_managedObjectContext deleteObject:workout_day_one];
        }
        NSError *saveError = nil;
        [_managedObjectContext save:&saveError];
    }
    else {
        // Deal with error.
    }
}

// delete workout second day
- (void)deleteSecondDayWorkoutforUser:(NSString *)email_id
{
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_workout_Day_Two_Entity ) {
        m_workout_Day_Two_Entity            = [ NSEntityDescription entityForName : @"Workout_Day_Two" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_Two_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *workoutDayTwoArray             = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( workoutDayTwoArray != nil ) {
        for ( Workout_Day_Two *workout_day_two in workoutDayTwoArray ) {
            [_managedObjectContext deleteObject:workout_day_two];
        }
        NSError *saveError = nil;
        [_managedObjectContext save:&saveError];
    }
    else {
        // Deal with error.
    }
}

// delete workout third day
- (void)deleteThirdDayWorkoutforUser:(NSString *)email_id
{
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_workout_Day_Three_Entity ) {
        m_workout_Day_Three_Entity          = [ NSEntityDescription entityForName : @"Workout_Day_Three" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_Three_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *workoutDayThreeArray           = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( workoutDayThreeArray != nil ) {
        for ( Workout_Day_Three *workout_day_three in workoutDayThreeArray ) {
            [_managedObjectContext deleteObject:workout_day_three];
        }
        NSError *saveError = nil;
        [_managedObjectContext save:&saveError];
    }
    else {
        // Deal with error.
    }
}

// delete workout fourth day
- (void)deleteFourthDayWorkoutforUser:(NSString *)email_id
{
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_workout_Day_Four_Entity ) {
        m_workout_Day_Four_Entity           = [ NSEntityDescription entityForName : @"Workout_Day_Four" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_Four_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *workoutDayFourArray            = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( workoutDayFourArray != nil ) {
        for ( Workout_Day_Four *workout_day_four in workoutDayFourArray ) {
            [_managedObjectContext deleteObject:workout_day_four];
        }
        NSError *saveError = nil;
        [_managedObjectContext save:&saveError];
    }
    else {
        // Deal with error.
    }
}

// delete workout fifth day
- (void)deleteFifthDayWorkoutforUser:(NSString *)email_id
{
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_workout_Day_Five_Entity ) {
        m_workout_Day_Five_Entity           = [ NSEntityDescription entityForName : @"Workout_Day_Five" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_Five_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *workoutDayFiveArray            = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( workoutDayFiveArray != nil ) {
        for ( Workout_Day_Five *workout_day_five in workoutDayFiveArray ) {
            [_managedObjectContext deleteObject:workout_day_five];
        }
        NSError *saveError = nil;
        [_managedObjectContext save:&saveError];
    }
    else {
        // Deal with error.
    }
}

// delete workout sixth day
- (void)deleteSixthDayWorkoutforUser:(NSString *)email_id
{
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_workout_Day_Six_Entity ) {
        m_workout_Day_Six_Entity            = [ NSEntityDescription entityForName : @"Workout_Day_Six" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_Six_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *workoutDaySixArray             = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( workoutDaySixArray != nil ) {
        for ( Workout_Day_Six *workout_day_six in workoutDaySixArray ) {
            [_managedObjectContext deleteObject:workout_day_six];
        }
        NSError *saveError = nil;
        [_managedObjectContext save:&saveError];
    }
    else {
        // Deal with error.
    }
}

// delete workout seventh day
- (void)deleteSeventhDayWorkoutforUser:(NSString *)email_id
{
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_workout_Day_Seven_Entity ) {
        m_workout_Day_Seven_Entity          = [ NSEntityDescription entityForName : @"Workout_Day_Seven" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_workout_Day_Seven_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *workoutDaySevenArray           = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( workoutDaySevenArray != nil ) {
        for ( Workout_Day_Seven *workout_day_seven in workoutDaySevenArray ) {
            [_managedObjectContext deleteObject:workout_day_seven];
        }
        NSError *saveError = nil;
        [_managedObjectContext save:&saveError];
    }
    else {
        // Deal with error.
    }
}

// insert into breakfast
- (NSString *)insertIntoSupplementBreakfast:(NSString *)supplement Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    // Clean up the supplement first
    m_supplement_breakfast                         = nil;
    if ( !m_supplement_breakfast ) {
        m_supplement_breakfast                     = [ NSEntityDescription insertNewObjectForEntityForName : @"SupplementBreakfast" inManagedObjectContext : _managedObjectContext ];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_supplement_breakfast.email_id            = email_id;
    }
    // Give out message if null
    
    if ((supplement != NULL) && (supplement.length != 0)) {
        m_supplement_breakfast.supplement          = supplement;
    }
    
    if ((quantity != NULL) && (quantity.length != 0)) {
        m_supplement_breakfast.quantity             = quantity;
    }
    
    NSError *error;
    
    if ( ![ _managedObjectContext save:&error] ) {
        NSLog(@"Error on insert into Supplement Breakfast table");
    }
    else {
        status                           = @"inserted";
    }
    return status;
}

// update into supplement breakfast
- (NSString *)updateSupplementBreakfast:(NSString *)supplement Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( !m_supplement_breakfast_Entity ) {
        m_supplement_breakfast_Entity              = [ NSEntityDescription entityForName : @"SupplementBreakfast" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_supplement_breakfast_Entity ];
    
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSError *error;
    
    NSArray *supplementBreakfastArray             = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    // Object to delete
    NSManagedObject *objectIDToDelete;
    
    for ( SupplementBreakfast *supplementbreakfast in supplementBreakfastArray ) { // Loop through each object in a row of the "Users" table
        // Delete "supplement" object which is to be replaced
        if ([supplementbreakfast.supplement isEqualToString:supplement]) {
            objectIDToDelete            = [_managedObjectContext objectWithID:supplementbreakfast.objectID];
            [_managedObjectContext deleteObject:objectIDToDelete];
            // Must save the managedobjectcontext to delete
            [ self.managedObjectContext save : nil ];
            status                      = @"deleted";
            break;
        }
        else {
            // Deal with error.
        }
    }
    return status;
}

// insert into supplement pre workout
- (NSString *)insertIntoSupplementPreWorkout:(NSString *)supplement Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    // Clean up the supplement pre workout first
    m_supplement_pre_workout                       = nil;
    if ( !m_supplement_pre_workout ) {
        m_supplement_pre_workout                   = [ NSEntityDescription insertNewObjectForEntityForName : @"SupplementPreWorkout" inManagedObjectContext : _managedObjectContext ];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_supplement_pre_workout.email_id          = email_id;
    }
    // Give out message if null
    
    if ((supplement != NULL) && (supplement.length != 0)) {
        m_supplement_pre_workout.supplement              = supplement;
    }
    
    if ((quantity != NULL) && (quantity.length != 0)) {
        m_supplement_pre_workout.quantity          = quantity;
    }
    
    NSError *error;
    
    if ( ![ _managedObjectContext save:&error] ) {
        NSLog(@"Error on insert into SupplementPreWorkout table");
    }
    else {
        status                           = @"inserted";
    }
    return status;
}

// update into supplement pre workout
- (NSString *)updateSupplementPreWorkout:(NSString *)supplement Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( !m_supplement_pre_workout_Entity ) {
        m_supplement_pre_workout_Entity            = [ NSEntityDescription entityForName : @"SupplementPreWorkout" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_supplement_pre_workout_Entity ];
    
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSError *error;
    
    NSArray *supplementPreWorkoutArray            = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    // Object to delete
    NSManagedObject *objectIDToDelete;
    
    for ( SupplementPreWorkout *pre_workout in supplementPreWorkoutArray ) { // Loop through each object in a row of the "Users" table
        // Delete "supplement" object which is to be replaced
        if ([pre_workout.supplement isEqualToString:supplement]) {
            objectIDToDelete            = [_managedObjectContext objectWithID:pre_workout.objectID];
            [_managedObjectContext deleteObject:objectIDToDelete];
            // Must save the managedobjectcontext to delete
            [ self.managedObjectContext save : nil ];
            status                      = @"deleted";
            break;
        }
        else {
            // Deal with error.
        }
    }
    return status;
}

// insert into supplement pre workout
- (NSString *)insertIntoSupplementPostWorkout:(NSString *)supplement Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    // Clean up the supplement post workout first
    m_supplement_post_workout                       = nil;
    if ( !m_supplement_post_workout ) {
        m_supplement_post_workout                   = [ NSEntityDescription insertNewObjectForEntityForName : @"SupplementPostWorkout" inManagedObjectContext : _managedObjectContext ];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_supplement_post_workout.email_id          = email_id;
    }
    // Give out message if null
    
    if ((supplement != NULL) && (supplement.length != 0)) {
        m_supplement_post_workout.supplement              = supplement;
    }
    
    if ((quantity != NULL) && (quantity.length != 0)) {
        m_supplement_post_workout.quantity          = quantity;
    }
    
    NSError *error;
    
    if ( ![ _managedObjectContext save:&error] ) {
        NSLog(@"Error on insert into Supplement Post Workout table");
    }
    else {
        status                           = @"inserted";
    }
    return status;
}

// update into supplement post workout
- (NSString *)updateSupplementPostWorkout:(NSString *)supplement Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( !m_supplement_post_workout_Entity ) {
        m_supplement_post_workout_Entity            = [ NSEntityDescription entityForName : @"SupplementPostWorkout" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_supplement_post_workout_Entity ];
    
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSError *error;
    
    NSArray *postWorkoutArray            = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    // Object to delete
    NSManagedObject *objectIDToDelete;
    
    for ( SupplementPostWorkout *post_workout in postWorkoutArray ) { // Loop through each object in a row of the "Users" table
        // Delete "supplement" object which is to be replaced
        if ([post_workout.supplement isEqualToString:supplement]) {
            objectIDToDelete            = [_managedObjectContext objectWithID:post_workout.objectID];
            [_managedObjectContext deleteObject:objectIDToDelete];
            // Must save the managedobjectcontext to delete
            [ self.managedObjectContext save : nil ];
            status                      = @"deleted";
            break;
        }
        else {
            // Deal with error.
        }
    }
    return status;
}


// insert into supplement pre workout
- (NSString *)insertIntoSupplementBeforeBed:(NSString *)supplement Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    // Clean up the before bed supplement first
    m_supplement_before_bed                       = nil;
    if ( !m_supplement_before_bed ) {
        m_supplement_before_bed                   = [ NSEntityDescription insertNewObjectForEntityForName : @"SupplementBeforeBed" inManagedObjectContext : _managedObjectContext ];
    }
    
    if ((email_id != NULL) && (email_id.length != 0)) {
        m_supplement_before_bed.email_id          = email_id;
    }
    // Give out message if null
    
    if ((supplement != NULL) && (supplement.length != 0)) {
        m_supplement_before_bed.supplement        = supplement;
    }
    
    if ((quantity != NULL) && (quantity.length != 0)) {
        m_supplement_before_bed.quantity          = quantity;
    }
    
    NSError *error;
    
    if ( ![ _managedObjectContext save:&error] ) {
        NSLog(@"Error on insert into Supplement Before Bed table");
    }
    else {
        status                           = @"inserted";
    }
    return status;
}

// update into supplement before bed
- (NSString *)updateSupplementBeforeBed:(NSString *)supplement Quantity:(NSString *)quantity forUser:(NSString *)email_id
{
    NSString *status;
    
    if ( m_Request ) {
        m_Request                   = nil;
    }
    
    if ( !m_Request ) {
        m_Request                   = [ [ NSFetchRequest alloc ] init ];
    }
    
    // Clean up the _managedObjectContext first
    _managedObjectContext               = nil;
    if ( !_managedObjectContext ) {
        _managedObjectContext           = [ self managedObjectContext ];
    }
    
    if ( !m_supplement_before_bed_Entity ) {
        m_supplement_before_bed_Entity            = [ NSEntityDescription entityForName : @"SupplementBeforeBed" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_supplement_before_bed_Entity ];
    
    NSPredicate *predicate              = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    NSError *error;
    
    NSArray *beforeBedArray            = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    // Object to delete
    NSManagedObject *objectIDToDelete;
    
    for ( SupplementBeforeBed *before_bed in beforeBedArray ) { // Loop through each object in a row of the "Users" table
        // Delete "supplement" object which is to be replaced
        if ([before_bed.supplement isEqualToString:supplement]) {
            objectIDToDelete            = [_managedObjectContext objectWithID:before_bed.objectID];
            [_managedObjectContext deleteObject:objectIDToDelete];
            // Must save the managedobjectcontext to delete
            [ self.managedObjectContext save : nil ];
            status                      = @"deleted";
            break;
        }
        else {
            // Deal with error.
        }
    }
    return status;
}

// get supplement breakfast
- (NSMutableArray *)getSupplementBreakfastforUser:(NSString *)email_id
{
    NSError *error;
    NSMutableArray *supplementBreakfastMutableArray = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_supplement_breakfast_Entity ) {
        m_supplement_breakfast_Entity                  = [ NSEntityDescription entityForName : @"SupplementBreakfast" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_supplement_breakfast_Entity ];
    
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *supplement_breakfastArray        = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    if ( supplement_breakfastArray != nil ) {
        for ( SupplementBreakfast *supplement_breakfast in supplement_breakfastArray ) {
            [ supplementBreakfastMutableArray addObject:supplement_breakfast.supplement ];
            [ supplementBreakfastMutableArray addObject:supplement_breakfast.quantity ];
        }
    }
    else {
        // Deal with error.
    }
    return supplementBreakfastMutableArray;
    
}

// delete supplement breakfast
- (void)deleteSupplementBreakfastforUser:(NSString *)email_id
{
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_supplement_breakfast_Entity ) {
        m_supplement_breakfast_Entity                  = [ NSEntityDescription entityForName : @"SupplementBreakfast" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_supplement_breakfast_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *supplementBreakfastArray                 = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( supplementBreakfastArray != nil ) {
        for ( SupplementBreakfast *supplement_breakfast in supplementBreakfastArray ) {
            [_managedObjectContext deleteObject:supplement_breakfast];
        }
        NSError *saveError = nil;
        [_managedObjectContext save:&saveError];
    }
    else {
        // Deal with error.
    }
}

// get supplement pre workout
- (NSMutableArray *)getSupplementPreWorkoutforUser:(NSString *)email_id
{
    NSError *error;
    NSMutableArray *supplementPreWorkoutMutableArray = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_supplement_pre_workout_Entity ) {
        m_supplement_pre_workout_Entity                  = [ NSEntityDescription entityForName : @"SupplementPreWorkout" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_supplement_pre_workout_Entity ];
    
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *supplement_pre_workoutArray        = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( supplement_pre_workoutArray != nil ) {
        for ( SupplementPreWorkout *supplement_pre_workout in supplement_pre_workoutArray ) {
            [ supplementPreWorkoutMutableArray addObject:supplement_pre_workout.supplement ];
            [ supplementPreWorkoutMutableArray addObject:supplement_pre_workout.quantity ];
        }
    }
    else {
        // Deal with error.
    }
    return supplementPreWorkoutMutableArray;
    
}

// delete supplement per workout
- (void)deleteSupplementPreWorkoutforUser:(NSString *)email_id
{
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_supplement_pre_workout_Entity ) {
        m_supplement_pre_workout_Entity                  = [ NSEntityDescription entityForName : @"SupplementPreWorkout" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_supplement_pre_workout_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *supplementPreWorkoutArray                 = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( supplementPreWorkoutArray != nil ) {
        for ( SupplementPreWorkout *supplement_pre_workout in supplementPreWorkoutArray ) {
            [_managedObjectContext deleteObject:supplement_pre_workout];
        }
        NSError *saveError = nil;
        [_managedObjectContext save:&saveError];
    }
    else {
        // Deal with error.
    }
}

// get supplement post workout
- (NSMutableArray *)getSupplementPostWorkoutforUser:(NSString *)email_id
{
    NSError *error;
    NSMutableArray *supplementPostWorkoutMutableArray = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_supplement_post_workout_Entity ) {
        m_supplement_post_workout_Entity                  = [ NSEntityDescription entityForName : @"SupplementPostWorkout" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_supplement_post_workout_Entity ];
    
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *supplement_post_workoutArray        = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( supplement_post_workoutArray != nil ) {
        for ( SupplementPostWorkout *supplement_post_workout in supplement_post_workoutArray ) {
            [ supplementPostWorkoutMutableArray addObject:supplement_post_workout.supplement ];
            [ supplementPostWorkoutMutableArray addObject:supplement_post_workout.quantity ];
        }
    }
    else {
        // Deal with error.
    }
    return supplementPostWorkoutMutableArray;
    
}

// delete supplement post workout
- (void)deleteSupplementPostWorkoutforUser:(NSString *)email_id
{
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_supplement_post_workout_Entity ) {
        m_supplement_post_workout_Entity                  = [ NSEntityDescription entityForName : @"SupplementPostWorkout" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_supplement_post_workout_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *supplementPostWorkoutArray                 = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( supplementPostWorkoutArray != nil ) {
        for ( SupplementPostWorkout *supplement_post_workout in supplementPostWorkoutArray ) {
            [_managedObjectContext deleteObject:supplement_post_workout];
        }
        NSError *saveError = nil;
        [_managedObjectContext save:&saveError];
    }
    else {
        // Deal with error.
    }
}

// get supplement before bed
- (NSMutableArray *)getSupplementBeforeBedforUser:(NSString *)email_id
{
    NSError *error;
    NSMutableArray *supplementBeforeBedMutableArray = [[ NSMutableArray alloc ] init ];
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_supplement_before_bed_Entity ) {
        m_supplement_before_bed_Entity                  = [ NSEntityDescription entityForName : @"SupplementBeforeBed" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_supplement_before_bed_Entity ];
    
    NSPredicate *predicate          = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *supplement_before_bedArray        = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( supplement_before_bedArray != nil ) {
        for ( SupplementBeforeBed *supplement_before_bed in supplement_before_bedArray ) {
            [ supplementBeforeBedMutableArray addObject:supplement_before_bed.supplement ];
            [ supplementBeforeBedMutableArray addObject:supplement_before_bed.quantity ];
        }
    }
    else {
        // Deal with error.
    }
    return supplementBeforeBedMutableArray;
    
}

// delete supplement before bed
- (void)deleteSupplementBeforeBedforUser:(NSString *)email_id
{
    NSError *error;
    
    if ( !_managedObjectContext ) {
        _managedObjectContext               = [ self managedObjectContext ];
    }
    
    if ( m_Request ) {
        m_Request                           = nil;
    }
    
    if ( !m_Request ) {
        m_Request                           = [ [ NSFetchRequest alloc ] init ];
    }
    
    if ( !m_supplement_before_bed_Entity ) {
        m_supplement_before_bed_Entity                  = [ NSEntityDescription entityForName : @"SupplementBeforeBed" inManagedObjectContext : _managedObjectContext ];
    }
    [ m_Request setEntity:m_supplement_before_bed_Entity ];
    
    NSPredicate *predicate                  = [ NSPredicate predicateWithFormat : @"email_id == %@", email_id ];
    
    [ m_Request setPredicate : predicate ];
    
    
    NSArray *supplementBeforeBedArray                 = [ _managedObjectContext executeFetchRequest : m_Request error :&error ];
    
    if ( supplementBeforeBedArray != nil ) {
        for ( SupplementBeforeBed *supplement_before_bed in supplementBeforeBedArray ) {
            [_managedObjectContext deleteObject:supplement_before_bed];
        }
        NSError *saveError = nil;
        [_managedObjectContext save:&saveError];
    }
    else {
        // Deal with error.
    }
}

/*
 Saving changes before exiting
 */

- (void)saveContext
{
    NSError *error                                  = nil;
    NSManagedObjectContext *managedObjectContext    = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext           = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL                     = [[NSBundle mainBundle] URLForResource:@"Total_Fitness_and_Nutrition" withExtension:@"momd"];
  //HAX
    //_managedObjectModel                 = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  _managedObjectModel =  [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL                     = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Total_Fitness_and_Nutrition.sqlite"];
    
    NSError *error                      = nil;
    _persistentStoreCoordinator         = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
