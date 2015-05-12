//
//  ExerciseViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-17.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import "ExerciseViewController.h"
#import "WorkoutSelection.h"
#import "FoodProfileViewController.h"
#import "CalenderViewController.h"
#import "ProfileViewController.h"
#import "RootViewController.h"
#import "ExerciseProfileViewController.h"
#import "ExerciseListViewController.h"
#import "SwitchPlanItemViewController.h"
#import "NSString+FindImage.h"
#import "NSMutableArray+PlanLists.h"
#import "NSString+ExerciseToSwitch.h"
#import "NSMutableArray+SportsList.h"
#import "ExcerciseIndexViewController.h"

@interface ExerciseViewController ()

@property (strong, nonatomic) Database *m_database;
@property (strong, nonatomic) ProfileViewController *m_profileViewController;
@property (strong, nonatomic) CalenderViewController *m_calenderViewController;
@property (strong, nonatomic)FoodProfileViewController *m_foodProfileViewController;
@property (strong, nonatomic)ExerciseProfileViewController *m_exerciseProfileViewController;
@property (strong, nonatomic)MealViewController *m_mealViewController;
@property (strong, nonatomic)SupplementPlanViewController *m_supplementPlanViewController;
@property (strong, nonatomic)ExerciseListViewController *m_exerciseListViewController;
@property (strong, nonatomic)MusicTracksViewController *m_musicTracksViewController;
@property (strong, nonatomic)SwitchPlanItemViewController *m_switchPlanItemViewController;
@property (strong, nonatomic)RootViewController *m_rootViewController;
@property (strong, nonatomic)WorkoutSelection *m_workoutSelection;
@property (strong, nonatomic)ViewTransitions *m_transition;
@property (strong, nonatomic)ViewFactory *m_controllerViews;
@property (strong, nonatomic)ExcerciseIndexViewController *m_ExcerciseIndexViewController;
@property (strong, nonatomic)NSMutableDictionary *m_currentDictionary;
@property (strong, nonatomic)NSMutableArray *m_workoutImagesArray;
@property (strong, nonatomic)NSMutableArray *m_workoutKeyArray;
@property (strong, nonatomic)NSMutableArray *m_workoutValueArray;
@property (strong, nonatomic)NSMutableArray *m_exerciseIndexArray;
@property (strong, nonatomic)NSMutableArray *m_imagesForExerciseIndexArray;
@property (strong, nonatomic)NSString *m_workoutOrExerciseIndexTable;
@property (strong, nonatomic)NSMutableArray *m_workoutPlanArrayExerciseView;
@property (strong, nonatomic)NSString *m_userEmail;
@property (strong, nonatomic)NSString *m_goal;
@property (strong, nonatomic)NSString *m_gender;
@property (nonatomic)NSInteger m_numberOfSections;
@property (strong, nonatomic)NSMutableArray *m_sportsListExerciseView;
@property (strong, nonatomic)NSMutableArray *m_sportsListImages;
@property (strong, nonatomic)NSString *m_sportsOrOtherExercisesExerciseView;
@property (nonatomic)BOOL isSportsActivityViewIsOpened;
@property (nonatomic)BOOL isDisclosure;
@property (strong, nonatomic)UIButton *m_helpPopUpButtonViewInExerciseView;
@property (strong, nonatomic)NSUserDefaults *userDefaults;



// Move to previous View
- (IBAction)moveToPreviousView:(id)sender;
// Move to CalenderViewController
- (void)moveToCalenderViewController:(id)sender;
// Move to MealViewController
- (void)moveToMealViewController:(id)sender;
// Move to ExerciseProfileViewController
- (void)moveToExerciseProfileViewController:(id)sender;
// Move to ExerciseListViewController
- (void)moveToExerciseListViewController:(id)sender;
// Move to MusicTracksViewController
- (void)moveToMusicTracksViewController:(id)sender;
// Move to SupplementPlanViewController
- (void)moveToSupplementPlanViewController:(id)sender;
// Move to SwitchPlanItemViewController
- (void)movetoSwitchPlanItemViewController:(id)sender;
/////  Move to Supplements at websiute
- (void)moveToSupplementsAtWebsite:(id)sender;
// Move to RootViewController's view
- (IBAction)moveToRootViewController:(id)sender;
// Load up data and images for the sports exercise workout
- (void)loadUpSportsListForGender:(NSString *)gender WithArray:(NSMutableArray *)sportsListArray ForImagesArray:(NSMutableArray *)imagesArray;
// load up the right workout for the user
- (void) loadUpWorkoutPlanExerciseView;
// Get Exercise Index
- (void)getExerciseIndex;
// Details of meal plan and work out plan for the day
- (IBAction)planSection:(id)sender;
// Add methods to each control buttons
- (void)addSelectorToControlButtons;
// Cell contents such as images, items and measurement displayed
- (void)cellContents:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath WithImageArray:(NSMutableArray *)imageArray AndKeyArray:(NSMutableArray *)keyArray AndValueArray:(NSMutableArray *)valueArray;
// Each section has its own images, key and value arrays
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath onTableView:tableView;
// Upload sports list
- (void)sportsListArray;

