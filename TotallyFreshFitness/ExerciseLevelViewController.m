//
//  ExerciseLevelViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-06.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import "ExerciseLevelViewController.h"
#import "WorkOutDaysViewController.h"

@interface ExerciseLevelViewController ()

// Load up the exercise Level images
- (void)loadExerciseImages;
// Exercise level selected images are placed in an array
- (void)loadExerciseSelectedImages;
// Move to moveToWorkoutDaysViewController
- (void)moveToWorkoutDaysViewController;

@end

@implementation ExerciseLevelViewController

// Advanced level image
NSString *const m_advanced                              =   @"advanced.png";
// Beginner level image
NSString *const m_beginner                              =   @"beginner.png";
// Intermediate level image
NSString *const m_intermediate                          =   @"intermediate.png";
// Advanced level image for iphone5
NSString *const m_advanced_iPhone5                      =   @"advanced_iphone5.png";
// Beginner level image for iPhone5
NSString *const m_beginner_iPhone5                      =   @"beginner_iphone5.png";
// Intermediate level image for iPhone5
NSString *const m_intermediate_iPhone5                  =   @"intermediate_iphone5.png";
// Advanced level selected image
NSString *const m_advanced_selected                     =   @"advanced_selected.png";
// Beginner level selected image
NSString *const m_beginner_selected                     =   @"beginner_selected.png";
// Intermediate level selected image
NSString *const m_intermediate_selected                 =   @"intermediate_selected.png";
// Advanced level selected image for iphone5
NSString *const m_advanced_iPhone5_selected             =   @"advanced_iphone5_selected.png";
// Beginner level selected image for iPhone5
NSString *const m_beginner_iPhone5_selected             =   @"beginner_iphone5_selected.png";
// Intermediate level selected image for iPhone5
NSString *const m_intermediate_iPhone5_selected         =   @"intermediate_iphone5_selected.png";

// WorkoutDaysViewController class object
WorkOutDaysViewController *m_workoutDaysViewController;
// Database class object
Database *m_database;
// ViewFactory class object
ViewFactory *m_controllerViews;
// ViewTransitions class object
ViewTransitions *m_transition;
// All exercise level images - images are the cell background
NSMutableArray  *exerciseLevelImages;
// All exercise level selected images - images are the cell background
NSMutableArray  *exerciseLevelSelectedImages;

@synthesize messageButton;
@synthesize theTableView;
@synthesize indicatorView;

/*
 Singleton ExerciseLevelViewController object
 */
+ (ExerciseLevelViewController *)sharedInstance {
	static ExerciseLevelViewController *globalInstance;
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
        m_transition                = [[ViewTransitions alloc] init];
    }
    [m_transition performTransitionFromRight:self.view.superview];
    [self.view removeFromSuperview];
}

/*
 Move to WorkoutDaysViewController
 */
