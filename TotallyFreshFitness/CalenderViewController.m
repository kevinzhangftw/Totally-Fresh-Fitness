//
//  CalenderViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-04.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import "CalenderViewController.h"
#import "MealPlanSelection.h"
#import "WorkoutSelection.h"
#import "FoodProfileViewController.h"
#import "ProfileViewController.h"
#import "ExerciseProfileViewController.h"
#import "WorkOutDaysViewController.h"
#import "ExerciseLevelViewController.h"
#import "GoalsViewController.h"
#import "RootViewController.h"
#import "WorkoutPlanManager.h"
#import "NSString+FindImage.h"
#import "NSMutableArray+SportsList.h"
#import "SupplementCheck.h"
#import "SupplementProfileViewController.h"
#import "NSString+SupplementImageName.h"

@interface CalenderViewController ()

// Move to FoodProfileViewController
- (void)moveToFoodProfileViewController:(id)sender;
// Move to MealViewController
- (void)moveToMealViewController:(id)sender;
// Move to ExerciseViewController
- (void)moveToExerciseViewController:(id)sender;
// Move to supplements at website
- (void)moveToSupplementsAtWebsite:(id)sender;
// Move to ExerciseProfileViewController
- (void)moveToExerciseProfileViewController:(id)sender;
// Move to WorkOutDaysViewController's view
- (void)moveToWorkOutDaysViewController:(id)sender;
// Move to GoalsViewController's view
- (void)moveToGoalsViewController:(id)sender;
// Move to ExerciseLevelViewController's view
- (void)moveToExerciseLevelViewController:(id)sender;
// Move to MusicTracksViewContorller's view
- (void)moveToMusicTracksViewController:(id)sender;
// Move to SupplementPlanViewController
- (void)moveToSupplementPlanViewController:(id)sender;
// Move to SupplementProfileViewController
- (void)moveToSupplementProfileViewController:(id)sender;
// Move to RootViewController's view
- (IBAction)moveToRootViewController:(id)sender;
// If days, goals and exercise levels are not selected, go to them
- (void)hasUserSelectedDaysGoalsAndLevels;
// Get days from current week using weekdays of the month.
- (void)getDaysFromCurrentWeekUsingWeekDayOfTheMonth;
// Get the days from the selected week
- (NSMutableArray *)getDaysOfTheWeek:(int)startInt;
// Get the days from the selected week when swiped left or right
- (void)getDaysOfTheSelectedWeek;
// Days transitions
- (void)daysTransitions:(NSString *)leftOrRight;
// Hide and show days
- (void)daysHideAndShow:(NSString *)hideOrShow;
// Get Food details from the database
- (void)getFoodDetails;
// Details of meal plan and work out plan for the day
- (IBAction)planSection:(id)sender;
// Initial position of selection button
- (void)positionSelectionButtonToTheFirstSelectedDay;
//  Cell contents such as images, items and measurement displayed
- (void)cellContents:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath WithImageArray:(NSMutableArray *)imageArray AndKeyArray:(NSMutableArray *)keyArray AndValueArray:(NSMutableArray *)valueArray;
// Each section has its own images, key and value arrays
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
// Upload sports list
- (void)sportsListArray;

@end

@implementation CalenderViewController

// ProfileViewController class object
ProfileViewController *m_profileViewController;
// FoodViewController class object
FoodProfileViewController *m_foodProfileViewController;
// ExerciseViewController class object
ExerciseViewController *m_exerciseViewController;
// MealViewContrioller class object
MealViewController *m_mealViewController;
// ExerciseProfileViewController class object
ExerciseProfileViewController *m_exerciseProfileViewController;
// WorkoutDaysViewController class object
WorkOutDaysViewController *m_workoutDaysViewController;
// GoalsViewController class object
GoalsViewController *m_goalsViewController;
// ExerciseLevelViewController class object
ExerciseLevelViewController *m_exerciseLevelViewController;
// MusicTracksViewController class object
MusicTracksViewController *m_musicTracksViewController;
// SupplementPlanViewController class object
SupplementPlanViewController *m_supplementPlanViewController;
// SupplementProfileViewController class object
SupplementProfileViewController *m_supplementProfileViewController;
// RootViewController class object
RootViewController *m_rootViewController;
// Supplement Check Instance object
SupplementCheck *m_supplementCheck;
// Database class object
Database *m_database;
// MealPlanSelectin class object
MealPlanSelection *m_mealPlanSelection;
// WorkoutSelection class object
WorkoutSelection *m_workoutSelection;
// ViewTransition class object
ViewTransitions *m_transition;
// ViewFactory class object
ViewFactory *m_controllerViews;
// WorkoutPlanManager class object
WorkoutPlanManager *m_workoutPlanManager;

// User status log string
NSString *m_logStatusString;
// NSCalendar object
NSCalendar *m_calendar;
// Today
NSDate *m_today;
// The selected date
NSDate *m_theSelectedDate;
// NSComponent object
NSDateComponents *m_components;
// To set NSDate to day
NSDateFormatter *m_dateFormatter;
// Days in the Week
NSMutableArray *m_theDaysOfTheWeek;
// Start day
int m_startDayInt;
// End day int
int m_endDayInt;
// Meal plan array
NSArray *m_mealPlanArray;
// Get calorie plist
NSMutableArray *m_calorieArray;
// Section Dictionary
NSMutableDictionary *m_currentDictionary;
// User email retrieved from Database
NSString *m_userEmailID;
// User exercise goal from database
NSString *m_goal;
// User gender from database
NSString *m_gender;
// User selected exercise days
NSMutableArray *m_daysArray;
// User first selected exercise day
NSString *m_first_Selected_Day;
// Workout Table or Meal Plan table
NSString *m_workOutOrMealPlanTable;
// The workout array
NSMutableArray *m_workoutArrayCalendar;
// Sports Activities list
NSMutableArray *m_sportsListCalendar;
// Sports List Images
NSMutableArray *m_sportsListImages;
// Sports or Other Exercises
NSString *m_sportsOrOtherExercises;
// if sports activity is opened when coming back from previous view
bool isSportsActivityViewIsOpened;
// Current selected day
NSString *m_current_Selected_Label;
// Current selected day int
int m_current_Selected_Int;
// Workout day number label
NSString *m_workoutDayNumberLabel;
// Non workout days suggestion
bool isANonWorkoutDay;

