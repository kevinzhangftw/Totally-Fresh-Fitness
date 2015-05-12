//
//  GoalsViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-01.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import "GoalsViewController.h"
#import "SupplementPlanManager.h"
#import "BreakFastSupplementPlanManager.h"
#import "PreWorkoutSupplementPlanManager.h"
#import "PostWorkoutSupplementPlanManager.h"
#import "BeforeBedSupplementPlanManager.h"
#import "SupplementPlanSelection.h"
#import "ExerciseLevelViewController.h"

@interface GoalsViewController ()

// Load up the goals images
- (void)loadGoalsImages;
// Move to moveToExerciseLevelViewController
- (void)moveToExerciseLevelViewController:(id)sender;

@end

@implementation GoalsViewController

// Build muscle image
NSString *const m_tfnBuildMuscle                         =   @"tfn-build_active.png";
// Build gettoned image
NSString *const m_tfnGetToned                            =   @"tfn-gettoned_active.png";
// Build muscle isolation image
NSString *const m_tfnMuscleIsolation                     =   @"tfn-iso_active.png";
// Build shred fact image
NSString *const m_tfnShredFat                            =   @"tfn-shredfat_active.png";

// ExerciseLevelViewController class object
ExerciseLevelViewController *m_exerciseLevelViewController;
// SupplementPlanManager class object
SupplementPlanManager *m_supplementPlanManager;
// SupplementPlanSelection class object
SupplementPlanSelection *m_supplementPlanSelection;
// Database class object
Database *m_database;
// ViewFactory class object
ViewFactory *m_controllerViews;
// ViewTransitions class object
ViewTransitions *m_transition;
// All goals images - images are the cell background
NSMutableArray  *m_goalsImages;
// User email id from database
NSString *m_userEmailID;

NSString *goal              = @"";

@synthesize messageButton;
@synthesize shredFatButton;
@synthesize getTonedButton;
@synthesize buildMuscleMassButton;
@synthesize buildMuscleIsolationButton;

/*
 Singleton GoalsViewController object
 */
