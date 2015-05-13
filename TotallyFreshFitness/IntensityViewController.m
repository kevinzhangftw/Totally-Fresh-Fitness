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

@property (strong, nonatomic) Database *m_database;
@property (strong, nonatomic) ProfileViewController *m_profileViewController;
@property (strong, nonatomic) ExerciseViewController *m_exerciseViewController;
@property (strong, nonatomic) MealViewController *m_mealViewController;
@property (strong, nonatomic) CalenderViewController *m_calenderViewController;
@property (strong, nonatomic) GoalsViewController *m_goalsViewController;
@property (strong, nonatomic) MusicTracksViewController *m_musicTracksViewController;
@property (strong, nonatomic) GenderViewController *m_genderViewController;
@property (strong, nonatomic) ViewFactory *m_controllerViews;
@property (strong, nonatomic) ViewTransitions *m_transition;
@property (strong, nonatomic) MealPlanManager *m_mealPlanManager;
@property (strong, nonatomic) MealPlanSelection *m_mealPlanSelection;
@property (strong, nonatomic) NSMutableArray *m_exercise_Intensity_Images;
@property (strong, nonatomic) NSMutableArray *m_exercise_Intensity_Active_Images;
@property (strong, nonatomic) NSString *m_exerciseIntensity; //= @"";
@property (strong, nonatomic) NSString *m_exerciseLightIntensity; //= @"light exercise";
@property (strong, nonatomic) NSString *m_exerciseActiveIntensity; //= @"active exercise";
@property (strong, nonatomic) NSString *m_exerciseBeastIntensity; //= @"beast exercise";
@property (strong, nonatomic) NSString *m_userEmailID;
@property (strong, nonatomic) NSMutableArray *m_calorieArray;
@property (nonatomic) UILabel *bmrLabel;
@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property (strong, nonatomic) UIButton *lightIntensityImageButton;
@property (strong, nonatomic) UIButton *activeIntensityImageButton;
@property (strong, nonatomic) UIButton *beastIntensityImageButton;
@property (strong, nonatomic) UIButton *messageButton;
@property (strong, nonatomic) UIButton *doneButton;

@end

@implementation IntensityViewController

