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

// ResultViewController class object
@property (strong, nonatomic)ResultViewController *m_resultViewController;
// ViewFactory class object
@property (strong, nonatomic)ViewFactory *m_controllerViews;
// ViewTransitions clas object
@property (strong, nonatomic)ViewTransitions *m_transition;
// Database class object
@property (strong, nonatomic)Database *m_database;
// WorkoutSelection class object
@property (strong, nonatomic)WorkoutSelection *m_workoutSelection;
// WorkoutPlanManager class object
@property (strong, nonatomic)WorkoutPlanManager *m_workoutPlanManager;
// GoalsViewController class object
@property (strong, nonatomic)GoalsViewController *m_goalsViewController;
// Previous Button
@property (strong, nonatomic)UIButton *m_previousButton;

// Help pop up button
@property (strong, nonatomic)UIButton *m_helpPopUpButtonViewInWorkoutDaysview;
// NSUserDefault
@property (strong, nonatomic)NSUserDefaults *userDefaults;

// All the days
@property (strong, nonatomic)NSMutableArray *m_daysMutableArray;
// Days default value is "NO"
@property (strong, nonatomic)NSString *m_Monday; //@"NO";
@property (strong, nonatomic)NSString *m_Tuesday;//     = @"NO";
@property (strong, nonatomic)NSString *m_Wednesday;//   = @"NO";
@property (strong, nonatomic)NSString *m_Thursday;//    = @"NO";
@property (strong, nonatomic)NSString *m_Friday;//      = @"NO";
@property (strong, nonatomic)NSString *m_Saturday;//    = @"NO";
@property (strong, nonatomic)NSString *m_Sunday;//    = @"NO";

// Tick buttons
@property (strong, nonatomic)UIButton *m_mondayButton;
@property (strong, nonatomic)UIButton *m_tuesdayButton;
@property (strong, nonatomic)UIButton *m_wednesdayButton;
@property (strong, nonatomic)UIButton *m_thursdayButton;
@property (strong, nonatomic)UIButton *m_fridayButton;
@property (strong, nonatomic)UIButton *m_saturdayButton;
@property (strong, nonatomic)UIButton *m_sundayButton;

// Day numbers
@property (nonatomic)int m_MondayNumber;//      = 0;
@property (nonatomic)int m_TuesdayNumber;//     = 1;
@property (nonatomic)int m_WednesdayNumber;//   = 2;
@property (nonatomic)int m_ThursdayNumber;//    = 3;
@property (nonatomic)int m_FridayNumber;//      = 4;
@property (nonatomic)int m_SaturdayNumber;//    = 5;
@property (nonatomic)int m_SundayNumber;//      = 6;

// User email id
@property (strong, nonatomic)NSString *m_userEmailID;
// User goal
@property (strong, nonatomic)NSString *m_goal;
// Total number of days selected
@property (nonatomic)NSInteger m_totalNumberOfDaysSelected;
// Workout array
@property (strong, nonatomic)NSMutableArray *m_workoutArray;

// Buttons
@property (strong, nonatomic)UIButton *m_monday;
@property (strong, nonatomic)UIButton *m_tuesday;
@property (strong, nonatomic)UIButton *m_wednesday;
@property (strong, nonatomic)UIButton *m_thursday;
@property (strong, nonatomic)UIButton *m_friday;
@property (strong, nonatomic)UIButton *m_saturday;
@property (strong, nonatomic)UIButton *m_sunday;
@property (strong, nonatomic)UIButton *m_nextButton;

// Labels
@property (strong, nonatomic)UILabel *m_mondayLabel;
@property (strong, nonatomic)UILabel *m_tuesdayLabel;
@property (strong, nonatomic)UILabel *m_wednesdayLabel;
@property (strong, nonatomic)UILabel *m_thursdayLabel;
@property (strong, nonatomic)UILabel *m_fridayLabel;
@property (strong, nonatomic)UILabel *m_saturdayLabel;
@property (strong, nonatomic)UILabel *m_sundayLabel;