- (void)moveToWorkoutDaysViewController
{
    if (!m_workoutDaysViewController) {
        m_workoutDaysViewController       = [WorkOutDaysViewController sharedInstance];
    }
    id instanceObject               = m_workoutDaysViewController;
    [self moveToView:m_workoutDaysViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
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
 Exercise level images are placed in an array
 */
- (void)loadExerciseImages
{
    exerciseLevelImages                     = [NSMutableArray mutableArrayObject];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        // Exercise level images for iPhone5
        [exerciseLevelImages addObject:m_beginner_iPhone5];
        [exerciseLevelImages addObject:m_intermediate_iPhone5];
        [exerciseLevelImages addObject:m_advanced_iPhone5];
    }
    else {
        // Exercise level images
        [exerciseLevelImages addObject:m_beginner];
        [exerciseLevelImages addObject:m_intermediate];
        [exerciseLevelImages addObject:m_advanced];
    }
}

/*
 Exercise level selected images are placed in an array
 */
- (void)loadExerciseSelectedImages
{
    exerciseLevelSelectedImages                     = [NSMutableArray mutableArrayObject];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        // Exercise level selected images for iPhone5
        [exerciseLevelSelectedImages addObject:m_beginner_iPhone5_selected];
        [exerciseLevelSelectedImages addObject:m_intermediate_iPhone5_selected];
        [exerciseLevelSelectedImages addObject:m_advanced_iPhone5_selected];
    }
    else {
        // Exercise level selected images
        [exerciseLevelSelectedImages addObject:m_beginner_selected];
        [exerciseLevelSelectedImages addObject:m_intermediate_selected];
        [exerciseLevelSelectedImages addObject:m_advanced_selected];
    }
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
        self.theTableView       = [self adjustiPhone5HeightOfTableView:self.theTableView ForController:self];
        [self.view addSubview:self.theTableView];
        self.indicatorView      = [self reAddActivityIndicatorforiPhone5:self.indicatorView];
        [self.view addSubview:self.indicatorView];
    }
    [self.indicatorView startAnimating];
    
    [self.messageButton removeFromSuperview];
    self.messageButton.titleLabel.font          = [UIFont customFontWithSize:13];
    self.messageButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messageButton.titleLabel.numberOfLines = 2;
    self.messageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.messageButton];
    
    // load up the exercise images
    [self loadExerciseImages];
    // load up the exercise selected images
    [self loadExerciseSelectedImages];

}

- (void)viewWillAppear:(BOOL)animated
{
    [self.theTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [exerciseLevelImages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *emailIDsIdentifier = @"emailIDsIdentifier";
    UITableViewCell *cell               = [tableView dequeueReusableCellWithIdentifier:emailIDsIdentifier];
    cell                            = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:emailIDsIdentifier];
    //        cell.textLabel.text             = [NSMutableArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor        = [UIColor whiteColor];
    cell.textLabel.font             = [UIFont customFontWithSize:10];
    
    // Configure the cell.
    UIImageView *imageview          = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[exerciseLevelImages objectAtIndex:indexPath.row]]];
    cell.accessoryType              = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundView             = imageview;
    imageview.tag               	= 1;
    
    // Set clear cell background color when selected
    UIView *bgView              = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    [bgView setBackgroundColor:[UIColor clearColor]];
    cell.selectedBackgroundView = bgView;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float heightForRowAtIndexPath   = 140.0f;
    
    // If the device is iphone 5, take care of the screen
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        heightForRowAtIndexPath     = 168.0f;
    }
    return heightForRowAtIndexPath;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Stop the indicatorview when cells are to be loaded
    [self.indicatorView stopAnimating];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Exercise Level
    NSString *exerciseLevel        = @"";
    NSString *exerciseLevelStatus  = @"";
    
    NSDate *date                   = [NSDate date];
    
    // Update the background image to selected
    UITableViewCell *cell          = [theTableView cellForRowAtIndexPath:indexPath];
    UIImageView *imageview         = (UIImageView *)[cell viewWithTag:1];
    imageview.image                = [UIImage imageNamed:[exerciseLevelSelectedImages objectAtIndex:indexPath.row]];
    cell.backgroundView            = imageview;


    if (indexPath.row == 0) {
        exerciseLevel      = @"BEGINNER";

    }
    else if(indexPath.row == 1) {
        exerciseLevel      = @"INTERMEDIATE";
        
    }
    else if(indexPath.row == 2) {
        exerciseLevel      = @"ADVANCED";

    }
    
    if (([exerciseLevel length] != 0) && (exerciseLevel != NULL)) {
        if (!m_database) {
            m_database      = [Database alloc];
        }
        exerciseLevelStatus      = [m_database insertIntoExerciseLevelEmail_Id:[NSString getUserEmail] Date:date Level:exerciseLevel];
        if ([exerciseLevelStatus isEqualToString:@"updated"]) { // If the insert is successful
            [self moveToWorkoutDaysViewController];
        }
        else {
            [self displayMessage:@"We failed save to exercise level, please try later"];
        }
    }
    // Unselect the row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