@synthesize monthLabel;
@synthesize firstLabel;
@synthesize secondLabel;
@synthesize thirdLabel;
@synthesize fourthLabel;
@synthesize fifthLabel;
@synthesize sixthLabel;
@synthesize seventhLabel;
// Selection Button
@synthesize selectionButton;
@synthesize firstLabelTapRecognizer;
@synthesize secondLabelTapRecognizer;
@synthesize thirdLabelTapRecognizer;
@synthesize fourthLabelTapRecognizer;
@synthesize fifthLabelTapRecognizer;
@synthesize sixthLabelTapRecognizer;
@synthesize seventhLabelTapRecognizer;
@synthesize firstLabelRightSwipeRecognizer;
@synthesize firstLabelLeftSwipeRecognizer;
@synthesize secondLabelRightSwipeRecognizer;
@synthesize secondLabelLeftSwipeRecognizer;
@synthesize thirdLabelRightSwipeRecognizer;
@synthesize thirdLabelLeftSwipeRecognizer;
@synthesize fourthLabelRightSwipeRecognizer;
@synthesize fourthLabelLeftSwipeRecognizer;
@synthesize fifthLabelLeftSwipeRecognizer;
@synthesize fifthLabelRightSwipeRecognizer;
@synthesize sixthLabelLeftSwipeRecognizer;
@synthesize sixthLabelRightSwipeRecognizer;
@synthesize seventhLabelLeftSwipeRecognizer;
@synthesize seventhLabelRightSwipeRecognizer;
@synthesize planSectionButton;
@synthesize mealPlanSectionButton;
@synthesize workOutPlanSectionButton;
@synthesize theTableView;
@synthesize indicatorView;
@synthesize bottomBarButton;
@synthesize musicPlayerButton;
@synthesize exercisePlanButton;
@synthesize calendarButton;
@synthesize mealPlanButton;
@synthesize nutritionPlanButton;
@synthesize selectedImage;
@synthesize createPlan;

/*
 Singleton CalenderViewController object
 */
