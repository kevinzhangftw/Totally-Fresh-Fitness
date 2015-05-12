//
//  Database.h
//  Total Fitness and Nutrition
//
//  Created by Namgyal Damdul on 2012-10-25.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Database : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// Changes will be saved before exiting
- (void)saveContext;

// Database file path
- (NSURL *)applicationDocumentsDirectory;

// Work out record maintained
- (void)insertIntoWorkOutPlanEmail_Id:(NSString *)email_id Exercise:(NSString *)exercise Date:(NSDate *)date Day:(NSString *)day Day_Number:(NSNumber *)day_number Weight:(NSNumber *)weight Rep:(NSNumber *)rep;

// Meal plan record maintiaed
- (NSString *)insertIntoMealPlanEmail_Id:(NSString *)email_id Date:(NSDate *)date Meal:(NSString *)meal Quantity:(NSString *)quantity;

// User registration
- (NSString *)insertIntoUserEmail_Id:(NSString *)email_id Password:(NSString *)password Log:(NSString *)log;

// Progress record maintained
- (NSString *)insertIntoProgressEmail_Id:(NSString *)email_id Weight:(NSNumber *)weight Height:(NSNumber *)height Workouts:(NSString *)workout BMR:(NSNumber *)bmr Date:(NSDate *)date;

// BMR details maintained
- (NSString *)insertIntoBMREmail_Id:(NSString *)email_id Sex:(NSString *)sex Age:(NSNumber *)age Weight:(NSNumber *)weight Height:(NSNumber *)height BMR:(NSNumber *)bmr Date:(NSDate *)date Exercise_Mode:(NSString *)exercise_mode;

// Exercise Days maintined
- (NSString *)insertIntoExerciseDaysEmail_Id:(NSString *)email_id Date:(NSDate*)date Monday:(NSString *)monday Tuesday:(NSString *)tuesday Wednesday:(NSString *)wednesday Thursday:(NSString *)thursday Friday:(NSString *)friday Saturday:(NSString *)saturday Sunday:(NSString *)sunday;

// Exercise Level maintined
- (NSString *)insertIntoExerciseLevelEmail_Id:(NSString *)email_id Date:(NSDate *)date Level:(NSString *)level;

// Exercise goals maintined
- (NSString *)insertIntoGoalsEmail_Id:(NSString *)email_id Date:(NSDate *)date Goal:(NSString *)goal;

// Grocery list maintained
- (NSString *)insertIntoGroceryEmail_Id:(NSString *)email_id Date:(NSDate *)date food:(NSString *)food;

// Food Recipes Transit
- (NSString *)insertIntoFoodRecipesTitle:(NSString *)title Image:(NSString *)image Ingredients:(NSString *)ingredients Directions:(NSString *)directions;

// Exercise Report Maintain
- (NSString *)insertIntoExerciseReport:(NSString *)exercise Email_Id:(NSString *)email_id Date:(NSDate *)date SetOneWeight:(NSNumber *)set_one_weight SetOneRep:(NSNumber *)set_one_rep SetTwoWeight:(NSNumber *)set_two_weight SetTwoRep:(NSNumber *)set_two_rep SetThreeWeight:(NSNumber *)set_three_weight SetThreeRep:(NSNumber *)set_three_rep SetFourWeight:(NSNumber *)set_four_weight SetFourRep:(NSNumber *)set_four_rep SetFiveWeight:(NSNumber *)set_five_weight SetFiveRep:(NSNumber *)set_five_rep;

// Exercise Report Maintain
- (NSString *)insertIntoExerciseReport:(NSString *)exercise Email_Id:(NSString *)email_id Date:(NSDate *)date SetOneWeight:(NSNumber *)set_one_weight SetOneTime:(NSNumber *)set_one_time SetOneRep:(NSNumber *)set_one_rep;

// Exercise Report Maintain by updating
- (NSString *)updateExerciseReport:(NSString *)exercise Email_Id:(NSString *)email_id Date:(NSDate *)date Set:(NSNumber *)set_number SetTheWeight:(NSNumber *)set_the_weight SetTheTime:(NSNumber *)set_the_time SetTheRep:(NSNumber *)set_the_rep;

// Exercise Report Maintain
- (NSString *)insertIntoExerciseReportWeight:(NSNumber *)weight Email_Id:(NSString *)email_id;

// Exercise list maintained


// Meal list maintained


// Get Workout plan
- (NSMutableArray *)getWorkOutPlan:(NSString *)email_Id;

// Get meal plan
- (NSMutableArray *)getMealPlan:(NSString *)email_Id;

// Get User Info
- (NSMutableArray *)getUserInfo:(NSString *)email_Id;

// Get Progress Report
- (NSMutableArray *)getProgressReport:(NSString *)email_Id;

// Get BMR 
- (int)getBMR:(NSString *)email_Id;

// Get BMR details
- (NSMutableArray *)getBMRDetails:(NSString *)email_Id;

