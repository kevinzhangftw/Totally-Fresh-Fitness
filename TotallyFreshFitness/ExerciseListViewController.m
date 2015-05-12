//
//  ExerciseListViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-12-07.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import "ExerciseListViewController.h"
#import "ExerciseProfileViewController.h"
#import "NSString+FindImage.h"
#import "NSMutableArray+SportsList.h"
#import "ExcerciseIndexViewController.h"

@interface ExerciseListViewController ()

// Move to previous View
- (IBAction)goBack:(id)sender;
// Move to ExerciseViewController
- (void)moveToExerciseViewController:(id)sender;
// Move to ExerciseProfileViewController
- (void)moveToExerciseProfileViewController:(id)sender;
// Move to CalenderViewController
- (void)moveToCalenderViewController:(id)sender;
// Move to MealViewController
- (void)moveToMealViewController:(id)sender;
// Move to MusicTracksViewController
- (void)moveToMusicTracksViewController:(id)sender;
// Move to supplements at website
- (void)moveToSupplementsAtWebsite:(id)sender;
// Move to SupplementPlanViewController
- (void)moveToSupplementPlanViewController:(id)sender;
// Select Exercise list
- (void)selectExerciseList:(NSString *)selectedString;
// Find image for the exercise
- (void)findImageForExercise:(NSMutableArray *)itemsListArray;
// Clean up images array
- (void)cleanUpImagesArray;
// Add methods to each control buttons
- (void)addSelectorToControlButtons;

@end

@implementation ExerciseListViewController

// ProfileViewController class object
ProfileViewController *m_profileViewController;
// ExerciseViewController class object
ExerciseViewController *m_exerciseViewController;
// ExerciseProfileViewController class object
ExerciseProfileViewController *m_exerciseProfileViewController;
// CalenderViewController class object
CalenderViewController *m_calenderViewController;
// ExerciseProfileViewController class object
ExerciseProfileViewController *m_exerciseProfileViewController;
// MealViewController class object
MealViewController *m_mealViewController;
// ExerciseListViewController class object
ExerciseListViewController *m_exerciseListViewController;
// MusicTracksViewController class object
MusicTracksViewController *m_musicTracksViewController;
// SupplementPlanViewController class object
SupplementPlanViewController *m_supplementPlanViewController;
// ViewTransitions class object
ViewTransitions *m_transition;
//ExerciseListView
ExcerciseIndexViewController *m_ExerciseIndexView;

// Images array
NSMutableArray *m_imagesArray;
// Triceps images array
NSMutableArray *m_tricepsImagesArray;
// Biceps images array
NSMutableArray *m_bicepsImagesArray;
// Abs exercises list
NSMutableArray *m_absExerciseList;
// Arms exercises list
NSMutableArray *m_armsExerciseList;
// Triceps exercises list
NSMutableArray *m_tricepsExerciseList;
// Biceps exercises list
NSMutableArray *m_bicepsExerciseList;
// Back exercises list
NSMutableArray *m_backExerciseList;
// Chest exercises list
NSMutableArray *m_chestExerciseList;
// Legs exercises list
NSMutableArray *m_legsExerciseList;
// Shoulder exercises list
NSMutableArray *m_shoulderExerciseList;
// Full Body exercises list
NSMutableArray *m_fullBodyExerciseList;
// Cardio exercises list
NSMutableArray *m_cardioExerciseList;
// Sports exercises list
NSMutableArray *m_sportsExerciseList;
NSMutableArray *m_sleep;
// Selected exercise list
NSMutableArray *m_itemsListArray;
// Exercise selected
NSString *m_selectedStringFromExerciseViewController;
// User email id
NSString *m_userEmailID;
// Gender of the user
NSString *m_gender;
// Triceps exercise count
NSUInteger m_tricepsExercisesCount;
// Biceps exercise count
NSUInteger m_bicepsExercisesCount;
// Biceps image start check
NSString *m_showBicepImages;

