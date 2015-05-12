//
//  IntensityViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-01-13.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "IntensityViewController.h"
#import "IntensityViewController+BMRCalculator.h"
#import "GoalsViewController.h"
#import "MealPlanManager.h"
#import "BreakFastPlanManager.h"
#import "FirstSnackPlanManager.h"
#import "LunchPlanManager.h"
#import "SecondSnackPlanManager.h"
#import "DinnerPlanManager.h"
#import "ThirdSnackPlanManager.h"
#import "MealPlanSelection.h"
#import "MealViewController.h"
#import "GenderViewController.h"

@interface IntensityViewController ()

// Take user to goals view controller
- (void)moveToGoalViewController:(id)sender;
// Calculate BMR
- (void)calculateBMR;
// BMR details maintained
- (NSString *)insertIntoBMREmail_Id:(NSString *)email_id Sex:(NSString *)sex Age:(NSNumber *)age Weight:(NSNumber *)weight Height:(NSNumber *)height BMR:(NSNumber *)bmr Date:(NSDate *)date Exercise_Mode:(NSString *)exercise_mode;
- (IBAction)moveToPreviousViewController:(id)sender;

@end

@implementation IntensityViewController

// Exercise intensity active images
static NSString *m_intensity_light_active                   = @"tfn-intensity_light_active";
static NSString *m_intensity_active_active                  = @"tfn-intensity_active_active";
static NSString *m_intensity_beast_active                   = @"tfn-intensity_beast_active";

// ProfileViewController class object
ProfileViewController *m_profileViewController;
// ExerciseViewController class object
ExerciseViewController *m_exerciseViewController;
// MealViewController class object
MealViewController *m_mealViewController;
// CalenderViewController class object
CalenderViewController *m_calenderViewController;
// GoalsViewController class object
GoalsViewController *m_goalsViewController;
// MusicTracksViewController class object
MusicTracksViewController *m_musicTracksViewController;
// GenderViewController class object
GenderViewController *m_genderViewController;
// ViewFactory class object
ViewFactory *m_controllerViews;
// ViewTransition class object
ViewTransitions *m_transition;
// Database class object
Database *m_database;
// Meal Plan class object
MealPlanManager *m_mealPlanManager;
// Meal Plan selection class object
MealPlanSelection *m_mealPlanSelection;
// Exercise intensity array
NSMutableArray *m_exercise_Intensity_Images;
// Exercise intensity array
NSMutableArray *m_exercise_Intensity_Active_Images;
// Exercise intensity
NSString *m_exerciseIntensity                                = @"";
// Exercise light intensity
NSString *m_exerciseLightIntensity                           = @"light exercise";
// Exercise active intensity
NSString *m_exerciseActiveIntensity                          = @"active exercise";
// Exercise beast intensity
NSString *m_exerciseBeastIntensity                           = @"beast exercise";

// User email id
NSString *m_userEmailID;
// Calorie array
NSMutableArray *m_calorieArray;

UILabel *bmrLabel;
UIButton *doneButton;
UIImageView *backgroundImageView;
UIActivityIndicatorView *indicatorView;
// Light Intensity Image Button
UIButton *lightIntensityImageButton;
// Active Intensity Image Button
UIButton *activeIntensityImageButton;
// Beast Intensity Image Button
UIButton *beastIntensityImageButton;
UIButton *messageButton;

/*
 Singleton IntensityViewController object
 */