// Exercise intensity active images
static NSString *m_intensity_light_active                   = @"tfn-intensity_light_active";
static NSString *m_intensity_active_active                  = @"tfn-intensity_active_active";
static NSString *m_intensity_beast_active                   = @"tfn-intensity_beast_active";


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
    if (!self.m_transition) {
        self.m_transition                    = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionFromRight:self.view.superview];
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
    if (!self.m_goalsViewController) {
        self.m_goalsViewController           = [GoalsViewController sharedInstance];
    }
    id instanceObject               = self.m_goalsViewController;
    [self moveToView:self.m_goalsViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Load up intensity images
 */
- (void)loadUpExerciseIntensityActiveImages
{
    if (!self.m_exercise_Intensity_Active_Images) {
        self.m_exercise_Intensity_Active_Images             = [NSMutableArray mutableArrayObject];
    }
    [self.m_exercise_Intensity_Active_Images addObject:m_intensity_light_active];
    [self.m_exercise_Intensity_Active_Images addObject:m_intensity_active_active];
    [self.m_exercise_Intensity_Active_Images addObject:m_intensity_beast_active];
}

/*
 Display message to user with animation
 */
- (void)displayMessage:(NSString *)message
{
    self.messageButton.hidden   = NO;
    
    [UIButton animateWithDuration:3.0f animations:^{self.messageButton.alpha = 5.0;} completion:nil];
    
    [self.messageButton setTitle:message forState:UIControlStateNormal];
    
    if (!self.m_transition) {
        self.m_transition    = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionFromBottom:self.messageButton];
    
    [UIButton animateWithDuration:5.0f animations:^{self.messageButton.alpha = 0.0;} completion:nil];
}

/*
 BMR details maintained
 */
- (NSString *)insertIntoBMREmail_Id:(NSString *)email_id Sex:(NSString *)sex Age:(NSNumber *)age Weight:(NSNumber *)weight Height:(NSNumber *)height BMR:(NSNumber *)bmr Date:(NSDate *)date Exercise_Mode:(NSString *)exercise_mode
{
    NSString *bmrStatus;
    if (!self.m_database) {
        self.m_database      = [Database alloc];
    }
    bmrStatus           = [self.m_database insertIntoBMREmail_Id:email_id Sex:sex Age:age Weight:weight Height:height BMR:bmr Date:date Exercise_Mode:exercise_mode];
    
    return bmrStatus;
}

/*
 Calculate BMR
 */
- (void)calculateBMR
{
    if (!self.m_profileViewController) {
        self.m_profileViewController             = [ProfileViewController sharedInstance];
    }
    if (!self.m_genderViewController) {
        self.m_genderViewController              = [GenderViewController sharedInstance];
    }
    self.bmrLabel.text                      = [NSString stringWithFormat:@"%d",[self calculateBMRSex:self.m_genderViewController.sex Weight:self.m_profileViewController.weight Age:self.m_profileViewController.age Height:self.m_profileViewController.height ExerciseIntensity:self.m_exerciseIntensity]];
}

// Done
- (void)done:(id)sender
{
    NSString *exerciseIntensityStatus   = @"";
    NSDate *date                        = [NSDate date];

    if (!self.m_profileViewController) {
        self.m_profileViewController         = [ProfileViewController sharedInstance];
    }
    
    if (!self.m_genderViewController) {
        self.m_genderViewController          = [GenderViewController sharedInstance];
    }
    
    if (([self.m_exerciseIntensity length] != 0) && (self.m_exerciseIntensity != NULL)) { // Intensity is selected
        
        if ((self.m_profileViewController.age != 0) && (self.m_profileViewController.weight != 0) && (self.m_profileViewController.height != 0) && ([self.m_genderViewController.sex length] != 0) && (self.m_genderViewController.sex != NULL)) {
            if (!self.m_database) {
                self.m_database                  = [Database alloc];
            }
            NSNumberFormatter *formatter    = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            // Clean up the height format with ' for feet and ” for inches
            NSString *heightString          = self.m_profileViewController.height;
            heightString                      = [[heightString componentsSeparatedByCharactersInSet:
                                                                       [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                                                                      componentsJoinedByString:@""];
            // Convert to nsnumber for insert into database
            NSNumber *theHeight             = [formatter numberFromString:heightString];
            NSNumber *theBMR                = [formatter numberFromString:self.bmrLabel.text];

            // Save BMR details in the database
            exerciseIntensityStatus         = [self.m_database insertIntoBMREmail_Id:self.m_userEmailID Sex:self.m_genderViewController.sex Age:[NSNumber numberWithInt:self.m_profileViewController.age] Weight:[NSNumber numberWithInt:self.m_profileViewController.weight] Height:theHeight BMR:theBMR Date:date Exercise_Mode:self.m_exerciseIntensity];
            
            [self saveMealPlanIntoDatabaseWithBMR:[self.bmrLabel.text intValue] ForGender:self.m_genderViewController.sex];
            // So that we have new static gender
            [NSString setGenderOfUser:self.m_genderViewController.sex];
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


    if (sender == self.lightIntensityImageButton) {
        if ([self.m_exerciseLightIntensity isEqualToString:@"light exercise"]) {
            // assign the mode
            self.m_exerciseLightIntensity               = @"light exercise active";
            self.m_exerciseActiveIntensity              = @"active exercise";
            self.m_exerciseBeastIntensity               = @"beast exercise";
            self.m_exerciseIntensity                    = @"light exercise";
            // set light intensity image
            [self.lightIntensityImageButton setBackgroundImage:[UIImage imageNamed:[self.m_exercise_Intensity_Active_Images objectAtIndex:0]] forState:UIControlStateNormal];
            [self.activeIntensityImageButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
            [self.beastIntensityImageButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];

        }
        else {
            // assign the mode
            self.m_exerciseLightIntensity               = @"light exercise";
            // set light intensity image
            [self.lightIntensityImageButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
        }
    }
    else if (sender == self.activeIntensityImageButton) {
        if ([self.m_exerciseActiveIntensity isEqualToString:@"active exercise"]) {
            // assign the mode
            self.m_exerciseActiveIntensity               = @"active exercise active";
            self.m_exerciseLightIntensity                = @"light exercise";
            self.m_exerciseBeastIntensity                = @"beast exercise";
            self.m_exerciseIntensity                     = @"active exercise";
            [self.activeIntensityImageButton setBackgroundImage:[UIImage imageNamed:[self.m_exercise_Intensity_Active_Images objectAtIndex:1]] forState:UIControlStateNormal];
            [self.lightIntensityImageButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
            [self.beastIntensityImageButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];

        }
        else {
            // assign the mode
            self.m_exerciseActiveIntensity               = @"active exercise";
            [self.activeIntensityImageButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
        }
    }
    else if (sender == self.beastIntensityImageButton) {
        if ([self.m_exerciseBeastIntensity isEqualToString:@"beast exercise"]) {
            // assign the mode
            self.m_exerciseBeastIntensity               = @"beast exercise active";
            self.m_exerciseLightIntensity               = @"light exercise";
            self.m_exerciseActiveIntensity              = @"active exercise";
            self.m_exerciseIntensity                    = @"beast exercise";
            // set active intensity image
            [self.beastIntensityImageButton setBackgroundImage:[UIImage imageNamed:[self.m_exercise_Intensity_Active_Images objectAtIndex:2]] forState:UIControlStateNormal];
            [self.activeIntensityImageButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
            [self.lightIntensityImageButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
        }
        else {
            // assign the mode
            self.m_exerciseBeastIntensity               = @"beast exercise";
            // set active intensity image
            [self.beastIntensityImageButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
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
    
    self.backgroundImageView                   = [[UIImageView alloc] initWithFrame:backgroundImageViewFrame];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.backgroundImageView.image         = [UIImage imageNamed:@"intensity.png"];
    }
    else {
        self.backgroundImageView.image         = [UIImage imageNamed:@"intensity.png"];
    }
    self.backgroundImageView.userInteractionEnabled  = NO;
    [self.view addSubview:self.backgroundImageView];
    
    CGRect lightIntensityImageButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        lightIntensityImageButtonFrame              = CGRectMake(0.0f, 64.0f, 320.0f, 142.0f);
    }
    else {
        lightIntensityImageButtonFrame              = CGRectMake(0.0f, 64.0f, 320.0f, 113.0f);
    }
    self.lightIntensityImageButton                   = [[UIButton alloc] initWithFrame:lightIntensityImageButtonFrame];
    [self.view addSubview:self.lightIntensityImageButton];
    [self.lightIntensityImageButton addTarget:self action:@selector(selectExerciseIntensity:) forControlEvents:UIControlEventTouchUpInside];

    CGRect activeIntensityImageButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        activeIntensityImageButtonFrame              = CGRectMake(0.0f, 208.0f, 320.0f, 142.0f);
    }
    else {
        activeIntensityImageButtonFrame              = CGRectMake(0.0f, 180.0f, 320.0f, 114.0f);
    }
    self.activeIntensityImageButton             = [[UIButton alloc] initWithFrame:activeIntensityImageButtonFrame];
    [self.view addSubview:self.activeIntensityImageButton];
    [self.activeIntensityImageButton addTarget:self action:@selector(selectExerciseIntensity:) forControlEvents:UIControlEventTouchUpInside];

    CGRect beastIntensityImageButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        beastIntensityImageButtonFrame              = CGRectMake(0.0f, 352.0f, 320.0f, 142.0f);
    }
    else {
        beastIntensityImageButtonFrame              = CGRectMake(0.0f, 296.0f, 320.0f, 113.0f);
    }
    self.beastIntensityImageButton              = [[UIButton alloc] initWithFrame:beastIntensityImageButtonFrame];
    [self.view addSubview:self.beastIntensityImageButton];
    [self.beastIntensityImageButton addTarget:self action:@selector(selectExerciseIntensity:) forControlEvents:UIControlEventTouchUpInside];
    
    // load up the exercise intensity selected images
    [self loadUpExerciseIntensityActiveImages];
    
    CGRect messageButtonFrame             = CGRectMake(0.0f, 64.0f, 320.0f, 25.0f);
    self.messageButton                         = [[UIButton alloc] initWithFrame:messageButtonFrame];
    self.messageButton.backgroundColor         = [UIColor clearColor];
    self.messageButton.titleLabel.textColor    = [UIColor darkGrayColor];
    self.messageButton.titleLabel.font         = [UIFont customFontWithSize:13];
    self.messageButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messageButton.titleLabel.numberOfLines = 2;
    self.messageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.messageButton addTarget:self action:@selector(displayMessage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.messageButton];
    
    self.doneButton                            = [[UIButton alloc] initWithFrame:doneButtonFrame];
    self.doneButton.userInteractionEnabled     = YES;
    self.doneButton.hidden                     = NO;
    self.doneButton.enabled                    = YES;
    [self.doneButton becomeFirstResponder];
    [self.view addSubview:self.doneButton];
    [self.doneButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect bmrLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        bmrLabelFrame                   = CGRectMake(40.0f, 523.0f, 50.0f, 30.0f);
    }
    else {
        bmrLabelFrame                   = CGRectMake(40.0f, 430.0f, 50.0f, 30.0f);
    }
    self.bmrLabel                               = [[UILabel alloc] initWithFrame:bmrLabelFrame];
    self.bmrLabel.backgroundColor               = [UIColor clearColor];
    self.bmrLabel.textAlignment                 = NSTextAlignmentCenter;
    self.bmrLabel.textColor                     = [UIColor redColor];
    self.bmrLabel.font                          = [UIFont customFontWithSize:15];
    [self.view addSubview:self.bmrLabel];

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
    if(!self.m_calorieArray)
        self.m_calorieArray              = [NSMutableArray mutableArrayObject];
    
    if (!self.m_mealPlanSelection) {
        self.m_mealPlanSelection         = [MealPlanSelection sharedInstance];
    }
    
    self.m_calorieArray                  = [self.m_mealPlanSelection calorieSelection:bmr Gender:gender];

//    if (!m_mealPlanManager) {
//        m_mealPlanManager           = [MealPlanManager sharedInstance];
//    }
//    [m_mealPlanManager saveMealPlanInDatabase:m_calorieArray];
    BreakFastPlanManager *m_breakFastPlanManager     = [BreakFastPlanManager sharedInstance];
    [m_breakFastPlanManager saveBreakFastPlanInDatabase:[self.m_calorieArray objectAtIndex:0]];
    
    FirstSnackPlanManager *m_firstSnackPlanManager   = [FirstSnackPlanManager sharedInstance];
    [m_firstSnackPlanManager saveFirstSnackPlanInDatabase:[self.m_calorieArray objectAtIndex:1]];
    
    LunchPlanManager *m_lunchPlanManager             = [LunchPlanManager sharedInstance];
    [m_lunchPlanManager saveLunchPlanInDatabase:[self.m_calorieArray objectAtIndex:2]];
    
    SecondSnackPlanManager *m_secondSnackPlanManager = [SecondSnackPlanManager sharedInstance];
    [m_secondSnackPlanManager saveSecondSnackPlanInDatabase:[self.m_calorieArray objectAtIndex:3]];
    
    DinnerPlanManager *m_dinnerPlanManager           = [DinnerPlanManager sharedInstance];
    [m_dinnerPlanManager saveDinnerPlanInDatabase:[self.m_calorieArray objectAtIndex:4]];
    
    ThirdSnackPlanManager *m_thirdPlanManager        = [ThirdSnackPlanManager sharedInstance];
    [m_thirdPlanManager saveThirdSnackPlanInDatabase:[self.m_calorieArray objectAtIndex:5]];
}

@end