// Get latest BMR details
- (NSMutableArray *)getLatestBMR:(NSString *)email_Id;

// Get gender
- (NSString *)getGender:(NSString *)email_Id;

// Get Exercise days details
- (NSMutableArray *)getExerciseDays:(NSString *)email_Id;

// Get Latest exercise days
- (NSMutableArray *)getLatestExerciseDays:(NSString *)email_Id;

// Check if the user has a selected exercise
- (NSString *)hasUserSelectedDays:(NSString *)email_Id;

// Get Exercise level details
- (NSMutableArray *)getExerciseLevel:(NSString *)email_Id;

// Get Latest Exercise level
- (NSMutableArray *)getLatestExerciseLevel:(NSString *)email_Id;

// Check if the user has a selected exercise
- (NSString *)hasUserSelectedLevel:(NSString *)email_Id;

// Get Exercise goal
- (NSMutableArray *)getGoal:(NSString *)email_Id;

// Get Latest Exercise goal
- (NSString *)getLatestExerciseGoal:(NSString *)email_Id;

// Check if the user has a selected exercise goal
- (NSString *)hasUserSelectedGoal:(NSString *)email_Id;

// Check if the user has a selected exercise level
- (NSString *)hasUserSelectedExerciseLevel:(NSString *)email_Id;

// Check Email Id from BMR details
- (BOOL)checkEmailIDInBMR:(NSString *)email_Id;

// Get User's Email Id
- (NSString *)getEmailId:(NSString *)log;

// Get User's Password
- (NSString *)getPassword:(NSString *)email;

// Get Users' Email Ids
- (NSMutableArray *)getAllEmailIds;

// Get Food Recipes
- (NSMutableArray *)getFoodRecipes;

// Count number of users
- (int)countNumberOfUsers;

// Log in User
- (void)logInUser:(NSString *)email_Id;

// Log out User
- (void)logOutUser:(NSString *)email_Id;

// Log out other User
- (void)logOutOtherUsers:(NSString *)email_Id;

// Check user login status
- (NSString *)checkUserLogInStatus:(NSString *)email_Id;

// Check the loggedin status of any user
- (NSString *)checkUserLogInStatus;

// Is user man or woman
- (NSString  *)sexOfUser:(NSString *)email_Id;

// Get Grocery list
- (NSMutableArray *)getGroceryList:(NSString *)email_Id;

// Get Exercise Report
- (NSMutableArray *)getExerciseReport:(NSString *)email_Id;

// Get A Week's Average Exercise Report for a particular exercise
- (NSMutableArray *)getAverageExerciseReport:(NSString *)exercise ForAWeek:(NSString *)email_Id StartDate:(NSDate *)startDate EndDate:(NSDate *)endDate;

// Get A Week's overall average Exercise Report 
- (NSMutableArray *)getAverageExerciseReportForAWeek:(NSString *)email_Id StartDate:(NSDate *)startDate EndDate:(NSDate *)endDate;

// Check if food is already in the list
- (BOOL)checkFood:(NSString *)food AlreadyIntheList:(NSString *)email_Id;

// Delete the empty user created by facebook login
- (void)deleteDummyUsers;

// Delete the empty user created by facebook login
- (void)deleteFoodRecipes;

// Check if terms and conditions accepted
- (NSString *)checkIfTermsAndConditionsAccepted;

// Accept terms and conditions
- (NSString *)insertIntoTermsAndConditionsToAccept:(NSString *)yes;

// insert into breakfast
- (NSString *)insertIntoBreakfastFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// update into breakfast
- (NSString *)updateBreakfastFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// insert into first snack
- (NSString *)insertIntoFirstSnackFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// update into first snack
- (NSString *)updateFirstSnackFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// insert into lunch
- (NSString *)insertIntoLunchFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// update into lunch
- (NSString *)updateLunchFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// insert into second snack
- (NSString *)insertIntoSecondSnackFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// update into second snack
- (NSString *)updateSecondSnackFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// insert into dinner
- (NSString *)insertIntoDinnerFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// update into dinner
- (NSString *)updateDinnerFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// insert into third snack
- (NSString *)insertIntoThirdSnackFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// update into third snack
- (NSString *)updateThirdSnackFood:(NSString *)food Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// get breakfast
- (NSMutableArray *)getBreakfastforUser:(NSString *)email_Id;

// get first snack
- (NSMutableArray *)getFirstSnackforUser:(NSString *)email_Id;

// get lunch
- (NSMutableArray *)getLunchforUser:(NSString *)email_Id;

// get second snack
- (NSMutableArray *)getSecondSnackforUser:(NSString *)email_Id;

// get dinner
- (NSMutableArray *)getDinnerforUser:(NSString *)email_Id;

// get third snack
- (NSMutableArray *)getThirdSnackforUser:(NSString *)email_Id;

// delete breakfast
- (void)deleteBreakfastforUser:(NSString *)email_Id;

// delete first snack
- (void)deleteFirstSnackforUser:(NSString *)email_Id;

