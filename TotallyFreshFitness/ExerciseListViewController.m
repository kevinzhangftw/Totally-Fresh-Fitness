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

// ProfileViewController class object
@property (strong, nonatomic)ProfileViewController *m_profileViewController;
// ExerciseViewController class object
@property (strong, nonatomic)ExerciseViewController *m_exerciseViewController;
// ExerciseProfileViewController class object
@property (strong, nonatomic)ExerciseProfileViewController *m_exerciseProfileViewController;
// CalenderViewController class object
@property (strong, nonatomic)CalenderViewController *m_calenderViewController;
//// ExerciseProfileViewController class object
//@property (strong, nonatomic)ExerciseProfileViewController *m_exerciseProfileViewController;
// MealViewController class object
@property (strong, nonatomic)MealViewController *m_mealViewController;
// ExerciseListViewController class object
@property (strong, nonatomic)ExerciseListViewController *m_exerciseListViewController;
// MusicTracksViewController class object
@property (strong, nonatomic)MusicTracksViewController *m_musicTracksViewController;
// SupplementPlanViewController class object
@property (strong, nonatomic)SupplementPlanViewController *m_supplementPlanViewController;
// ViewTransitions class object
@property (strong, nonatomic)ViewTransitions *m_transition;
//ExerciseListView
@property (strong, nonatomic)ExcerciseIndexViewController *m_ExerciseIndexView;

// Images array
@property (strong, nonatomic)NSMutableArray *m_imagesArray;
// Triceps images array
@property (strong, nonatomic)NSMutableArray *m_tricepsImagesArray;
// Biceps images array
@property (strong, nonatomic)NSMutableArray *m_bicepsImagesArray;
// Abs exercises list
@property (strong, nonatomic)NSMutableArray *m_absExerciseList;
// Arms exercises list
@property (strong, nonatomic)NSMutableArray *m_armsExerciseList;
// Triceps exercises list
@property (strong, nonatomic)NSMutableArray *m_tricepsExerciseList;
// Biceps exercises list
@property (strong, nonatomic)NSMutableArray *m_bicepsExerciseList;
// Back exercises list
@property (strong, nonatomic)NSMutableArray *m_backExerciseList;
// Chest exercises list
@property (strong, nonatomic)NSMutableArray *m_chestExerciseList;
// Legs exercises list
@property (strong, nonatomic)NSMutableArray *m_legsExerciseList;
// Shoulder exercises list
@property (strong, nonatomic)NSMutableArray *m_shoulderExerciseList;
// Full Body exercises list
@property (strong, nonatomic)NSMutableArray *m_fullBodyExerciseList;
// Cardio exercises list
@property (strong, nonatomic)NSMutableArray *m_cardioExerciseList;
// Sports exercises list
@property (strong, nonatomic)NSMutableArray *m_sportsExerciseList;
@property (strong, nonatomic)NSMutableArray *m_sleep;
// Selected exercise list
@property (strong, nonatomic)NSMutableArray *m_itemsListArray;
// Exercise selected
@property (strong, nonatomic)NSString *m_selectedStringFromExerciseViewController;
// User email id
@property (strong, nonatomic)NSString *m_userEmailID;
// Gender of the user
@property (strong, nonatomic)NSString *m_gender;
// Triceps exercise count
@property (nonatomic)NSUInteger m_tricepsExercisesCount;
// Biceps exercise count
@property (nonatomic)NSUInteger m_bicepsExercisesCount;
// Biceps image start check
@property (strong, nonatomic)NSString *m_showBicepImages;

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
    if (!self.m_transition) {
        self.m_transition                = [ViewTransitions sharedInstance];
    }
    
    [self.m_transition performTransitionFromRight:self.view.superview];
    [self.view removeFromSuperview];
    // Clean up the selected exercise from the previous view
    self.m_selectedStringFromExerciseViewController      = @"";
    [self cleanUpImagesArray];
    
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
 Move to ExerciseViewController
 */