+ (CalenderViewController *)sharedInstance {
	static CalenderViewController *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 Move to FoodProfileViewController
 */
- (void)moveToFoodProfileViewController:(id)sender
{
    if (!m_foodProfileViewController) {
        m_foodProfileViewController     = [FoodProfileViewController sharedInstance];
    }
    id instanceObject                   = m_foodProfileViewController;
    [self moveToView:m_foodProfileViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to ExerciseViewController
 */
- (void)moveToExerciseViewController:(id)sender
{
    if (!m_exerciseViewController) {
        m_exerciseViewController        = [ExerciseViewController sharedInstance];
    }
    
    id instanceObject                   = m_exerciseViewController;
    [self moveToView:m_exerciseViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
}

/*
 Move to MealViewController
 */
- (void)moveToMealViewController:(id)sender
{
    if (!m_mealViewController) {
        m_mealViewController        = [MealViewController sharedInstance];
    }
    id instanceObject               = m_mealViewController;
    [self moveToView:m_mealViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
}

/*
 Move to SupplementPlanViewController
 */
- (void)moveToSupplementPlanViewController:(id)sender
{
    if (!m_supplementPlanViewController) {
        m_supplementPlanViewController         = [SupplementPlanViewController sharedInstance];
    }
    id instanceObject               = m_supplementPlanViewController;
    m_supplementPlanViewController.view.tag     = 1;

    [self moveToView:m_supplementPlanViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
    
}

/*
 Move to ExerciseProfileViewController
 */
- (void)moveToExerciseProfileViewController:(id)sender
{
    if (!m_exerciseProfileViewController) {
        m_exerciseProfileViewController         = [ExerciseProfileViewController sharedInstance];
    }
    
    id instanceObject               = m_exerciseProfileViewController;
    [self moveToView:m_exerciseProfileViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to WorkOutDaysViewController
 */
- (void)moveToWorkOutDaysViewController:(id)sender
{
    if (!m_workoutDaysViewController) {
        m_workoutDaysViewController             = [WorkOutDaysViewController sharedInstance];
    }
    
    id instanceObject               = m_workoutDaysViewController;
    [self moveToView:m_workoutDaysViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to GoalsViewController
 */
- (void)moveToGoalsViewController:(id)sender
{
    if (!m_goalsViewController) {
        m_goalsViewController                   = [GoalsViewController sharedInstance];
    }
    id instanceObject               = m_goalsViewController;
    [self moveToView:m_goalsViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to ExerciseLevelViewController
 */
- (void)moveToExerciseLevelViewController:(id)sender
{
    if (!m_exerciseLevelViewController) {
        m_exerciseLevelViewController           = [ExerciseLevelViewController sharedInstance];
    }
    id instanceObject               = m_exerciseLevelViewController;
    [self moveToView:m_exerciseLevelViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];}

/*
 Move to MusicTracksViewController
 */
- (void)moveToMusicTracksViewController:(id)sender
{
    if (!m_musicTracksViewController) {
        m_musicTracksViewController         = [MusicTracksViewController sharedInstance];
    }
    id instanceObject               = m_musicTracksViewController;
    [self moveToView:m_musicTracksViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];

}

/*
 Move to MusicTracksViewController
 */
- (IBAction)moveToRootViewController:(id)sender
{
    if (!m_rootViewController) {
        m_rootViewController                = [RootViewController sharedInstance];
    }
    
    id instanceObject               = m_rootViewController;
    [self moveToView:m_rootViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to SupplementProfileViewController
 */
- (void)moveToSupplementProfileViewController:(id)sender
{
    if (!m_supplementProfileViewController) {
        m_supplementProfileViewController         = [SupplementProfileViewController sharedInstance];
    }
    id instanceObject               = m_supplementProfileViewController;
    [self moveToView:m_supplementProfileViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to supplements at website
 */
- (void)moveToSupplementsAtWebsite:(id)sender
{    
    NSURL *url                  = [[NSURL alloc] initWithString:@"http://totalfitness.com/supplements"];
    [[UIApplication sharedApplication] openURL:url];
}

/*
 If days, goals and exercise levels are not selected, go to them
 */
- (void)hasUserSelectedDaysGoalsAndLevels
{
    // Don't block main thread when doing the big data load up below
    // initialize the Queue if not already initialized
    // Don't block the main thread
    // Do any additional setup after loading the view.
    if (!m_database) {
        m_database              = [Database alloc];
    }
    if ([m_userEmailID length] == 0) {
        m_userEmailID           = [NSString getUserEmail];
    }
    if ([[m_database hasUserSelectedGoal:m_userEmailID] isEqualToString:@"YES"]) { // User has selected goal once
        if ([[m_database hasUserSelectedDays:m_userEmailID] isEqualToString:@"YES"]) { // User has selected days once
            if ([[m_database hasUserSelectedExerciseLevel:m_userEmailID] isEqualToString:@"YES"]) { // User has selected level once
                // Stay on the RootViewController
            }
            else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self moveToExerciseLevelViewController:self];
                });
            }
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self moveToWorkOutDaysViewController:self];
            });
        }
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self moveToGoalsViewController:self];
        });
    }
}

/*
 Move to Back or Home
 */
- (IBAction)goBackorGoHome:(id)sender
{
    if (!m_controllerViews) {
        m_controllerViews                           = [ViewFactory sharedInstance];
    }
    
    if (!m_transition) {
        m_transition                                = [ViewTransitions sharedInstance];
    }

    if(!isSportsActivityViewIsOpened) { // Sports list view is not opened
        // go to home
    }
    else if(isSportsActivityViewIsOpened) { // Or reload the data for workout exercises
        
        m_sportsOrOtherExercises             = @"";
        
        // Get food details from database
        [self getFoodDetails];
        
        if (!m_transition) {
            m_transition                     = [ViewTransitions sharedInstance];
        }
        [m_transition performTransitionFromLeft:self.theTableView];
        // Refresh the tableview
        [self.theTableView reloadData];
        
        // Sports list view is no longer opened
        isSportsActivityViewIsOpened         = NO;
    }
}

/*
 Get the days from the selected week
 */
- (NSMutableArray *)getDaysOfTheWeek:(int)startInt 
{
    if (m_theDaysOfTheWeek) {
        m_theDaysOfTheWeek    = nil;
    }
    m_theDaysOfTheWeek        = [NSMutableArray mutableArrayObject];
    
    NSString *nameOfTheDay    = @"";
    
    if (!m_calendar) {
        m_calendar                    = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    
    if (!m_today) {
        m_today                       = [NSDate date];
    }
    
    if (!m_components) {
        m_components                  = [[NSDateComponents alloc] init];
    }
    
    if (!m_dateFormatter) {
        m_dateFormatter               = [[NSDateFormatter alloc] init];
    }
    // Format to get day
    [m_dateFormatter setDateFormat:@"dd"];
    
    // Loop through to add each day
    for (int i = startInt; i <= startInt + 7; i++) {
        [m_components setDay:i];
        m_theSelectedDate                 = [m_calendar dateByAddingComponents:m_components toDate:m_today options:0];
        
        nameOfTheDay                      = [m_dateFormatter stringFromDate:m_theSelectedDate];
        
        // Get the day date of that day
        [m_theDaysOfTheWeek addObject:[NSString stringWithFormat:@"%d",[nameOfTheDay intValue]]];
    }
    return m_theDaysOfTheWeek;
}

/*
 Display days of the week
 */
- (void)displayDaysOfTheWeek:(NSMutableArray *)DaysOfTheWeek
{
    self.firstLabel.text    = [DaysOfTheWeek objectAtIndex:0];
    self.secondLabel.text   = [DaysOfTheWeek objectAtIndex:1];
    self.thirdLabel.text    = [DaysOfTheWeek objectAtIndex:2];
    self.fourthLabel.text   = [DaysOfTheWeek objectAtIndex:3];
    self.fifthLabel.text    = [DaysOfTheWeek objectAtIndex:4];
    self.sixthLabel.text    = [DaysOfTheWeek objectAtIndex:5];
    self.seventhLabel.text  = [DaysOfTheWeek objectAtIndex:6];
    
    [self.view setNeedsDisplay];
}

/*
 Get days from current week using weekdays of the month.
 This method is called only for the when view is loaded.
 */
- (void)getDaysFromCurrentWeekUsingWeekDayOfTheMonth
{
    // Calender
    NSCalendar *calendar;
    if (!calendar) {
        calendar                = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    // Today
    NSDate *today;
    
    if (!today) {
        today                   = [NSDate date];
    }
    
    NSDateComponents *components;
    
    if (!components) {
        components              = [[NSDateComponents alloc] init];
    }
    
    components                  = [calendar components: NSDayCalendarUnit | NSWeekdayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger weekday           = [components weekday];
    NSInteger month             = [components month];
    NSInteger year              = [components year];
    
    NSString * dateString = [NSString stringWithFormat: @"%ld", (long)month];
    
    if (!m_dateFormatter) {
        m_dateFormatter             = [[NSDateFormatter alloc] init];
    }
    [m_dateFormatter setDateFormat:@"MM"];
    NSDate* monthDate               = [m_dateFormatter dateFromString:dateString];
    
    NSDateFormatter *formatter;
    if (!formatter) {
        formatter                   = [[NSDateFormatter alloc] init];
    }
    
    [formatter setDateFormat:@"MMMM"];
    NSString *monthName         = [formatter stringFromDate:monthDate];
    
    // Display the month and year
    self.monthLabel.text        = [NSString stringWithFormat:@"%@ %ld", monthName, (long)year];
    
    NSMutableArray *daysOfTheWeek;
    if (!daysOfTheWeek) {
        daysOfTheWeek           = [NSMutableArray mutableArrayObject];
    }
    
    if (weekday == 2) { // Today is the second day of the week
        m_startDayInt     +=   0;
        [self displayDaysOfTheWeek:[self getDaysOfTheWeek:m_startDayInt]];
    }
    else if(weekday == 3) { // Today is the third day of the week
        m_startDayInt     +=    -1;
        [self displayDaysOfTheWeek:[self getDaysOfTheWeek:m_startDayInt]];
    }
    else if(weekday == 4) { // Today is the fourth day of the week
        m_startDayInt     +=    -2;
        [self displayDaysOfTheWeek:[self getDaysOfTheWeek:m_startDayInt]];
    }
    else if(weekday == 5) { // Today is the fifth day of the week
        m_startDayInt     +=    -3;
        [self displayDaysOfTheWeek:[self getDaysOfTheWeek:m_startDayInt]];
    }
    else if(weekday == 6) { // Today is the sixth day of the week
        m_startDayInt     +=    -4;
        [self displayDaysOfTheWeek:[self getDaysOfTheWeek:m_startDayInt]];
    }
    else if(weekday == 7) { // Today is the seventh day of the week
        m_startDayInt     +=    -5;
        [self displayDaysOfTheWeek:[self getDaysOfTheWeek:m_startDayInt]];
    }
    else if(weekday == 1) { // Today is the first day of the week
        m_startDayInt     +=    -6;
        [self displayDaysOfTheWeek:[self getDaysOfTheWeek:m_startDayInt]];
    }
}

/*
 Get the days from the selected week when swiped left or right
 */
- (void)getDaysOfTheSelectedWeek
{
    // increase days by week i.e 7 days
    [self displayDaysOfTheWeek:[self getDaysOfTheWeek:m_startDayInt]];
}

/*
 Perform Days transitions
 */
- (void)daysTransitions:(NSString *)leftOrRight
{
    if (!m_transition) {
        m_transition        = [ViewTransitions sharedInstance];
    }
    
    if ([leftOrRight isEqualToString:@"Right"]) {
        [m_transition performTransitionFromRight:self.firstLabel];
        [m_transition performTransitionFromRight:self.secondLabel];
        [m_transition performTransitionFromRight:self.fourthLabel];
        [m_transition performTransitionFromRight:self.fifthLabel];
        [m_transition performTransitionFromRight:self.sixthLabel];
        [m_transition performTransitionFromRight:self.seventhLabel];
    }
    else if([leftOrRight isEqualToString:@"Left"]) {
        [m_transition performTransitionFromLeft:self.firstLabel];
        [m_transition performTransitionFromLeft:self.secondLabel];
        [m_transition performTransitionFromLeft:self.fourthLabel];
        [m_transition performTransitionFromLeft:self.fifthLabel];
        [m_transition performTransitionFromLeft:self.sixthLabel];
        [m_transition performTransitionFromLeft:self.seventhLabel];
    }
}

/*
 Hide and show days
 */
- (void)daysHideAndShow:(NSString *)hideOrShow
{
    if ([hideOrShow isEqualToString:@"Hide"]) {
        self.firstLabel.hidden          = YES;
        self.secondLabel.hidden         = YES;
        self.thirdLabel.hidden          = YES;
        self.fourthLabel.hidden         = YES;
        self.fifthLabel.hidden          = YES;
        self.fifthLabel.hidden          = YES;
        self.sixthLabel.hidden          = YES;
        self.seventhLabel.hidden        = YES;
    }
    else if([hideOrShow isEqualToString:@"Show"]) {
        self.firstLabel.hidden          = NO;
        self.secondLabel.hidden         = NO;
        self.thirdLabel.hidden          = NO;
        self.fourthLabel.hidden         = NO;
        self.fifthLabel.hidden          = NO;
        self.fifthLabel.hidden          = NO;
        self.sixthLabel.hidden          = NO;
        self.seventhLabel.hidden        = NO;
    }
}

/*
 Select day by tapping
 */
- (IBAction)handleTap:(UITapGestureRecognizer *)sender
{
    // start indicator on tableview
    [self.indicatorView startAnimating];
    
    CGRect frame            = self.selectionButton.frame;
    // "1" is deducted to adjust for size diff between labels and the selector button
    if (sender == firstLabelTapRecognizer) {
        frame.origin.x           = firstLabel.frame.origin.x; // Postion selection button to the right label
        if ([m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]) {
            [self getFoodDetails]; // get Food details
        }
        else if([m_workOutOrMealPlanTable isEqualToString:@"Workout"]) {
            [self selectWorkoutBasedOnGoalAndSelectedDays:@"One" andDayInt:0]; // load up workout
        }
        m_current_Selected_Label     = @"One"; // set current label
        m_current_Selected_Int       = 0; // set current label
    }
    else if(sender == secondLabelTapRecognizer) {
        frame.origin.x               = secondLabel.frame.origin.x; // Postion selection button to the right label
        if ([m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]) {
            [self getFoodDetails]; // get Food details
        }
        else if([m_workOutOrMealPlanTable isEqualToString:@"Workout"]) {
            [self selectWorkoutBasedOnGoalAndSelectedDays:@"Two" andDayInt:1]; // load up workout
        }
        m_current_Selected_Label     = @"Two"; // set current label
        m_current_Selected_Int       = 1; // set current label
    }
    else if(sender == thirdLabelTapRecognizer) {
        frame.origin.x               = thirdLabel.frame.origin.x; // Postion selection button to the right label
        if ([m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]) {
            [self getFoodDetails]; // get Food details
        }
        else if([m_workOutOrMealPlanTable isEqualToString:@"Workout"]) {
            [self selectWorkoutBasedOnGoalAndSelectedDays:@"Three" andDayInt:2]; // load up workout
        }
        m_current_Selected_Label     = @"Three"; // set current label
        m_current_Selected_Int       = 2; // set current label
    }
    else if(sender == fourthLabelTapRecognizer) {
        frame.origin.x               = fourthLabel.frame.origin.x; // Postion selection button to the right label
        if ([m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]) {
            [self getFoodDetails]; // get Food details
        }
        else if([m_workOutOrMealPlanTable isEqualToString:@"Workout"]) {
            [self selectWorkoutBasedOnGoalAndSelectedDays:@"Four" andDayInt:3]; // load up workout
        }
        m_current_Selected_Label     = @"Four"; // set current label
        m_current_Selected_Int       = 3; // set current label
    }
    else if(sender == fifthLabelTapRecognizer) {
        frame.origin.x               = fifthLabel.frame.origin.x; // Postion selection button to the right label
        if ([m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]) {
            [self getFoodDetails]; // get Food details
        }
        else if([m_workOutOrMealPlanTable isEqualToString:@"Workout"]) {
            [self selectWorkoutBasedOnGoalAndSelectedDays:@"Five" andDayInt:4]; // load up workout
        }
        m_current_Selected_Label     = @"Five"; // set current label
        m_current_Selected_Int       = 4; // set current label
    }
    else if(sender == sixthLabelTapRecognizer) {
        frame.origin.x               = sixthLabel.frame.origin.x; // Postion selection button to the right label
        if ([m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]) {
            [self getFoodDetails]; // get Food details
        }
        else if([m_workOutOrMealPlanTable isEqualToString:@"Workout"]) {
            [self selectWorkoutBasedOnGoalAndSelectedDays:@"Six" andDayInt:5]; // load up workout
        }
        m_current_Selected_Label     = @"Six"; // set current label
        m_current_Selected_Int       = 5; // set current label
    }
    else if(sender == seventhLabelTapRecognizer) {
        frame.origin.x               = seventhLabel.frame.origin.x; // Postion selection button to the right label
        if ([m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]) {
            [self getFoodDetails]; // get Food details
        }
        else if([m_workOutOrMealPlanTable isEqualToString:@"Workout"]) {
            [self selectWorkoutBasedOnGoalAndSelectedDays:@"Seven" andDayInt:6]; // load up workout
        }

        m_current_Selected_Label     = @"Seven"; // set current label
        m_current_Selected_Int       = 6; // set current label
    }
    
    [self.theTableView reloadData]; // Refresh the table

    if (sender.state == UIGestureRecognizerStateEnded) {
        // Bring button to the selected position
        [UIView animateWithDuration:0.55 animations:^{
            self.selectionButton.alpha = 1.0;
            self.selectionButton.frame = CGRectMake((frame.origin.x + 4.5f), frame.origin.y, 35.0f, 35.0f); // Position the labels
        }];
    }
    // Refocus from the top
    [self.theTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

/*
 In response to left or right swipe gesture, day selector button selects day to the left or right.
 */
- (IBAction)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    
    CGRect frame            = self.selectionButton.frame;
    
    // For the background image, button width 49 and increment 46 is perfect.
    if ((recognizer == self.firstLabelRightSwipeRecognizer) || (recognizer == self.secondLabelRightSwipeRecognizer) || (recognizer == self.thirdLabelRightSwipeRecognizer) || (recognizer == self.fourthLabelRightSwipeRecognizer) || (recognizer == self.fifthLabelRightSwipeRecognizer) || (recognizer == self.sixthLabelRightSwipeRecognizer) || (recognizer == self.seventhLabelRightSwipeRecognizer)) { // Go to previous week
        [self daysHideAndShow:@"Hide"];
        frame.origin.x       = 0.0;
        m_startDayInt        += -7; // Change the week by adding or substracting 7 days
        [self getDaysOfTheSelectedWeek];
        [self daysTransitions:@"Left"];
        [self daysHideAndShow:@"Show"];
    }
    else if ((recognizer == self.firstLabelLeftSwipeRecognizer) || (recognizer == self.secondLabelLeftSwipeRecognizer) || (recognizer == self.thirdLabelLeftSwipeRecognizer) || (recognizer == self.fourthLabelLeftSwipeRecognizer) || (recognizer == self.fifthLabelLeftSwipeRecognizer) || (recognizer == self.sixthLabelLeftSwipeRecognizer) || (recognizer == self.seventhLabelLeftSwipeRecognizer)) { // Go to next week
        [self daysHideAndShow:@"Hide"];
        frame.origin.x       = 0.0;
        m_startDayInt        += 7; // Change the week by adding or substracting 7 days
        [self getDaysOfTheSelectedWeek];
        [self daysTransitions:@"Right"];
        [self daysHideAndShow:@"Show"];
    }
    
    // Bring button to the selected position
	[UIView animateWithDuration:0.55 animations:^{
        self.selectionButton.alpha = 1.0;
        self.selectionButton.frame           = CGRectMake((frame.origin.x + 4.5f), frame.origin.y, 35.0f, 35.0f); // Position the labels
    }];
}

/*
 Details of meal plan and work out plan for the day
 */
- (IBAction)planSection:(id)sender;
{
    if (!m_transition) {
        m_transition            = [ViewTransitions alloc];
    }

    if ((sender == self.mealPlanSectionButton) && ([m_workOutOrMealPlanTable isEqualToString:@"Workout"])) {
        [self.planSectionButton setBackgroundImage:[UIImage imageNamed:@"tfn_mealplan-active.png"] forState:UIControlStateNormal];
        // The view is meal plan table
        m_workOutOrMealPlanTable        = @"Meal Plan";
        self.createPlan.hidden           = YES;
        self.theTableView.hidden         = NO;
        [self getFoodDetails]; // get Food details
        [m_transition performTransitionFromRight:self.theTableView];
    }
    else if((sender == self.workOutPlanSectionButton)  && ([m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"])) {
        [self.planSectionButton setBackgroundImage:[UIImage imageNamed:@"tfn_workoutplan-active.png"] forState:UIControlStateNormal];
        // The view is meal plan table
        m_workOutOrMealPlanTable        = @"Workout";
        self.createPlan.hidden           = YES;
        self.theTableView.hidden         = NO;
        [self sportsListArray];
        [self selectWorkoutBasedOnGoalAndSelectedDays:m_current_Selected_Label andDayInt:m_current_Selected_Int];
        [m_transition performTransitionFromLeft:self.theTableView];
    }
    [[self theTableView] reloadData]; // refresh the tableview
    // Refocus from the top
    [self.theTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

/*
 Get Food details from the database
 */
- (void)getFoodDetails
{
    m_mealPlanArray         = [NSMutableArray loadUpMealPlan];
}

/*
 load up the right workout for the user
 */
- (void) selectWorkoutBasedOnGoalAndSelectedDays:(NSString *)day andDayInt:(int)dayInt;
{
    NSMutableArray *m_daysArray     = [m_database getLatestExerciseDays:[NSString getUserEmail]]; // Get latest selected days
    // Keep track of selected days
    if ([[m_daysArray objectAtIndex:dayInt] isEqualToString:@"YES"]) {
        // index of daysSelected is the day number
        m_workoutDayNumberLabel         = [NSString stringWithFormat:@"Day %@", day];
        if (![m_goal isEqualToString:@"MUSCLE ISOLATION"]) {
            m_workoutArrayCalendar              = nil;
            m_workoutArrayCalendar              = [NSMutableArray arrayWithArray:[NSMutableArray loadUpWorkoutPlan:day]];
        }
        else if([m_goal isEqualToString:@"MUSCLE ISOLATION"]) {
            m_workoutArrayCalendar          = [NSMutableArray mutableArrayObject];
            m_workoutArrayCalendar          = [NSMutableArray loadUpWorkoutPlan];
        }
        isANonWorkoutDay                = NO;
        m_sportsOrOtherExercises        = @"Non Sports Activity";
    }
    else {
        // Display sports and yoga if workout day not selected
        m_workoutDayNumberLabel         = @"Active Suggestions";
        m_sportsOrOtherExercises        = @"Sports Activity";
        m_sportsOrOtherExercises        = @"Sleep Benefits";
        isANonWorkoutDay                = YES;
    }
}

/*
 Add methods to each control buttons
 */
- (void)addSelectorToControlButtons
{
    // Set up the bottom bar control buttons
    NSMutableArray *controlButtonArrays = [self bottomBar:self.bottomBarButton MusicPlayerButton:self.musicPlayerButton ExercisePlanButton:self.exercisePlanButton Calendar:self.calendarButton MealPlan:self.mealPlanButton MoreButton:self.nutritionPlanButton InView:self.view];
    
    self.musicPlayerButton              = [controlButtonArrays objectAtIndex:1];
    // Add moveToMusicViewController method to move there
    [self.musicPlayerButton addTarget:self action:@selector(moveToMusicTracksViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    self.exercisePlanButton             = [controlButtonArrays objectAtIndex:2];
    // Add ExerciseViewController method to move there
    // Add moveToExerciseViewController method to move there
    [self.exercisePlanButton addTarget:self action:@selector(moveToExerciseViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    self.calendarButton                 = [controlButtonArrays objectAtIndex:3];
    // stay here
    
    self.mealPlanButton                 = [controlButtonArrays objectAtIndex:4];
    // Add moveToMealViewController method to move there
    [self.mealPlanButton addTarget:self action:@selector(moveToMealViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nutritionPlanButton                     = [controlButtonArrays objectAtIndex:5];
    // Add MoreViewController method to move there
    [self.nutritionPlanButton addTarget:self action:@selector(moveToSupplementsAtWebsite:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)positionSelectionButtonToTheFirstSelectedDay
{
    // Place this here to give more time to load up
    if (!m_userEmailID) {
        m_userEmailID       = [NSString getUserEmail];
    }
    m_daysArray             = [m_database getLatestExerciseDays:m_userEmailID]; // Get latest selected day
    
    CGRect frame;
    if (m_daysArray) {
        for (int i = 0; i < [m_daysArray count]; i++) {
            if ([[m_daysArray objectAtIndex:i] isEqualToString:@"YES"]) { // When we get the first selected day, quit the loop
                if (i == 0) {
                    m_first_Selected_Day    = @"One";
                    frame                   = self.firstLabel.frame;
                }
                else if(i == 1) {
                    m_first_Selected_Day    = @"Two";
                    frame                   = self.secondLabel.frame;
                }
                else if(i == 2) {
                    m_first_Selected_Day    = @"Three";
                    frame                   = self.thirdLabel.frame;
                }
                else if(i == 3) {
                    m_first_Selected_Day    = @"Four";
                    frame                   = self.fourthLabel.frame;
                }
                else if(i == 4) {
                    m_first_Selected_Day    = @"Five";
                    frame                   = self.fifthLabel.frame;
                }
                else if(i == 5) {
                    m_first_Selected_Day    = @"Six";
                    frame                   = self.sixthLabel.frame;
                }
                else if(i == 6) {
                    m_first_Selected_Day    = @"Seven";
                    frame                   = self.seventhLabel.frame;
                }
                break;
            }
        }
    }
    frame                                           = CGRectMake(5.0f+1.0f, 111.0f + 1.0f, 35.0f, 35.0f);
    self.selectionButton                            = [[UIButton alloc] initWithFrame:frame];
    [self.selectionButton setBackgroundImage:[UIImage imageNamed:@"tfn_calender-dayselector.png"] forState:UIControlStateNormal];
    self.selectionButton.userInteractionEnabled     = NO;
    self.selectionButton.hidden                     = NO;
    self.selectionButton.frame                      = frame;
    [self.view addSubview:self.selectionButton];
    [self.view sendSubviewToBack:self.selectionButton];

    m_current_Selected_Label                        = m_first_Selected_Day; // set current selected label
}

/*
 Upload sports list
 */
- (void)sportsListArray
{
    // initialize the sports list array
    if (!m_sportsListCalendar) {
        m_sportsListCalendar                = [NSMutableArray sportsList];
    }
    // initialize the sports list images
    m_sportsListImages                      = [NSMutableArray getImages:m_sportsListCalendar forPlan:@"Workout"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_workoutDayNumberLabel     = @"Day 1"; // Default view is the Day 1
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // adjust view and tableview size for iphone5
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        // adjust the height of the tableview and readd the indicator view
        self.theTableView       = [self adjustiPhone5HeightOfTableView:self.theTableView ForController:self];
        [self.view addSubview:self.theTableView];
    }
    // Set fonts for the days and month
    self.monthLabel.font        = [UIFont customFontWithSize:15];
    self.firstLabel.font        = [UIFont customFontWithSize:15];
    self.secondLabel.font       = [UIFont customFontWithSize:15];
    self.thirdLabel.font        = [UIFont customFontWithSize:15];
    self.fourthLabel.font       = [UIFont customFontWithSize:15];
    self.fifthLabel.font        = [UIFont customFontWithSize:15];
    self.sixthLabel.font        = [UIFont customFontWithSize:15];
    self.seventhLabel.font      = [UIFont customFontWithSize:15];

    // start indicator view on the tableview
    [self.indicatorView startAnimating];
    
    // Set up current week days
    [self getDaysFromCurrentWeekUsingWeekDayOfTheMonth];
    
    // Add selectors to control buttons
    [self addSelectorToControlButtons];

    // Initial position of the selection button
    [self positionSelectionButtonToTheFirstSelectedDay];

}

- (void)viewWillAppear:(BOOL)animated
{
    if (!m_database) {
        m_database                      = [Database alloc];
    }
    m_userEmailID                       = [NSString getUserEmail];

    m_goal                              = [m_database getLatestExerciseGoal:m_userEmailID];
    
    m_gender                            = [NSString getGenderOfUser];
    // check if those are selected here, to go to the respective view quicker
//    [self hasUserSelectedDaysGoalsAndLevels];

    // Default table data selection view is meal plan
    m_workOutOrMealPlanTable            = @"Meal Plan";
    
    [self.planSectionButton setBackgroundImage:[UIImage imageNamed:@"tfn_mealplan-active.png"] forState:UIControlStateNormal];

    if (![m_sportsOrOtherExercises isEqualToString:@"Non Sports Activity"]) { // if coming from non sports exercise profile
    }
    
    // Select calorie for the first selected day
    [self getFoodDetails];

    self.createPlan.hidden           = YES;
    self.theTableView.hidden         = NO;

    // Refresh the tableview
    [self.theTableView reloadData];

    [self.createPlan addTarget:self action:@selector(moveToInAppStoreViewController:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSource
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Stop the indicatorview when cells are to be loaded
    [self.indicatorView stopAnimating];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView;
    headerView              = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    UILabel *label          = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];

    if ([m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]) { // The table view is meal plan table view
        if (section == 0) {
            label.text        = @"  Breakfast Shake";
        }
        else if(section == 1) {
            label.text        = @"  Morning Snack";
        }
        else if(section == 2) {
            label.text        = @"  Lunch";
        }
        else if(section == 3) {
            label.text        = @"  Afternoon Snack";
        }
        else if(section == 4) {
            label.text        = @"  Dinner";
        }
        else if(section == 5) {
            label.text        = @"  Evening Snack";
        }
    }
    else if ([m_workOutOrMealPlanTable isEqualToString:@"Workout"]) {
        if ([m_current_Selected_Label isEqualToString:@"Seven"]) {
            return headerView;
        }
        if ([m_goal isEqualToString:@"MUSCLE ISOLATION"]) {
            if (section == 0) {
                label.text        = @"  Abs";
            }
            else if(section == 1) {
                label.text        = @"  Legs";
            }
            else if(section == 2) {
                label.text        = @"  Chest";
            }
            else if(section == 3) {
                label.text        = @"  Back";
            }
            else if(section == 4) {
                label.text        = @"  Shoulder";
            }
            else if(section == 5) {
                label.text        = @"  Arms";
            }
        }
        else { // Other goals
            
            if (![m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
                label.text              = [NSString stringWithFormat:@"    %@", m_workoutDayNumberLabel];
            }
            else if([m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
                label.text              = @"    Sports";
                
            }
        }
    }
    label.textAlignment         = NSTextAlignmentLeft;
    label.textColor             = [UIColor redColor];
    label.backgroundColor       = [UIColor clearColor];
    label.font                  = [UIFont customFontWithSize:16];
    [headerView addSubview:label];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    CGRect sepFrame = CGRectMake(0, headerView.frame.size.height-1, 320, 1);
    UIView *seperatorView = [[UIView alloc] initWithFrame:sepFrame];
    seperatorView.backgroundColor = [UIColor redColor];
    [headerView addSubview:seperatorView];
    
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int numberOfSections                    = 0;
    if ([m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]) {
        return numberOfSections             = 6;
        // Stop the indicatorview when cells are to be loaded
        [self.indicatorView stopAnimating];
    }
    else if([m_workOutOrMealPlanTable isEqualToString:@"Workout"]){
        if ([m_current_Selected_Label isEqualToString:@"Seven"]) {
            return numberOfSections         = 0;
        }
        if ([m_goal isEqualToString:@"MUSCLE ISOLATION"]) {
            return numberOfSections         = 6;
        }
        else { // Other Goals, same for non-sports exercises and sports exercises
            return numberOfSections         = 1;
        }
    }
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRowsInSection       = 1;
    if (([m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"])) { // if the tableview is meal plan table view
        return numberOfRowsInSection    = [[[m_mealPlanArray objectAtIndex:section] objectAtIndex:0] count];
    }
    else if([m_workOutOrMealPlanTable isEqualToString:@"Workout"]) { // Workout View has only one section
        if ([m_current_Selected_Label isEqualToString:@"Seven"]) {
            return numberOfRowsInSection       = 0;
        }
        if ([m_goal isEqualToString:@"MUSCLE ISOLATION"]) { // Need to show this goal's exercises as under headings of each parts of the muscle
            return numberOfRowsInSection    = [[[m_workoutArrayCalendar objectAtIndex:section] objectAtIndex:0] count];
        }
        else { // Other goals            
            if (![m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
                if (isANonWorkoutDay) { // show sports as suggestions
                    return numberOfRowsInSection    = [m_workoutArrayCalendar count];
                }
                else {
                    return numberOfRowsInSection    = [[m_workoutArrayCalendar objectAtIndex:0] count];
                }
            }
            else if([m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
                return numberOfRowsInSection        = [m_sportsListCalendar count];
            }
        }
    }
    return numberOfRowsInSection;
}

- (UIImage *)imageWithFilename:(NSString *)filename
{
    NSString *path;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	path = [paths[0] stringByAppendingPathComponent:@""];
	path = [path stringByAppendingPathComponent:filename];
    
    return [UIImage imageWithContentsOfFile:path];
}

/*
 Cell contents such as images, items and measurement displayed
 */
- (void)cellContents:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath WithImageArray:(NSMutableArray *)imageArray AndKeyArray:(NSMutableArray *)keyArray AndValueArray:(NSMutableArray *)valueArray
{
    
    if([m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]){
        UIImage *cellImage                                  = nil;
        
        // If imageArray is less than indexpath, it will give error
        if (([imageArray count] >= indexPath.row) && ([imageArray count] > 0)) {
            cellImage                                       = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];     // Find the right image
        }
        ((UIImageView *)[cell viewWithTag:1]).image         = cellImage;
        if (!cellImage) { // If the there is no image displayed then, there isn't any food item for that
            cell.accessoryType                              = UITableViewCellAccessoryNone;
            [cell setUserInteractionEnabled:NO];
        }
        else if(indexPath.section == 6) { // Total calories cell should be interaction disabled
            cell.accessoryType                              = UITableViewCellAccessoryNone;
            [cell setUserInteractionEnabled:NO];
        }
        else { // Cell the set have the accessory and interaction as well to avoid remaining disabled from the above if
            cell.accessoryType                              = UITableViewCellAccessoryDisclosureIndicator;
            [cell setUserInteractionEnabled:YES];
        }
        if (([keyArray count] >= indexPath.row) && ([keyArray count] > 0)) { // Prevent crashing if workout plan not purchased
            if ((![[keyArray objectAtIndex:indexPath.row] isEqualToString:@"Empty Space"])) {
                ((UILabel *)[cell viewWithTag:2]).text          = [keyArray objectAtIndex:indexPath.row];
            }
            else {
                ((UILabel *)[cell viewWithTag:2]).text          = @"";
            }
        }
        if (!isANonWorkoutDay) {
            if (([valueArray count] >= indexPath.row) && ([valueArray count] > 0)) { // Prevent crashing if workout plan not purchased
                if (![[valueArray objectAtIndex:indexPath.row] isEqualToString:@"Empty Space"]) {
                    ((UILabel *)[cell viewWithTag:3]).text          = [valueArray objectAtIndex:indexPath.row];
                }
                else {
                    ((UILabel *)[cell viewWithTag:3]).text          = @"";
                }
            }
        }
        else {
            ((UILabel *)[cell viewWithTag:3]).text          = @"";
        }
        
    }
    else if([m_workOutOrMealPlanTable isEqualToString:@"Workout"]){
        UIImage *cellImage                                  = nil;
        
        // If imageArray is less than indexpath, it will give error
        if (([imageArray count] >= indexPath.row) && ([imageArray count] > 0)) {
            cellImage                                       = [self imageWithFilename:imageArray[indexPath.row]];
            //[UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];     // Find the right image
        }
        ((UIImageView *)[cell viewWithTag:1]).image         = cellImage;
        if (!cellImage) { // If the there is no image displayed then, there isn't any food item for that
            cell.accessoryType                              = UITableViewCellAccessoryNone;
            [cell setUserInteractionEnabled:NO];
        }
        else if(indexPath.section == 6) { // Total calories cell should be interaction disabled
            cell.accessoryType                              = UITableViewCellAccessoryNone;
            [cell setUserInteractionEnabled:NO];
        }
        else { // Cell the set have the accessory and interaction as well to avoid remaining disabled from the above if
            cell.accessoryType                              = UITableViewCellAccessoryDisclosureIndicator;
            [cell setUserInteractionEnabled:YES];
        }
        if (([keyArray count] >= indexPath.row) && ([keyArray count] > 0)) { // Prevent crashing if workout plan not purchased
            if ((![[keyArray objectAtIndex:indexPath.row] isEqualToString:@"Empty Space"])) {
                ((UILabel *)[cell viewWithTag:2]).text          = [keyArray objectAtIndex:indexPath.row];
            }
            else {
                ((UILabel *)[cell viewWithTag:2]).text          = @"";
            }
        }
        if (!isANonWorkoutDay) {
            if (([valueArray count] >= indexPath.row) && ([valueArray count] > 0)) { // Prevent crashing if workout plan not purchased
                if (![[valueArray objectAtIndex:indexPath.row] isEqualToString:@"Empty Space"]) {
                    ((UILabel *)[cell viewWithTag:3]).text          = [valueArray objectAtIndex:indexPath.row];
                }
                else {
                    ((UILabel *)[cell viewWithTag:3]).text          = @"";
                }
            }
        }
        else {
            ((UILabel *)[cell viewWithTag:3]).text          = @"";
        }
        
    }
}

/*
 Each section has its own images, key and value arrays
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if (([m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"])) {
        [self cellContents:cell atIndexPath:indexPath WithImageArray:[[m_mealPlanArray objectAtIndex:indexPath.section] objectAtIndex:0] AndKeyArray:[[m_mealPlanArray objectAtIndex:indexPath.section] objectAtIndex:1] AndValueArray:[[m_mealPlanArray objectAtIndex:indexPath.section] objectAtIndex:2]];
    }
    else if([m_workOutOrMealPlanTable isEqualToString:@"Workout"]) { // Only one section
        if (![m_goal isEqualToString:@"MUSCLE ISOLATION"]) { // Muscle Isolation IS not the goal
            if (![m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
                [self cellContents:cell atIndexPath:indexPath WithImageArray:[m_workoutArrayCalendar objectAtIndex:0] AndKeyArray:[m_workoutArrayCalendar objectAtIndex:1] AndValueArray:[m_workoutArrayCalendar objectAtIndex:2]];
            }
            else if([m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
                [self cellContents:cell atIndexPath:indexPath WithImageArray:m_sportsListImages AndKeyArray:m_sportsListCalendar AndValueArray:nil];
            }
        }
        else { // GOAL IS MUSCLE ISOLATION
            if (![m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
                if (indexPath.section == 0) { // Abs section
                    [self cellContents:cell atIndexPath:indexPath WithImageArray:[[m_workoutArrayCalendar objectAtIndex:0] objectAtIndex:0] AndKeyArray:[[m_workoutArrayCalendar objectAtIndex:0] objectAtIndex:1] AndValueArray:[[m_workoutArrayCalendar objectAtIndex:0] objectAtIndex:2]];
                }
                if (indexPath.section == 1) { // Legs section
                    [self cellContents:cell atIndexPath:indexPath WithImageArray:[[m_workoutArrayCalendar objectAtIndex:1] objectAtIndex:0] AndKeyArray:[[m_workoutArrayCalendar objectAtIndex:1] objectAtIndex:1] AndValueArray:[[m_workoutArrayCalendar objectAtIndex:1] objectAtIndex:2]];
                }
                if (indexPath.section == 2) { // Chest section
                    [self cellContents:cell atIndexPath:indexPath WithImageArray:[[m_workoutArrayCalendar objectAtIndex:2] objectAtIndex:0] AndKeyArray:[[m_workoutArrayCalendar objectAtIndex:2] objectAtIndex:1] AndValueArray:[[m_workoutArrayCalendar objectAtIndex:2] objectAtIndex:2]];
                }
                if (indexPath.section == 3) { // Back section
                    [self cellContents:cell atIndexPath:indexPath WithImageArray:[[m_workoutArrayCalendar objectAtIndex:3] objectAtIndex:0] AndKeyArray:[[m_workoutArrayCalendar objectAtIndex:3] objectAtIndex:1] AndValueArray:[[m_workoutArrayCalendar objectAtIndex:3] objectAtIndex:2]];
                }
                if (indexPath.section == 4) { // Shoulder section
                    [self cellContents:cell atIndexPath:indexPath WithImageArray:[[m_workoutArrayCalendar objectAtIndex:4] objectAtIndex:0] AndKeyArray:[[m_workoutArrayCalendar objectAtIndex:4] objectAtIndex:1] AndValueArray:[[m_workoutArrayCalendar objectAtIndex:4] objectAtIndex:2]];
                }
                if (indexPath.section == 5) { // Arms section
                    [self cellContents:cell atIndexPath:indexPath WithImageArray:[[m_workoutArrayCalendar objectAtIndex:5] objectAtIndex:0] AndKeyArray:[[m_workoutArrayCalendar objectAtIndex:5] objectAtIndex:1] AndValueArray:[[m_workoutArrayCalendar objectAtIndex:5] objectAtIndex:2]];
                }
                if (indexPath.section == 6) {
                    [self cellContents:cell atIndexPath:indexPath WithImageArray:[[m_workoutArrayCalendar objectAtIndex:6] objectAtIndex:0] AndKeyArray:[[m_workoutArrayCalendar objectAtIndex:6] objectAtIndex:1] AndValueArray:[[m_workoutArrayCalendar objectAtIndex:6] objectAtIndex:2]];
                }
            }
            else if ([m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
                [self cellContents:cell atIndexPath:indexPath WithImageArray:m_sportsListImages AndKeyArray:m_sportsListCalendar AndValueArray:nil];
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CalenderIdentifier            = @"CalenderIdentifier";
    UITableViewCell *cell                          = [tableView dequeueReusableCellWithIdentifier:CalenderIdentifier];
    
    if (cell == nil) {
        cell                                       = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CalenderIdentifier];
        cell.backgroundColor                       = [UIColor whiteColor];

        UIImageView *theImageView                  = [[UIImageView alloc] initWithFrame: CGRectMake(0,5,75,75)];
        theImageView.tag                           = 1; 
        [cell.contentView addSubview:theImageView];
        
        UILabel *theTextLabel                      = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 215, 60)];
        theTextLabel.font                          = [UIFont customFontWithSize:15];
        theTextLabel.lineBreakMode                 = NSLineBreakByWordWrapping;
        theTextLabel.numberOfLines                 = 3;
        theTextLabel.textAlignment                 = NSTextAlignmentLeft;
        theTextLabel.textColor                     = [UIColor blackColor];
        theTextLabel.tag                           = 2; 
        [cell.contentView addSubview:theTextLabel];
        
        UILabel *theDetailTextLabel                = [[UILabel alloc] initWithFrame:CGRectMake(85, 45, 215, 20)];
        
        theDetailTextLabel.font                    = [UIFont customFontWithSize:11];
        theDetailTextLabel.lineBreakMode           = NSLineBreakByWordWrapping;
        theDetailTextLabel.numberOfLines           = 2;
        theDetailTextLabel.textAlignment           = NSTextAlignmentLeft;
        theDetailTextLabel.textColor               = [UIColor blackColor];
        theDetailTextLabel.tag                     = 3; 
        [cell.contentView addSubview:theDetailTextLabel];
        
    }
    // Configure the cell.
    
    // Neccessary to use tag to add content to avoid overwritting by reference the imageview and label outside the if(cell == nil) statement
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float heightForRow                  = 80.0f;
    return heightForRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    float heightForHeaderSection        = 30.0f;
    return heightForHeaderSection;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedSupplement;
    if (selectedSupplement) {
        selectedSupplement      = nil;
    }
    
    if (!m_supplementCheck) {
        m_supplementCheck           = [SupplementCheck sharedInstance];
    }
    
    if (self.selectedImage) {
        self.selectedImage      = nil;
    }
    
    if (([m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"])) { // if the tableview is meal plan table view, send image relating to food
        
        selectedSupplement         = [[[m_mealPlanArray objectAtIndex:indexPath.section] objectAtIndex:0]  objectAtIndex:indexPath.row];
        
        if ([m_supplementCheck checkSupplementItemExist:selectedSupplement]) { // if the selected item is supplement
                [NSString setSupplementImageName:selectedSupplement];
                [self moveToSupplementProfileViewController:self];
        }
        else {
            // assign image for the next view
            self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[[[m_mealPlanArray objectAtIndex:indexPath.section] objectAtIndex:0]  objectAtIndex:indexPath.row]];
            // Move to FoodProfileViewController
            [self moveToFoodProfileViewController:indexPath];
        }
    
    }
    else if([m_workOutOrMealPlanTable isEqualToString:@"Workout"]) { // if the tableview is workout table view, send image relating to workout
        
        if(![m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
            if (![m_goal isEqualToString:@"MUSCLE ISOLATION"]) { // GOAL IS Not MUSCLE ISOLATION
                // assign image for the next view
              self.selectedImage               = [[NSString alloc ] initWithFormat:@"%@",[[m_workoutArrayCalendar objectAtIndex:0] objectAtIndex:indexPath.row]];
            }
            else { // GOAL IS MUSCLE ISOLATION
                if (indexPath.section == 0) {
                    // assign image for the next view
                    self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[[[m_workoutArrayCalendar objectAtIndex:0] objectAtIndex:0] objectAtIndex:indexPath.row]];
                }
                else if(indexPath.section == 1) {
                    // assign image for the next view
                    self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[[[m_workoutArrayCalendar objectAtIndex:1] objectAtIndex:0] objectAtIndex:indexPath.row]];
                    
                }
                else if(indexPath.section == 2) {
                    // assign image for the next view
                    self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[[[m_workoutArrayCalendar objectAtIndex:2] objectAtIndex:0] objectAtIndex:indexPath.row]];
                }
                else if(indexPath.section == 3) {
                    // assign image for the next view
                    self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[[[m_workoutArrayCalendar objectAtIndex:3] objectAtIndex:0] objectAtIndex:indexPath.row]];
                    
                }
                else if(indexPath.section == 4) {
                    // assign image for the next view
                    self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[[[m_workoutArrayCalendar objectAtIndex:4] objectAtIndex:0] objectAtIndex:indexPath.row]];
                    
                }
                else if(indexPath.section == 5) {
                    // assign image for the next view
                    self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[[[m_workoutArrayCalendar objectAtIndex:5] objectAtIndex:0] objectAtIndex:indexPath.row]];
                    
                }
            }
            // Sport list view is not opened
            isSportsActivityViewIsOpened       = NO;
        }
        else if([m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
            self.selectedImage                 = [[NSString alloc ] initWithFormat:@"%@",[m_sportsListImages  objectAtIndex:indexPath.row]];
            // Sport list is opened
            isSportsActivityViewIsOpened       = YES;
        }
        
        // Check if selected row is sports
        if ([self.selectedImage rangeOfString:@"sports_activity"].location == NSNotFound) {
            
            if (!isSportsActivityViewIsOpened) { // if sports list view is not opened, it must be other exercises
                m_sportsOrOtherExercises       = @"Non Sports Activity";
            }
            // Move to ExerciseProfileViewController
            [self moveToExerciseProfileViewController:indexPath];
        } else { // selected row is sports activity
            
            // Sport list is opened
            isSportsActivityViewIsOpened       = YES;

            m_sportsOrOtherExercises           = @"Sports Activity";
            
            // Load up the sports activity list
            [self sportsListArray];
            
            if (!m_transition) {
                m_transition                    = [ViewTransitions sharedInstance];
            }
            [m_transition performTransitionFromLeft:self.theTableView];
            // Load up the sports list images
            [[self theTableView] reloadData];
        }
    }
    // Unselect the row
    [[self theTableView] deselectRowAtIndexPath:indexPath animated:YES];
}

@end
