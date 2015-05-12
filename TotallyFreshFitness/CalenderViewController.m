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
//
// ProfileViewController class object
@property (strong, nonatomic) ProfileViewController *m_profileViewController;
@property (strong, nonatomic) FoodProfileViewController *m_foodProfileViewController;
@property (strong, nonatomic) ExerciseViewController *m_exerciseViewController;
@property (strong, nonatomic) MealViewController *m_mealViewController;
@property (strong, nonatomic) ExerciseProfileViewController *m_exerciseProfileViewController;
@property (strong, nonatomic) WorkOutDaysViewController *m_workoutDaysViewController;
@property (strong, nonatomic) GoalsViewController *m_goalsViewController;
@property (strong, nonatomic) ExerciseLevelViewController *m_exerciseLevelViewController;
@property (strong, nonatomic) MusicTracksViewController *m_musicTracksViewController;
@property (strong, nonatomic) SupplementPlanViewController *m_supplementPlanViewController;
@property (strong, nonatomic) SupplementProfileViewController *m_supplementProfileViewController;
@property (strong, nonatomic) RootViewController *m_rootViewController;
@property (strong, nonatomic) SupplementCheck *m_supplementCheck;
@property (strong, nonatomic) Database *m_database;
@property (strong, nonatomic) MealPlanSelection *m_mealPlanSelection;
@property (strong, nonatomic) WorkoutSelection *m_workoutSelection;
@property (strong, nonatomic) ViewTransitions *m_transition;
@property (strong, nonatomic) ViewFactory *m_controllerViews;
@property (strong, nonatomic) WorkoutPlanManager *m_workoutPlanManager;
@property (strong, nonatomic) NSString *m_logStatusString;
@property (strong, nonatomic) NSCalendar *m_calendar;
@property (strong, nonatomic) NSDate *m_today;
@property (strong, nonatomic) NSDate *m_theSelectedDate;
@property (strong, nonatomic) NSDateComponents *m_components;
@property (strong, nonatomic) NSDateFormatter *m_dateFormatter;
@property (strong, nonatomic) NSMutableArray *m_theDaysOfTheWeek;
@property (nonatomic) int m_startDayInt;
@property (nonatomic) int m_endDayInt;
@property (strong, nonatomic) NSArray *m_mealPlanArray;
@property (strong, nonatomic) NSMutableArray *m_calorieArray;
@property (strong, nonatomic) NSMutableDictionary *m_currentDictionary;
@property (strong, nonatomic)NSString *m_userEmailID;
@property (strong, nonatomic)NSString *m_goal;
@property (strong, nonatomic)NSString *m_gender;
@property (strong, nonatomic)NSMutableArray *m_daysArray;
@property (strong, nonatomic)NSString *m_first_Selected_Day;
@property (strong, nonatomic)NSString *m_workOutOrMealPlanTable;
@property (strong, nonatomic)NSMutableArray *m_workoutArrayCalendar;
@property (strong, nonatomic)NSMutableArray *m_sportsListCalendar;
@property (strong, nonatomic)NSMutableArray *m_sportsListImages;
@property (strong, nonatomic)NSString *m_sportsOrOtherExercises;
@property (nonatomic)BOOL isSportsActivityViewIsOpened;
@property (strong, nonatomic)NSString *m_current_Selected_Label;
@property (nonatomic)int m_current_Selected_Int;
@property (strong, nonatomic)NSString *m_workoutDayNumberLabel;
@property (nonatomic)BOOL isANonWorkoutDay;



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
    if (!self.m_foodProfileViewController) {
        self.m_foodProfileViewController     = [FoodProfileViewController sharedInstance];
    }
    id instanceObject                   = self.m_foodProfileViewController;
    [self moveToView:self.m_foodProfileViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to ExerciseViewController
 */
- (void)moveToExerciseViewController:(id)sender
{
    if (!self.m_exerciseViewController) {
        self.m_exerciseViewController        = [ExerciseViewController sharedInstance];
    }
    
    id instanceObject                   = self.m_exerciseViewController;
    [self moveToView:self.m_exerciseViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
}

/*
 Move to MealViewController
 */
- (void)moveToMealViewController:(id)sender
{
    if (!self.m_mealViewController) {
        self.m_mealViewController        = [MealViewController sharedInstance];
    }
    id instanceObject               = self.m_mealViewController;
    [self moveToView:self.m_mealViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
}

/*
 Move to SupplementPlanViewController
 */
- (void)moveToSupplementPlanViewController:(id)sender
{
    if (!self.m_supplementPlanViewController) {
        self.m_supplementPlanViewController         = [SupplementPlanViewController sharedInstance];
    }
    id instanceObject               = self.m_supplementPlanViewController;
    self.m_supplementPlanViewController.view.tag     = 1;

    [self moveToView:self.m_supplementPlanViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
    
}

/*
 Move to ExerciseProfileViewController
 */
- (void)moveToExerciseProfileViewController:(id)sender
{
    if (!self.m_exerciseProfileViewController) {
        self.m_exerciseProfileViewController         = [ExerciseProfileViewController sharedInstance];
    }
    
    id instanceObject               = self.m_exerciseProfileViewController;
    [self moveToView:self.m_exerciseProfileViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to WorkOutDaysViewController
 */
- (void)moveToWorkOutDaysViewController:(id)sender
{
    if (!self.m_workoutDaysViewController) {
        self.m_workoutDaysViewController             = [WorkOutDaysViewController sharedInstance];
    }
    
    id instanceObject               = self.m_workoutDaysViewController;
    [self moveToView:self.m_workoutDaysViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to GoalsViewController
 */
- (void)moveToGoalsViewController:(id)sender
{
    if (!self.m_goalsViewController) {
        self.m_goalsViewController                   = [GoalsViewController sharedInstance];
    }
    id instanceObject               = self.m_goalsViewController;
    [self moveToView:self.m_goalsViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to ExerciseLevelViewController
 */
- (void)moveToExerciseLevelViewController:(id)sender
{
    if (!self.m_exerciseLevelViewController) {
        self.m_exerciseLevelViewController           = [ExerciseLevelViewController sharedInstance];
    }
    id instanceObject               = self.m_exerciseLevelViewController;
    [self moveToView:self.m_exerciseLevelViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];}

/*
 Move to MusicTracksViewController
 */
- (void)moveToMusicTracksViewController:(id)sender
{
    if (!self.m_musicTracksViewController) {
        self.m_musicTracksViewController         = [MusicTracksViewController sharedInstance];
    }
    id instanceObject               = self.m_musicTracksViewController;
    [self moveToView:self.m_musicTracksViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];

}

/*
 Move to MusicTracksViewController
 */
- (IBAction)moveToRootViewController:(id)sender
{
    if (!self.m_rootViewController) {
        self.m_rootViewController                = [RootViewController sharedInstance];
    }
    
    id instanceObject               = self.m_rootViewController;
    [self moveToView:self.m_rootViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to SupplementProfileViewController
 */
- (void)moveToSupplementProfileViewController:(id)sender
{
    if (!self.m_supplementProfileViewController) {
        self.m_supplementProfileViewController         = [SupplementProfileViewController sharedInstance];
    }
    id instanceObject               = self.m_supplementProfileViewController;
    [self moveToView:self.m_supplementProfileViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
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
    if (!self.m_database) {
        self.m_database              = [Database alloc];
    }
    if ([self.m_userEmailID length] == 0) {
        self.m_userEmailID           = [NSString getUserEmail];
    }
    if ([[self.m_database hasUserSelectedGoal:self.m_userEmailID] isEqualToString:@"YES"]) { // User has selected goal once
        if ([[self.m_database hasUserSelectedDays:self.m_userEmailID] isEqualToString:@"YES"]) { // User has selected days once
            if ([[self.m_database hasUserSelectedExerciseLevel:self.m_userEmailID] isEqualToString:@"YES"]) { // User has selected level once
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
    if (!self.m_controllerViews) {
        self.m_controllerViews                           = [ViewFactory sharedInstance];
    }
    
    if (!self.m_transition) {
        self.m_transition                                = [ViewTransitions sharedInstance];
    }

    if(!self.isSportsActivityViewIsOpened) { // Sports list view is not opened
        // go to home
    }
    else if(self.isSportsActivityViewIsOpened) { // Or reload the data for workout exercises
        
        self.m_sportsOrOtherExercises             = @"";
        
        // Get food details from database
        [self getFoodDetails];
        
        if (!self.m_transition) {
            self.m_transition                     = [ViewTransitions sharedInstance];
        }
        [self.m_transition performTransitionFromLeft:self.theTableView];
        // Refresh the tableview
        [self.theTableView reloadData];
        
        // Sports list view is no longer opened
        self.isSportsActivityViewIsOpened         = NO;
    }
}

/*
 Get the days from the selected week
 */
- (NSMutableArray *)getDaysOfTheWeek:(int)startInt 
{
    if (self.m_theDaysOfTheWeek) {
        self.m_theDaysOfTheWeek    = nil;
    }
    self.m_theDaysOfTheWeek        = [NSMutableArray mutableArrayObject];
    
    NSString *nameOfTheDay    = @"";
    
    if (!self.m_calendar) {
        self.m_calendar                    = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    
    if (!self.m_today) {
        self.m_today                       = [NSDate date];
    }
    
    if (!self.m_components) {
        self.m_components                  = [[NSDateComponents alloc] init];
    }
    
    if (!self.m_dateFormatter) {
        self.m_dateFormatter               = [[NSDateFormatter alloc] init];
    }
    // Format to get day
    [self.m_dateFormatter setDateFormat:@"dd"];
    
    // Loop through to add each day
    for (int i = startInt; i <= startInt + 7; i++) {
        [self.m_components setDay:i];
        self.m_theSelectedDate                 = [self.m_calendar dateByAddingComponents:self.m_components toDate:self.m_today options:0];
        
        nameOfTheDay                      = [self.m_dateFormatter stringFromDate:self.m_theSelectedDate];
        
        // Get the day date of that day
        [self.m_theDaysOfTheWeek addObject:[NSString stringWithFormat:@"%d",[nameOfTheDay intValue]]];
    }
    return self.m_theDaysOfTheWeek;
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
    
    if (!self.m_dateFormatter) {
        self.m_dateFormatter             = [[NSDateFormatter alloc] init];
    }
    [self.m_dateFormatter setDateFormat:@"MM"];
    NSDate* monthDate               = [self.m_dateFormatter dateFromString:dateString];
    
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
        self.m_startDayInt     +=   0;
        [self displayDaysOfTheWeek:[self getDaysOfTheWeek:self.m_startDayInt]];
    }
    else if(weekday == 3) { // Today is the third day of the week
        self.m_startDayInt     +=    -1;
        [self displayDaysOfTheWeek:[self getDaysOfTheWeek:self.m_startDayInt]];
    }
    else if(weekday == 4) { // Today is the fourth day of the week
        self.m_startDayInt     +=    -2;
        [self displayDaysOfTheWeek:[self getDaysOfTheWeek:self.m_startDayInt]];
    }
    else if(weekday == 5) { // Today is the fifth day of the week
        self.m_startDayInt     +=    -3;
        [self displayDaysOfTheWeek:[self getDaysOfTheWeek:self.m_startDayInt]];
    }
    else if(weekday == 6) { // Today is the sixth day of the week
        self.m_startDayInt     +=    -4;
        [self displayDaysOfTheWeek:[self getDaysOfTheWeek:self.m_startDayInt]];
    }
    else if(weekday == 7) { // Today is the seventh day of the week
        self.m_startDayInt     +=    -5;
        [self displayDaysOfTheWeek:[self getDaysOfTheWeek:self.m_startDayInt]];
    }
    else if(weekday == 1) { // Today is the first day of the week
        self.m_startDayInt     +=    -6;
        [self displayDaysOfTheWeek:[self getDaysOfTheWeek:self.m_startDayInt]];
    }
}

/*
 Get the days from the selected week when swiped left or right
 */
- (void)getDaysOfTheSelectedWeek
{
    // increase days by week i.e 7 days
    [self displayDaysOfTheWeek:[self getDaysOfTheWeek:self.m_startDayInt]];
}

/*
 Perform Days transitions
 */
- (void)daysTransitions:(NSString *)leftOrRight
{
    if (!self.m_transition) {
        self.m_transition        = [ViewTransitions sharedInstance];
    }
    
    if ([leftOrRight isEqualToString:@"Right"]) {
        [self.m_transition performTransitionFromRight:self.firstLabel];
        [self.m_transition performTransitionFromRight:self.secondLabel];
        [self.m_transition performTransitionFromRight:self.fourthLabel];
        [self.m_transition performTransitionFromRight:self.fifthLabel];
        [self.m_transition performTransitionFromRight:self.sixthLabel];
        [self.m_transition performTransitionFromRight:self.seventhLabel];
    }
    else if([leftOrRight isEqualToString:@"Left"]) {
        [self.m_transition performTransitionFromLeft:self.firstLabel];
        [self.m_transition performTransitionFromLeft:self.secondLabel];
        [self.m_transition performTransitionFromLeft:self.fourthLabel];
        [self.m_transition performTransitionFromLeft:self.fifthLabel];
        [self.m_transition performTransitionFromLeft:self.sixthLabel];
        [self.m_transition performTransitionFromLeft:self.seventhLabel];
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
        if ([self.m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]) {
            [self getFoodDetails]; // get Food details
        }
        else if([self.m_workOutOrMealPlanTable isEqualToString:@"Workout"]) {
            [self selectWorkoutBasedOnGoalAndSelectedDays:@"One" andDayInt:0]; // load up workout
        }
        self.m_current_Selected_Label     = @"One"; // set current label
        self.m_current_Selected_Int       = 0; // set current label
    }
    else if(sender == secondLabelTapRecognizer) {
        frame.origin.x               = secondLabel.frame.origin.x; // Postion selection button to the right label
        if ([self.m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]) {
            [self getFoodDetails]; // get Food details
        }
        else if([self.m_workOutOrMealPlanTable isEqualToString:@"Workout"]) {
            [self selectWorkoutBasedOnGoalAndSelectedDays:@"Two" andDayInt:1]; // load up workout
        }
        self.m_current_Selected_Label     = @"Two"; // set current label
        self.m_current_Selected_Int       = 1; // set current label
    }
    else if(sender == thirdLabelTapRecognizer) {
        frame.origin.x               = thirdLabel.frame.origin.x; // Postion selection button to the right label
        if ([self.m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]) {
            [self getFoodDetails]; // get Food details
        }
        else if([self.m_workOutOrMealPlanTable isEqualToString:@"Workout"]) {
            [self selectWorkoutBasedOnGoalAndSelectedDays:@"Three" andDayInt:2]; // load up workout
        }
        self.m_current_Selected_Label     = @"Three"; // set current label
        self.m_current_Selected_Int       = 2; // set current label
    }
    else if(sender == fourthLabelTapRecognizer) {
        frame.origin.x               = fourthLabel.frame.origin.x; // Postion selection button to the right label
        if ([self.m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]) {
            [self getFoodDetails]; // get Food details
        }
        else if([self.m_workOutOrMealPlanTable isEqualToString:@"Workout"]) {
            [self selectWorkoutBasedOnGoalAndSelectedDays:@"Four" andDayInt:3]; // load up workout
        }
        self.m_current_Selected_Label     = @"Four"; // set current label
        self.m_current_Selected_Int       = 3; // set current label
    }
    else if(sender == fifthLabelTapRecognizer) {
        frame.origin.x               = fifthLabel.frame.origin.x; // Postion selection button to the right label
        if ([self.m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]) {
            [self getFoodDetails]; // get Food details
        }
        else if([self.m_workOutOrMealPlanTable isEqualToString:@"Workout"]) {
            [self selectWorkoutBasedOnGoalAndSelectedDays:@"Five" andDayInt:4]; // load up workout
        }
        self.m_current_Selected_Label     = @"Five"; // set current label
        self.m_current_Selected_Int       = 4; // set current label
    }
    else if(sender == sixthLabelTapRecognizer) {
        frame.origin.x               = sixthLabel.frame.origin.x; // Postion selection button to the right label
        if ([self.m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]) {
            [self getFoodDetails]; // get Food details
        }
        else if([self.m_workOutOrMealPlanTable isEqualToString:@"Workout"]) {
            [self selectWorkoutBasedOnGoalAndSelectedDays:@"Six" andDayInt:5]; // load up workout
        }
        self.m_current_Selected_Label     = @"Six"; // set current label
        self.m_current_Selected_Int       = 5; // set current label
    }
    else if(sender == seventhLabelTapRecognizer) {
        frame.origin.x               = seventhLabel.frame.origin.x; // Postion selection button to the right label
        if ([self.m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]) {
            [self getFoodDetails]; // get Food details
        }
        else if([self.m_workOutOrMealPlanTable isEqualToString:@"Workout"]) {
            [self selectWorkoutBasedOnGoalAndSelectedDays:@"Seven" andDayInt:6]; // load up workout
        }

        self.m_current_Selected_Label     = @"Seven"; // set current label
        self.m_current_Selected_Int       = 6; // set current label
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
        self.m_startDayInt        += -7; // Change the week by adding or substracting 7 days
        [self getDaysOfTheSelectedWeek];
        [self daysTransitions:@"Left"];
        [self daysHideAndShow:@"Show"];
    }
    else if ((recognizer == self.firstLabelLeftSwipeRecognizer) || (recognizer == self.secondLabelLeftSwipeRecognizer) || (recognizer == self.thirdLabelLeftSwipeRecognizer) || (recognizer == self.fourthLabelLeftSwipeRecognizer) || (recognizer == self.fifthLabelLeftSwipeRecognizer) || (recognizer == self.sixthLabelLeftSwipeRecognizer) || (recognizer == self.seventhLabelLeftSwipeRecognizer)) { // Go to next week
        [self daysHideAndShow:@"Hide"];
        frame.origin.x       = 0.0;
        self.m_startDayInt        += 7; // Change the week by adding or substracting 7 days
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
    if (!self.m_transition) {
        self.m_transition            = [ViewTransitions alloc];
    }

    if ((sender == self.mealPlanSectionButton) && ([self.m_workOutOrMealPlanTable isEqualToString:@"Workout"])) {
        [self.planSectionButton setBackgroundImage:[UIImage imageNamed:@"tfn_mealplan-active.png"] forState:UIControlStateNormal];
        // The view is meal plan table
        self.m_workOutOrMealPlanTable        = @"Meal Plan";
        self.createPlan.hidden           = YES;
        self.theTableView.hidden         = NO;
        [self getFoodDetails]; // get Food details
        [self.m_transition performTransitionFromRight:self.theTableView];
    }
    else if((sender == self.workOutPlanSectionButton)  && ([self.m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"])) {
        [self.planSectionButton setBackgroundImage:[UIImage imageNamed:@"tfn_workoutplan-active.png"] forState:UIControlStateNormal];
        // The view is meal plan table
        self.m_workOutOrMealPlanTable        = @"Workout";
        self.createPlan.hidden           = YES;
        self.theTableView.hidden         = NO;
        [self sportsListArray];
        [self selectWorkoutBasedOnGoalAndSelectedDays:self.m_current_Selected_Label andDayInt:self.m_current_Selected_Int];
        [self.m_transition performTransitionFromLeft:self.theTableView];
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
    self.m_mealPlanArray         = [NSMutableArray loadUpMealPlan];
}

/*
 load up the right workout for the user
 */
- (void) selectWorkoutBasedOnGoalAndSelectedDays:(NSString *)day andDayInt:(int)dayInt;
{
    NSMutableArray *m_daysArray     = [self.m_database getLatestExerciseDays:[NSString getUserEmail]]; // Get latest selected days
    // Keep track of selected days
    if ([[m_daysArray objectAtIndex:dayInt] isEqualToString:@"YES"]) {
        // index of daysSelected is the day number
        self.m_workoutDayNumberLabel         = [NSString stringWithFormat:@"Day %@", day];
        if (![self.m_goal isEqualToString:@"MUSCLE ISOLATION"]) {
            self.m_workoutArrayCalendar              = nil;
            self.m_workoutArrayCalendar              = [NSMutableArray arrayWithArray:[NSMutableArray loadUpWorkoutPlan:day]];
        }
        else if([self.m_goal isEqualToString:@"MUSCLE ISOLATION"]) {
            self.m_workoutArrayCalendar          = [NSMutableArray mutableArrayObject];
            self.m_workoutArrayCalendar          = [NSMutableArray loadUpWorkoutPlan];
        }
        self.isANonWorkoutDay                = NO;
        self.m_sportsOrOtherExercises        = @"Non Sports Activity";
    }
    else {
        // Display sports and yoga if workout day not selected
        self.m_workoutDayNumberLabel         = @"Active Suggestions";
        self.m_sportsOrOtherExercises        = @"Sports Activity";
        self.m_sportsOrOtherExercises        = @"Sleep Benefits";
        self.isANonWorkoutDay                = YES;
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
    if (!self.m_userEmailID) {
        self.m_userEmailID       = [NSString getUserEmail];
    }
    self.m_daysArray             = [self.m_database getLatestExerciseDays:self.m_userEmailID]; // Get latest selected day
    
    CGRect frame;
    if (self.m_daysArray) {
        for (int i = 0; i < [self.m_daysArray count]; i++) {
            if ([[self.m_daysArray objectAtIndex:i] isEqualToString:@"YES"]) { // When we get the first selected day, quit the loop
                if (i == 0) {
                    self.m_first_Selected_Day    = @"One";
                    frame                   = self.firstLabel.frame;
                }
                else if(i == 1) {
                    self.m_first_Selected_Day    = @"Two";
                    frame                   = self.secondLabel.frame;
                }
                else if(i == 2) {
                    self.m_first_Selected_Day    = @"Three";
                    frame                   = self.thirdLabel.frame;
                }
                else if(i == 3) {
                    self.m_first_Selected_Day    = @"Four";
                    frame                   = self.fourthLabel.frame;
                }
                else if(i == 4) {
                    self.m_first_Selected_Day    = @"Five";
                    frame                   = self.fifthLabel.frame;
                }
                else if(i == 5) {
                    self.m_first_Selected_Day    = @"Six";
                    frame                   = self.sixthLabel.frame;
                }
                else if(i == 6) {
                    self.m_first_Selected_Day    = @"Seven";
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

    self.m_current_Selected_Label                        = self.m_first_Selected_Day; // set current selected label
}

/*
 Upload sports list
 */
- (void)sportsListArray
{
    // initialize the sports list array
    if (!self.m_sportsListCalendar) {
        self.m_sportsListCalendar                = [NSMutableArray sportsList];
    }
    // initialize the sports list images
    self.m_sportsListImages                      = [NSMutableArray getImages:self.m_sportsListCalendar forPlan:@"Workout"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.m_workoutDayNumberLabel     = @"Day 1"; // Default view is the Day 1
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
    if (!self.m_database) {
        self.m_database                      = [Database alloc];
    }
    self.m_userEmailID                       = [NSString getUserEmail];

    self.m_goal                              = [self.m_database getLatestExerciseGoal:self.m_userEmailID];
    
    self.m_gender                            = [NSString getGenderOfUser];
    // check if those are selected here, to go to the respective view quicker
//    [self hasUserSelectedDaysGoalsAndLevels];

    // Default table data selection view is meal plan
    self.m_workOutOrMealPlanTable            = @"Meal Plan";
    
    [self.planSectionButton setBackgroundImage:[UIImage imageNamed:@"tfn_mealplan-active.png"] forState:UIControlStateNormal];

    if (![self.m_sportsOrOtherExercises isEqualToString:@"Non Sports Activity"]) { // if coming from non sports exercise profile
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

    if ([self.m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]) { // The table view is meal plan table view
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
    else if ([self.m_workOutOrMealPlanTable isEqualToString:@"Workout"]) {
        if ([self.m_current_Selected_Label isEqualToString:@"Seven"]) {
            return headerView;
        }
        if ([self.m_goal isEqualToString:@"MUSCLE ISOLATION"]) {
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
            
            if (![self.m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
                label.text              = [NSString stringWithFormat:@"    %@", self.m_workoutDayNumberLabel];
            }
            else if([self.m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
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
    if ([self.m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]) {
        return numberOfSections             = 6;
        // Stop the indicatorview when cells are to be loaded
        [self.indicatorView stopAnimating];
    }
    else if([self.m_workOutOrMealPlanTable isEqualToString:@"Workout"]){
        if ([self.m_current_Selected_Label isEqualToString:@"Seven"]) {
            return numberOfSections         = 0;
        }
        if ([self.m_goal isEqualToString:@"MUSCLE ISOLATION"]) {
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
    if (([self.m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"])) { // if the tableview is meal plan table view
        return numberOfRowsInSection    = [[[self.m_mealPlanArray objectAtIndex:section] objectAtIndex:0] count];
    }
    else if([self.m_workOutOrMealPlanTable isEqualToString:@"Workout"]) { // Workout View has only one section
        if ([self.m_current_Selected_Label isEqualToString:@"Seven"]) {
            return numberOfRowsInSection       = 0;
        }
        if ([self.m_goal isEqualToString:@"MUSCLE ISOLATION"]) { // Need to show this goal's exercises as under headings of each parts of the muscle
            return numberOfRowsInSection    = [[[self.m_workoutArrayCalendar objectAtIndex:section] objectAtIndex:0] count];
        }
        else { // Other goals            
            if (![self.m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
                if (self.isANonWorkoutDay) { // show sports as suggestions
                    return numberOfRowsInSection    = [self.m_workoutArrayCalendar count];
                }
                else {
                    return numberOfRowsInSection    = [[self.m_workoutArrayCalendar objectAtIndex:0] count];
                }
            }
            else if([self.m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
                return numberOfRowsInSection        = [self.m_sportsListCalendar count];
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
    
    if([self.m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"]){
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
        if (!self.isANonWorkoutDay) {
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
    else if([self.m_workOutOrMealPlanTable isEqualToString:@"Workout"]){
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
        if (!self.isANonWorkoutDay) {
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
    if (([self.m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"])) {
        [self cellContents:cell atIndexPath:indexPath WithImageArray:[[self.m_mealPlanArray objectAtIndex:indexPath.section] objectAtIndex:0] AndKeyArray:[[self.m_mealPlanArray objectAtIndex:indexPath.section] objectAtIndex:1] AndValueArray:[[self.m_mealPlanArray objectAtIndex:indexPath.section] objectAtIndex:2]];
    }
    else if([self.m_workOutOrMealPlanTable isEqualToString:@"Workout"]) { // Only one section
        if (![self.m_goal isEqualToString:@"MUSCLE ISOLATION"]) { // Muscle Isolation IS not the goal
            if (![self.m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
                [self cellContents:cell atIndexPath:indexPath WithImageArray:[self.m_workoutArrayCalendar objectAtIndex:0] AndKeyArray:[self.m_workoutArrayCalendar objectAtIndex:1] AndValueArray:[self.m_workoutArrayCalendar objectAtIndex:2]];
            }
            else if([self.m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
                [self cellContents:cell atIndexPath:indexPath WithImageArray:self.m_sportsListImages AndKeyArray:self.m_sportsListCalendar AndValueArray:nil];
            }
        }
        else { // GOAL IS MUSCLE ISOLATION
            if (![self.m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
                if (indexPath.section == 0) { // Abs section
                    [self cellContents:cell atIndexPath:indexPath WithImageArray:[[self.m_workoutArrayCalendar objectAtIndex:0] objectAtIndex:0] AndKeyArray:[[self.m_workoutArrayCalendar objectAtIndex:0] objectAtIndex:1] AndValueArray:[[self.m_workoutArrayCalendar objectAtIndex:0] objectAtIndex:2]];
                }
                if (indexPath.section == 1) { // Legs section
                    [self cellContents:cell atIndexPath:indexPath WithImageArray:[[self.m_workoutArrayCalendar objectAtIndex:1] objectAtIndex:0] AndKeyArray:[[self.m_workoutArrayCalendar objectAtIndex:1] objectAtIndex:1] AndValueArray:[[self.m_workoutArrayCalendar objectAtIndex:1] objectAtIndex:2]];
                }
                if (indexPath.section == 2) { // Chest section
                    [self cellContents:cell atIndexPath:indexPath WithImageArray:[[self.m_workoutArrayCalendar objectAtIndex:2] objectAtIndex:0] AndKeyArray:[[self.m_workoutArrayCalendar objectAtIndex:2] objectAtIndex:1] AndValueArray:[[self.m_workoutArrayCalendar objectAtIndex:2] objectAtIndex:2]];
                }
                if (indexPath.section == 3) { // Back section
                    [self cellContents:cell atIndexPath:indexPath WithImageArray:[[self.m_workoutArrayCalendar objectAtIndex:3] objectAtIndex:0] AndKeyArray:[[self.m_workoutArrayCalendar objectAtIndex:3] objectAtIndex:1] AndValueArray:[[self.m_workoutArrayCalendar objectAtIndex:3] objectAtIndex:2]];
                }
                if (indexPath.section == 4) { // Shoulder section
                    [self cellContents:cell atIndexPath:indexPath WithImageArray:[[self.m_workoutArrayCalendar objectAtIndex:4] objectAtIndex:0] AndKeyArray:[[self.m_workoutArrayCalendar objectAtIndex:4] objectAtIndex:1] AndValueArray:[[self.m_workoutArrayCalendar objectAtIndex:4] objectAtIndex:2]];
                }
                if (indexPath.section == 5) { // Arms section
                    [self cellContents:cell atIndexPath:indexPath WithImageArray:[[self.m_workoutArrayCalendar objectAtIndex:5] objectAtIndex:0] AndKeyArray:[[self.m_workoutArrayCalendar objectAtIndex:5] objectAtIndex:1] AndValueArray:[[self.m_workoutArrayCalendar objectAtIndex:5] objectAtIndex:2]];
                }
                if (indexPath.section == 6) {
                    [self cellContents:cell atIndexPath:indexPath WithImageArray:[[self.m_workoutArrayCalendar objectAtIndex:6] objectAtIndex:0] AndKeyArray:[[self.m_workoutArrayCalendar objectAtIndex:6] objectAtIndex:1] AndValueArray:[[self.m_workoutArrayCalendar objectAtIndex:6] objectAtIndex:2]];
                }
            }
            else if ([self.m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
                [self cellContents:cell atIndexPath:indexPath WithImageArray:self.m_sportsListImages AndKeyArray:self.m_sportsListCalendar AndValueArray:nil];
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
    
    if (!self.m_supplementCheck) {
        self.m_supplementCheck           = [SupplementCheck sharedInstance];
    }
    
    if (self.selectedImage) {
        self.selectedImage      = nil;
    }
    
    if (([self.m_workOutOrMealPlanTable isEqualToString:@"Meal Plan"])) { // if the tableview is meal plan table view, send image relating to food
        
        selectedSupplement         = [[[self.m_mealPlanArray objectAtIndex:indexPath.section] objectAtIndex:0]  objectAtIndex:indexPath.row];
        
        if ([self.m_supplementCheck checkSupplementItemExist:selectedSupplement]) { // if the selected item is supplement
                [NSString setSupplementImageName:selectedSupplement];
                [self moveToSupplementProfileViewController:self];
        }
        else {
            // assign image for the next view
            self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[[[self.m_mealPlanArray objectAtIndex:indexPath.section] objectAtIndex:0]  objectAtIndex:indexPath.row]];
            // Move to FoodProfileViewController
            [self moveToFoodProfileViewController:indexPath];
        }
    
    }
    else if([self.m_workOutOrMealPlanTable isEqualToString:@"Workout"]) { // if the tableview is workout table view, send image relating to workout
        
        if(![self.m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
            if (![self.m_goal isEqualToString:@"MUSCLE ISOLATION"]) { // GOAL IS Not MUSCLE ISOLATION
                // assign image for the next view
              self.selectedImage               = [[NSString alloc ] initWithFormat:@"%@",[[self.m_workoutArrayCalendar objectAtIndex:0] objectAtIndex:indexPath.row]];
            }
            else { // GOAL IS MUSCLE ISOLATION
                if (indexPath.section == 0) {
                    // assign image for the next view
                    self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[[[self.m_workoutArrayCalendar objectAtIndex:0] objectAtIndex:0] objectAtIndex:indexPath.row]];
                }
                else if(indexPath.section == 1) {
                    // assign image for the next view
                    self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[[[self.m_workoutArrayCalendar objectAtIndex:1] objectAtIndex:0] objectAtIndex:indexPath.row]];
                    
                }
                else if(indexPath.section == 2) {
                    // assign image for the next view
                    self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[[[self.m_workoutArrayCalendar objectAtIndex:2] objectAtIndex:0] objectAtIndex:indexPath.row]];
                }
                else if(indexPath.section == 3) {
                    // assign image for the next view
                    self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[[[self.m_workoutArrayCalendar objectAtIndex:3] objectAtIndex:0] objectAtIndex:indexPath.row]];
                    
                }
                else if(indexPath.section == 4) {
                    // assign image for the next view
                    self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[[[self.m_workoutArrayCalendar objectAtIndex:4] objectAtIndex:0] objectAtIndex:indexPath.row]];
                    
                }
                else if(indexPath.section == 5) {
                    // assign image for the next view
                    self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[[[self.m_workoutArrayCalendar objectAtIndex:5] objectAtIndex:0] objectAtIndex:indexPath.row]];
                    
                }
            }
            // Sport list view is not opened
            self.isSportsActivityViewIsOpened       = NO;
        }
        else if([self.m_sportsOrOtherExercises isEqualToString:@"Sports Activity"]) {
            self.selectedImage                 = [[NSString alloc ] initWithFormat:@"%@",[self.m_sportsListImages  objectAtIndex:indexPath.row]];
            // Sport list is opened
            self.isSportsActivityViewIsOpened       = YES;
        }
        
        // Check if selected row is sports
        if ([self.selectedImage rangeOfString:@"sports_activity"].location == NSNotFound) {
            
            if (!self.isSportsActivityViewIsOpened) { // if sports list view is not opened, it must be other exercises
                self.m_sportsOrOtherExercises       = @"Non Sports Activity";
            }
            // Move to ExerciseProfileViewController
            [self moveToExerciseProfileViewController:indexPath];
        } else { // selected row is sports activity
            
            // Sport list is opened
            self.isSportsActivityViewIsOpened       = YES;

            self.m_sportsOrOtherExercises           = @"Sports Activity";
            
            // Load up the sports activity list
            [self sportsListArray];
            
            if (!self.m_transition) {
                self.m_transition                    = [ViewTransitions sharedInstance];
            }
            [self.m_transition performTransitionFromLeft:self.theTableView];
            // Load up the sports list images
            [[self theTableView] reloadData];
        }
    }
    // Unselect the row
    [[self theTableView] deselectRowAtIndexPath:indexPath animated:YES];
}

@end