- (void)moveToExerciseViewController:(id)sender
{
    if (!self.m_exerciseViewController) {
        self.m_exerciseViewController        = [ExerciseViewController alloc];
    }
    id instanceObject                   = self.m_exerciseViewController;
    [self moveToView:self.m_exerciseViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
}

/*
 Move to ExerciseProfileViewController
 */
- (void)moveToExerciseProfileViewController:(id)sender
{
    if (!self.m_exerciseProfileViewController) {
        self.m_exerciseProfileViewController         = [ExerciseProfileViewController sharedInstance];
    }
    
    id instanceObject                           = self.m_exerciseProfileViewController;
    
    [self moveToView:self.m_exerciseProfileViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
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
 Move to MealViewController
 */
- (void)moveToMealViewController:(id)sender
{
    if (!self.m_mealViewController) {
        self.m_mealViewController        = [MealViewController alloc];
    }
    id instanceObject               = self.m_mealViewController;
    [self moveToView:self.m_mealViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];

}

/*
 Move to MusicTracksViewController
 */
- (void)moveToMusicTracksViewController:(id)sender
{
    if (!self.m_musicTracksViewController) {
        self.m_musicTracksViewController         = [MusicTracksViewController alloc];
    }
    id instanceObject                       = self.m_musicTracksViewController;
    [self moveToView:self.m_musicTracksViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
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
    self.m_imagesArray               = nil;
    self.m_tricepsExercisesCount     = 0;
    self.m_bicepsExercisesCount      = 0;
}

/*
 Load up the abs
 */
- (NSMutableArray *)loadUpAbsExercise
{
    if (!self.m_absExerciseList) {
        self.m_absExerciseList           = [NSMutableArray mutableArrayObject];
        [self.m_absExerciseList addObject:@"Ab Roller"];
        [self.m_absExerciseList addObject:@"Ball Hand To Feet"];
        [self.m_absExerciseList addObject:@"Ball Roll Ins"];
        [self.m_absExerciseList addObject:@"Ball Twist"];
        [self.m_absExerciseList addObject:@"Bench V Sit Crunch"];
        [self.m_absExerciseList addObject:@"Bicycle Crunch"];
        [self.m_absExerciseList addObject:@"Crunches"];
        [self.m_absExerciseList addObject:@"Flutter Kicks"];
        [self.m_absExerciseList addObject:@"Hanging Leg Raises"];
        [self.m_absExerciseList addObject:@"Hip Raises"];
        [self.m_absExerciseList addObject:@"Laying Windshield Wipers"];
        [self.m_absExerciseList addObject:@"Plank"];
        [self.m_absExerciseList addObject:@"Scissor Sit Ups"];
        [self.m_absExerciseList addObject:@"Side Plank Hip Raises"];
        [self.m_absExerciseList addObject:@"Side Plank"];
        [self.m_absExerciseList addObject:@"Sit ups"];
        [self.m_absExerciseList addObject:@"Supermans"];
        [self.m_absExerciseList addObject:@"Toe Touches"];
        [self.m_absExerciseList addObject:@"V Sit"];
        [self.m_absExerciseList addObject:@"Weighted Crunch On Ball"];
    }
    return self.m_absExerciseList;
}

/*
 Load up Arms exercises
 */
- (NSMutableArray *)loadUpArmsExercises
{
    if (!self.m_tricepsExerciseList) {
        self.m_tricepsExerciseList           = [NSMutableArray mutableArrayObject];
        // triceps exercise list starts
        [self.m_tricepsExerciseList addObject:@"Bench Dips"];
//        [m_tricepsExerciseList addObject:@"Dumbbell Skull Crushers"];
        [self.m_tricepsExerciseList addObject:@"Tricep Extension"];
        [self.m_tricepsExerciseList addObject:@"Tricep Kick Backs"];
        [self.m_tricepsExerciseList addObject:@"Tricep Rope Pull Down"];
        // Total triceps exercises
        self.m_tricepsExercisesCount             = [self.m_tricepsExerciseList count];
    }
    if (!self.m_bicepsExerciseList) {
        self.m_bicepsExerciseList            = [NSMutableArray mutableArrayObject];
        // biceps exercise list starts
        [self.m_bicepsExerciseList addObject:@"Bicep Curl"];
        [self.m_bicepsExerciseList addObject:@"Concentration Curl"];
        [self.m_bicepsExerciseList addObject:@"EZ Bar Curl"];
        [self.m_bicepsExerciseList addObject:@"Preacher Curl"];
        // Total biceps exercises
        self.m_bicepsExercisesCount              = [self.m_bicepsExerciseList count];
    }
    
    return self.m_armsExerciseList;
}

/*
 load up Back exercises
 */
- (NSMutableArray *)loadUpBackExercises
{
    if (!self.m_backExerciseList) {
        self.m_backExerciseList              = [NSMutableArray mutableArrayObject];
        [self.m_backExerciseList addObject:@"Single Arm Bent Over Row"];
        [self.m_backExerciseList addObject:@"Bent Over Alternating Row"];
        [self.m_backExerciseList addObject:@"Bent Over Barbell Row"];
        [self.m_backExerciseList addObject:@"Bent Over Dumbbell Row"];
        [self.m_backExerciseList addObject:@"Seated Row"];
        [self.m_backExerciseList addObject:@"Narrow Grip Pull Up"];
        [self.m_backExerciseList addObject:@"Upright Row"];
        [self.m_backExerciseList addObject:@"Wide Grip Lateral Pull Down"];
        [self.m_backExerciseList addObject:@"Wide Grip Pull Up"];
    }
    return self.m_backExerciseList;
}

/*
 load up Chest exercises
 */
- (NSMutableArray *)loadUpChestExercises
{
    if (!self.m_chestExerciseList) {
        self.m_chestExerciseList            = [NSMutableArray mutableArrayObject];
        [self.m_chestExerciseList addObject:@"Bench Press"];
        [self.m_chestExerciseList addObject:@"Inch Worm Push Up"];
        [self.m_chestExerciseList addObject:@"Incline Bench Press"];
//        [m_chestExerciseList addObject:@"Incline Dumbbell Chest Press"];
        [self.m_chestExerciseList addObject:@"Push Ups"];
        [self.m_chestExerciseList addObject:@"Weighted Chest Fly"];
    }
    return self.m_chestExerciseList;
}

/*
 load up Legs exercises
 */
- (NSMutableArray *)loadUpLegsExercises
{
    if (!self.m_legsExerciseList) {
        self.m_legsExerciseList             = [NSMutableArray mutableArrayObject];
        [self.m_legsExerciseList addObject:@"Body Weight Squats"];
        [self.m_legsExerciseList addObject:@"Butt Kicks"];
        [self.m_legsExerciseList addObject:@"Calf Raises"];
        [self.m_legsExerciseList addObject:@"Deadlift"];
        [self.m_legsExerciseList addObject:@"Squat and Press"];
        [self.m_legsExerciseList addObject:@"Dumbbell Deadlift"];
        [self.m_legsExerciseList addObject:@"Front Squat"];
        [self.m_legsExerciseList addObject:@"Jump squat"];
        [self.m_legsExerciseList addObject:@"Squat"];
        [self.m_legsExerciseList addObject:@"Jumping Split Squat"];
        [self.m_legsExerciseList addObject:@"Leg Press"];
        [self.m_legsExerciseList addObject:@"Lunges"];
        [self.m_legsExerciseList addObject:@"Reverse Lunge"];
        [self.m_legsExerciseList addObject:@"Single Arm Deadlift"];
        [self.m_legsExerciseList addObject:@"Skater Lunges"];
    }
    return self.m_legsExerciseList;
}

/*
 load up Shoulder exercises
 */
- (NSMutableArray *)loadUpShoulderExercises
{
    if (!self.m_shoulderExerciseList) {
        self.m_shoulderExerciseList          = [NSMutableArray mutableArrayObject];
        [self.m_shoulderExerciseList addObject:@"Bent Lateral Raises"];
        [self.m_shoulderExerciseList addObject:@"Dumbbell Drop"];
        [self.m_shoulderExerciseList addObject:@"Front Raises"];
        [self.m_shoulderExerciseList addObject:@"Seated Shoulder Press"];
        [self.m_shoulderExerciseList addObject:@"Power Shrug"];
        [self.m_shoulderExerciseList addObject:@"Standing Shoulder Press"];
        [self.m_shoulderExerciseList addObject:@"Standing Shrug"];
    }
    return self.m_shoulderExerciseList;
}

-(NSMutableArray *)loadUpSleep{
    if(!self.m_sleep){
        self.m_sleep = [NSMutableArray mutableArrayObject];
        [self.m_sleep addObject:@"Sleep Benefits"];
    }
    return self.m_sleep;
}
/*
 load up Full Body Exercises
 */
- (NSMutableArray *)loadUpFullBodyExercises
{
    if (!self.m_fullBodyExerciseList) {
        self.m_fullBodyExerciseList          = [NSMutableArray mutableArrayObject];
        [self.m_fullBodyExerciseList addObject:@"Burpee Push Up"];
        [self.m_fullBodyExerciseList addObject:@"Burpees"];
        [self.m_fullBodyExerciseList addObject:@"Half Burpees"];
        [self.m_fullBodyExerciseList addObject:@"High Pull"];
        [self.m_fullBodyExerciseList addObject:@"Jump Tucks"];
        [self.m_fullBodyExerciseList addObject:@"Jumping Jacks"];
        [self.m_fullBodyExerciseList addObject:@"Kettle Bell Swing"];
        [self.m_fullBodyExerciseList addObject:@"Knee Abductions"];
        [self.m_fullBodyExerciseList addObject:@"Mountain Climbers"];
        [self.m_fullBodyExerciseList addObject:@"Plea Squat Upright Row"];
        [self.m_fullBodyExerciseList addObject:@"High Knees"];
        [self.m_fullBodyExerciseList addObject:@"Squat And Press"];
        [self.m_fullBodyExerciseList addObject:@"Wood Choppers"];
    }
    return self.m_fullBodyExerciseList;
}

/*
 load up Cardio exercises
 */
- (NSMutableArray *)loadUpCardioExercises
{
    if (!self.m_cardioExerciseList) {
        self.m_cardioExerciseList            = [NSMutableArray mutableArrayObject];
        [self.m_cardioExerciseList addObject:@"Bike"];
        [self.m_cardioExerciseList addObject:@"Skip"];
//        [m_cardioExerciseList addObject:@"Sprint"];
//        [m_cardioExerciseList addObject:@"Walk"];
        [self.m_cardioExerciseList addObject:@"Jogging"];
    }
    return self.m_cardioExerciseList;
}

/*
 load up Sports exercises
 */
- (NSMutableArray *)loadUpSportsExercises
{
    if (!self.m_sportsExerciseList) {
        self.m_sportsExerciseList            = [NSMutableArray sportsList];
    }
    return self.m_sportsExerciseList;
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
    if (![self.m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) {
        self.m_imagesArray              = nil;
    }
    
    if(!self.m_bicepsImagesArray){
        self.m_bicepsImagesArray = [NSMutableArray mutableArrayObject];
    }
    
    for (NSString *exercise in itemsListArray) {
        NSString *imageName        = [NSString findImageForWorkout:[NSString stringWithFormat:@"%@",exercise]];
        //NSString *imageName = [NSString findImageForWorkout:[self stringWithFilename:[NSString stringWithFormat:@"%@", exercise]]];
        //NSString *imageName = [self imageWithFilename:[NSString findImageForWorkout:[NSString stringWithFormat:@"%@", exercise]]];
        [self.m_bicepsImagesArray addObject:imageName];
    }

}

/*
 Find image for the exercise
 */
- (void)findImageForExercise:(NSMutableArray *)itemsListArray
{
    // Need to add bicep images on triceps images
    if (![self.m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) {
        self.m_imagesArray              = nil;
    }

    if (!self.m_imagesArray) {
        self.m_imagesArray              = [NSMutableArray mutableArrayObject];
    }
    

    for (NSString *exercise in itemsListArray) {
        NSString *imageName        = [NSString findImageForWorkout:[NSString stringWithFormat:@"%@",exercise]];
        //NSString *imageName = [NSString findImageForWorkout:[self stringWithFilename:[NSString stringWithFormat:@"%@", exercise]]];
        //NSString *imageName = [self imageWithFilename:[NSString findImageForWorkout:[NSString stringWithFormat:@"%@", exercise]]];
        [self.m_imagesArray addObject:imageName];
    }
}

/*
 Select Exercise list
 */
- (void)selectExerciseList:(NSString *)selectedString
{
    // Empty arrays first
    self.m_itemsListArray                = nil;
    self.m_tricepsExerciseList           = nil;
    self.m_bicepsExerciseList            = nil;
    
    if (![self.m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) {
        if([selectedString isEqualToString:@"Abdomimals"]) {
            self.m_itemsListArray            = [self loadUpAbsExercise];
        }
        else if([selectedString isEqualToString:@"Back"]) {
            self.m_itemsListArray            = [self loadUpBackExercises];
        }
        else if([selectedString isEqualToString:@"Chest"]) {
            self.m_itemsListArray            = [self loadUpChestExercises];
        }
        else if([selectedString isEqualToString:@"Legs"]) {
            self.m_itemsListArray            = [self loadUpLegsExercises];
        }
        else if([selectedString isEqualToString:@"Shoulders"]) {
            self.m_itemsListArray            = [self loadUpShoulderExercises];
        }
        else if([selectedString isEqualToString:@"Full Body"]) {
            self.m_itemsListArray            = [self loadUpFullBodyExercises];
        }
        else if([selectedString isEqualToString:@"Cardio"]) {
            self.m_itemsListArray            = [self loadUpCardioExercises];
        }
        else if([selectedString isEqualToString:@"Sports"]) {
            self.m_itemsListArray            = [self loadUpSportsExercises];
        }
        else if([selectedString isEqualToString:@"Sleep"]){
            self.m_itemsListArray = [self loadUpSleep];
        }
        // Then find the image using the exercise names
        [self findImageForExercise:self.m_itemsListArray];
    }
    else if([selectedString isEqualToString:@"Arms"]) {
        self.m_selectedStringFromExerciseViewController          = @"Arms";
        self.m_imagesArray                   = nil;
        self.m_bicepsImagesArray = nil;
        [self loadUpArmsExercises];
        // Then find the image using the exercise names
        [self findImageForExercise:self.m_tricepsExerciseList];
        [self findImageForBicep:self.m_bicepsExerciseList];
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
    self.m_userEmailID                                       = [NSString getUserEmail];
    self.m_gender                                            = [NSString getGenderOfUser];
    
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
    
    if(!self.m_ExerciseIndexView){
        self.m_ExerciseIndexView = [ExcerciseIndexViewController sharedInstance];
    }
    
    if(([self.m_ExerciseIndexView.selectedImage length] != 0) && (self.m_ExerciseIndexView.selectedImage != NULL)){
        self.m_selectedStringFromExerciseViewController = self.m_ExerciseIndexView.selectedImage;
        self.m_ExerciseIndexView.selectedImage = @"";
    }
    [self selectExerciseList:self.m_selectedStringFromExerciseViewController];

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
    if ([self.m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) {
        numberOfSections        = 2;
    }
    
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRowsInSection                  = 0;
    if ([self.m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) {
        if (section == 0) { // Triceps exercises count
           return numberOfRowsInSection        = self.m_tricepsExercisesCount;
        }
        else if(section == 1) { // Biceps exercises count
            return numberOfRowsInSection       = self.m_bicepsExercisesCount;
        }
    }
    else {
        return numberOfRowsInSection           = [self.m_itemsListArray count];
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
    if ([self.m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) {
        
        if ([self.m_showBicepImages isEqualToString:@"YES"]) {
            objectAtIndex                                       = self.m_tricepsExercisesCount;
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
    if ([self.m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) {
        if (indexPath.section == 0) {
            self.m_showBicepImages               = @"NO";
            [self cellContents:cell atIndexPath:indexPath WithImageArray:self.m_imagesArray AndExerciseArray:self.m_tricepsExerciseList];
        }
        else if(indexPath.section == 1) {
            self.m_showBicepImages               = @"YES";
            [self cellContents:cell atIndexPath:indexPath WithImageArray:self.m_bicepsImagesArray AndExerciseArray:self.m_bicepsExerciseList];
        }
    }
    else {
        [self cellContents:cell atIndexPath:indexPath WithImageArray:self.m_imagesArray AndExerciseArray:self.m_itemsListArray];
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
    
    if([self.m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) { // If the selected exercises "Arms"
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
    if ([self.m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) { // The table view is meal plan table view
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
    if([self.m_selectedStringFromExerciseViewController isEqualToString:@"Arms"]) { // If the selected exercises "Arms"
        if (indexPath.section == 0) {
            self.selectedImage               = [[NSString alloc ] initWithFormat:@"%@",[self.m_imagesArray objectAtIndex:indexPath.row]];
        }
        else if(indexPath.section == 1) {
            self.selectedImage               = [[NSString alloc ] initWithFormat:@"%@",[self.m_bicepsImagesArray objectAtIndex:indexPath.row]];
        }
    }
    else {
        self.selectedImage                   = [[NSString alloc ] initWithFormat:@"%@",[self.m_imagesArray objectAtIndex:indexPath.row]];
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