@end

@implementation ExerciseViewController

static const NSString *m_abs_Male_Image_Name                    = @"tfn_exercises_male_ABS.png";
static const NSString *m_arms_Male_Image_Name                   = @"tfn_exercises_male_ARMS.png";
static const NSString *m_back_Male_Image_Name                   = @"tfn_exercises_male_BACK.png";
static const NSString *m_chest_Male_Image_Name                  = @"tfn_exercises_male_CHEST.png";
static const NSString *m_legs_Male_Image_Name                   = @"tfn_exercises_male_LEGS.png";
static const NSString *m_shoulders_Male_Image_Name              = @"tfn_exercises_male_SHOULDERS.png";
static const NSString *m_cardio_Male_Image_Name                 = @"cardio_male_thumb.png";
static const NSString *m_sports_Male_Image_Name                 = @"sports_male_thumb.png";

static const NSString *m_abs_Female_Image_Name                  = @"tfn_exercises_women_ABS.png";
static const NSString *m_arms_Female_Image_Name                 = @"tfn_exercises_women_ARMS.png";
static const NSString *m_back_Female_Image_Name                 = @"tfn_exercises_women_BACK.png";
static const NSString *m_chest_Female_Image_Name                = @"tfn_exercises_women_CHEST.png";
static const NSString *m_legs_Female_Image_Name                 = @"tfn_exercises_women_LEGS.png";
static const NSString *m_shoulders_Female_Image_Name            = @"tfn_exercises_women_SHOULDERS.png";
static const NSString *m_cardio_Female_Image_Name               = @"cardio_female_thumb.png";
static const NSString *m_sports_Female_Image_Name               = @"sports_female_thumb.png";



@synthesize controlsImageView;
@synthesize workoutPlanSectionButton;
@synthesize exerciseIndexSectionButton;
@synthesize workoutTableView;
@synthesize exerciseIndexTableView;
@synthesize indicatorView;
@synthesize bottomBarButton;
@synthesize musicPlayerButton;
@synthesize exercisePlanButton;
@synthesize calendarButton;
@synthesize mealPlanButton;
@synthesize nutritionPlanButton;
@synthesize messageButton;
@synthesize selectedImage;
@synthesize workoutSelectedToEdit;

/*
 Singleton ExerciseViewController object
 */