// delete lunch
- (void)deleteLunchforUser:(NSString *)email_Id;

// delete second snack
- (void)deleteSecondSnackforUser:(NSString *)email_Id;

// delete dinner
- (void)deleteDinnerforUser:(NSString *)email_Id;

// delete third snack
- (void)deleteThirdSnackforUser:(NSString *)email_Id;

// insert into workout first day
- (NSString *)insertIntoFirstDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_Id;

// update workout first day
- (NSString *)updateFirstDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_Id;

// insert into workout second day
- (NSString *)insertIntoSecondDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_Id;

// update workout second day
- (NSString *)updateSecondDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_Id;

// insert into workout third day
- (NSString *)insertIntoThirdDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_Id;

// update workout third day
- (NSString *)updateThirdDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_Id;

// insert into workout fourth day
- (NSString *)insertIntoFourthDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_Id;

// update workout fourth day
- (NSString *)updateFourthDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_Id;

// insert into workout fifth day
- (NSString *)insertIntoFifthDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_Id;

// update workout fifth day
- (NSString *)updateFifthDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_Id;

// insert into workout sixth day
- (NSString *)insertIntoSixthDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_Id;

// update workout Sixth day
- (NSString *)updateSixthDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_Id;

// insert into workout seventh day
- (NSString *)insertIntoSeventhDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_Id;

// update workout Seventh day
- (NSString *)updateSeventhDayWorkOut:(NSString *)exercise Details:(NSString *)details forUser:(NSString *)email_Id;

// get workout first day
- (NSMutableArray *)getFirstDayWorkOutforUser:(NSString *)email_Id;

// get workout second day
- (NSMutableArray *)getSecondDayWorkOutforUser:(NSString *)email_Id;

// get workout third day
- (NSMutableArray *)getThirdDayWorkOutforUser:(NSString *)email_Id;

// get workout fourth day
- (NSMutableArray *)getFourthDayWorkOutforUser:(NSString *)email_Id;

// get workout fifth day
- (NSMutableArray *)getFifthDayWorkOutforUser:(NSString *)email_Id;

// get workout sixth day
- (NSMutableArray *)getSixthDayWorkOutforUser:(NSString *)email_Id;

// get workout seventh day
- (NSMutableArray *)getSeventhDayWorkOutforUser:(NSString *)email_Id;

// delete workout first day 
- (void)deleteFirstDayWorkoutforUser:(NSString *)email_Id;

// delete workout second day
- (void)deleteSecondDayWorkoutforUser:(NSString *)email_Id;

// delete workout third day
- (void)deleteThirdDayWorkoutforUser:(NSString *)email_Id;

// delete workout fourth day
- (void)deleteFourthDayWorkoutforUser:(NSString *)email_Id;

// delete workout fifth day
- (void)deleteFifthDayWorkoutforUser:(NSString *)email_Id;

// delete workout sixth day
- (void)deleteSixthDayWorkoutforUser:(NSString *)email_Id;

// delete workout seventh day
- (void)deleteSeventhDayWorkoutforUser:(NSString *)email_Id;

// insert into supplement breakfast
- (NSString *)insertIntoSupplementBreakfast:(NSString *)supplement Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// update into supplement breakfast
- (NSString *)updateSupplementBreakfast:(NSString *)supplement Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// insert into supplement pre work
- (NSString *)insertIntoSupplementPreWorkout:(NSString *)supplement Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// update into supplement pre work
- (NSString *)updateSupplementPreWorkout:(NSString *)supplement Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// insert into supplement post work
- (NSString *)insertIntoSupplementPostWorkout:(NSString *)supplement Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// update into supplement post work
- (NSString *)updateSupplementPostWorkout:(NSString *)supplement Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// insert into supplement before work
- (NSString *)insertIntoSupplementBeforeBed:(NSString *)supplement Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// update into supplement before work
- (NSString *)updateSupplementBeforeBed:(NSString *)supplement Quantity:(NSString *)quantity forUser:(NSString *)email_Id;

// get supplement breakfast
- (NSMutableArray *)getSupplementBreakfastforUser:(NSString *)email_Id;

// get Supplement pre workout
- (NSMutableArray *)getSupplementPreWorkoutforUser:(NSString *)email_Id;

// get Supplement post workout
- (NSMutableArray *)getSupplementPostWorkoutforUser:(NSString *)email_Id;

// get supplement before bed
- (NSMutableArray *)getSupplementBeforeBedforUser:(NSString *)email_Id;

// delete Supplement breakfast
- (void)deleteSupplementBreakfastforUser:(NSString *)email_Id;

// delete supplement pre workout
- (void)deleteSupplementPreWorkoutforUser:(NSString *)email_Id;

// delete supplement post workout
- (void)deleteSupplementPostWorkoutforUser:(NSString *)email_Id;

// delete supplement before bed
- (void)deleteSupplementBeforeBedforUser:(NSString *)email_Id;

@end