+ (GoalsViewController *)sharedInstance {
	static GoalsViewController *globalInstance;
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
 Goals images are placed in an array
 */
- (void)loadGoalsImages
{
    if (!m_goalsImages) {
        m_goalsImages                 = [NSMutableArray mutableArrayObject];
    }
    // Goals images
    [m_goalsImages addObject:m_tfnShredFat];
    [m_goalsImages addObject:m_tfnGetToned];
    [m_goalsImages addObject:m_tfnBuildMuscle];
    [m_goalsImages addObject:m_tfnMuscleIsolation];
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
    [self moveToView:m_exerciseLevelViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Insert goal into database
 */
- (void)insertGoalIntoDatabase:(NSString *)goal {
    // Goal
    NSString *goalStatus  = @"";
    
    NSDate *date          = [NSDate date];

    if (!m_database) {
        m_database      = [Database alloc];
    }
    if (!m_userEmailID) {
        m_userEmailID   = [NSString getUserEmail];
    }
    goalStatus      = [m_database insertIntoGoalsEmail_Id:m_userEmailID Date:date Goal:goal];

    if ([goalStatus isEqualToString:@"updated"]) { // If the insert is successful
        [self moveToExerciseLevelViewController:self];
    }
    else {
        [self displayMessage:@"We failed save to goals, please try later"];
    }
}
- (IBAction)nextView:(id)sender {
    
    if(![goal isEqualToString:@""]){
        [self insertGoalIntoDatabase:goal];
    }
}

/*
 Update goal button
 */
- (void)updateGoalButton:(id)sender
{


    //NSString *goal              = @"";
    
    if (sender == self.shredFatButton) {
        if (self.shredFatButton.tag == 0) {
            // assign the mode
            self.shredFatButton.tag               = 1;
            self.getTonedButton.tag               = 0;
            self.buildMuscleMassButton.tag        = 0;
            self.buildMuscleIsolationButton.tag   = 0;
            // set light intensity image
            [self.shredFatButton setBackgroundImage:[UIImage imageNamed:[m_goalsImages objectAtIndex:0]] forState:UIControlStateNormal];
            [self.getTonedButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
            [self.buildMuscleMassButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
            [self.buildMuscleIsolationButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
            goal                                  = @"SHRED FAT";
            
            [self insertGoalIntoDatabase:goal];
            


        }
        else {
            // assign the mode
            self.shredFatButton.tag               = 0;
            // set light intensity image
            [self.shredFatButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
        }
    }
    else if (sender == self.getTonedButton) {
        if (self.getTonedButton.tag == 0) {
            // assign the mode
            self.shredFatButton.tag               = 0;
            self.getTonedButton.tag               = 1;
            self.buildMuscleMassButton.tag        = 0;
            self.buildMuscleIsolationButton.tag   = 0;
            // set light intensity image
            [self.shredFatButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
            [self.getTonedButton setBackgroundImage:[UIImage imageNamed:[m_goalsImages objectAtIndex:1]] forState:UIControlStateNormal];
            [self.buildMuscleMassButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
            [self.buildMuscleIsolationButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
            
            goal                                  = @"GET TONED";
            
            [self insertGoalIntoDatabase:goal];

        }
        else {
            // assign the mode
            self.getTonedButton.tag               = 0;
            // set light intensity image
            [self.getTonedButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
        }
    }
    else if (sender == self.buildMuscleMassButton) {
        if (self.buildMuscleMassButton.tag == 0) {
            // assign the mode
            self.shredFatButton.tag               = 0;
            self.getTonedButton.tag               = 0;
            self.buildMuscleMassButton.tag        = 1;
            self.buildMuscleIsolationButton.tag   = 0;
            // set light intensity image
            [self.shredFatButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
            [self.getTonedButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
            [self.buildMuscleMassButton setBackgroundImage:[UIImage imageNamed:[m_goalsImages objectAtIndex:2]] forState:UIControlStateNormal];
            [self.buildMuscleIsolationButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
            
            goal                                  = @"BUILD MUSCLE MASS";
            
            [self insertGoalIntoDatabase:goal];
        }
        else {
            // assign the mode
            self.buildMuscleMassButton.tag               = 0;
            // set light intensity image
            [self.buildMuscleMassButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
        }
    }
    else if (sender == self.buildMuscleIsolationButton) {
        if (self.buildMuscleIsolationButton.tag == 0) {
            // assign the mode
            self.shredFatButton.tag               = 0;
            self.getTonedButton.tag               = 0;
            self.buildMuscleMassButton.tag        = 0;
            self.buildMuscleIsolationButton.tag   = 1;
            // set light intensity image
            [self.shredFatButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
            [self.getTonedButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
            [self.buildMuscleMassButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
            [self.buildMuscleIsolationButton setBackgroundImage:[UIImage imageNamed:[m_goalsImages objectAtIndex:3]] forState:UIControlStateNormal];
            
            goal                                  = @"MUSCLE ISOLATION";
            
            [self insertGoalIntoDatabase:goal];

        }
        else {
            // assign the mode
            self.buildMuscleIsolationButton.tag               = 0;
            // set light intensity image
            [self.buildMuscleIsolationButton setBackgroundImage:[UIImage imageNamed:nil] forState:UIControlStateNormal];
        }
    }
    // save supplement plan
    [self saveSupplementPlanForGoal:goal];
}

/*
 Save into supplement plan based on goal
 */
- (void)saveSupplementPlanForGoal:(NSString *)goal
{
//    if (!m_supplementPlanManager) {
//        m_supplementPlanManager       = [SupplementPlanManager sharedInstance];
//    }
    if (!m_supplementPlanSelection) {
        m_supplementPlanSelection     = [SupplementPlanSelection sharedInstance];
    }
//    [m_supplementPlanManager saveSupplementPlanInDatabase:[m_supplementPlanSelection selectSupplementPlistBasedonGoal:goal]];
    BreakFastSupplementPlanManager  *m_breakfastSupplementPlanManager         = [BreakFastSupplementPlanManager sharedInstance];
    [m_breakfastSupplementPlanManager saveBreakFastSupplementPlanInDatabase:[[m_supplementPlanSelection selectSupplementPlistBasedonGoal:goal] objectAtIndex:0]];
    
    PreWorkoutSupplementPlanManager  *m_preWorkoutSupplementPlanManager       = [PreWorkoutSupplementPlanManager sharedInstance];
    [m_preWorkoutSupplementPlanManager savePreWorkoutSupplementPlanInDatabase:[[m_supplementPlanSelection selectSupplementPlistBasedonGoal:goal] objectAtIndex:1]];
    
    PostWorkoutSupplementPlanManager  *m_postWorkoutSupplementPlanManager     = [PostWorkoutSupplementPlanManager sharedInstance];
    [m_postWorkoutSupplementPlanManager savePostWorkoutSupplementPlanInDatabase:[[m_supplementPlanSelection selectSupplementPlistBasedonGoal:goal] objectAtIndex:2]];

    BeforeBedSupplementPlanManager  *m_beforeBedSupplementPlanManager         = [BeforeBedSupplementPlanManager sharedInstance];
    [m_beforeBedSupplementPlanManager saveBeforeBedSupplementPlanInDatabase:[[m_supplementPlanSelection selectSupplementPlistBasedonGoal:goal] objectAtIndex:3]];
}

/*
 User selects one gaol
 */
- (IBAction)selectGoal:(id)sender
{
    [self updateGoalButton:sender];
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

    // adjust view and tableview size for iphone5
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5

        CGRect frame                                = self.backgroundImageView.frame;
        [self.backgroundImageView removeFromSuperview];
        frame.size.height                           = frame.size.height + 95.0f;
        self.backgroundImageView                    = [[UIImageView alloc] initWithFrame:frame];
        self.backgroundImageView.image              = [UIImage imageNamed:@"tfn-goals.png"];
        [self.view addSubview:self.backgroundImageView];
        
        frame                                       = self.shredFatButton.frame;
        [self.shredFatButton removeFromSuperview];
        frame.origin.y                              = frame.origin.y - 2.0f;
        frame.size.height                           = frame.size.height + 27.0f;
        self.shredFatButton                         = [[UIButton alloc] initWithFrame:frame];
        [self.view addSubview:self.shredFatButton];
        [self.shredFatButton addTarget:self action:@selector(updateGoalButton:) forControlEvents:UIControlEventTouchUpInside];
        self.shredFatButton.tag                     = 0;
        
        frame                                       = self.getTonedButton.frame;
        [self.getTonedButton removeFromSuperview];
        frame.origin.y                              = frame.origin.y + 24.0f;
        frame.size.height                           = frame.size.height + 27.0f;
        self.getTonedButton                         = [[UIButton alloc] initWithFrame:frame];
        [self.view addSubview:self.getTonedButton];
        [self.getTonedButton addTarget:self action:@selector(updateGoalButton:) forControlEvents:UIControlEventTouchUpInside];
        self.getTonedButton.tag                     = 0;

        frame                                       = self.buildMuscleMassButton.frame;
        [self.buildMuscleMassButton removeFromSuperview];
        frame.origin.y                              = frame.origin.y + 47.0f;
        frame.size.height                           = frame.size.height + 27.0f;
        self.buildMuscleMassButton                  = [[UIButton alloc] initWithFrame:frame];
        [self.view addSubview:self.buildMuscleMassButton];
        [self.buildMuscleMassButton addTarget:self action:@selector(updateGoalButton:) forControlEvents:UIControlEventTouchUpInside];
        self.buildMuscleMassButton.tag              = 0;

        frame                                       = self.buildMuscleIsolationButton.frame;
        [self.buildMuscleIsolationButton removeFromSuperview];
        frame.origin.y                              = frame.origin.y + 68.0f;
        frame.size.height                           = frame.size.height + 27.0f;
        self.buildMuscleIsolationButton             = [[UIButton alloc] initWithFrame:frame];
        [self.view addSubview:self.buildMuscleIsolationButton];
        [self.buildMuscleIsolationButton addTarget:self action:@selector(updateGoalButton:) forControlEvents:UIControlEventTouchUpInside];
        self.buildMuscleIsolationButton.tag         = 0;
    }
    
    // Need to load or refresh the load
    [self loadGoalsImages];
    
    [self.messageButton removeFromSuperview];
    self.messageButton.titleLabel.font          = [UIFont customFontWithSize:13];
    self.messageButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messageButton.titleLabel.numberOfLines = 2;
    self.messageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.messageButton];
    
}

- (void)viewWillAppear:(BOOL)animated
{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