// Buttons
@property (strong, nonatomic)UIButton *m_mondayTickButton;
@property (strong, nonatomic)UIButton *m_tuesdayTickButton;
@property (strong, nonatomic)UIButton *m_wednesdayTickButton;
@property (strong, nonatomic)UIButton *m_thursdayTickButton;
@property (strong, nonatomic)UIButton *m_fridayTickButton;
@property (strong, nonatomic)UIButton *m_saturdayTickButton;
@property (strong, nonatomic)UIButton *m_sundayTickButton;
@end


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
    if (!self.m_transition) {
        self.m_transition                    = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionFromRight:self.view.superview];
    [self.view removeFromSuperview];
}

/*
 Move to ResultViewController
 */
- (void)moveToResultViewController:(id)sender
{
    if (!self.m_resultViewController) {
        self.m_resultViewController                  = [ResultViewController sharedInstance];
    }
    id instanceObject               = self.m_resultViewController;
    [self moveToView:self.m_resultViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to GoalsViewController
 */
- (void)moveToGoalsViewController:(id)sender
{
    if (!self.m_goalsViewController) {
        self.m_goalsViewController       = [GoalsViewController sharedInstance];
    }
    id instanceObject               = self.m_goalsViewController;
    [self moveToView:self.m_goalsViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Display message to user with animation
 */
- (void)displayMessage:(NSString *)message
{
    self.messageButton.hidden  = NO;
    
    [UIButton animateWithDuration:3.0f animations:^{self.messageButton.alpha = 5.0;} completion:nil];
    
    [self.messageButton setTitle:message forState:UIControlStateNormal];
    
    if (!self.m_transition) {
        self.m_transition    = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionFromBottom:self.messageButton];
    
    [UIButton animateWithDuration:5.0f animations:^{self.messageButton.alpha = 0.0;} completion:nil];
}

/*
 Exercise days selection
 */
- (void)exerciseDaysSelected:(id)sender
{
    if (([self.m_Monday length] != 0) || ([self.m_Tuesday length] != 0) || ([self.m_Wednesday length] != 0) || ([self.m_Thursday length] != 0) || ([self.m_Friday length] != 0) || ([self.m_Saturday length] != 0) || ([self.m_Sunday length] != 0)) { // If atleast one day is selected
        NSString *daysStatus            = @"";
        NSDate *date                    = [NSDate date];
        
        // Save selections in the database
        if (!self.m_database) {
            self.m_database                  = [Database alloc];
        }
        daysStatus                      = [self.m_database insertIntoExerciseDaysEmail_Id:self.m_userEmailID Date:date Monday:self.m_Monday Tuesday:self.m_Tuesday Wednesday:self.m_Wednesday Thursday:self.m_Thursday Friday:self.m_Friday Saturday:self.m_Saturday Sunday:self.m_Sunday];
        
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
    [self changeTextColor:self.m_monday];
    if (self.m_monday.tag == 0) {
        self.m_monday.tag = 1;
       self.m_Monday            = @"YES";
        [self.m_mondayButton setBackgroundImage:[UIImage imageNamed:@"grocery_selected.png"] forState:UIControlStateNormal];
        self.m_totalNumberOfDaysSelected++;
    }
    else {
        self.m_monday.tag = 0;
        self.m_Monday            = @"NO";
        [self.m_mondayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.m_totalNumberOfDaysSelected--;
    }
}

// Tuesday button click
- (void)clickTuesday:(UIButton *)sender
{
    [self changeTextColor:self.m_tuesday];
    if (self.m_tuesday.tag == 0) {
        self.m_tuesday.tag = 1;
        self.m_Tuesday           = @"YES";
        [self.m_tuesdayButton setBackgroundImage:[UIImage imageNamed:@"grocery_selected.png"] forState:UIControlStateNormal];
        self.m_totalNumberOfDaysSelected++;
    }
    else {
        self.m_tuesday.tag = 0;
        self.m_Tuesday           = @"NO";
        [self.m_tuesdayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.m_totalNumberOfDaysSelected--;
    }
}

// Wednesday button click
- (void)clickWednesday:(UIButton *)sender
{
    [self changeTextColor:self.m_wednesday];
    if (self.m_wednesday.tag == 0) {
        self.m_wednesday.tag = 1;
        self.m_Wednesday         = @"YES";
        [self.m_wednesdayButton setBackgroundImage:[UIImage imageNamed:@"grocery_selected.png"] forState:UIControlStateNormal];
        self.m_totalNumberOfDaysSelected++;
    }
    else {
        self.m_wednesday.tag = 0;
        self.m_Wednesday         = @"NO";
        [self.m_wednesdayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.m_totalNumberOfDaysSelected--;
    }
}

// Thursday button click
- (void)clickThursday:(UIButton *)sender
{
    [self changeTextColor:self.m_thursday];
    if (self.m_thursday.tag == 0) {
        self.m_thursday.tag = 1;
        self.m_Thursday          = @"YES";
        [self.m_thursdayButton setBackgroundImage:[UIImage imageNamed:@"grocery_selected.png"] forState:UIControlStateNormal];
        self.m_totalNumberOfDaysSelected++;
    }
    else {
        self.m_thursday.tag = 0;
        self.m_Thursday          = @"NO";
        [self.m_thursdayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.m_totalNumberOfDaysSelected--;
    }
}

// Friday button click
- (void)clickFriday:(UIButton *)sender
{
    [self changeTextColor:self.m_friday];
    if (self.m_friday.tag == 0) {
        self.m_friday.tag = 1;
        self.m_Friday            = @"YES";
        [self.m_fridayButton setBackgroundImage:[UIImage imageNamed:@"grocery_selected.png"] forState:UIControlStateNormal];
        self.m_totalNumberOfDaysSelected++;
    }
    else {
        self.m_friday.tag = 0;
        self.m_Friday            = @"NO";
        [self.m_fridayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.m_totalNumberOfDaysSelected--;
    }
}

// Saturday button click
- (void)clickSaturday:(UIButton *)sender
{
    [self changeTextColor:self.m_saturday];
    if (self.m_saturday.tag == 0) {
        self.m_saturday.tag = 1;
        self.m_Saturday          = @"YES";
        [self.m_saturdayButton setBackgroundImage:[UIImage imageNamed:@"grocery_selected.png"] forState:UIControlStateNormal];
        self.m_totalNumberOfDaysSelected++;
    }
    else {
        self.m_saturday.tag = 0;
        self.m_Saturday          = @"NO";
        [self.m_saturdayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.m_totalNumberOfDaysSelected--;
    }
}

// Sunday button click
- (void)clickSunday:(UIButton *)sender
{
    [self changeTextColor:self.m_sunday];
    if (self.m_sunday.tag == 0) {
        self.m_sunday.tag = 1;
        self.m_Sunday            = @"YES";
        [self.m_sundayButton setBackgroundImage:[UIImage imageNamed:@"grocery_selected.png"] forState:UIControlStateNormal];
        self.m_totalNumberOfDaysSelected++;
    }
    else {
        self.m_sunday.tag = 0;
        self.m_Sunday            = @"NO";
        [self.m_sundayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.m_totalNumberOfDaysSelected--;
    }
}

// Muscle Isolation check all day
- (void)checkAllDays
{
    // Reload tableview
    if (!self.m_database) {
        self.m_database                  = [Database alloc];
    }
    self.m_userEmailID                   = [NSString getUserEmail];
    self.m_goal                          = [self.m_database getLatestExerciseGoal:self.m_userEmailID]; // Get the latest goal
    if ([self.m_goal isEqualToString:@"MUSCLE ISOLATION"]) { // if goal is MUSCLE ISOLATION
        self.m_monday.tag    = 0;
        [self clickMonday:self.m_monday];
        self.m_tuesday.tag    = 0;
        [self clickTuesday:self.m_tuesday];
        self.m_wednesday.tag    = 0;
        [self clickWednesday:self.m_wednesday];
        self.m_thursday.tag    = 0;
        [self clickThursday:self.m_thursday];
        self.m_friday.tag    = 0;
        [self clickFriday:self.m_friday];
        self.m_saturday.tag    = 0;
        [self clickSaturday:self.m_saturday];
        self.m_sunday.tag    = 0;
        [self clickSunday:self.m_sunday];
    }
}

- (void)helpButtonClicked
{
    self.userDefaults        = [NSUserDefaults standardUserDefaults];
    [self.userDefaults setInteger:1 forKey:@"WorkoutDays_Help"];
    [self.userDefaults synchronize];
    
    [self.m_helpPopUpButtonViewInWorkoutDaysview removeFromSuperview];
    self.m_monday.userInteractionEnabled       = YES;
    self.m_tuesday.userInteractionEnabled      = YES;
    self.m_wednesday.userInteractionEnabled        = YES;
    self.m_thursday.userInteractionEnabled     = YES;
    self.m_friday.userInteractionEnabled       = YES;
    self.m_saturday.userInteractionEnabled     = YES;
    self.m_sunday.userInteractionEnabled       = YES;
    self.m_mondayButton.userInteractionEnabled       = YES;
    self.m_tuesdayButton.userInteractionEnabled      = YES;
    self.m_wednesdayButton.userInteractionEnabled        = YES;
    self.m_thursdayButton.userInteractionEnabled     = YES;
    self.m_fridayButton.userInteractionEnabled       = YES;
    self.m_saturdayButton.userInteractionEnabled     = YES;
    self.m_sundayButton.userInteractionEnabled       = YES;
    self.m_nextButton.userInteractionEnabled     = YES;
    self.m_previousButton.userInteractionEnabled     = YES;
    self.backButton.userInteractionEnabled      = YES;
}

- (void)createHelpPopUp
{
    CGRect helpPopUpButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        helpPopUpButtonFrame     = CGRectMake(0.0f, 0.0f, 320.0f, 568.0f);
        self.m_helpPopUpButtonViewInWorkoutDaysview       = [[UIButton alloc] initWithFrame:helpPopUpButtonFrame];
        [self.m_helpPopUpButtonViewInWorkoutDaysview setBackgroundImage:[UIImage imageNamed:@"workoutdays_instruction_i5.png"] forState:UIControlStateNormal];
    }
    else {
        helpPopUpButtonFrame     = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
        self.m_helpPopUpButtonViewInWorkoutDaysview       = [[UIButton alloc] initWithFrame:helpPopUpButtonFrame];
        [self.m_helpPopUpButtonViewInWorkoutDaysview setBackgroundImage:[UIImage imageNamed:@"workoutdays_instruction.png"] forState:UIControlStateNormal];
    }
    [self.view addSubview:self.m_helpPopUpButtonViewInWorkoutDaysview];
    [self.m_helpPopUpButtonViewInWorkoutDaysview addTarget:self action:@selector(helpButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.m_monday.userInteractionEnabled       = YES;
    self.m_tuesday.userInteractionEnabled      = YES;
    self.m_wednesday.userInteractionEnabled        = YES;
    self.m_thursday.userInteractionEnabled     = YES;
    self.m_friday.userInteractionEnabled       = YES;
    self.m_saturday.userInteractionEnabled     = YES;
    self.m_sunday.userInteractionEnabled       = YES;
    self.m_mondayButton.userInteractionEnabled       = YES;
    self.m_tuesdayButton.userInteractionEnabled      = YES;
    self.m_wednesdayButton.userInteractionEnabled        = YES;
    self.m_thursdayButton.userInteractionEnabled     = YES;
    self.m_fridayButton.userInteractionEnabled       = YES;
    self.m_saturdayButton.userInteractionEnabled     = YES;
    self.m_sundayButton.userInteractionEnabled       = YES;
    self.m_nextButton.userInteractionEnabled     = YES;
    self.m_previousButton.userInteractionEnabled     = YES;
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
    self.m_monday                            = [[UIButton alloc] initWithFrame:m_firstButtonFrame];
    [self.m_monday addTarget:self action:@selector(clickMonday:) forControlEvents:UIControlEventTouchUpInside];
    self.m_monday.titleLabel.font            = [UIFont customFontWithSize:20];
    [self.m_monday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.m_monday setTitle:@"       Monday" forState:UIControlStateNormal];
    [self.m_monday setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:self.m_monday];
    self.m_monday.tag                        = 0;
    
    self.m_mondayButton                  = [[UIButton alloc] initWithFrame:m_firstTickButtonFrame];
    [self.m_mondayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.m_monday addSubview:self.m_mondayButton];
    [self.m_mondayButton addTarget:self action:@selector(clickMonday:) forControlEvents:UIControlEventTouchUpInside];

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

    self.m_tuesday                           = [[UIButton alloc] initWithFrame:m_secondButtonFrame];
    [self.m_tuesday addTarget:self action:@selector(clickTuesday:) forControlEvents:UIControlEventTouchUpInside];
    self.m_tuesday.titleLabel.font           = [UIFont customFontWithSize:20];
    [self.m_tuesday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.m_tuesday setTitle:@"       Tuesday" forState:UIControlStateNormal];
    [self.m_tuesday setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:self.m_tuesday];
    self.m_tuesday.tag                       = 0;
    
    self.m_tuesdayButton                  = [[UIButton alloc] initWithFrame:m_secondTickButtonFrame];
    [self.m_tuesdayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.m_tuesday addSubview:self.m_tuesdayButton];
    [self.m_tuesdayButton addTarget:self action:@selector(clickTuesday:) forControlEvents:UIControlEventTouchUpInside];

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
    
    self.m_wednesday                         = [[UIButton alloc] initWithFrame:m_thirdButtonFrame];
    [self.m_wednesday addTarget:self action:@selector(clickWednesday:) forControlEvents:UIControlEventTouchUpInside];
    self.m_wednesday.titleLabel.font         = [UIFont customFontWithSize:20];
    [self.m_wednesday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.m_wednesday setTitle:@"       Wednesday" forState:UIControlStateNormal];
    [self.m_wednesday setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:self.m_wednesday];
    self.m_wednesday.tag                     = 0;

    self.m_wednesdayButton                  = [[UIButton alloc] initWithFrame:m_thirdTickButtonFrame];
    [self.m_wednesdayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.m_wednesday addSubview:self.m_wednesdayButton];
    [self.m_wednesdayButton addTarget:self action:@selector(clickWednesday:) forControlEvents:UIControlEventTouchUpInside];

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

    self.m_thursday                          = [[UIButton alloc] initWithFrame:m_fourthButtonFrame];
    [self.m_thursday addTarget:self action:@selector(clickThursday:) forControlEvents:UIControlEventTouchUpInside];
    self.m_thursday.titleLabel.font          = [UIFont customFontWithSize:20];
    [self.m_thursday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.m_thursday setTitle:@"       Thursday" forState:UIControlStateNormal];
    [self.m_thursday setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:self.m_thursday];
    self.m_thursday.tag                      = 0;

    self.m_thursdayButton                  = [[UIButton alloc] initWithFrame:m_fourthTickButtonFrame];
    [self.m_thursdayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.m_thursday addSubview:self.m_thursdayButton];
    [self.m_thursdayButton addTarget:self action:@selector(clickThursday:) forControlEvents:UIControlEventTouchUpInside];
    
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

    self.m_friday                            = [[UIButton alloc] initWithFrame:m_fifthButtonFrame];
    [self.m_friday addTarget:self action:@selector(clickFriday:) forControlEvents:UIControlEventTouchUpInside];
    self.m_friday.titleLabel.font            = [UIFont customFontWithSize:20];
    [self.m_friday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.m_friday setTitle:@"       Friday" forState:UIControlStateNormal];
    [self.m_friday setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:self.m_friday];
    self.m_friday.tag                        = 0;
    
    self.m_fridayButton                  = [[UIButton alloc] initWithFrame:m_fifthTickButtonFrame];
    [self.m_fridayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.m_friday addSubview:self.m_fridayButton];
    [self.m_fridayButton addTarget:self action:@selector(clickFriday:) forControlEvents:UIControlEventTouchUpInside];

    
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

    self.m_saturday                         = [[UIButton alloc] initWithFrame:m_sixthButtonFrame];
    [self.m_saturday addTarget:self action:@selector(clickSaturday:) forControlEvents:UIControlEventTouchUpInside];
    self.m_saturday.titleLabel.font         = [UIFont customFontWithSize:20];
    [self.m_saturday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.m_saturday setTitle:@"       Saturday" forState:UIControlStateNormal];
    [self.m_saturday setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:self.m_saturday];
    self.m_saturday.tag                     = 0;

    self.m_saturdayButton                  = [[UIButton alloc] initWithFrame:m_sixthTickButtonFrame];
    [self.m_saturdayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.m_saturday addSubview:self.m_saturdayButton];
    [self.m_saturdayButton addTarget:self action:@selector(clickSaturday:) forControlEvents:UIControlEventTouchUpInside];

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

    self.m_sunday                            = [[UIButton alloc] initWithFrame:m_seventhButtonFrame];
    [self.m_sunday addTarget:self action:@selector(clickSunday:) forControlEvents:UIControlEventTouchUpInside];
    self.m_sunday.titleLabel.font            = [UIFont customFontWithSize:20];
    [self.m_sunday setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.m_sunday setTitle:@"       Sunday" forState:UIControlStateNormal];
    [self.m_sunday setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:self.m_sunday];
    self.m_sunday.tag                        = 0;

    self.m_sundayButton                  = [[UIButton alloc] initWithFrame:m_seventhTickButtonFrame];
    [self.m_sundayButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.m_sunday addSubview:self.m_sundayButton];
    [self.m_sundayButton addTarget:self action:@selector(clickSunday:) forControlEvents:UIControlEventTouchUpInside];

    CGRect m_nextButtonFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_nextButtonFrame            = CGRectMake(260.0f, 510.0f, 50.0f, 40.0f);
    }
    else {
        m_nextButtonFrame            = CGRectMake(260.0f, 430.0f, 50.0f, 40.0f);
    }
    self.m_nextButton                        = [[UIButton alloc] initWithFrame:m_nextButtonFrame];
    [self.m_nextButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.m_nextButton addTarget:self action:@selector(exerciseDaysSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.m_nextButton];
    
    
    CGRect m_previousButtonFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_previousButtonFrame            = CGRectMake(15.0f, 510.0f, 50.0f, 40.0f);
    }
    else {
        m_previousButtonFrame            = CGRectMake(15.0f, 430.0f, 50.0f, 40.0f);
    }
    self.m_previousButton                        = [[UIButton alloc] initWithFrame:m_previousButtonFrame];
    [self.m_previousButton addTarget:self action:@selector(moveToPreviousViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.m_previousButton];
    
    self.userDefaults        = [NSUserDefaults standardUserDefaults];
    if (![self.userDefaults integerForKey:@"WorkoutDays_Help"]) {
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
    if (!self.m_database) {
        self.m_database                  = [Database alloc];
    }
    if (!self.m_userEmailID) {
        self.m_userEmailID               = [NSString getUserEmail];
    }
    self.m_goal                          = [self.m_database getLatestExerciseGoal:self.m_userEmailID]; // Get the latest goal
    
    if (!self.m_workoutSelection) {
        self.m_workoutSelection          = [WorkoutSelection sharedInstance];
    }
  
    if (!self.m_workoutPlanManager) {
        self.m_workoutPlanManager        = [WorkoutPlanManager sharedInstance];
    }
    
    // First remove any previous data in the workout plan
    [self.m_workoutPlanManager deletePreviousWorkoutPlan];
    
    NSMutableArray *daysArray       = [NSMutableArray mutableArrayObject];

    if ([self.m_Monday isEqualToString:@"YES"]) {
        // index of daysSelected is the day number
        [daysArray addObject:@"Monday"];
        self.m_workoutArray                      = [self.m_workoutSelection workoutGoal:self.m_goal WithTheDay:(int)[daysArray indexOfObject:@"Monday"] ForTotalWorkOutDays:(int)self.m_totalNumberOfDaysSelected];
        FirstDayWorkoutPlanManager  *m_firstDayWorkoutPlanManager = [FirstDayWorkoutPlanManager sharedInstance];
        [m_firstDayWorkoutPlanManager saveFirstDayWorkoutPlanInDatabase:self.m_workoutArray];
    }
    
    if ([self.m_Tuesday isEqualToString:@"YES"]) {
        // index of daysSelected is the day number
        [daysArray addObject:@"Tuesday"];
        self.m_workoutArray                      = [self.m_workoutSelection workoutGoal:self.m_goal WithTheDay:(int)[daysArray indexOfObject:@"Tuesday"] ForTotalWorkOutDays:(int)self.m_totalNumberOfDaysSelected];
        SecondDayWorkoutPlanManager  *m_secondDayWorkoutPlanManager = [SecondDayWorkoutPlanManager sharedInstance];
        [m_secondDayWorkoutPlanManager saveSecondDayWorkoutPlanInDatabase:self.m_workoutArray];
    }
    
    if ([self.m_Wednesday isEqualToString:@"YES"]) {
        // index of daysSelected is the day number
        [daysArray addObject:@"Wednesday"];
        self.m_workoutArray                      = [self.m_workoutSelection workoutGoal:self.m_goal WithTheDay:(int)[daysArray indexOfObject:@"Wednesday"] ForTotalWorkOutDays:(int)self.m_totalNumberOfDaysSelected];
        ThirdDayWorkoutPlanManager  *m_thirdDayWorkoutPlanManager = [ThirdDayWorkoutPlanManager sharedInstance];
        [m_thirdDayWorkoutPlanManager saveThirdDayWorkoutPlanInDatabase:self.m_workoutArray];
    }
    
    if ([self.m_Thursday isEqualToString:@"YES"]) {
        // index of daysSelected is the day number
        [daysArray addObject:@"Thursday"];
        self.m_workoutArray                      = [self.m_workoutSelection workoutGoal:self.m_goal WithTheDay:(int)[daysArray indexOfObject:@"Thursday"] ForTotalWorkOutDays:(int)self.m_totalNumberOfDaysSelected];
        FourthDayWorkoutPlanManager  *m_fourthDayWorkoutPlanManager = [FourthDayWorkoutPlanManager sharedInstance];
        [m_fourthDayWorkoutPlanManager saveFourthDayWorkoutPlanInDatabase:self.m_workoutArray];
    }
    
    if ([self.m_Friday isEqualToString:@"YES"]) {
        // index of daysSelected is the day number
        [daysArray addObject:@"Friday"];
        self.m_workoutArray                      = [self.m_workoutSelection workoutGoal:self.m_goal WithTheDay:(int)[daysArray indexOfObject:@"Friday"] ForTotalWorkOutDays:(int) self.m_totalNumberOfDaysSelected];
        FifthDayWorkoutPlanManager  *m_fifthDayWorkoutPlanManager = [FifthDayWorkoutPlanManager sharedInstance];
        [m_fifthDayWorkoutPlanManager saveFifthDayWorkoutPlanInDatabase:self.m_workoutArray];
    }
    
    if ([self.m_Saturday isEqualToString:@"YES"]) {
        // index of daysSelected is the day number
        [daysArray addObject:@"Saturday"];
        self.m_workoutArray                      = [self.m_workoutSelection workoutGoal:self.m_goal WithTheDay:(int)[daysArray indexOfObject:@"Saturday"] ForTotalWorkOutDays:(int) self.m_totalNumberOfDaysSelected];
        SixthDayWorkoutPlanManager  *m_sixthDayWorkoutPlanManager = [SixthDayWorkoutPlanManager sharedInstance];
        [m_sixthDayWorkoutPlanManager saveSixthDayWorkoutPlanInDatabase:self.m_workoutArray];
    }
    
    if ([self.m_Sunday isEqualToString:@"YES"]) {
        // index of daysSelected is the day number
        [daysArray addObject:@"Sunday"];
        self.m_workoutArray                      = [self.m_workoutSelection workoutGoal:self.m_goal WithTheDay:(int)[daysArray indexOfObject:@"Sunday"] ForTotalWorkOutDays:(int)self.m_totalNumberOfDaysSelected];
        SeventhDayWorkoutPlanManager  *m_seventhDayWorkoutPlanManager = [SeventhDayWorkoutPlanManager sharedInstance];
        [m_seventhDayWorkoutPlanManager saveSeventhDayWorkoutPlanInDatabase:self.m_workoutArray];
    }
}

@end