+ (IntensityViewController *)sharedInstance {
	static IntensityViewController *globalInstance;
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
 Move to supplements at website
 */
- (void)moveToSupplementsAtWebsite:(id)sender
{
    NSURL *url                  = [[NSURL alloc] initWithString:@"http://totalfitness.com/supplements"];
    [[UIApplication sharedApplication] openURL:url];
}

/*
 Take user to goals view controller
 */
- (void)moveToGoalViewController:(id)sender
{
    if (!m_goalsViewController) {
        m_goalsViewController           = [GoalsViewController sharedInstance];
    }
    id instanceObject               = m_goalsViewController;
    [self moveToView:m_goalsViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Load up intensity images
 */
- (void)loadUpExerciseIntensityActiveImages
{
    if (!m_exercise_Intensity_Active_Images) {
        m_exercise_Intensity_Active_Images             = [NSMutableArray mutableArrayObject];
    }
    [m_exercise_Intensity_Active_Images addObject:m_intensity_light_active];
    [m_exercise_Intensity_Active_Images addObject:m_intensity_active_active];
    [m_exercise_Intensity_Active_Images addObject:m_intensity_beast_active];
}

/*
 Display message to user with animation
 */
- (void)displayMessage:(NSString *)message
{
    messageButton.hidden   = NO;
    
    [UIButton animateWithDuration:3.0f animations:^{messageButton.alpha = 5.0;} completion:nil];
    
    [messageButton setTitle:message forState:UIControlStateNormal];
    
    if (!m_transition) {
        m_transition    = [ViewTransitions sharedInstance];
    }
    [m_transition performTransitionFromBottom:messageButton];
    
    [UIButton animateWithDuration:5.0f animations:^{messageButton.alpha = 0.0;} completion:nil];
}

/*
 BMR details maintained
 */
- (NSString *)insertIntoBMREmail_Id:(NSString *)email_id Sex:(NSString *)sex Age:(NSNumber *)age Weight:(NSNumber *)weight Height:(NSNumber *)height BMR:(NSNumber *)bmr Date:(NSDate *)date Exercise_Mode:(NSString *)exercise_mode
{
    NSString *bmrStatus;
    if (!m_database) {
        m_database      = [Database alloc];
    }
    bmrStatus           = [m_database insertIntoBMREmail_Id:email_id Sex:sex Age:age Weight:weight Height:height BMR:bmr Date:date Exercise_Mode:exercise_mode];
    
    return bmrStatus;
}

/*
 Calculate BMR
 */
- (void)calculateBMR
{
    if (!m_profileViewController) {
        m_profileViewController             = [ProfileViewController sharedInstance];
    }
    if (!m_genderViewController) {
        m_genderViewController              = [GenderViewController sharedInstance];
    }
    bmrLabel.text                      = [NSString stringWithFormat:@"%d",[self calculateBMRSex:m_genderViewController.sex Weight:m_profileViewController.weight Age:m_profileViewController.age Height:m_profileViewController.height ExerciseIntensity:m_exerciseIntensity]];
}

// Done
- (void)done:(id)sender
{
    NSString *exerciseIntensityStatus   = @"";
    NSDate *date                        = [NSDate date];

    if (!m_profileViewController) {
        m_profileViewController         = [ProfileViewController sharedInstance];
    }
    
    if (!m_genderViewController) {
        m_genderViewController          = [GenderViewController sharedInstance];
    }
    
    if (([m_exerciseIntensity length] != 0) && (m_exerciseIntensity != NULL)) { // Intensity is selected
        
        if ((m_profileViewController.age != 0) && (m_profileViewController.weight != 0) && (m_profileViewController.height != 0) && ([m_genderViewController.sex length] != 0) && (m_genderViewController.sex != NULL)) {
            if (!m_database) {
                m_database                  = [Database alloc];
            }
            NSNumberFormatter *formatter    = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            // Clean up the height format with ' for feet and ” for inches
            NSString *heightString          = m_profileViewController.height;
            heightString                      = [[heightString componentsSeparatedByCharactersInSet:
                                                                       [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                                                                      componentsJoinedByString:@""];
            // Convert to nsnumber for insert into database
            NSNumber *theHeight             = [formatter numberFromString:heightString];
            NSNumber *theBMR                = [formatter numberFromString:bmrLabel.text];

            // Save BMR details in the database
            exerciseIntensityStatus         = [m_database insertIntoBMREmail_Id:m_userEmailID Sex:m_genderViewController.sex Age:[NSNumber numberWithInt:m_profileViewController.age] Weight:[NSNumber numberWithInt:m_profileViewController.weight] Height:theHeight BMR:theBMR Date:date Exercise_Mode:m_exerciseIntensity];
            
            [self saveMealPlanIntoDatabaseWithBMR:[bmrLabel.text intValue] ForGender:m_genderViewController.sex];
            // So that we have new static gender
            [NSString setGenderOfUser:m_genderViewController.sex];
            // So that we have new static user email
            [NSString resetEmail];
            if ([exerciseIntensityStatus isEqualToString:@"live"]) { // If the insert is successful
                // Take user to GoalsViewController
                [self moveToGoalViewController:sender];
            }
            else {
                [self displayMessage:@"We failed save to your profile, please try again."];
            }
        }
        else {
            [self displayMessage:@"Please start over by going back."];
        }
    }
    else {
        [self displayMessage:@"Please select an exercise intensity."];
    }
}

/*
 Update intensity button
 */
- (void)updateIntensityButton:(id)sender
{


    if (sender == lightIntensityImageButton) {
        if ([m_exerciseLightIntensity isEqualToString:@"light exercise"]) {
            // assign the mode
            m_exerciseLightIntensity               = @"light exercise active";
            m_exerciseActiveIntensity              = @"active exercise";
            m_exerciseBeastIntensity               = @"beast exercise";
            m_exerciseIntensity                    = @"light exercise";
            // set light intensity image
            [lightIntensityImageButton setBackgroundImage:[UIImage imageNamed:[m_exercise_Intensity_Active_Images objectAtIndex:0]] forState:UIControlStateNormal];
            [activeIntensityImageButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
            [beastIntensityImageButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];

        }
        else {
            // assign the mode
            m_exerciseLightIntensity               = @"light exercise";
            // set light intensity image
            [lightIntensityImageButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
        }
    }
    else if (sender == activeIntensityImageButton) {
        if ([m_exerciseActiveIntensity isEqualToString:@"active exercise"]) {
            // assign the mode
            m_exerciseActiveIntensity               = @"active exercise active";
            m_exerciseLightIntensity                = @"light exercise";
            m_exerciseBeastIntensity                = @"beast exercise";
            m_exerciseIntensity                     = @"active exercise";
            [activeIntensityImageButton setBackgroundImage:[UIImage imageNamed:[m_exercise_Intensity_Active_Images objectAtIndex:1]] forState:UIControlStateNormal];
            [lightIntensityImageButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
            [beastIntensityImageButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];

        }
        else {
            // assign the mode
            m_exerciseActiveIntensity               = @"active exercise";
            [activeIntensityImageButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
        }
    }
    else if (sender == beastIntensityImageButton) {
        if ([m_exerciseBeastIntensity isEqualToString:@"beast exercise"]) {
            // assign the mode
            m_exerciseBeastIntensity               = @"beast exercise active";
            m_exerciseLightIntensity               = @"light exercise";
            m_exerciseActiveIntensity              = @"active exercise";
            m_exerciseIntensity                    = @"beast exercise";
            // set active intensity image
            [beastIntensityImageButton setBackgroundImage:[UIImage imageNamed:[m_exercise_Intensity_Active_Images objectAtIndex:2]] forState:UIControlStateNormal];
            [activeIntensityImageButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
            [lightIntensityImageButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
        }
        else {
            // assign the mode
            m_exerciseBeastIntensity               = @"beast exercise";
            // set active intensity image
            [beastIntensityImageButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
        }
    }
}

/*
 Select exercse intensity
 */
- (void)selectExerciseIntensity:(id)sender
{
    // update intensity button
    [self updateIntensityButton:sender];
    // calculate the bmr
    [self calculateBMR];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
        // Adjust the height of the view
        
    CGRect backgroundImageViewFrame;
    CGRect doneButtonFrame;
    
    // if iPhone 5 adjust view size
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        backgroundImageViewFrame          = CGRectMake(0.0f, 60.0f, 320.0f, 520.0f);
        doneButtonFrame                   = CGRectMake(252.0f, 568 - 65, 60.0f, 55.0f);
    }
    else {
        backgroundImageViewFrame          = CGRectMake(0.0f, 60.0f, 320.0f, 420.0f);
        doneButtonFrame                   = CGRectMake(252.0f, 425.0f, 60.0f, 40.0f);
    }
    
    backgroundImageView                   = [[UIImageView alloc] initWithFrame:backgroundImageViewFrame];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        backgroundImageView.image         = [UIImage imageNamed:@"intensity.png"];
    }
    else {
        backgroundImageView.image         = [UIImage imageNamed:@"intensity.png"];
    }
    backgroundImageView.userInteractionEnabled  = NO;
    [self.view addSubview:backgroundImageView];
    
    CGRect lightIntensityImageButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        lightIntensityImageButtonFrame              = CGRectMake(0.0f, 64.0f, 320.0f, 142.0f);
    }
    else {
        lightIntensityImageButtonFrame              = CGRectMake(0.0f, 64.0f, 320.0f, 113.0f);
    }
    lightIntensityImageButton                   = [[UIButton alloc] initWithFrame:lightIntensityImageButtonFrame];
    [self.view addSubview:lightIntensityImageButton];
    [lightIntensityImageButton addTarget:self action:@selector(selectExerciseIntensity:) forControlEvents:UIControlEventTouchUpInside];

    CGRect activeIntensityImageButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        activeIntensityImageButtonFrame              = CGRectMake(0.0f, 208.0f, 320.0f, 142.0f);
    }
    else {
        activeIntensityImageButtonFrame              = CGRectMake(0.0f, 180.0f, 320.0f, 114.0f);
    }
    activeIntensityImageButton             = [[UIButton alloc] initWithFrame:activeIntensityImageButtonFrame];
    [self.view addSubview:activeIntensityImageButton];
    [activeIntensityImageButton addTarget:self action:@selector(selectExerciseIntensity:) forControlEvents:UIControlEventTouchUpInside];

    CGRect beastIntensityImageButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        beastIntensityImageButtonFrame              = CGRectMake(0.0f, 352.0f, 320.0f, 142.0f);
    }
    else {
        beastIntensityImageButtonFrame              = CGRectMake(0.0f, 296.0f, 320.0f, 113.0f);
    }
    beastIntensityImageButton              = [[UIButton alloc] initWithFrame:beastIntensityImageButtonFrame];
    [self.view addSubview:beastIntensityImageButton];
    [beastIntensityImageButton addTarget:self action:@selector(selectExerciseIntensity:) forControlEvents:UIControlEventTouchUpInside];
    
    // load up the exercise intensity selected images
    [self loadUpExerciseIntensityActiveImages];
    
    CGRect messageButtonFrame             = CGRectMake(0.0f, 64.0f, 320.0f, 25.0f);
    messageButton                         = [[UIButton alloc] initWithFrame:messageButtonFrame];
    messageButton.backgroundColor         = [UIColor clearColor];
    messageButton.titleLabel.textColor    = [UIColor darkGrayColor];
    messageButton.titleLabel.font         = [UIFont customFontWithSize:13];
    messageButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    messageButton.titleLabel.numberOfLines = 2;
    messageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [messageButton addTarget:self action:@selector(displayMessage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:messageButton];
    
    doneButton                            = [[UIButton alloc] initWithFrame:doneButtonFrame];
    doneButton.userInteractionEnabled     = YES;
    doneButton.hidden                     = NO;
    doneButton.enabled                    = YES;
    [doneButton becomeFirstResponder];
    [self.view addSubview:doneButton];
    [doneButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect bmrLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        bmrLabelFrame                   = CGRectMake(40.0f, 523.0f, 50.0f, 30.0f);
    }
    else {
        bmrLabelFrame                   = CGRectMake(40.0f, 430.0f, 50.0f, 30.0f);
    }
    bmrLabel                               = [[UILabel alloc] initWithFrame:bmrLabelFrame];
    bmrLabel.backgroundColor               = [UIColor clearColor];
    bmrLabel.textAlignment                 = NSTextAlignmentCenter;
    bmrLabel.textColor                     = [UIColor redColor];
    bmrLabel.font                          = [UIFont customFontWithSize:15];
    [self.view addSubview:bmrLabel];

}

- (void)viewWillAppear:(BOOL)animated
{
    // calculate bmr
    [self calculateBMR];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Save meal plan into database
- (void)saveMealPlanIntoDatabaseWithBMR:(int)bmr ForGender:(NSString *)gender
{
    // m_calorieArray to be displayed on the tableview
    if(!m_calorieArray)
        m_calorieArray              = [NSMutableArray mutableArrayObject];
    
    if (!m_mealPlanSelection) {
        m_mealPlanSelection         = [MealPlanSelection sharedInstance];
    }
    
    m_calorieArray                  = [m_mealPlanSelection calorieSelection:bmr Gender:gender];

//    if (!m_mealPlanManager) {
//        m_mealPlanManager           = [MealPlanManager sharedInstance];
//    }
//    [m_mealPlanManager saveMealPlanInDatabase:m_calorieArray];
    BreakFastPlanManager *m_breakFastPlanManager     = [BreakFastPlanManager sharedInstance];
    [m_breakFastPlanManager saveBreakFastPlanInDatabase:[m_calorieArray objectAtIndex:0]];
    
    FirstSnackPlanManager *m_firstSnackPlanManager   = [FirstSnackPlanManager sharedInstance];
    [m_firstSnackPlanManager saveFirstSnackPlanInDatabase:[m_calorieArray objectAtIndex:1]];
    
    LunchPlanManager *m_lunchPlanManager             = [LunchPlanManager sharedInstance];
    [m_lunchPlanManager saveLunchPlanInDatabase:[m_calorieArray objectAtIndex:2]];
    
    SecondSnackPlanManager *m_secondSnackPlanManager = [SecondSnackPlanManager sharedInstance];
    [m_secondSnackPlanManager saveSecondSnackPlanInDatabase:[m_calorieArray objectAtIndex:3]];
    
    DinnerPlanManager *m_dinnerPlanManager           = [DinnerPlanManager sharedInstance];
    [m_dinnerPlanManager saveDinnerPlanInDatabase:[m_calorieArray objectAtIndex:4]];
    
    ThirdSnackPlanManager *m_thirdPlanManager        = [ThirdSnackPlanManager sharedInstance];
    [m_thirdPlanManager saveThirdSnackPlanInDatabase:[m_calorieArray objectAtIndex:5]];
}

@end