@synthesize topNavigationBar;
@synthesize backButton;
@synthesize createNewButton;
@synthesize indicatorView;
@synthesize selectedImage;
@synthesize bottomBarButton;
@synthesize musicPlayerButton;
@synthesize exercisePlanButton;
@synthesize calendarButton;
@synthesize mealPlanButton;
@synthesize nutritionPlanButton;
@synthesize messageButton;

/*
 Singleton ExerciseListViewController object
 */
+ (ExerciseListViewController *)sharedInstance {
	static ExerciseListViewController *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 Move to previous View
 */
- (IBAction)goBack:(id)sender
{
    if (!m_transition) {
        m_transition                = [ViewTransitions sharedInstance];
    }
    
    [m_transition performTransitionFromRight:self.view.superview];
    [self.view removeFromSuperview];
    // Clean up the selected exercise from the previous view
    m_selectedStringFromExerciseViewController      = @"";
    [self cleanUpImagesArray];
    
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
 Move to ExerciseViewController
 */
- (void)moveToExerciseViewController:(id)sender
{
    if (!m_exerciseViewController) {
        m_exerciseViewController        = [ExerciseViewController alloc];
    }
    id instanceObject                   = m_exerciseViewController;
    [self moveToView:m_exerciseViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
}

/*
 Move to ExerciseProfileViewController
 */
- (void)moveToExerciseProfileViewController:(id)sender
{
    if (!m_exerciseProfileViewController) {
        m_exerciseProfileViewController         = [ExerciseProfileViewController sharedInstance];
    }
    
    id instanceObject                           = m_exerciseProfileViewController;
    
    [self moveToView:m_exerciseProfileViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to CalenderViewController
 */
- (void)moveToCalenderViewController:(id)sender
{
    if (!m_calenderViewController) {
        m_calenderViewController    = [CalenderViewController sharedInstance];
    }
    
    id instanceObject               = m_calenderViewController;
    [self moveToView:m_calenderViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
}

/*
 Move to MealViewController
 */
- (void)moveToMealViewController:(id)sender
{
    if (!m_mealViewController) {
        m_mealViewController        = [MealViewController alloc];
    }
    id instanceObject               = m_mealViewController;
    [self moveToView:m_mealViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];

}

/*
 Move to MusicTracksViewController
 */
- (void)moveToMusicTracksViewController:(id)sender
{
    if (!m_musicTracksViewController) {
        m_musicTracksViewController         = [MusicTracksViewController alloc];
    }
    id instanceObject                       = m_musicTracksViewController;
    [self moveToView:m_musicTracksViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
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
 Move to supplements at website
 */
- (void)moveToSupplementsAtWebsite:(id)sender
{
    NSURL *url                  = [[NSURL alloc] initWithString:@"http://totalfitness.com/supplements"];
    [[UIApplication sharedApplication] openURL:url];
}

/*
 Clean up images arrays
 */
- (void)cleanUpImagesArray
{
    // Clean up images array and arms exercises increments
    m_imagesArray               = nil;
    m_tricepsExercisesCount     = 0;
    m_bicepsExercisesCount      = 0;
}

/*
 Load up the abs
 */
- (NSMutableArray *)loadUpAbsExercise
{
    if (!m_absExerciseList) {
        m_absExerciseList           = [NSMutableArray mutableArrayObject];
        [m_absExerciseList addObject:@"Ab Roller"];
        [m_absExerciseList addObject:@"Ball Hand To Feet"];
        [m_absExerciseList addObject:@"Ball Roll Ins"];
        [m_absExerciseList addObject:@"Ball Twist"];
        [m_absExerciseList addObject:@"Bench V Sit Crunch"];
        [m_absExerciseList addObject:@"Bicycle Crunch"];
        [m_absExerciseList addObject:@"Crunches"];
        [m_absExerciseList addObject:@"Flutter Kicks"];
        [m_absExerciseList addObject:@"Hanging Leg Raises"];
        [m_absExerciseList addObject:@"Hip Raises"];
        [m_absExerciseList addObject:@"Laying Windshield Wipers"];
        [m_absExerciseList addObject:@"Plank"];
        [m_absExerciseList addObject:@"Scissor Sit Ups"];
        [m_absExerciseList addObject:@"Side Plank Hip Raises"];
        [m_absExerciseList addObject:@"Side Plank"];
        [m_absExerciseList addObject:@"Sit ups"];
        [m_absExerciseList addObject:@"Supermans"];
        [m_absExerciseList addObject:@"Toe Touches"];
        [m_absExerciseList addObject:@"V Sit"];
        [m_absExerciseList addObject:@"Weighted Crunch On Ball"];
    }
    return m_absExerciseList;
}

/*
 Load up Arms exercises
 */
- (NSMutableArray *)loadUpArmsExercises
{
    if (!m_tricepsExerciseList) {
        m_tricepsExerciseList           = [NSMutableArray mutableArrayObject];
        // triceps exercise list starts
        [m_tricepsExerciseList addObject:@"Bench Dips"];
//        [m_tricepsExerciseList addObject:@"Dumbbell Skull Crushers"];
        [m_tricepsExerciseList addObject:@"Tricep Extension"];
        [m_tricepsExerciseList addObject:@"Tricep Kick Backs"];
        [m_tricepsExerciseList addObject:@"Tricep Rope Pull Down"];
        // Total triceps exercises
        m_tricepsExercisesCount             = [m_tricepsExerciseList count];
    }
    if (!m_bicepsExerciseList) {
        m_bicepsExerciseList            = [NSMutableArray mutableArrayObject];
        // biceps exercise list starts
        [m_bicepsExerciseList addObject:@"Bicep Curl"];
        [m_bicepsExerciseList addObject:@"Concentration Curl"];
        [m_bicepsExerciseList addObject:@"EZ Bar Curl"];
        [m_bicepsExerciseList addObject:@"Preacher Curl"];
        // Total biceps exercises
        m_bicepsExercisesCount              = [m_bicepsExerciseList count];
    }
    
    return m_armsExerciseList;
}

/*
 load up Back exercises
 */
- (NSMutableArray *)loadUpBackExercises
{
    if (!m_backExerciseList) {
        m_backExerciseList              = [NSMutableArray mutableArrayObject];
        [m_backExerciseList addObject:@"Single Arm Bent Over Row"];
        [m_backExerciseList addObject:@"Bent Over Alternating Row"];
        [m_backExerciseList addObject:@"Bent Over Barbell Row"];
        [m_backExerciseList addObject:@"Bent Over Dumbbell Row"];
        [m_backExerciseList addObject:@"Seated Row"];
        [m_backExerciseList addObject:@"Narrow Grip Pull Up"];
        [m_backExerciseList addObject:@"Upright Row"];
        [m_backExerciseList addObject:@"Wide Grip Lateral Pull Down"];
        [m_backExerciseList addObject:@"Wide Grip Pull Up"];
    }
    return m_backExerciseList;
}

/*
 load up Chest exercises
 */
- (NSMutableArray *)loadUpChestExercises
{
    if (!m_chestExerciseList) {
        m_chestExerciseList            = [NSMutableArray mutableArrayObject];
        [m_chestExerciseList addObject:@"Bench Press"];
        [m_chestExerciseList addObject:@"Inch Worm Push Up"];
        [m_chestExerciseList addObject:@"Incline Bench Press"];
//        [m_chestExerciseList addObject:@"Incline Dumbbell Chest Press"];
        [m_chestExerciseList addObject:@"Push Ups"];
        [m_chestExerciseList addObject:@"Weighted Chest Fly"];
    }
    return m_chestExerciseList;
}

/*
 load up Legs exercises
 */
- (NSMutableArray *)loadUpLegsExercises
{
    if (!m_legsExerciseList) {
        m_legsExerciseList             = [NSMutableArray mutableArrayObject];
        [m_legsExerciseList addObject:@"Body Weight Squats"];
        [m_legsExerciseList addObject:@"Butt Kicks"];
        [m_legsExerciseList addObject:@"Calf Raises"];
        [m_legsExerciseList addObject:@"Deadlift"];
        [m_legsExerciseList addObject:@"Squat and Press"];
        [m_legsExerciseList addObject:@"Dumbbell Deadlift"];
        [m_legsExerciseList addObject:@"Front Squat"];
        [m_legsExerciseList addObject:@"Jump squat"];
        [m_legsExerciseList addObject:@"Squat"];
        [m_legsExerciseList addObject:@"Jumping Split Squat"];
        [m_legsExerciseList addObject:@"Leg Press"];
        [m_legsExerciseList addObject:@"Lunges"];
        [m_legsExerciseList addObject:@"Reverse Lunge"];
        [m_legsExerciseList addObject:@"Single Arm Deadlift"];
        [m_legsExerciseList addObject:@"Skater Lunges"];
    }
    return m_legsExerciseList;
}

/*
 load up Shoulder exercises
 */
- (NSMutableArray *)loadUpShoulderExercises
{
    if (!m_shoulderExerciseList) {
        m_shoulderExerciseList          = [NSMutableArray mutableArrayObject];
        [m_shoulderExerciseList addObject:@"Bent Lateral Raises"];
        [m_shoulderExerciseList addObject:@"Dumbbell Drop"];
        [m_shoulderExerciseList addObject:@"Front Raises"];
        [m_shoulderExerciseList addObject:@"Seated Shoulder Press"];
        [m_shoulderExerciseList addObject:@"Power Shrug"];
        [m_shoulderExerciseList addObject:@"Standing Shoulder Press"];
        [m_shoulderExerciseList addObject:@"Standing Shrug"];
    }
    return m_shoulderExerciseList;
}

-(NSMutableArray *)loadUpSleep{
    if(!m_sleep){
        m_sleep = [NSMutableArray mutableArrayObject];
        [m_sleep addObject:@"Sleep Benefits"];
    }
    return m_sleep;
}
/*
 load up Full Body Exercises
 */
- (NSMutableArray *)loadUpFullBodyExercises
{
    if (!m_fullBodyExerciseList) {
        m_fullBodyExerciseList          = [NSMutableArray mutableArrayObject];
        [m_fullBodyExerciseList addObject:@"Burpee Push Up"];
        [m_fullBodyExerciseList addObject:@"Burpees"];
        [m_fullBodyExerciseList addObject:@"Half Burpees"];
        [m_fullBodyExerciseList addObject:@"High Pull"];
        [m_fullBodyExerciseList addObject:@"Jump Tucks"];
        [m_fullBodyExerciseList addObject:@"Jumping Jacks"];
        [m_fullBodyExerciseList addObject:@"Kettle Bell Swing"];
        [m_fullBodyExerciseList addObject:@"Knee Abductions"];
        [m_fullBodyExerciseList addObject:@"Mountain Climbers"];
        [m_fullBodyExerciseList addObject:@"Plea Squat Upright Row"];
        [m_fullBodyExerciseList addObject:@"High Knees"];
        [m_fullBodyExerciseList addObject:@"Squat And Press"];
        [m_fullBodyExerciseList addObject:@"Wood Choppers"];
    }
    return m_fullBodyExerciseList;
}

/*
 load up Cardio exercises
 */
- (NSMutableArray *)loadUpCardioExercises
{
    if (!m_cardioExerciseList) {
        m_cardioExerciseList            = [NSMutableArray mutableArrayObject];
        [m_cardioExerciseList addObject:@"Bike"];
        [m_cardioExerciseList addObject:@"Skip"];
//        [m_cardioExerciseList addObject:@"Sprint"];
//        [m_cardioExerciseList addObject:@"Walk"];
        [m_cardioExerciseList addObject:@"Jogging"];
    }
    return m_cardioExerciseList;
}

/*
 load up Sports exercises
 */
- (NSMutableArray *)loadUpSportsExercises
{
    if (!m_sportsExerciseList) {
        m_sportsExerciseList            = [NSMutableArray sportsList];
    }
    return m_sportsExerciseList;
}

- (UIImage *)imageWithFilename:(NSString *)filename
{
    NSString *path;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	path = [paths[0] stringByAppendingPathComponent:@""];
	path = [path stringByAppendingPathComponent:filename];
    
    return [UIImage imageWithContentsOfFile:path];
}

- (NSString *)stringWithFilename:(NSString *)filename
{
    NSString *path;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	path = [paths[0] stringByAppendingPathComponent:@""];
	path = [path stringByAppendingPathComponent:filename];
    
    //return [NSString imageWithContentsOfFile:path];
    return [NSString stringWithContentsOfFile:path encoding:nil error:nil];
}

-(void)findImageForBicep:(NSMutableArray *)itemsListArray{
    // Need to add bicep images on triceps images
    if (![m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) {
        m_imagesArray              = nil;
    }
    
    if(!m_bicepsImagesArray){
        m_bicepsImagesArray = [NSMutableArray mutableArrayObject];
    }
    
    for (NSString *exercise in itemsListArray) {
        NSString *imageName        = [NSString findImageForWorkout:[NSString stringWithFormat:@"%@",exercise]];
        //NSString *imageName = [NSString findImageForWorkout:[self stringWithFilename:[NSString stringWithFormat:@"%@", exercise]]];
        //NSString *imageName = [self imageWithFilename:[NSString findImageForWorkout:[NSString stringWithFormat:@"%@", exercise]]];
        [m_bicepsImagesArray addObject:imageName];
    }

}

/*
 Find image for the exercise
 */
- (void)findImageForExercise:(NSMutableArray *)itemsListArray
{
    // Need to add bicep images on triceps images
    if (![m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) {
        m_imagesArray              = nil;
    }

    if (!m_imagesArray) {
        m_imagesArray              = [NSMutableArray mutableArrayObject];
    }
    

    for (NSString *exercise in itemsListArray) {
        NSString *imageName        = [NSString findImageForWorkout:[NSString stringWithFormat:@"%@",exercise]];
        //NSString *imageName = [NSString findImageForWorkout:[self stringWithFilename:[NSString stringWithFormat:@"%@", exercise]]];
        //NSString *imageName = [self imageWithFilename:[NSString findImageForWorkout:[NSString stringWithFormat:@"%@", exercise]]];
        [m_imagesArray addObject:imageName];
    }
}

/*
 Select Exercise list
 */
- (void)selectExerciseList:(NSString *)selectedString
{
    // Empty arrays first
    m_itemsListArray                = nil;
    m_tricepsExerciseList           = nil;
    m_bicepsExerciseList            = nil;
    
    if (![m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) {
        if([selectedString isEqualToString:@"Abdomimals"]) {
            m_itemsListArray            = [self loadUpAbsExercise];
        }
        else if([selectedString isEqualToString:@"Back"]) {
            m_itemsListArray            = [self loadUpBackExercises];
        }
        else if([selectedString isEqualToString:@"Chest"]) {
            m_itemsListArray            = [self loadUpChestExercises];
        }
        else if([selectedString isEqualToString:@"Legs"]) {
            m_itemsListArray            = [self loadUpLegsExercises];
        }
        else if([selectedString isEqualToString:@"Shoulders"]) {
            m_itemsListArray            = [self loadUpShoulderExercises];
        }
        else if([selectedString isEqualToString:@"Full Body"]) {
            m_itemsListArray            = [self loadUpFullBodyExercises];
        }
        else if([selectedString isEqualToString:@"Cardio"]) {
            m_itemsListArray            = [self loadUpCardioExercises];
        }
        else if([selectedString isEqualToString:@"Sports"]) {
            m_itemsListArray            = [self loadUpSportsExercises];
        }
        else if([selectedString isEqualToString:@"Sleep"]){
            m_itemsListArray = [self loadUpSleep];
        }
        // Then find the image using the exercise names
        [self findImageForExercise:m_itemsListArray];
    }
    else if([selectedString isEqualToString:@"Arms"]) {
        m_selectedStringFromExerciseViewController          = @"Arms";
        m_imagesArray                   = nil;
        m_bicepsImagesArray = nil;
        [self loadUpArmsExercises];
        // Then find the image using the exercise names
        [self findImageForExercise:m_tricepsExerciseList];
        [self findImageForBicep:m_bicepsExerciseList];
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
    
    self.calendarButton                 = [controlButtonArrays objectAtIndex:3];
    
    self.mealPlanButton                 = [controlButtonArrays objectAtIndex:4];
    
    self.nutritionPlanButton                     = [controlButtonArrays objectAtIndex:5];
    
    // Refresh the view
    [self.view setNeedsDisplay];
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
        // adjust the height of the tableview and readd the indicator view
        [self.theTableView removeFromSuperview];
        self.theTableView       = [self adjustiPhone5HeightOfTableView:self.theTableView ForController:self];
        [self.view addSubview:self.theTableView];
        self.indicatorView      = [self reAddActivityIndicatorforiPhone5:self.indicatorView];
        [self.view addSubview:self.indicatorView];
    }

    [self.messageButton removeFromSuperview];
    self.messageButton.titleLabel.font          = [UIFont customFontWithSize:13];
    self.messageButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messageButton.titleLabel.numberOfLines = 2;
    self.messageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.messageButton];
    
    [self.indicatorView startAnimating];
    
    // Refresh the control buttons
    [self addSelectorToControlButtons];

}

- (void)viewWillAppear:(BOOL)animated
{
    m_userEmailID                                       = [NSString getUserEmail];
    m_gender                                            = [NSString getGenderOfUser];
    
//    if (!m_exerciseViewController) {
//        m_exerciseViewController                        = [ExerciseViewController sharedInstance];
//    }
//    
//    if (([m_exerciseViewController.selectedImage length] != 0) && (m_exerciseViewController.selectedImage != NULL)) {
//        // Data on the first level of the tableview
//        m_selectedStringFromExerciseViewController      = m_exerciseViewController.selectedImage;
//        m_exerciseViewController.selectedImage          = @"";
//        [self selectExerciseList:m_selectedStringFromExerciseViewController];
//    }
    
    if(!m_ExerciseIndexView){
        m_ExerciseIndexView = [ExcerciseIndexViewController sharedInstance];
    }
    
    if(([m_ExerciseIndexView.selectedImage length] != 0) && (m_ExerciseIndexView.selectedImage != NULL)){
        m_selectedStringFromExerciseViewController = m_ExerciseIndexView.selectedImage;
        m_ExerciseIndexView.selectedImage = @"";
    }
    [self selectExerciseList:m_selectedStringFromExerciseViewController];

    // Refresh the TableView data
    [self.theTableView reloadData];
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
    int numberOfSections        = 1;
    if ([m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) {
        numberOfSections        = 2;
    }
    
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRowsInSection                  = 0;
    if ([m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) {
        if (section == 0) { // Triceps exercises count
           return numberOfRowsInSection        = m_tricepsExercisesCount;
        }
        else if(section == 1) { // Biceps exercises count
            return numberOfRowsInSection       = m_bicepsExercisesCount;
        }
    }
    else {
        return numberOfRowsInSection           = [m_itemsListArray count];
    }
    return numberOfRowsInSection;
}

/*
 Cell contents such as images, items and measurement displayed for Meal Plan
 */
- (void)cellContents:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath WithImageArray:(NSMutableArray *)imageArray AndExerciseArray:(NSMutableArray *)exerciseArray
{
    // needed for images to increment the tricep exercise count for biceps exercises count
    NSUInteger objectAtIndex                                       = 0;
    UIImage *cellImage                                      = nil;
    if ([m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) {
        
        if ([m_showBicepImages isEqualToString:@"YES"]) {
            objectAtIndex                                       = m_tricepsExercisesCount;
        }
        if ([imageArray count] >= indexPath.row) {
            cellImage                                           = [self imageWithFilename:imageArray[indexPath.row]];
            //[UIImage imageNamed:[imageArray objectAtIndex:indexPath.row + objectAtIndex]];     // Find the right image
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
        }
    
    }
    else  {
        if ([imageArray count] >= indexPath.row) {
            cellImage                                           =[self imageWithFilename:imageArray[indexPath.row]];
            //[UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];     // Find the right image
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
        }
    
    }
        
    if (![[exerciseArray objectAtIndex:indexPath.row] isEqualToString:@"Empty Space"]) {
        ((UILabel *)[cell viewWithTag:2]).text          = [exerciseArray objectAtIndex:indexPath.row];
    }
    else {
        ((UILabel *)[cell viewWithTag:2]).text          = @"";
    }
}

/*
 Each section has its own images, key and value arrays
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath onTableView:tableView
{
    if ([m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) {
        if (indexPath.section == 0) {
            m_showBicepImages               = @"NO";
            [self cellContents:cell atIndexPath:indexPath WithImageArray:m_imagesArray AndExerciseArray:m_tricepsExerciseList];
        }
        else if(indexPath.section == 1) {
            m_showBicepImages               = @"YES";
            [self cellContents:cell atIndexPath:indexPath WithImageArray:m_bicepsImagesArray AndExerciseArray:m_bicepsExerciseList];
        }
    }
    else {
        [self cellContents:cell atIndexPath:indexPath WithImageArray:m_imagesArray AndExerciseArray:m_itemsListArray];    
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ExerciseListIdentifier         = @"ExerciseListIdentifier";
    UITableViewCell *cell                           = [tableView dequeueReusableCellWithIdentifier:ExerciseListIdentifier];
    
    if (cell == nil) {
        cell                                       = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ExerciseListIdentifier];
        UIImageView *theImageView                  = [[UIImageView alloc] initWithFrame: CGRectMake(0,0,80,80)];
        theImageView.tag                           = 1; // Need to add outside the if statment
        [cell.contentView addSubview:theImageView];
        
        UILabel *theTextLabel                      = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 215, 80)];
        theTextLabel.font                          = [UIFont customFontWithSize:15];
        theTextLabel.lineBreakMode                 = NSLineBreakByWordWrapping;
        theTextLabel.numberOfLines                 = 3;
        theTextLabel.textAlignment                 = NSTextAlignmentLeft;
        theTextLabel.textColor                     = [UIColor blackColor];
        theTextLabel.tag                           = 2; // Need to add outside the if statment
        [cell.contentView addSubview:theTextLabel];
        
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
    
    if([m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) { // If the selected exercises "Arms"
        heightForHeaderSection          = 30.0f;
    }
    else { // If the exercise index
        heightForHeaderSection          = 0.0f;
    }
    return heightForHeaderSection;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView;
    if ([m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) { // The table view is meal plan table view
        headerView              = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
        UILabel *label          = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];

        if (section == 0) {
            label.text          = @"    Triceps";
        }
        else if(section == 1) {
            label.text          = @"    Biceps";
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
        self.selectedImage                   = @"";
    }
    // assign image from exercise images
    if([m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) { // If the selected exercises "Arms"
        if (indexPath.section == 0) {
            self.selectedImage               = [[NSString alloc ] initWithFormat:@"%@",[m_imagesArray objectAtIndex:indexPath.row]];
        }
        else if(indexPath.section == 1) {
            self.selectedImage               = [[NSString alloc ] initWithFormat:@"%@",[m_bicepsImagesArray objectAtIndex:indexPath.row]];
        }
    }
    else {
        self.selectedImage                   = [[NSString alloc ] initWithFormat:@"%@",[m_imagesArray objectAtIndex:indexPath.row]];
    }

    if (self.selectedImage) { // We can retrieve a particular exercise name
        [self moveToExerciseProfileViewController:indexPath];
    }
    // Unselect the row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- ( void ) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
}
@end