+ (ExerciseViewController *)sharedInstance {
	static ExerciseViewController *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 Move to previous View
 */
- (IBAction)moveToPreviousView:(id)sender
{
    
    if (!self.m_transition) {
        self.m_transition                = [ViewTransitions sharedInstance];
    }
    
    if(!self.isSportsActivityViewIsOpened) { // Sports list view is not opened
        
        // go to previous view
        [self.m_transition performTransitionFromLeft:self.view.superview];
        [self.view removeFromSuperview];
    }
    else if(self.isSportsActivityViewIsOpened) { // Or reload the data for workout exercises
        
        // make it empty, so that it is not "Sports Activity"
        self.m_sportsOrOtherExercisesExerciseView               =  @"";
        
        // Load up all the workouts
        [self loadUpWorkoutPlanExerciseView];
        
        [self.m_transition performTransitionFromLeft:self.workoutTableView];
        
        [self.workoutTableView reloadData];
    }

}

/*
 Move to CalenderViewController
 */
- (void)moveToCalenderViewController:(id)sender
{
    if (!self.m_calenderViewController) {
        self.m_calenderViewController    = [CalenderViewController sharedInstance];
    }
    
    id instanceObject               = self.m_calenderViewController;
    [self moveToView:self.m_calenderViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
}

/*
 Move to FoodProfileViewController
 */
- (void)moveToFoodProfileViewController:(id)sender
{
    if (!self.m_foodProfileViewController) {
        self.m_foodProfileViewController     = [FoodProfileViewController sharedInstance];
    }
    id instanceObject               = self.m_foodProfileViewController;
    [self moveToView:self.m_foodProfileViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to ExerciseProfileViewController
 */
- (void)moveToExerciseProfileViewController:(id)sender
{
    if (!self.m_exerciseProfileViewController) {
        self.m_exerciseProfileViewController        = [ExerciseProfileViewController sharedInstance];
    }
    
    id instanceObject                   = self.m_exerciseProfileViewController;
    
    [self moveToView:self.m_exerciseProfileViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
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
 Move to ExerciseListViewController
 */
- (void)moveToExerciseListViewController:(id)sender
{
    if (!self.m_exerciseListViewController) {
        self.m_exerciseListViewController    = [ExerciseListViewController sharedInstance];
    }
    id instanceObject               = self.m_exerciseListViewController;
    [self moveToView:self.m_exerciseListViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to MusicTracksViewController
 */
- (void)moveToMusicTracksViewController:(id)sender
{
    if (!self.m_musicTracksViewController) {
        self.m_musicTracksViewController         = [MusicTracksViewController sharedInstance];
    }
    id instanceObject                       = self.m_musicTracksViewController;
    [self moveToView:self.m_musicTracksViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
}

-(void)moveToExerciseIndexViewController:(id)sender{
    if(!self.m_ExcerciseIndexViewController){
        self.m_ExcerciseIndexViewController = [ExcerciseIndexViewController sharedInstance];
    }
    id instanceObject = self.m_ExcerciseIndexViewController;
    [self moveToView:self.m_ExcerciseIndexViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}


- (IBAction)exerciseIndex:(id)sender {
    
    [self moveToExerciseIndexViewController:self];
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
 Move to supplements at website
 */
- (void)moveToSupplementsAtWebsite:(id)sender
{
    NSURL *url                  = [[NSURL alloc] initWithString:@"http://totalfitness.com/supplements"];
    [[UIApplication sharedApplication] openURL:url];
}

/*
 Move to SwitchPlanItemViewController
 */
- (void)movetoSwitchPlanItemViewController:(id)sender
{
    if (!self.m_switchPlanItemViewController) {
        self.m_switchPlanItemViewController      = [SwitchPlanItemViewController sharedInstance];
    }
    id instanceObject                       = self.m_switchPlanItemViewController;
    self.m_switchPlanItemViewController.view.tag = 2;
    [self moveToView:self.m_switchPlanItemViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Get Exercise Index
 */
- (void)getExerciseIndex
{
    // clean the arrays first
    self.m_imagesForExerciseIndexArray         = nil;
    
    if (!self.m_exerciseIndexArray) {
        self.m_exerciseIndexArray              = [NSMutableArray mutableArrayObject];
        [self.m_exerciseIndexArray addObject:@"Abdomimals"];
        [self.m_exerciseIndexArray addObject:@"Arms"];
        [self.m_exerciseIndexArray addObject:@"Back"];
        [self.m_exerciseIndexArray addObject:@"Chest"];
        [self.m_exerciseIndexArray addObject:@"Legs"];
        [self.m_exerciseIndexArray addObject:@"Shoulders"];
        [self.m_exerciseIndexArray addObject:@"Cardio"];
        [self.m_exerciseIndexArray addObject:@"Sports"];
    }
    
    if (!self.m_imagesForExerciseIndexArray) {
        self.m_imagesForExerciseIndexArray     = [NSMutableArray mutableArrayObject];
    }
    if (!self.m_database) {
        self.m_database                        = [Database alloc];
    }
    if (!self.m_userEmail) {
        self.m_userEmail                       = [NSString getUserEmail];
    }
    
    if ([[self.m_database getGender:self.m_userEmail] isEqualToString:@"Male"]) {
        [self.m_imagesForExerciseIndexArray addObject:m_abs_Male_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_arms_Male_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_back_Male_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_chest_Male_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_legs_Male_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_shoulders_Male_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_cardio_Male_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_sports_Male_Image_Name];
    }
    else if ([[self.m_database getGender:self.m_userEmail] isEqualToString:@"Female"]) {
        [self.m_imagesForExerciseIndexArray addObject:m_abs_Female_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_arms_Female_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_back_Female_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_chest_Female_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_legs_Female_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_shoulders_Female_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_cardio_Female_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_sports_Female_Image_Name];
    }
}

/*
 Details of workout plan and exercise index
 */
- (IBAction)planSection:(id)sender;
{

    
    if (!self.m_transition) {
        self.m_transition            = [ViewTransitions sharedInstance];
    }
    if ((sender == self.workoutPlanSectionButton) && ([self.m_workoutOrExerciseIndexTable isEqualToString:@"Exercise Index"])) {
        self.controlsImageView.image                    = [UIImage imageNamed:@"tfn_workout_active.png"];
        self.m_workoutOrExerciseIndexTable                   = @"Workout";
        // Hide exercise tableview
        self.exerciseIndexTableView.hidden              = YES;
        
        //        NSUserDefaults *userDefaults                        = [NSUserDefaults standardUserDefaults];
        //        if ([userDefaults boolForKey:@"CustomTrainingProgram"]) { // Workout plan is purchased
        // Load up all the workouts
        [self loadUpWorkoutPlanExerciseView];
        [self.m_transition performTransitionFromLeft:self.workoutTableView];
        // Show workout table view
        self.workoutTableView.hidden                    = NO;
        // Reload the workout data
        [self.workoutTableView reloadData];
        [self.workoutTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        //        }
        //        else {
        //            self.createPlan.hidden                       = NO;
        //            self.workoutTableView.hidden                 = YES;
        //            [m_transition performTransitionFromLeft:self.createPlan];
        //        }
        

    }
    else if((sender == self.exerciseIndexSectionButton)  && ([self.m_workoutOrExerciseIndexTable isEqualToString:@"Workout"])) {
        // Get exercise index list
        [self getExerciseIndex];
        
        self.controlsImageView.image                    = [UIImage imageNamed:@"tfn_exercises_active.png"];
        self.m_workoutOrExerciseIndexTable                   = @"Exercise Index";
        [self.m_transition performTransitionFromRight:self.exerciseIndexTableView];
        // Hide workout tableview
        self.workoutTableView.hidden                    = YES;
        // Hide exercise tableview
        self.exerciseIndexTableView.hidden              = NO;
        // Reload the exercise index data
        [self.exerciseIndexTableView reloadData];
        [self.exerciseIndexTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

    }
}
#pragma Loading Images
/*
 Load up data and images for the muscle isolation workout
 */
- (void)loadUpSportsListForGender:(NSString *)gender WithArray:(NSMutableArray *)sportsListArray ForImagesArray:(NSMutableArray *)imagesArray
{
    NSInteger numberOfItems                               = [sportsListArray count];
    for (int i = 0; i < numberOfItems; i++) {
        NSString *keyString                         = [sportsListArray objectAtIndex:i];
        //[imagesArray addObject:[NSString findImageForWorkout:[NSString stringWithFormat:@"%@",keyString]]]; // add images
        [imagesArray addObject:[self imageWithFilename:[NSString findImageForWorkout:[NSString stringWithFormat:@"%@", keyString]]]];
    }
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
 load up the right workout for the user
 */
- (void) loadUpWorkoutPlanExerciseView
{
    self.m_workoutPlanArrayExerciseView     = [NSMutableArray loadUpWorkoutPlan];
    self.m_numberOfSections                 = [self.m_workoutPlanArrayExerciseView count];
    
    // Stop the indicatorview when cells are to be loaded
    [self.indicatorView stopAnimating];
}

/*
 Click edit button
 */
- (void)editButtonTapped:(id)sender event:(id)event
{
    NSSet *touches                  = [event allTouches];
    UITouch *touch                  = [touches anyObject];
    CGPoint currentTouchPosition    = [touch locationInView:self.workoutTableView];
    NSIndexPath *indexPath          = [self.workoutTableView indexPathForRowAtPoint: currentTouchPosition];
    
    if (indexPath != nil) {
        // Eachtime button is clicked, let the accessoryButtonTappedForRoWithIndexPath know
        [self tableView: self.workoutTableView accessoryButtonTappedForRowWithIndexPath: indexPath];
    }
}

/*
 Add methods to each control buttons
 */
- (void)addSelectorToControlButtons
{
    // Set up the bottom bar control buttons
    NSMutableArray *controlButtonArrays;
    controlButtonArrays                 = [self bottomBar:self.bottomBarButton MusicPlayerButton:self.musicPlayerButton ExercisePlanButton:self.exercisePlanButton Calendar:self.calendarButton MealPlan:self.mealPlanButton MoreButton:self.nutritionPlanButton InView:self.view];
    
    self.bottomBarButton                = [controlButtonArrays objectAtIndex:0];
    
    self.musicPlayerButton              = [controlButtonArrays objectAtIndex:1];
    
    self.exercisePlanButton             = [controlButtonArrays objectAtIndex:2];
    // stay here
    
    self.calendarButton                 = [controlButtonArrays objectAtIndex:3];
    
    self.mealPlanButton                 = [controlButtonArrays objectAtIndex:4];
    
    self.nutritionPlanButton            = [controlButtonArrays objectAtIndex:5];
    
    // Refresh the view
    [self.view setNeedsDisplay];
}

/*
 Checkbox for the grocery list
 */
- (void)checkBoxForGroceryList:(id)sender
{
    UIButton *button            = (UIButton *)sender;
    [button setBackgroundImage:[UIImage imageNamed:@"checkedbox.png"] forState:UIControlStateSelected];
}

/*
 Upload sports list
 */
- (void)sportsListArray
{
    self.m_sportsListExerciseView         = [NSMutableArray sportsList];
}

- (void)helpButtonClicked
{
    self.userDefaults        = [NSUserDefaults standardUserDefaults];
    [self.userDefaults setInteger:1 forKey:@"SwitchWorkoutPlanItem_Help"];
    [self.userDefaults synchronize];
    
    [self.m_helpPopUpButtonViewInExerciseView removeFromSuperview];
}

- (void)createHelpPopUp
{
    CGRect helpPopUpButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        helpPopUpButtonFrame     =   CGRectMake(0.0f, 0.0f, 320.0f, 568.0f);
        self.m_helpPopUpButtonViewInExerciseView       = [[UIButton alloc] initWithFrame:helpPopUpButtonFrame];
        [self.m_helpPopUpButtonViewInExerciseView setBackgroundImage:[UIImage imageNamed:@"substitute_exercise_instruction_i5.png"] forState:UIControlStateNormal];
    }
    else {
        helpPopUpButtonFrame     = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
        self.m_helpPopUpButtonViewInExerciseView       = [[UIButton alloc] initWithFrame:helpPopUpButtonFrame];
        [self.m_helpPopUpButtonViewInExerciseView setBackgroundImage:[UIImage imageNamed:@"substitute_exercise_instruction.png"] forState:UIControlStateNormal];
    }
    [self.view addSubview:self.m_helpPopUpButtonViewInExerciseView];
    [self.m_helpPopUpButtonViewInExerciseView addTarget:self action:@selector(helpButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // initialize the sports list images
        self.m_sportsListImages          = [NSMutableArray mutableArrayObject];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // adjust view and tableview size for iphone5
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        // adjust the height of the tableviews and readd the indicator view
        [self.workoutTableView removeFromSuperview];
        self.workoutTableView       = [self adjustiPhone5HeightOfTableView:self.workoutTableView ForController:self];
        [self.view addSubview:self.workoutTableView];
        [self.exerciseIndexTableView removeFromSuperview];
        self.exerciseIndexTableView = [self adjustiPhone5HeightOfTableView:self.exerciseIndexTableView ForController:self];
        [self.view addSubview:self.exerciseIndexTableView];
        self.indicatorView      = [self reAddActivityIndicatorforiPhone5:self.indicatorView];
        [self.view addSubview:self.indicatorView];
    }
    
    [self.messageButton removeFromSuperview];
    self.messageButton.titleLabel.font          = [UIFont customFontWithSize:13];
    self.messageButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messageButton.titleLabel.numberOfLines = 2;
    self.messageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.messageButton];
    
    // Refresh the control buttons
    [self addSelectorToControlButtons];
    
    // start indicator view on the tableview
    [self.indicatorView startAnimating];
    
    self.userDefaults        = [NSUserDefaults standardUserDefaults];
    if (![self.userDefaults integerForKey:@"SwitchWorkoutPlanItem_Help"]) {
        // Add Help Pop Up
        [self createHelpPopUp];
    }


}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.m_database) {
        self.m_database                          = [Database alloc];
    }
    self.m_userEmail                             = [NSString getUserEmail];
    self.m_goal                                  = [self.m_database getLatestExerciseGoal:self.m_userEmail]; // Get the latest goal
    self.m_gender                                = [self.m_database getGender:self.m_userEmail];
    
    self.m_workoutOrExerciseIndexTable       = @"Workout";
    self.controlsImageView.image        = [UIImage imageNamed:@"tfn_workout_active.png"];
    
    if ([self.m_workoutOrExerciseIndexTable isEqualToString:@"Workout"]) {
        //self.exerciseIndexTableView.hidden          = YES;
        // Load up all the workouts
        [self loadUpWorkoutPlanExerciseView];
        //self.workoutTableView.hidden                = NO;
        // Refresh tableview
        
    }
    else if ([self.m_workoutOrExerciseIndexTable isEqualToString:@"Exercise Index"]) {
        // Get Exercise Index
        [self getExerciseIndex];
        //self.workoutTableView.hidden                = YES;
        //self.exerciseIndexTableView.hidden          = NO;
        
    }
    [self.workoutTableView reloadData];
    //[self getExerciseIndex];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numberOfSections    = 0;
    if ([self.m_workoutOrExerciseIndexTable isEqualToString:@"Workout"]) {
        if (![self.m_sportsOrOtherExercisesExerciseView isEqualToString:@"Sports Activity"]) {
            numberOfSections    = self.m_numberOfSections;
        }
        else if ([self.m_sportsOrOtherExercisesExerciseView isEqualToString:@"Sports Activity"]) {
            numberOfSections    = 1;
        }
    }
    else if([self.m_workoutOrExerciseIndexTable isEqualToString:@"Exercise Index"]) {
        numberOfSections    = 1;
    }
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRowsInSection       = 0;
    if ([self.m_workoutOrExerciseIndexTable isEqualToString:@"Workout"]) { // if the section is Workout Plan
        if (![self.m_sportsOrOtherExercisesExerciseView isEqualToString:@"Sports Activity"]) {
            return numberOfRowsInSection        = [[[self.m_workoutPlanArrayExerciseView objectAtIndex:section] objectAtIndex:0] count];
        }
        else if([self.m_sportsOrOtherExercisesExerciseView isEqualToString:@"Sports Activity"]) {
            return numberOfRowsInSection            = [self.m_sportsListExerciseView count];
        }
    }
    else if([self.m_workoutOrExerciseIndexTable isEqualToString:@"Exercise Index"]) { // if the section is exercise index
        return numberOfRowsInSection                = [self.m_exerciseIndexArray count];
    }
    
    return numberOfRowsInSection;
}

/*
 Cell contents such as images, items and measurement displayed for Meal Plan
 */
- (void)cellContents:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath WithImageArray:(NSMutableArray *)imageArray AndKeyArray:(NSMutableArray *)keyArray AndValueArray:(NSMutableArray *)valueArray
{
    UIImage *cellImage = nil;
    
    if([imageArray count] > 0){
    cellImage                                           = [self imageWithFilename:imageArray[indexPath.row]];
    //cellImage = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
        // Find the right image
    }
    ((UIImageView *)[cell viewWithTag:1]).image         = cellImage;
    if (!cellImage) { // If the there is no image displayed then, there isn't any food item for that
        cell.accessoryType                              = UITableViewCellAccessoryNone;
        [cell setUserInteractionEnabled:NO];
    }
    else { // Cell the set have the accessory and interaction as well to avoid remaining disabled from the above if
        // Customize accessoryView
        cell.accessoryType                              = UITableViewCellAccessoryDisclosureIndicator;
        [cell setUserInteractionEnabled:YES];
    }
    
    if (![[keyArray objectAtIndex:indexPath.row] isEqualToString:@"Empty Space"]) {
        ((UILabel *)[cell viewWithTag:2]).text          = [keyArray objectAtIndex:indexPath.row];
    }
    else {
        ((UILabel *)[cell viewWithTag:2]).text          = @"";
    }
    
    if ([self.m_workoutOrExerciseIndexTable isEqualToString:@"Workout"]) {
        if (![[valueArray objectAtIndex:indexPath.row] isEqualToString:@"Empty Space"]) {
            ((UILabel *)[cell viewWithTag:3]).text      = [valueArray objectAtIndex:indexPath.row];
        }
        else {
            ((UILabel *)[cell viewWithTag:3]).text      = @"";
        }
    }
    else {
        ((UILabel *)[cell viewWithTag:3]).text          = @"";
    }
}

/*
 Each section has its own images, key and value arrays
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath onTableView:tableView
{
    if([self.m_workoutOrExerciseIndexTable isEqualToString:@"Workout"]) { // Each sections has its own arrays
        if (![self.m_sportsOrOtherExercisesExerciseView isEqualToString:@"Sports Activity"]) {
            [self cellContents:cell atIndexPath:indexPath WithImageArray:[[self.m_workoutPlanArrayExerciseView objectAtIndex:indexPath.section] objectAtIndex:0] AndKeyArray:[[self.m_workoutPlanArrayExerciseView objectAtIndex:indexPath.section] objectAtIndex:1] AndValueArray:[[self.m_workoutPlanArrayExerciseView objectAtIndex:indexPath.section] objectAtIndex:2]];
        }
        else if ([self.m_sportsOrOtherExercisesExerciseView isEqualToString:@"Sports Activity"]) {
            [self cellContents:cell atIndexPath:indexPath WithImageArray:self.m_sportsListImages AndKeyArray:self.m_sportsListExerciseView AndValueArray:nil];
        }
    }
    else if([self.m_workoutOrExerciseIndexTable isEqualToString:@"Exercise Index"]) { // Set the cell for Exercise Index
        [self cellContents:cell atIndexPath:indexPath WithImageArray:self.m_imagesForExerciseIndexArray AndKeyArray:self.m_exerciseIndexArray AndValueArray:nil];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *WorkoutAndExerciseIndexIdentifier    = @"WorkoutAndExerciseIndexIdentifier";
    UITableViewCell *cell                                 = [tableView dequeueReusableCellWithIdentifier:WorkoutAndExerciseIndexIdentifier];
    
    if (cell == nil) {
        cell                                       = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:WorkoutAndExerciseIndexIdentifier];
        UIImageView *theImageView                  = [[UIImageView alloc] initWithFrame: CGRectMake(0,0,80,80)];
        theImageView.tag                           = 1; // Need to add outside the if statment
        [cell.contentView addSubview:theImageView];
        
        UILabel *theTextLabel                      = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 150, 60)];
        theTextLabel.font                          = [UIFont customFontWithSize:15];
        theTextLabel.lineBreakMode                 = NSLineBreakByWordWrapping;
        theTextLabel.numberOfLines                 = 3;
        theTextLabel.textAlignment                 = NSTextAlignmentLeft;
        theTextLabel.textColor                     = [UIColor darkGrayColor];
        theTextLabel.tag                           = 2; // Need to add outside the if statment
        [cell.contentView addSubview:theTextLabel];
        
        UILabel *theDetailTextLabel                = [[UILabel alloc] initWithFrame:CGRectMake(85, 45, 150, 20)];
        theDetailTextLabel.font                    = [UIFont customFontWithSize:11];
        theDetailTextLabel.lineBreakMode           = NSLineBreakByWordWrapping;
        theDetailTextLabel.numberOfLines           = 2;
        theDetailTextLabel.textAlignment           = NSTextAlignmentLeft;
        theDetailTextLabel.textColor               = [UIColor darkGrayColor];
        theDetailTextLabel.tag                     = 3; // Need to add outside the if statment
        [cell.contentView addSubview:theDetailTextLabel];
        
        if (tableView == self.workoutTableView) { // display edit button only if it is workout plan tableview
            UIButton *dayButton                        = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *image                             = [UIImage imageNamed:@"switch"];
            CGRect frame                               = CGRectMake(0.0, 0.0, image.size.width - 15.0f, image.size.height - 15.0f);
            dayButton.frame                            = frame;
            [dayButton setBackgroundImage:image forState:UIControlStateNormal];
            // set the button's target to this table view controller so we can interpret touch events and map that to a NSIndexSet
            [dayButton addTarget:self action:@selector(editButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
            dayButton.backgroundColor                  = [UIColor clearColor];
            dayButton.tag                              = 4;
            cell.accessoryView                         = dayButton;
        }
    }
    // Configure the cell.
    
    // Remove the default blue selction color with clear color
    UIImageView *cellBackgroundSelectionColor          = [[UIImageView alloc] init];
    cellBackgroundSelectionColor.backgroundColor       = [UIColor clearColor];
    cell.selectedBackgroundView                        = cellBackgroundSelectionColor;
    
    
    // Neccessary to use tag to add content to avoid overwritting by reference the imageview and label outside the if(cell == nil) statement
    
    [self configureCell:cell atIndexPath:indexPath onTableView:tableView];
    
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
    float heightForHeaderSection;
    
    if([self.m_workoutOrExerciseIndexTable isEqualToString:@"Workout"]) { // If the view is Meal Plan
        heightForHeaderSection  = 30.0f;
    }
    else { // If the exercise index
        heightForHeaderSection  = 0.0f;
    }
    return heightForHeaderSection;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView      = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    UILabel *label          = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    if ([self.m_workoutOrExerciseIndexTable isEqualToString:@"Workout"]) { // The table view is meal plan table view
        if (![self.m_sportsOrOtherExercisesExerciseView isEqualToString:@"Sports Activity"]) {
            if (section == 0) {
                if (![self.m_goal isEqualToString:@"MUSCLE ISOLATION"]) { // IF NOT MUSCLE ISOLATION
                    label.text        = @"  Day 1                                                                     Sub";
                }
                else { // if MUSCLE ISOLATION
                    label.text        = @"  Abs                                                                         Sub";
                }
            }
            else if(section == 1) {
                if (![self.m_goal isEqualToString:@"MUSCLE ISOLATION"]) { // IF NOT MUSCLE ISOLATION
                    label.text        = @"  Day 2                                                                     Sub";
                }
                else { // if MUSCLE ISOLATION
                    label.text        = @"  Legs                                                                        Sub";
                }
            }
            else if(section == 2) {
                if (![self.m_goal isEqualToString:@"MUSCLE ISOLATION"]) { // IF NOT MUSCLE ISOLATION
                    label.text        = @"  Day 3                                                                     Sub";
                }
                else { // if MUSCLE ISOLATION
                    label.text        = @"  Chest                                                                     Sub";
                }
            }
            else if(section == 3) {
                if (![self.m_goal isEqualToString:@"MUSCLE ISOLATION"]) { // IF NOT MUSCLE ISOLATION
                    label.text        = @"  Day 4                                                                     Sub";
                }
                else { // if MUSCLE ISOLATION
                    label.text        = @"  Back                                                                       Sub";
                }
            }
            else if(section == 4) {
                if (![self.m_goal isEqualToString:@"MUSCLE ISOLATION"]) { // IF NOT MUSCLE ISOLATION
                    label.text        = @"  Day 5                                                                     Sub";
                }
                else { // if MUSCLE ISOLATION
                    label.text        = @"  Shoulder                                                              Sub";
                }
            }
            else if(section == 5) {
                if (![self.m_goal isEqualToString:@"MUSCLE ISOLATION"]) { // IF NOT MUSCLE ISOLATION
                    label.text        = @"  Day 6                                                                     Sub";
                }
                else { // if MUSCLE ISOLATION
                    label.text        = @"  Arms                                                                      Sub";
                }
            }
            else if(section == 6) {
                if (![self.m_goal isEqualToString:@"MUSCLE ISOLATION"]) { // IF NOT MUSCLE ISOLATION
                    label.text        = @"  Day 7                                                                     Sub";
                }
                else { // if MUSCLE ISOLATION
                    label.text        = @"";
                }
            }
        }
        else if([self.m_sportsOrOtherExercisesExerciseView isEqualToString:@"Sports Activity"]) {
            label.text              = @"    Sports";
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
        
    }
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedImage) {
        self.selectedImage      = nil;
    }
    
    if ([self.m_workoutOrExerciseIndexTable isEqualToString:@"Workout"]) {
        // assign image for the next view
        if(![self.m_sportsOrOtherExercisesExerciseView isEqualToString:@"Sports Activity"]) {
            if (indexPath.section == 0) {
                self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[ [[self.m_workoutPlanArrayExerciseView objectAtIndex:0] objectAtIndex:0] objectAtIndex:indexPath.row]];
            }
            if (indexPath.section == 1) {
                self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[ [[self.m_workoutPlanArrayExerciseView objectAtIndex:1] objectAtIndex:0] objectAtIndex:indexPath.row]];
            }
            if (indexPath.section == 2) {
                self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[ [[self.m_workoutPlanArrayExerciseView objectAtIndex:2] objectAtIndex:0] objectAtIndex:indexPath.row]];
            }
            if (indexPath.section == 3) {
                self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[ [[self.m_workoutPlanArrayExerciseView objectAtIndex:3] objectAtIndex:0] objectAtIndex:indexPath.row]];
            }
            if (indexPath.section == 4) {
                self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[ [[self.m_workoutPlanArrayExerciseView objectAtIndex:4] objectAtIndex:0] objectAtIndex:indexPath.row]];
            }
            if (indexPath.section == 5) {
                self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[ [[self.m_workoutPlanArrayExerciseView objectAtIndex:5] objectAtIndex:0] objectAtIndex:indexPath.row]];
            }
            if (indexPath.section == 6) {
                self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[ [[self.m_workoutPlanArrayExerciseView objectAtIndex:6] objectAtIndex:0] objectAtIndex:indexPath.row]];
            }
            if (indexPath.section == 7) {
                self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[ [[self.m_workoutPlanArrayExerciseView objectAtIndex:7] objectAtIndex:0] objectAtIndex:indexPath.row]];
            }
            // Sport list view is not opened
            self.isSportsActivityViewIsOpened       = NO;
        }
        else if([self.m_sportsOrOtherExercisesExerciseView isEqualToString:@"Sports Activity"]) {
            self.selectedImage                 = [[NSString alloc ] initWithFormat:@"%@",[self.m_sportsListImages  objectAtIndex:indexPath.row]];
            // Sport list is opened
            self.isSportsActivityViewIsOpened       = YES;
        }
        
        // Check if selected row is sports
        if ([self.selectedImage rangeOfString:@"sports_activity"].location == NSNotFound) {
            
            if (!self.isSportsActivityViewIsOpened) { // if sports list view is not opened, it must be other exercises
                self.m_sportsOrOtherExercisesExerciseView       = @"Non Sports Activity";
            }
            // Move to ExerciseProfileViewController
            [self moveToExerciseProfileViewController:indexPath];
        } else { // selected row is sports activity
            
            // Sport list is opened
            self.isSportsActivityViewIsOpened       = YES;
            
            self.m_sportsOrOtherExercisesExerciseView           = @"Sports Activity";
            
            // Load up the sports activity list
            [self sportsListArray];

            // load up sports list for gender
            [self loadUpSportsListForGender:self.m_gender WithArray:self.m_sportsListExerciseView ForImagesArray:self.m_sportsListImages];
            
            if (!self.m_transition) {
                self.m_transition                    = [ViewTransitions sharedInstance];
            }
            [self.m_transition performTransitionFromLeft:self.workoutTableView];
            // Load up the sports list images
            [[self workoutTableView] reloadData];
        }
    }
    else if([self.m_workoutOrExerciseIndexTable isEqualToString:@"Exercise Index"]) {
        // assign image from exercise images
        self.selectedImage        = [self.m_exerciseIndexArray  objectAtIndex:indexPath.row];
        if (([self.selectedImage length] != 0) && (self.selectedImage != NULL)) {
            if (!self.m_exerciseListViewController) {
                self.m_exerciseListViewController            = [ExerciseListViewController alloc];
            }
            self.m_exerciseListViewController.selectedImage  = self.selectedImage;
            [self moveToExerciseListViewController:indexPath];
        }
    }
    // Unselect the row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- ( void ) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    // assign work item for the next view
    self.workoutSelectedToEdit         = [[NSString alloc ] initWithFormat:@"%@",[[[self.m_workoutPlanArrayExerciseView objectAtIndex:indexPath.section] objectAtIndex:0]  objectAtIndex:indexPath.row]];

    self.workoutSelectedToEdit      = [[[[self.workoutSelectedToEdit stringByReplacingOccurrencesOfString:@"_" withString:@" "] stringByReplacingOccurrencesOfString:@"thumb" withString:@""] stringByReplacingOccurrencesOfString:@" female " withString:@""] stringByReplacingOccurrencesOfString:@" male " withString:@""];
    
    [NSString setExerciseItemToSwitch:self.workoutSelectedToEdit];
    self.selectedSection            = indexPath.section;
    [self movetoSwitchPlanItemViewController:indexPath];
}

@end
