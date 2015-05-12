//
//  WorkOutDaysViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-06.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "WorkOutDaysViewController.h"
#import "ResultViewController.h"
#import "WorkoutPlanManager.h"
#import "FirstDayWorkoutPlanManager.h"
#import "SecondDayWorkoutPlanManager.h"
#import "ThirdDayWorkoutPlanManager.h"
#import "FourthDayWorkoutPlanManager.h"
#import "FifthDayWorkoutPlanManager.h"
#import "SixthDayWorkoutPlanManager.h"
#import "SeventhDayWorkoutPlanManager.h"
#import "WorkoutSelection.h"
#import "GoalsViewController.h"

@interface WorkOutDaysViewController ()

// Display message to user
- (void)displayMessage:(NSString *)message;
//Save workout plan into database
- (void)saveWorkoutPlanIntoDatabase;
@end
// ResultViewController class object
ResultViewController *m_resultViewController;
// ViewFactory class object
ViewFactory *m_controllerViews;
// ViewTransitions clas object
ViewTransitions *m_transition;
// Database class object
Database *m_database;
// WorkoutSelection class object
WorkoutSelection *m_workoutSelection;
// WorkoutPlanManager class object
WorkoutPlanManager *m_workoutPlanManager;
// GoalsViewController class object
GoalsViewController *m_goalsViewController;
// Previous Button
UIButton *m_previousButton;

// Help pop up button
UIButton *m_helpPopUpButtonViewInWorkoutDaysview;
// NSUserDefault
NSUserDefaults *userDefaults;

// All the days
NSMutableArray *m_daysMutableArray;
// Days default value is "NO"
NSString *m_Monday      = @"NO";
NSString *m_Tuesday     = @"NO";
NSString *m_Wednesday   = @"NO";
NSString *m_Thursday    = @"NO";
NSString *m_Friday      = @"NO";
NSString *m_Saturday    = @"NO";
NSString *m_Sunday      = @"NO";

// Tick buttons
UIButton *m_mondayButton;
UIButton *m_tuesdayButton;
UIButton *m_wednesdayButton;
UIButton *m_thursdayButton;
UIButton *m_fridayButton;
UIButton *m_saturdayButton;
UIButton *m_sundayButton;

// Day numbers
int m_MondayNumber      = 0;
int m_TuesdayNumber     = 1;
int m_WednesdayNumber   = 2;
int m_ThursdayNumber    = 3;
int m_FridayNumber      = 4;
int m_SaturdayNumber    = 5;
int m_SundayNumber      = 6;

// User email id
NSString *m_userEmailID;
// User goal
NSString *m_goal;
// Total number of days selected
NSInteger m_totalNumberOfDaysSelected;
// Workout array
NSMutableArray *m_workoutArray;

// Buttons
UIButton *m_monday;
UIButton *m_tuesday;
UIButton *m_wednesday;
UIButton *m_thursday;
UIButton *m_friday;
UIButton *m_saturday;
UIButton *m_sunday;
UIButton *m_nextButton;

// Labels
UILabel *m_mondayLabel;
UILabel *m_tuesdayLabel;
UILabel *m_wednesdayLabel;
UILabel *m_thursdayLabel;
UILabel *m_fridayLabel;
UILabel *m_saturdayLabel;
UILabel *m_sundayLabel;

// Buttons
UIButton *m_mondayTickButton;
UIButton *m_tuesdayTickButton;
UIButton *m_wednesdayTickButton;
UIButton *m_thursdayTickButton;
UIButton *m_fridayTickButton;
UIButton *m_saturdayTickButton;
UIButton *m_sundayTickButton;

@implementation WorkOutDaysViewController

@synthesize messageButton;
@synthesize backgroundImageView;

/*
 Singleton WorkOutDaysViewController object
 */
+ (WorkOutDaysViewController *)sharedInstance {
	static WorkOutDaysViewController *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 Move to the previous view
 */
- (IBAction)moveToPreviousViewController:(id)sender
{
    if (!m_transition) {
        m_transition                    = [ViewTransitions sharedInstance];
    }
    [m_transition performTransitionFromRight:self.view.superview];
    [self.view removeFromSuperview];
}

/*
 Move to ResultViewController
 */
- (void)moveToResultViewController:(id)sender
{
    if (!m_resultViewController) {
        m_resultViewController                  = [ResultViewController sharedInstance];
    }
    id instanceObject               = m_resultViewController;
    [self moveToView:m_resultViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to GoalsViewController
 */
- (void)moveToGoalsViewController:(id)sender
{
    if (!m_goalsViewController) {
        m_goalsViewController       = [GoalsViewController sharedInstance];
    }
    id instanceObject               = m_goalsViewController;
    [self moveToView:m_goalsViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Display message to user with animation
 */
- (void)displayMessage:(NSString *)message
{
    self.messageButton.hidden  = NO;
    
    [UIButton animateWithDuration:3.0f animations:^{self.messageButton.alpha = 5.0;} completion:nil];
    
    [self.messageButton setTitle:message forState:UIControlStateNormal];
    
    if (!m_transition) {
        m_transition    = [ViewTransitions sharedInstance];
    }
    [m_transition performTransitionFromBottom:self.messageButton];
    
    [UIButton animateWithDuration:5.0f animations:^{self.messageButton.alpha = 0.0;} completion:nil];
}

/*
 Exercise days selection
 */
- (void)exerciseDaysSelected:(id)sender
{
    if (([m_Monday length] != 0) || ([m_Tuesday length] != 0) || ([m_Wednesday length] != 0) || ([m_Thursday length] != 0) || ([m_Friday length] != 0) || ([m_Saturday length] != 0) || ([m_Sunday length] != 0)) { // If atleast one day is selected
        NSString *daysStatus            = @"";
        NSDate *date                    = [NSDate date];
        
        // Save selections in the database
        if (!m_database) {
            m_database                  = [Database alloc];
        }
        daysStatus                      = [m_database insertIntoExerciseDaysEmail_Id:m_userEmailID Date:date Monday:m_Monday Tuesday:m_Tuesday Wednesday:m_Wednesday Thursday:m_Thursday Friday:m_Friday Saturday:m_Saturday Sunday:m_Sunday];
        
        if ([daysStatus isEqualToString:@"updated"]) {
            // Save the workout plan into database
            [self saveWorkoutPlanIntoDatabase];
            [self moveToResultViewController:self];
        }
        else {
            [self displayMessage:@"We failed save to your days, please try later"];
        }
     }
    else { // No days selected
        [self displayMessage:@"Please select atleast one workout day."];
    }
}

// Change the text color to red or black
- (void)changeTextColor:(UIButton *)sender
{
    if (sender.tag == 0) {
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    else {
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

// Monday button click
- (void)clickMonday:(UIButton *)sender
{
    [self changeTextColor:m_monday];
    if (m_monday.tag == 0) {
        m_monday.tag = 1;
        m_Monday            = @"YES";
        [m_mondayButton setBackgroundImage:[UIImage imageNamed:@"grocery_selected.png"] forState:UIControlStateNormal];
        m_totalNumberOfDaysSelected++;
    }
    else {
        m_monday.tag = 0;
        m_Monday            = @"NO";
        [m_mondayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        m_totalNumberOfDaysSelected--;
    }
}

// Tuesday button click
- (void)clickTuesday:(UIButton *)sender
{
    [self changeTextColor:m_tuesday];
    if (m_tuesday.tag == 0) {
        m_tuesday.tag = 1;
        m_Tuesday           = @"YES";
        [m_tuesdayButton setBackgroundImage:[UIImage imageNamed:@"grocery_selected.png"] forState:UIControlStateNormal];
        m_totalNumberOfDaysSelected++;
    }
    else {
        m_tuesday.tag = 0;
        m_Tuesday           = @"NO";
        [m_tuesdayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        m_totalNumberOfDaysSelected--;
    }
}

// Wednesday button click
- (void)clickWednesday:(UIButton *)sender
{
    [self changeTextColor:m_wednesday];
    if (m_wednesday.tag == 0) {
        m_wednesday.tag = 1;
        m_Wednesday         = @"YES";
        [m_wednesdayButton setBackgroundImage:[UIImage imageNamed:@"grocery_selected.png"] forState:UIControlStateNormal];
        m_totalNumberOfDaysSelected++;
    }
    else {
        m_wednesday.tag = 0;
        m_Wednesday         = @"NO";
        [m_wednesdayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        m_totalNumberOfDaysSelected--;
    }
}

// Thursday button click
- (void)clickThursday:(UIButton *)sender
{
    [self changeTextColor:m_thursday];
    if (m_thursday.tag == 0) {
        m_thursday.tag = 1;
        m_Thursday          = @"YES";
        [m_thursdayButton setBackgroundImage:[UIImage imageNamed:@"grocery_selected.png"] forState:UIControlStateNormal];
        m_totalNumberOfDaysSelected++;
    }
    else {
        m_thursday.tag = 0;
        m_Thursday          = @"NO";
        [m_thursdayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        m_totalNumberOfDaysSelected--;
    }
}

// Friday button click
- (void)clickFriday:(UIButton *)sender
{
    [self changeTextColor:m_friday];
    if (m_friday.tag == 0) {
        m_friday.tag = 1;
        m_Friday            = @"YES";
        [m_fridayButton setBackgroundImage:[UIImage imageNamed:@"grocery_selected.png"] forState:UIControlStateNormal];
        m_totalNumberOfDaysSelected++;
    }
    else {
        m_friday.tag = 0;
        m_Friday            = @"NO";
        [m_fridayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        m_totalNumberOfDaysSelected--;
    }
}

// Saturday button click
- (void)clickSaturday:(UIButton *)sender
{
    [self changeTextColor:m_saturday];
    if (m_saturday.tag == 0) {
        m_saturday.tag = 1;
        m_Saturday          = @"YES";
        [m_saturdayButton setBackgroundImage:[UIImage imageNamed:@"grocery_selected.png"] forState:UIControlStateNormal];
        m_totalNumberOfDaysSelected++;
    }
    else {
        m_saturday.tag = 0;
        m_Saturday          = @"NO";
        [m_saturdayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        m_totalNumberOfDaysSelected--;
    }
}

// Sunday button click
- (void)clickSunday:(UIButton *)sender
{
    [self changeTextColor:m_sunday];
    if (m_sunday.tag == 0) {
        m_sunday.tag = 1;
        m_Sunday            = @"YES";
        [m_sundayButton setBackgroundImage:[UIImage imageNamed:@"grocery_selected.png"] forState:UIControlStateNormal];
        m_totalNumberOfDaysSelected++;
    }
    else {
        m_sunday.tag = 0;
        m_Sunday            = @"NO";
        [m_sundayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        m_totalNumberOfDaysSelected--;
    }
}

// Muscle Isolation check all day
- (void)checkAllDays
{
    // Reload tableview
    if (!m_database) {
        m_database                  = [Database alloc];
    }
    m_userEmailID                   = [NSString getUserEmail];
    m_goal                          = [m_database getLatestExerciseGoal:m_userEmailID]; // Get the latest goal
    if ([m_goal isEqualToString:@"MUSCLE ISOLATION"]) { // if goal is MUSCLE ISOLATION
        m_monday.tag    = 0;
        [self clickMonday:m_monday];
        m_tuesday.tag    = 0;
        [self clickTuesday:m_tuesday];
        m_wednesday.tag    = 0;
        [self clickWednesday:m_wednesday];
        m_thursday.tag    = 0;
        [self clickThursday:m_thursday];
        m_friday.tag    = 0;
        [self clickFriday:m_friday];
        m_saturday.tag    = 0;
        [self clickSaturday:m_saturday];
        m_sunday.tag    = 0;
        [self clickSunday:m_sunday];
    }
}

- (void)helpButtonClicked
{
    userDefaults        = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:1 forKey:@"WorkoutDays_Help"];
    [userDefaults synchronize];
    
    [m_helpPopUpButtonViewInWorkoutDaysview removeFromSuperview];
    m_monday.userInteractionEnabled       = YES;
    m_tuesday.userInteractionEnabled      = YES;
    m_wednesday.userInteractionEnabled        = YES;
    m_thursday.userInteractionEnabled     = YES;
    m_friday.userInteractionEnabled       = YES;
    m_saturday.userInteractionEnabled     = YES;
    m_sunday.userInteractionEnabled       = YES;
    m_mondayButton.userInteractionEnabled       = YES;
    m_tuesdayButton.userInteractionEnabled      = YES;
    m_wednesdayButton.userInteractionEnabled        = YES;
    m_thursdayButton.userInteractionEnabled     = YES;
    m_fridayButton.userInteractionEnabled       = YES;
    m_saturdayButton.userInteractionEnabled     = YES;
    m_sundayButton.userInteractionEnabled       = YES;
    m_nextButton.userInteractionEnabled     = YES;
    m_previousButton.userInteractionEnabled     = YES;
    self.backButton.userInteractionEnabled      = YES;
}

- (void)createHelpPopUp
{
    CGRect helpPopUpButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        helpPopUpButtonFrame     = CGRectMake(0.0f, 0.0f, 320.0f, 568.0f);
        m_helpPopUpButtonViewInWorkoutDaysview       = [[UIButton alloc] initWithFrame:helpPopUpButtonFrame];
        [m_helpPopUpButtonViewInWorkoutDaysview setBackgroundImage:[UIImage imageNamed:@"workoutdays_instruction_i5.png"] forState:UIControlStateNormal];
    }
    else {
        helpPopUpButtonFrame     = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
        m_helpPopUpButtonViewInWorkoutDaysview       = [[UIButton alloc] initWithFrame:helpPopUpButtonFrame];
        [m_helpPopUpButtonViewInWorkoutDaysview setBackgroundImage:[UIImage imageNamed:@"workoutdays_instruction.png"] forState:UIControlStateNormal];
    }
    [self.view addSubview:m_helpPopUpButtonViewInWorkoutDaysview];
    [m_helpPopUpButtonViewInWorkoutDaysview addTarget:self action:@selector(helpButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    m_monday.userInteractionEnabled       = YES;
    m_tuesday.userInteractionEnabled      = YES;
    m_wednesday.userInteractionEnabled        = YES;
    m_thursday.userInteractionEnabled     = YES;
    m_friday.userInteractionEnabled       = YES;
    m_saturday.userInteractionEnabled     = YES;
    m_sunday.userInteractionEnabled       = YES;
    m_mondayButton.userInteractionEnabled       = YES;
    m_tuesdayButton.userInteractionEnabled      = YES;
    m_wednesdayButton.userInteractionEnabled        = YES;
    m_thursdayButton.userInteractionEnabled     = YES;
    m_fridayButton.userInteractionEnabled       = YES;
    m_saturdayButton.userInteractionEnabled     = YES;
    m_sundayButton.userInteractionEnabled       = YES;
    m_nextButton.userInteractionEnabled     = YES;
    m_previousButton.userInteractionEnabled     = YES;
    self.backButton.userInteractionEnabled      = YES;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView         = [UIImageView topBarImage];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor     = [UIColor whiteColor];

    // Do any additional setup after loading the view from its nib.
    
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        CGRect m_backgroundImageViewFrame   = self.backgroundImageView.frame;
        [self.backgroundImageView removeFromSuperview];
        m_backgroundImageViewFrame.size.height  = m_backgroundImageViewFrame.size.height + 91.0f;
        self.backgroundImageView            = [[UIImageView alloc] initWithFrame:m_backgroundImageViewFrame];
        self.backgroundImageView.image      = [UIImage imageNamed:@"result_background.png"];
        [self.view addSubview:self.backgroundImageView];
    }

    [self.messageButton removeFromSuperview];
    self.messageButton.titleLabel.font          = [UIFont customFontWithSize:13];
    self.messageButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messageButton.titleLabel.numberOfLines = 2;
    self.messageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.messageButton];
    
    // Custom initialization
    CGRect m_firstButtonFrame;
    CGRect m_firstTickButtonFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_firstButtonFrame           = CGRectMake(0.0f, 60.0f, 320.0f, 60.0f);
        m_firstTickButtonFrame       = CGRectMake(250.0f, 15.0f, 50.0f, 41.0f);
    }
    else {
        m_firstButtonFrame           = CGRectMake(0.0f, 60.0f, 320.0f, 49.0f);
        m_firstTickButtonFrame       = CGRectMake(250.0f, 7.0f, 50.0f, 41.0f);
    }
    m_monday                            = [[UIButton alloc] initWithFrame:m_firstButtonFrame];
    [m_monday addTarget:self action:@selector(clickMonday:) forControlEvents:UIControlEventTouchUpInside];
    m_monday.titleLabel.font            = [UIFont customFontWithSize:20];
    [m_monday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [m_monday setTitle:@"       Monday" forState:UIControlStateNormal];
    [m_monday setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:m_monday];
    m_monday.tag                        = 0;
    
    m_mondayButton                  = [[UIButton alloc] initWithFrame:m_firstTickButtonFrame];
    [m_mondayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [m_monday addSubview:m_mondayButton];
    [m_mondayButton addTarget:self action:@selector(clickMonday:) forControlEvents:UIControlEventTouchUpInside];

    CGRect m_firstButtonSeperatorFrame;

    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_firstButtonSeperatorFrame  = CGRectMake(0.0f, 121.0f, 320.0f, 1.5f);
    }
    else {
        m_firstButtonSeperatorFrame  = CGRectMake(0.0f, 109.0f, 320.0f, 1.5f);
    }
    UIImageView *firstButtonSeperatorImageView  = [[UIImageView alloc] initWithFrame:m_firstButtonSeperatorFrame];
    firstButtonSeperatorImageView.image = [UIImage imageNamed:@"seperator.png"];
    [self.view addSubview:firstButtonSeperatorImageView];
    
    CGRect m_secondButtonFrame;
    CGRect m_secondTickButtonFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_secondButtonFrame          = CGRectMake(0.0f, 121.5f, 320.0f, 60.0f);
        m_secondTickButtonFrame      = CGRectMake(250.0f, 15.0f, 50.0f, 41.0f);
    }
    else {
        m_secondButtonFrame          = CGRectMake(0.0f, 110.5f, 320.0f, 49.0f);
        m_secondTickButtonFrame       = CGRectMake(250.0f, 7.0f, 50.0f, 41.0f);
    }

    m_tuesday                           = [[UIButton alloc] initWithFrame:m_secondButtonFrame];
    [m_tuesday addTarget:self action:@selector(clickTuesday:) forControlEvents:UIControlEventTouchUpInside];
    m_tuesday.titleLabel.font           = [UIFont customFontWithSize:20];
    [m_tuesday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [m_tuesday setTitle:@"       Tuesday" forState:UIControlStateNormal];
    [m_tuesday setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:m_tuesday];
    m_tuesday.tag                       = 0;
    
    m_tuesdayButton                  = [[UIButton alloc] initWithFrame:m_secondTickButtonFrame];
    [m_tuesdayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [m_tuesday addSubview:m_tuesdayButton];
    [m_tuesdayButton addTarget:self action:@selector(clickTuesday:) forControlEvents:UIControlEventTouchUpInside];

    CGRect m_secondButtonSeperatorFrame;

    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_secondButtonSeperatorFrame  = CGRectMake(0.0f, 182.5f, 320.0f, 1.5f);
    }
    else {
        m_secondButtonSeperatorFrame  = CGRectMake(0.0f, 159.0f, 320.0f, 1.5f);
    }
    UIImageView *secondButtonSeperatorImageView  = [[UIImageView alloc] initWithFrame:m_secondButtonSeperatorFrame];
    secondButtonSeperatorImageView.image = [UIImage imageNamed:@"seperator.png"];
    [self.view addSubview:secondButtonSeperatorImageView];

    CGRect m_thirdButtonFrame;
    CGRect m_thirdTickButtonFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_thirdButtonFrame           = CGRectMake(0.0f, 184.0f, 320.0f, 60.0f);
        m_thirdTickButtonFrame      = CGRectMake(250.0f, 15.0f, 50.0f, 41.0f);
    }
    else {
        m_thirdButtonFrame           = CGRectMake(0.0f, 160.5f, 320.0f, 49.0f);
        m_thirdTickButtonFrame       = CGRectMake(250.0f, 7.0f, 50.0f, 41.0f);
    }
    
    m_wednesday                         = [[UIButton alloc] initWithFrame:m_thirdButtonFrame];
    [m_wednesday addTarget:self action:@selector(clickWednesday:) forControlEvents:UIControlEventTouchUpInside];
    m_wednesday.titleLabel.font         = [UIFont customFontWithSize:20];
    [m_wednesday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [m_wednesday setTitle:@"       Wednesday" forState:UIControlStateNormal];
    [m_wednesday setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:m_wednesday];
    m_wednesday.tag                     = 0;

    m_wednesdayButton                  = [[UIButton alloc] initWithFrame:m_thirdTickButtonFrame];
    [m_wednesdayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [m_wednesday addSubview:m_wednesdayButton];
    [m_wednesdayButton addTarget:self action:@selector(clickWednesday:) forControlEvents:UIControlEventTouchUpInside];

    CGRect m_thirdButtonSeperatorFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_thirdButtonSeperatorFrame  = CGRectMake(0.0f, 244.0f, 320.0f, 1.5f);
    }
    else {
        m_thirdButtonSeperatorFrame  = CGRectMake(0.0f, 210.0f, 320.0f, 1.5f);
    }
    UIImageView *thirdButtonSeperatorImageView  = [[UIImageView alloc] initWithFrame:m_thirdButtonSeperatorFrame];
    thirdButtonSeperatorImageView.image = [UIImage imageNamed:@"seperator.png"];
    [self.view addSubview:thirdButtonSeperatorImageView];
    
    CGRect m_fourthButtonFrame;
    CGRect m_fourthTickButtonFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_fourthButtonFrame          = CGRectMake(0.0f, 245.5f, 320.0f, 60.0f);
        m_fourthTickButtonFrame      = CGRectMake(250.0f, 15.0f, 50.0f, 41.0f);
    }
    else{
        m_fourthButtonFrame          = CGRectMake(0.0f, 210.5f, 320.0f, 49.0f);
        m_fourthTickButtonFrame      = CGRectMake(250.0f, 7.0f, 50.0f, 41.0f);
    }

    m_thursday                          = [[UIButton alloc] initWithFrame:m_fourthButtonFrame];
    [m_thursday addTarget:self action:@selector(clickThursday:) forControlEvents:UIControlEventTouchUpInside];
    m_thursday.titleLabel.font          = [UIFont customFontWithSize:20];
    [m_thursday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [m_thursday setTitle:@"       Thursday" forState:UIControlStateNormal];
    [m_thursday setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:m_thursday];
    m_thursday.tag                      = 0;

    m_thursdayButton                  = [[UIButton alloc] initWithFrame:m_fourthTickButtonFrame];
    [m_thursdayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [m_thursday addSubview:m_thursdayButton];
    [m_thursdayButton addTarget:self action:@selector(clickThursday:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect m_fourthButtonSeperatorFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_fourthButtonSeperatorFrame  = CGRectMake(0.0f, 306.5f, 320.0f, 1.5f);
    }
    else {
        m_fourthButtonSeperatorFrame  = CGRectMake(0.0f, 260.0f, 320.0f, 1.5f);
    }
    
    UIImageView *fourthButtonSeperatorImageView  = [[UIImageView alloc] initWithFrame:m_fourthButtonSeperatorFrame];
    fourthButtonSeperatorImageView.image = [UIImage imageNamed:@"seperator.png"];
    [self.view addSubview:fourthButtonSeperatorImageView];
    
    CGRect m_fifthButtonFrame;
    CGRect m_fifthTickButtonFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_fifthButtonFrame           = CGRectMake(0.0f, 308.5f, 320.0f, 60.0f);
        m_fifthTickButtonFrame      = CGRectMake(250.0f, 15.0f, 50.0f, 41.0f);
    }
    else {
        m_fifthButtonFrame           = CGRectMake(0.0f, 260.5f, 320.0f, 49.0f);
        m_fifthTickButtonFrame      = CGRectMake(250.0f, 7.0f, 50.0f, 41.0f);
    }

    m_friday                            = [[UIButton alloc] initWithFrame:m_fifthButtonFrame];
    [m_friday addTarget:self action:@selector(clickFriday:) forControlEvents:UIControlEventTouchUpInside];
    m_friday.titleLabel.font            = [UIFont customFontWithSize:20];
    [m_friday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [m_friday setTitle:@"       Friday" forState:UIControlStateNormal];
    [m_friday setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:m_friday];
    m_friday.tag                        = 0;
    
    m_fridayButton                  = [[UIButton alloc] initWithFrame:m_fifthTickButtonFrame];
    [m_fridayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [m_friday addSubview:m_fridayButton];
    [m_fridayButton addTarget:self action:@selector(clickFriday:) forControlEvents:UIControlEventTouchUpInside];

    
    CGRect m_fifthButtonSeperatorFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_fifthButtonSeperatorFrame     = CGRectMake(0.0f, 369.0f, 320.0f, 1.5f);
    }
    else {
        m_fifthButtonSeperatorFrame     = CGRectMake(0.0f, 310.5f, 320.0f, 1.5f);
    }
    UIImageView *fifthButtonSeperatorImageView  = [[UIImageView alloc] initWithFrame:m_fifthButtonSeperatorFrame];
    fifthButtonSeperatorImageView.image = [UIImage imageNamed:@"seperator.png"];
    [self.view addSubview:fifthButtonSeperatorImageView];
    
    CGRect m_sixthButtonFrame;
    CGRect m_sixthTickButtonFrame;

    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_sixthButtonFrame          = CGRectMake(0.0f, 371.0f, 320.0f, 60.0f);
        m_sixthTickButtonFrame      = CGRectMake(250.0f, 15.0f, 50.0f, 41.0f);
    }
    else {
        m_sixthButtonFrame          = CGRectMake(0.0f, 310.5f, 320.0f, 49.0f);
        m_sixthTickButtonFrame      = CGRectMake(250.0f, 7.0f, 50.0f, 41.0f);
    }

    m_saturday                         = [[UIButton alloc] initWithFrame:m_sixthButtonFrame];
    [m_saturday addTarget:self action:@selector(clickSaturday:) forControlEvents:UIControlEventTouchUpInside];
    m_saturday.titleLabel.font         = [UIFont customFontWithSize:20];
    [m_saturday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [m_saturday setTitle:@"       Saturday" forState:UIControlStateNormal];
    [m_saturday setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:m_saturday];
    m_saturday.tag                     = 0;

    m_saturdayButton                  = [[UIButton alloc] initWithFrame:m_sixthTickButtonFrame];
    [m_saturdayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [m_saturday addSubview:m_saturdayButton];
    [m_saturdayButton addTarget:self action:@selector(clickSaturday:) forControlEvents:UIControlEventTouchUpInside];

    CGRect m_sixthButtonSeperatorFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_sixthButtonSeperatorFrame  = CGRectMake(0.0f, 432.0f, 320.0f, 1.5f);
    }
    else {
        m_sixthButtonSeperatorFrame  = CGRectMake(0.0f, 360.5f, 320.0f, 1.5f);
    }
    UIImageView *sixthButtonSeperatorImageView  = [[UIImageView alloc] initWithFrame:m_sixthButtonSeperatorFrame];
    sixthButtonSeperatorImageView.image = [UIImage imageNamed:@"seperator.png"];
    [self.view addSubview:sixthButtonSeperatorImageView];
    
    CGRect m_seventhButtonFrame;
    CGRect m_seventhTickButtonFrame;

    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_seventhButtonFrame         = CGRectMake(0.0f, 434.0f, 320.0f, 60.0f);
        m_seventhTickButtonFrame      = CGRectMake(250.0f, 15.0f, 50.0f, 41.0f);
    }
    else {
        m_seventhButtonFrame         = CGRectMake(0.0f, 362.5f, 320.0f, 49.0f);
        m_seventhTickButtonFrame      = CGRectMake(250.0f, 7.0f, 50.0f, 41.0f);
    }

    m_sunday                            = [[UIButton alloc] initWithFrame:m_seventhButtonFrame];
    [m_sunday addTarget:self action:@selector(clickSunday:) forControlEvents:UIControlEventTouchUpInside];
    m_sunday.titleLabel.font            = [UIFont customFontWithSize:20];
    [m_sunday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [m_sunday setTitle:@"       Sunday" forState:UIControlStateNormal];
    [m_sunday setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:m_sunday];
    m_sunday.tag                        = 0;

    m_sundayButton                  = [[UIButton alloc] initWithFrame:m_seventhTickButtonFrame];
    [m_sundayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [m_sunday addSubview:m_sundayButton];
    [m_sundayButton addTarget:self action:@selector(clickSunday:) forControlEvents:UIControlEventTouchUpInside];

    CGRect m_nextButtonFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_nextButtonFrame            = CGRectMake(260.0f, 510.0f, 50.0f, 40.0f);
    }
    else {
        m_nextButtonFrame            = CGRectMake(260.0f, 430.0f, 50.0f, 40.0f);
    }
    m_nextButton                        = [[UIButton alloc] initWithFrame:m_nextButtonFrame];
    [m_nextButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [m_nextButton addTarget:self action:@selector(exerciseDaysSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:m_nextButton];
    
    
    CGRect m_previousButtonFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_previousButtonFrame            = CGRectMake(15.0f, 510.0f, 50.0f, 40.0f);
    }
    else {
        m_previousButtonFrame            = CGRectMake(15.0f, 430.0f, 50.0f, 40.0f);
    }
    m_previousButton                        = [[UIButton alloc] initWithFrame:m_previousButtonFrame];
    [m_previousButton addTarget:self action:@selector(moveToPreviousViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:m_previousButton];
    
    userDefaults        = [NSUserDefaults standardUserDefaults];
    if (![userDefaults integerForKey:@"WorkoutDays_Help"]) {
        // Add Help Pop Up
        [self createHelpPopUp];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    // check all days for muscle isolation goal
    [self checkAllDays];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 Save workout plan into database
 */
- (void)saveWorkoutPlanIntoDatabase
{
    if (!m_database) {
        m_database                  = [Database alloc];
    }
    if (!m_userEmailID) {
        m_userEmailID               = [NSString getUserEmail];
    }
    m_goal                          = [m_database getLatestExerciseGoal:m_userEmailID]; // Get the latest goal
    
    if (!m_workoutSelection) {
        m_workoutSelection          = [WorkoutSelection sharedInstance];
    }
    
    if (!m_workoutPlanManager) {
        m_workoutPlanManager        = [WorkoutPlanManager sharedInstance];
    }
    
    // First remove any previous data in the workout plan
    [m_workoutPlanManager deletePreviousWorkoutPlan];
    
    NSMutableArray *daysArray       = [NSMutableArray mutableArrayObject];

    if ([m_Monday isEqualToString:@"YES"]) {
        // index of daysSelected is the day number
        [daysArray addObject:@"Monday"];
        m_workoutArray                      = [m_workoutSelection workoutGoal:m_goal WithTheDay:(int)[daysArray indexOfObject:@"Monday"] ForTotalWorkOutDays:(int)m_totalNumberOfDaysSelected];
        FirstDayWorkoutPlanManager  *m_firstDayWorkoutPlanManager = [FirstDayWorkoutPlanManager sharedInstance];
        [m_firstDayWorkoutPlanManager saveFirstDayWorkoutPlanInDatabase:m_workoutArray];
    }
    
    if ([m_Tuesday isEqualToString:@"YES"]) {
        // index of daysSelected is the day number
        [daysArray addObject:@"Tuesday"];
        m_workoutArray                      = [m_workoutSelection workoutGoal:m_goal WithTheDay:(int)[daysArray indexOfObject:@"Tuesday"] ForTotalWorkOutDays:(int)m_totalNumberOfDaysSelected];
        SecondDayWorkoutPlanManager  *m_secondDayWorkoutPlanManager = [SecondDayWorkoutPlanManager sharedInstance];
        [m_secondDayWorkoutPlanManager saveSecondDayWorkoutPlanInDatabase:m_workoutArray];
    }
    
    if ([m_Wednesday isEqualToString:@"YES"]) {
        // index of daysSelected is the day number
        [daysArray addObject:@"Wednesday"];
        m_workoutArray                      = [m_workoutSelection workoutGoal:m_goal WithTheDay:(int)[daysArray indexOfObject:@"Wednesday"] ForTotalWorkOutDays:(int)m_totalNumberOfDaysSelected];
        ThirdDayWorkoutPlanManager  *m_thirdDayWorkoutPlanManager = [ThirdDayWorkoutPlanManager sharedInstance];
        [m_thirdDayWorkoutPlanManager saveThirdDayWorkoutPlanInDatabase:m_workoutArray];
    }
    
    if ([m_Thursday isEqualToString:@"YES"]) {
        // index of daysSelected is the day number
        [daysArray addObject:@"Thursday"];
        m_workoutArray                      = [m_workoutSelection workoutGoal:m_goal WithTheDay:(int)[daysArray indexOfObject:@"Thursday"] ForTotalWorkOutDays:(int)m_totalNumberOfDaysSelected];
        FourthDayWorkoutPlanManager  *m_fourthDayWorkoutPlanManager = [FourthDayWorkoutPlanManager sharedInstance];
        [m_fourthDayWorkoutPlanManager saveFourthDayWorkoutPlanInDatabase:m_workoutArray];
    }
    
    if ([m_Friday isEqualToString:@"YES"]) {
        // index of daysSelected is the day number
        [daysArray addObject:@"Friday"];
        m_workoutArray                      = [m_workoutSelection workoutGoal:m_goal WithTheDay:(int)[daysArray indexOfObject:@"Friday"] ForTotalWorkOutDays:(int)m_totalNumberOfDaysSelected];
        FifthDayWorkoutPlanManager  *m_fifthDayWorkoutPlanManager = [FifthDayWorkoutPlanManager sharedInstance];
        [m_fifthDayWorkoutPlanManager saveFifthDayWorkoutPlanInDatabase:m_workoutArray];
    }
    
    if ([m_Saturday isEqualToString:@"YES"]) {
        // index of daysSelected is the day number
        [daysArray addObject:@"Saturday"];
        m_workoutArray                      = [m_workoutSelection workoutGoal:m_goal WithTheDay:(int)[daysArray indexOfObject:@"Saturday"] ForTotalWorkOutDays:(int)m_totalNumberOfDaysSelected];
        SixthDayWorkoutPlanManager  *m_sixthDayWorkoutPlanManager = [SixthDayWorkoutPlanManager sharedInstance];
        [m_sixthDayWorkoutPlanManager saveSixthDayWorkoutPlanInDatabase:m_workoutArray];
    }
    
    if ([m_Sunday isEqualToString:@"YES"]) {
        // index of daysSelected is the day number
        [daysArray addObject:@"Sunday"];
        m_workoutArray                      = [m_workoutSelection workoutGoal:m_goal WithTheDay:(int)[daysArray indexOfObject:@"Sunday"] ForTotalWorkOutDays:(int)m_totalNumberOfDaysSelected];
        SeventhDayWorkoutPlanManager  *m_seventhDayWorkoutPlanManager = [SeventhDayWorkoutPlanManager sharedInstance];
        [m_seventhDayWorkoutPlanManager saveSeventhDayWorkoutPlanInDatabase:m_workoutArray];
    }
}

@end
