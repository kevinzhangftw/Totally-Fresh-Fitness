//
//  MealViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-14.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import "MealViewController.h"
#import "MealPlanSelection.h"
#import "FoodProfileViewController.h"
#import "ProfileViewController.h"
#import "RootViewController.h"
#import "MealGroceryList.h"
#import "SwitchPlanItemViewController.h"
#import "NSString+FindImage.h"
#import "NSString+FoodToSwitch.h"
#import "SupplementCheck.h"
#import "SupplementProfileViewController.h"
#import "NSString+SupplementImageName.h"
#import "SHCToDoItem.h"
#import <QuartzCore/QuartzCore.h>
#import "SHCStrikethroughLabel.h"
#import "SHCTableViewCell.h"

@interface MealViewController ()

// Move to previous View
- (IBAction)goBack:(id)sender;
// Move to CalenderViewController
- (void)moveToCalenderViewController:(id)sender;
// Move to ExerciseViewController
- (void)moveToExerciseViewController:(id)sender;
// Move to FoodProfileViewController
- (void)moveToFoodProfileViewController:(id)sender;
// Move to supplements at website
- (void)moveToSupplementsAtWebsite:(id)sender;
// Move to MusicTracksViewController
- (void)moveToMusicTracksViewController:(id)sender;
// Move to SwitchPlanItemViewController
- (void)movetoSwitchPlanItemViewController:(id)sender;
// Move to SupplementPlanViewController
- (void)moveToSupplementPlanViewController:(id)sender;
// Move to SupplementProfileViewController
- (void)moveToSupplementProfileViewController:(id)sender;
// Move to RootViewController's view
- (IBAction)moveToRootViewController:(id)sender;
//Get Food details from the database
- (void)getFoodDetails;
//// Add images, headings and details into each array
//- (void)getFoodName:(NSMutableArray *)foodArray AndQuantity:(NSMutableArray *)valueArray AndAssignImages:(NSMutableArray *)imagesArray fromNSMutableArray:(NSMutableArray *)mutableArray;
// Get Grocery List
- (void)getGroceryList;
// Get Food images from food list names
- (NSMutableArray *)loadUpImagesFromFoodListNames:(NSMutableArray *)foodListNames;
// Details of meal plan and work out plan for the day
- (IBAction)planSection:(id)sender;
// Add methods to each control buttons
- (void)addSelectorToControlButtons;
// Checkbox for the grocery list
- (void)checkBoxForGroceryList:(id)sender;
//  Cell contents such as images, items and measurement displayed
- (void)cellContents:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath WithImageArray:(NSMutableArray *)imageArray AndKeyArray:(NSMutableArray *)keyArray AndValueArray:(NSMutableArray *)valueArray;
// Cell contents such as images, items displayed for Grocery List
- (void)cellContents:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath WithImageArray:(NSMutableArray *)imageArray AndKeyArray:(NSMutableArray *)keyArray;
// Each section has its own images, key and value arrays
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath onTableView:tableView;

@end

@implementation MealViewController{
    CAGradientLayer* _gradientLayer;
	CGPoint _originalCenter;
	BOOL _deleteOnDragRelease;
	SHCStrikethroughLabel *_label;
	CALayer *_itemCompleteLayer;
	BOOL _markCompleteOnDragRelease;
	UILabel *_tickLabel;
	UILabel *_crossLabel;
}

// ProfileViewController class object
ProfileViewController *m_profileViewController;
// CalenderViewController class object
CalenderViewController *m_calenderViewController;
// FoodViewController class object
FoodProfileViewController *m_foodProfileViewController;
// ExerciseViewController class object
ExerciseViewController *m_exerciseViewController;
// MusicTracksViewController class object
MusicTracksViewController *m_musicTracksViewController;
// SupplementPlanViewController class object
SupplementPlanViewController *m_supplementPlanViewController;
// SwitchPlanItemViewController class object
SwitchPlanItemViewController *m_switchPlanItemViewController;
// SupplementProfileViewController class object
SupplementProfileViewController *m_supplementProfileViewController;
// RootViewController class object
RootViewController *m_rootViewController;
// Database class object
Database *m_database;
// MealPlanSelectin class object
MealPlanSelection *m_mealPlanSelection;
// ViewTransition class object
ViewTransitions *m_transition;
// ViewFactory class object
ViewFactory *m_controllerViews;
// MealGroceryList class object
MealGroceryList *m_mealGroceryList;
// Supplement Check Instance object
SupplementCheck *m_supplementCheck;
MealViewController *m_mealViewController;

// Meal plan array
NSArray *m_mealPlanArray;
// Get calorie plist
NSMutableArray *m_calorieArray;
// Section Dictionary
NSMutableDictionary *m_currentDictionary;
// Breakfast Dictionary
NSMutableDictionary *m_breakFastDictionary;
// First snack Dictionary
NSMutableDictionary *m_firstSnackDictionary;
// Lunch Dictionary
NSMutableDictionary *m_lunchDictionary;
// Second snack Dictionary
NSMutableDictionary *m_secondSnackDictionary;
// Dinner Dictionary
NSMutableDictionary *m_dinnerDictionary;
// Third Snack Dictionary
NSMutableDictionary *m_thirdSnackDictionary;
// Total Calorie Dictionary
NSMutableDictionary *m_totalCalorieDictionary;
// Food list Mutable images array
NSMutableArray *m_foodListImagesArray;
// Food list Mutable names array
NSMutableArray *m_foodListNamesArray;
// Total Calorie Mutable Value array
NSMutableArray *m_totalCalorieValueArray;
// Total number of items in the breakfast dictionary
int m_numberOfItemsInBreakFast;
// Total number of items in the first snack dictionary
int m_numberOfItemsInFirstSnack;
// Total number of items in the lunch dictionary
int m_numberOfItemsInLunch;
// Total number of items in the second snack dictionary
int m_numberOfItemsInSecondSnack;
// Total number of items in the dinner dictionary
int m_numberOfItemsInDinner;
// Total number of items in the third snack dictionary
int m_numberOfItemsInThirdSnack;
// Total number of items in the total calorie dictionary
int m_numberOfItemsInTotalCalorie;
// Total number of items in all dictionaries in a calorie array
int m_totalDictionaryInACaloriePlist;
// Grocery list array;
NSMutableArray *m_groceryListArray;
// Image array for Grocery List
NSMutableArray *m_imagesForGroceryListArray;
// Row Check box array
NSMutableArray *m_checkBoxArray;
// To avoid redisplay an already active view
NSString *m_checkWhichMealButtonWasClicked;
// Meal Table is Meal Plan or Meal List
NSString *m_mealPlanOrFoodListOnMealTable;
// User email from database
NSString *m_userEmail;
// Gender of user
NSString *m_gender;
// NSMutableArray of cells
NSMutableArray *m_arrayOfCells;
// If switch or disclosure
bool isDisclosure;

// Help pop up button
UIButton *m_helpPopUpButtonViewInMealView;
// NSUserDefault
NSUserDefaults *userDefaults;

@synthesize controlsImageView;
@synthesize mealPlanSectionButton;
@synthesize groceryListSectionButton;
@synthesize mealTableView;
@synthesize groceryTableView;
@synthesize indicatorView;
@synthesize bottomBarButton;
@synthesize musicPlayerButton;
@synthesize exercisePlanButton;
@synthesize calendarButton;
@synthesize mealPlanButton;
@synthesize nutritionPlanButton;
@synthesize messageButton;
@synthesize selectedImage;
@synthesize foodSelectedToEdit;

/*
 Singleton MealViewController object
 */
+ (MealViewController *)sharedInstance {
	static MealViewController *globalInstance;
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
        m_transition    = [ViewTransitions sharedInstance];
    }
    
    [m_transition performTransitionFromRight:self.view.superview];
    [self.view removeFromSuperview];
    
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
 Move to FoodProfileViewController
 */
- (void)moveToFoodProfileViewController:(id)sender
{    
    if (!m_foodProfileViewController) {
        m_foodProfileViewController     = [FoodProfileViewController sharedInstance];
    }
    id instanceObject                   = m_foodProfileViewController;
    [self moveToView:m_foodProfileViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to ExerciseViewController
 */
- (void)moveToExerciseViewController:(id)sender
{
    if (!m_exerciseViewController) {
        m_exerciseViewController        = [ExerciseViewController sharedInstance];
    }
    
    id instanceObject                   = m_exerciseViewController;
    [self moveToView:m_exerciseViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
}

/*
 Move to MusicTracksViewController
 */
- (void)moveToMusicTracksViewController:(id)sender
{
    if (!m_musicTracksViewController) {
        m_musicTracksViewController         = [MusicTracksViewController sharedInstance];
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
 Move to SwitchPlanItemViewController
 */
- (void)movetoSwitchPlanItemViewController:(id)sender
{
    if (!m_switchPlanItemViewController) {
        m_switchPlanItemViewController      = [SwitchPlanItemViewController sharedInstance];
    }
    id instanceObject                       = m_switchPlanItemViewController;
    m_switchPlanItemViewController.view.tag = 1;
    [self moveToView:m_switchPlanItemViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to SupplementProfileViewController
 */
- (void)moveToSupplementProfileViewController:(id)sender
{
    if (!m_supplementProfileViewController) {
        m_supplementProfileViewController         = [SupplementProfileViewController sharedInstance];
    }
    id instanceObject               = m_supplementProfileViewController;
    [self moveToView:m_supplementProfileViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
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
 Move to MusicTracksViewController
 */
- (IBAction)moveToRootViewController:(id)sender
{
    if (!m_rootViewController) {
        m_rootViewController                = [RootViewController sharedInstance];
    }
    
    id instanceObject               = m_rootViewController;
    [self moveToView:m_rootViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Get Grocery List
 */
- (void)getGroceryList
{
    // clean the arrays first
    m_groceryListArray                  = nil;
    m_imagesForGroceryListArray         = nil;

    m_groceryListArray                  = [NSMutableArray mutableArrayObject];
    m_imagesForGroceryListArray         = [NSMutableArray mutableArrayObject];

    if (!m_database) {
        m_database                      = [Database alloc];
    }
    if (!m_userEmail) {
        m_userEmail                     = [NSString getUserEmail];
    }
    // Get the grocery list from the database
    m_groceryListArray                  = [m_database getGroceryList:m_userEmail];
    for (NSString *groceryItemName in m_groceryListArray) {
        // Find the food image from the food list names
        NSString *groceryItemNameString              = [NSString findImageForMealPlan:groceryItemName];
        if ((groceryItemNameString != NULL) && ([groceryItemNameString length] != 0)) {
            // Add to the grocery images array
            [m_imagesForGroceryListArray addObject:groceryItemNameString];
        }
    }
}

/*
 Details of meal plan and grocery list
 */
- (IBAction)planSection:(id)sender;
{


    if (!m_transition) {
        m_transition    = [ViewTransitions sharedInstance];
    }
    
    if ((sender == self.mealPlanSectionButton) && ([m_checkWhichMealButtonWasClicked isEqualToString:@"Grocery List"])) {
        m_checkWhichMealButtonWasClicked        = @"Meal Plan";
        self.controlsImageView.image            = [UIImage imageNamed:@"tfn_Mealplan_active.png"];
        self.groceryTableView.hidden            = YES;
        [m_transition performTransitionFromLeft:self.mealTableView];
        self.mealTableView.hidden               = NO;

        // Reload the data
        [self.mealTableView reloadData];
        // Refocus from the top
        [self.mealTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

    }
    else if((sender == self.groceryListSectionButton) && ([m_checkWhichMealButtonWasClicked isEqualToString:@"Meal Plan"])) {
        m_checkWhichMealButtonWasClicked        = @"Grocery List";
        self.controlsImageView.image            = [UIImage imageNamed:@"tfn_GL_active.png"];
        self.mealTableView.hidden               = YES;
        [m_transition performTransitionFromRight:self.groceryTableView];
        self.groceryTableView.hidden            = NO;

        // Reload the data
        [self.groceryTableView reloadData];
        // Refocus from the top
        [self.groceryTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    }
}

/*
 Get Food images from food list names
 */
- (NSMutableArray *)loadUpImagesFromFoodListNames:(NSMutableArray *)foodListNames
{
    NSMutableArray *foodImagesArray           = [NSMutableArray mutableArrayObject];
    for (NSString *foodName in foodListNames) {
        // Find the food image from the food list names
        NSString *foodNameString              = [NSString findImageForMealPlan:foodName];
        if ((foodNameString != NULL) && ([foodNameString length] != 0)) {
            // Add to the food images array
            [foodImagesArray addObject:foodNameString];
        }
    }
    return foodImagesArray;
}

/*
 Get Food list names
 */
- (void)getFoodListNames
{
    if (!m_mealPlanSelection) {
        m_mealPlanSelection                 = [MealPlanSelection  sharedInstance];
    }
    m_foodListNamesArray                = [NSMutableArray mutableArrayObject];
    m_foodListImagesArray               = [NSMutableArray mutableArrayObject];
    
    // Load up the food list array from the plist
    m_foodListNamesArray                    = [m_mealPlanSelection loadUpPlist:@"Food Items"];
    // Get the food list images array from the food list name
    m_foodListImagesArray                   = [self loadUpImagesFromFoodListNames:m_foodListNamesArray];
}

/*
 Get Food details from the database
 */
- (void)getFoodDetails
{
    m_mealPlanArray         = [NSMutableArray loadUpMealPlan];
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
    // Stay here
    
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
    [button setBackgroundImage:[UIImage imageNamed:@"grocery_selected.png"] forState:UIControlStateNormal];
    
    // NSInteger number be converted into NSNumber to add to the array
    CGPoint touchPoint          = [sender convertPoint:CGPointZero toView:self.groceryTableView];
    NSIndexPath *indexPath      = [self.groceryTableView indexPathForRowAtPoint:touchPoint];
//
    NSNumber *row               = [NSNumber numberWithInteger:indexPath.row];
    [m_checkBoxArray addObject:row];

    if (row) {
        [self tableView:self.groceryTableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }

}

/*
 Click edit button
 */
- (void)editButtonTapped:(id)sender event:(id)event
{
    NSSet *touches                  = [event allTouches];
    UITouch *touch                  = [touches anyObject];
    CGPoint currentTouchPosition    = [touch locationInView:self.mealTableView];
    NSIndexPath *indexPath          = [self.mealTableView indexPathForRowAtPoint: currentTouchPosition];
    
    if (indexPath != nil) {
        // Eachtime button is clicked, let the accessoryButtonTappedForRoWithIndexPath know
        [self tableView: self.mealTableView accessoryButtonTappedForRowWithIndexPath: indexPath];
    }
}

- (void)helpButtonClicked
{
    userDefaults        = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:1 forKey:@"SwitchMealPlanItem_Help"];
    [userDefaults synchronize];
    
    [m_helpPopUpButtonViewInMealView removeFromSuperview];
}

- (void)createHelpPopUp
{
    CGRect helpPopUpButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        helpPopUpButtonFrame     =   CGRectMake(0.0f, 0.0f, 320.0f, 568.0f);
        m_helpPopUpButtonViewInMealView       = [[UIButton alloc] initWithFrame:helpPopUpButtonFrame];
        [m_helpPopUpButtonViewInMealView setBackgroundImage:[UIImage imageNamed:@"substitute_meal_instruction_i5.png"] forState:UIControlStateNormal];
    }
    else {
        helpPopUpButtonFrame     = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
        m_helpPopUpButtonViewInMealView       = [[UIButton alloc] initWithFrame:helpPopUpButtonFrame];
        [m_helpPopUpButtonViewInMealView setBackgroundImage:[UIImage imageNamed:@"substitute_meal_instruction.png"] forState:UIControlStateNormal];
    }
    [self.view addSubview:m_helpPopUpButtonViewInMealView];
    [m_helpPopUpButtonViewInMealView addTarget:self action:@selector(helpButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    
    
    m_checkBoxArray                         = [NSMutableArray mutableArrayObject];

    // adjust view and tableview size for iphone5
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        // adjust the height of the tableview and readd the indicator view
        [self.groceryTableView removeFromSuperview];
        self.groceryTableView           = [self adjustiPhone5HeightOfTableView:self.groceryTableView ForController:self];
        [self.view addSubview:self.groceryTableView];
        [self.mealTableView removeFromSuperview];
        self.mealTableView              = [self adjustiPhone5HeightOfTableView:self.mealTableView ForController:self];
        [self.view addSubview:self.mealTableView];
        [self.indicatorView removeFromSuperview];
        self.indicatorView              = [self reAddActivityIndicatorforiPhone5:self.indicatorView];
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
        
    // The default view is "Meal Plan"
    m_checkWhichMealButtonWasClicked        = @"Meal Plan";
    self.controlsImageView.image            = [UIImage imageNamed:@"tfn_Mealplan_active.png"];
    
    userDefaults        = [NSUserDefaults standardUserDefaults];
    if (![userDefaults integerForKey:@"SwitchMealPlanItem_Help"]) {
        // Add Help Pop Up
        [self createHelpPopUp];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!m_database) {
        m_database                          = [Database alloc];
    }
    m_userEmail                             = [NSString getUserEmail];
    
    m_mealPlanOrFoodListOnMealTable         = @"Meal Plan";
    
    if ([m_mealPlanOrFoodListOnMealTable isEqualToString:@"Meal Plan"]) {
        // Get food details
        [self getFoodDetails];

        if (!m_arrayOfCells) {
            m_arrayOfCells                  = [NSMutableArray mutableArrayObject];
        }
    }
    else if([m_mealPlanOrFoodListOnMealTable isEqualToString:@"Food List"]) {
        // Load up the food list names
        [self getFoodListNames];
    }

    [self.mealTableView reloadData];
//    [groceryTableView reloadData];
    [self getGroceryList];
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
    if (tableView == mealTableView) {
        
        headerView              = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
        UILabel *label          = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
        
        if ([m_mealPlanOrFoodListOnMealTable isEqualToString:@"Meal Plan"]) { // User has a purchased a meal plan

            if (section == 0) {
                label.text        = @"  Breakfast Shake                                             Sub";
            }
            else if(section == 1) {
                label.text        = @"  Morning Snack                                                Sub";
            }
            else if(section == 2) {
                label.text        = @"  Lunch                                                                    Sub";
            }
            else if(section == 3) {
                label.text        = @"  Afternoon Snack                                            Sub";
            }
            else if(section == 4) {
                label.text        = @"  Dinner                                                                  Sub";
            }
            else if(section == 5) {
                label.text        = @"  Evening Snack                                                 Sub";
            }
            else if(section == 6) {
                label.text        = @"  Total Calories";
            }
        }
        else if ([m_mealPlanOrFoodListOnMealTable isEqualToString:@"Food List"]) { // User has not purchased a meal plan, show the food list
            label.text        = @"  Food Items";
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int numberOfSections    = 0;
    if (tableView == mealTableView) {
        if ([m_mealPlanOrFoodListOnMealTable isEqualToString:@"Meal Plan"]) { // User has a purchased a meal plan
            numberOfSections        = 6;
        }
        else if ([m_mealPlanOrFoodListOnMealTable isEqualToString:@"Food List"]) { // User has not purchased a meal plan, show the food list
            numberOfSections        = 1;
        }
    }
    else if(tableView == groceryTableView) {
        numberOfSections = 1;
    }
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRowsInSection       = 0;
    if (tableView == mealTableView) { // if the section is Meal Plan
        if ([m_mealPlanOrFoodListOnMealTable isEqualToString:@"Meal Plan"]) { // User has a purchased a meal plan
            if(section == 6) {
                return numberOfRowsInSection    = 1;
            }
            else {
                return numberOfRowsInSection    = [[[m_mealPlanArray objectAtIndex:section] objectAtIndex:0] count];
            }
        }
        else if ([m_mealPlanOrFoodListOnMealTable isEqualToString:@"Food List"]) { // User has not purchased a meal plan, show the food list
            return numberOfRowsInSection        = [m_foodListNamesArray count];
        }
    }
    else if(tableView == groceryTableView) { // if the section is grocery list
        return numberOfRowsInSection            = [m_groceryListArray count];
    }
       
    return numberOfRowsInSection;
}

/*
 Cell contents such as images, items and measurement displayed for Meal Plan
 */
- (void)cellContents:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath WithImageArray:(NSMutableArray *)imageArray AndKeyArray:(NSMutableArray *)keyArray AndValueArray:(NSMutableArray *)valueArray
{
    UIImage *cellImage                                  = nil;
    if ([imageArray count] > 0) { // So that assessing empty array, doesn't crash the app
        cellImage                                           = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];     // Find the right image
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
        // Customize accessoryView
        [cell setUserInteractionEnabled:YES];
    }
    ((UILabel *)[cell viewWithTag:2]).text              = [keyArray objectAtIndex:indexPath.row];

    if ([m_mealPlanOrFoodListOnMealTable isEqualToString:@"Meal Plan"]) { // User has a purchased a meal plan
        if ([[valueArray objectAtIndex:indexPath.row] isEqualToString:@"Empty Space"]) {
            ((UILabel *)[cell viewWithTag:3]).text      = @"";
        }
        else {
            ((UILabel *)[cell viewWithTag:3]).text      = [valueArray objectAtIndex:indexPath.row];
        }
    }
}

/*
 Cell contents such as images, items displayed for Grocery List
 */
- (void)cellContents:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath WithImageArray:(NSMutableArray *)imageArray AndKeyArray:(NSMutableArray *)keyArray
{
    // Add checkBoxForGroceryList functionality
    UIButton *button                                    = ((UIButton *)[cell viewWithTag:3]);
    [button addTarget:self action:@selector(checkBoxForGroceryList:) forControlEvents:UIControlEventTouchUpInside];
    
    // Default should be unchecked box
    [button setBackgroundImage:[UIImage imageNamed:@"grocery_unselected.png"] forState:UIControlStateNormal];

    // loop through selected row to make them checked
    if ([m_checkBoxArray count] > 0) {
        for (NSNumber *row in m_checkBoxArray) {
            if([row integerValue] == indexPath.row) {
                // If the row was already checked, give checkedbox background image
                [button setBackgroundImage:[UIImage imageNamed:@"grocery_selected.png"] forState:UIControlStateNormal];
                break;
            }
        }
    }
    
    UIImage *cellImage                                  = nil;

    if ([m_imagesForGroceryListArray count] > 0) { // so that accessing the empty array doesn't crash the app
        cellImage                                       = [UIImage imageNamed:[m_imagesForGroceryListArray objectAtIndex:indexPath.row]];     // Find the right image
    }
    ((UIImageView *)[cell viewWithTag:1]).image         = cellImage;
    if (!cellImage) { // If the there is no image displayed then, there isn't any food item for that
        cell.accessoryType                              = UITableViewCellAccessoryNone;
        [cell setUserInteractionEnabled:NO];
    }
    else { // Cell the set have the accessory and interaction as well to avoid remaining disabled from the above if
        
        // Customize accessoryView
        cell.accessoryType                              = UITableViewCellAccessoryNone;
        [cell setUserInteractionEnabled:YES];
    }
    ((UILabel *)[cell viewWithTag:2]).text              = [m_groceryListArray objectAtIndex:indexPath.row];
}


/*
 Each section has its own images, key and value arrays
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath onTableView:tableView
{
    if (tableView == mealTableView) { // set up cell for Meal plan
        if ([m_mealPlanOrFoodListOnMealTable isEqualToString:@"Meal Plan"]) { // User has a purchased a meal plan

            [self cellContents:cell atIndexPath:indexPath WithImageArray:[[m_mealPlanArray objectAtIndex:indexPath.section] objectAtIndex:0] AndKeyArray:[[m_mealPlanArray objectAtIndex:indexPath.section] objectAtIndex:1] AndValueArray:[[m_mealPlanArray objectAtIndex:indexPath.section] objectAtIndex:2]];
        }
        else if ([m_mealPlanOrFoodListOnMealTable isEqualToString:@"Food List"]) { // User has a purchased a meal plan
            [self cellContents:cell atIndexPath:indexPath WithImageArray:m_foodListImagesArray AndKeyArray:m_foodListNamesArray AndValueArray:nil];
        }
    }
    else if(tableView == groceryTableView) { // Set the cell for grocery list
        [self cellContents:cell atIndexPath:indexPath WithImageArray:m_imagesForGroceryListArray AndKeyArray:m_groceryListArray];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MealPlanAndGroceryListIdentifier     = @"MealPlanAndGroceryListIdentifier";
    UITableViewCell *cell                                 = [tableView dequeueReusableCellWithIdentifier:MealPlanAndGroceryListIdentifier];
    //SHCTableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:MealPlanAndGroceryListIdentifier];

    
    if (cell == nil) {
        cell                               = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MealPlanAndGroceryListIdentifier];
        
        if (tableView == groceryTableView) { // If the view is Grocery List
            // Position image after the check button
            // for the image on the left
            UIImageView *groceryListImageView         = [[UIImageView alloc] initWithFrame: CGRectMake(0,0,110,80)];
            groceryListImageView.tag                  = 1; // Need to add outside the if statment
            [cell.contentView addSubview:groceryListImageView];

            CGRect frame                              = CGRectMake(240, 20, 70, 50);
            // checkButton
            UIButton *checkButton                     = [[UIButton alloc] initWithFrame:frame];
            checkButton.tag                           = 3;
            // Add image to the butt
            [cell.contentView addSubview:checkButton];

            // Position after image and is the only text
            // for the name of the food item
            UILabel *groceryListTextLabel             = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 150, 60)];
            groceryListTextLabel.font                 = [UIFont customFontWithSize:15];
            groceryListTextLabel.lineBreakMode        = NSLineBreakByWordWrapping;
            groceryListTextLabel.numberOfLines        = 3;
            groceryListTextLabel.textAlignment        = NSTextAlignmentLeft;
            groceryListTextLabel.textColor            = [UIColor blackColor];
            groceryListTextLabel.tag                  = 2; // Need to add outside the if statment
            [cell.contentView addSubview:groceryListTextLabel];

            
        }
        else if(tableView == mealTableView) { // If the view is Meal Plan

            // there is no check button, so position from the left
            UIImageView *mealPlanImageView            = [[UIImageView alloc] initWithFrame: CGRectMake(0,5,75,75)];
            mealPlanImageView.tag                     = 1; // Need to add outside the if statment
            [cell.contentView addSubview:mealPlanImageView];

            // adjust the position to accommodate the calorie text label
            UILabel *mealPlanTextLabel                = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 150, 60)];
            mealPlanTextLabel.font                    = [UIFont customFontWithSize:15];
            mealPlanTextLabel.lineBreakMode           = NSLineBreakByWordWrapping;
            mealPlanTextLabel.numberOfLines           = 3;
            mealPlanTextLabel.textAlignment           = NSTextAlignmentLeft;
            mealPlanTextLabel.textColor               = [UIColor blackColor];
            mealPlanTextLabel.tag                     = 2; // Need to add outside the if statment
            [cell.contentView addSubview:mealPlanTextLabel];

            if ([m_mealPlanOrFoodListOnMealTable isEqualToString:@"Meal Plan"]) { // User has a purchased a meal plan
                //  Position the calorie text label
                UILabel *theDetailTextLabel           = [[UILabel alloc] initWithFrame:CGRectMake(85, 45, 150, 20)];
                theDetailTextLabel.font               = [UIFont customFontWithSize:10];
                theDetailTextLabel.lineBreakMode      = NSLineBreakByWordWrapping;
                theDetailTextLabel.numberOfLines      = 2;
                theDetailTextLabel.textAlignment      = NSTextAlignmentLeft;
                theDetailTextLabel.textColor          = [UIColor blackColor];
                theDetailTextLabel.tag                = 3; // Need to add outside the if statment
                [cell.contentView addSubview:theDetailTextLabel];
                
                UIButton *switchButton                   = [UIButton buttonWithType:UIButtonTypeCustom];
                UIImage *image                        = [UIImage imageNamed:@"switch"];
                CGRect frame                          = CGRectMake(0.0, 0.0, image.size.width - 15.0f, image.size.height - 15.0f);
                switchButton.frame                       = frame;
                [switchButton setBackgroundImage:image forState:UIControlStateNormal];
                // set the button's target to this table view controller so we can interpret touch events and map that to a NSIndexSet
                [switchButton addTarget:self action:@selector(editButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
                switchButton.backgroundColor             = [UIColor clearColor];
                switchButton.tag                         = 4;
                cell.accessoryView                    = switchButton;
            }
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
    
    if(tableView == mealTableView) { // If the view is Meal Plan
        
        heightForHeaderSection  = 30.0f;
    }
    else { // If the viewis Grocery List
        heightForHeaderSection  = 0.0f;
    
    }
    return heightForHeaderSection;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedSupplement;
    if (selectedSupplement) {
        selectedSupplement      = nil;
    }
    
    if (!m_supplementCheck) {
        m_supplementCheck           = [SupplementCheck sharedInstance];
    }
    
    if (self.selectedImage) {
        self.selectedImage      = nil;
    }

    if (self.selectedImage) {
        self.selectedImage      = nil;
    }
    
    if (tableView == mealTableView) {
        if ([m_mealPlanOrFoodListOnMealTable isEqualToString:@"Meal Plan"]) { // User has a purchased a meal plan
            // assign image for the next view
            selectedSupplement         = [[[m_mealPlanArray objectAtIndex:indexPath.section] objectAtIndex:0]  objectAtIndex:indexPath.row];
            
            if ([m_supplementCheck checkSupplementItemExist:selectedSupplement]) { // if the selected item is supplement
                [NSString setSupplementImageName:selectedSupplement];
                [self moveToSupplementProfileViewController:self];
            }
            else {
                // assign image for the next view
                self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[[[m_mealPlanArray objectAtIndex:indexPath.section] objectAtIndex:0]  objectAtIndex:indexPath.row]];
                // Move to FoodProfileViewController
                [self moveToFoodProfileViewController:indexPath];
            }
        }
        else if ([m_mealPlanOrFoodListOnMealTable isEqualToString:@"Food List"]) { // User has not purchased a meal plan
            self.selectedImage              = [[NSString alloc ] initWithFormat:@"%@",[m_foodListImagesArray objectAtIndex:indexPath.row]];
            // Move to FoodProfileViewController
            [self moveToFoodProfileViewController:indexPath];
        }
    }
    else if(tableView == groceryTableView) {
        // assign image from grocery list images
        self.selectedImage        = [m_imagesForGroceryListArray  objectAtIndex:indexPath.row];
        // Move to FoodProfileViewController
        [self moveToFoodProfileViewController:indexPath];
    }
    
    // Unselect the row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

/*
 Accessory button tapped
 */
- ( void ) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.groceryTableView) {
        UITableViewCell *cell               = [tableView cellForRowAtIndexPath:indexPath];
        if (cell.selectionStyle) {
            cell.selectionStyle             = UITableViewCellSelectionStyleNone;
        }
        else {
            cell.selectionStyle             = UITableViewCellSelectionStyleDefault;
        }
    }
    else {
        if (indexPath.section == 0) {
            if (tableView == self.mealTableView) {
                // assign food item for the next view
                self.foodSelectedToEdit         = [[NSString alloc ] initWithFormat:@"%@",[[[m_mealPlanArray objectAtIndex:0] objectAtIndex:1]  objectAtIndex:indexPath.row]];
            }
        }
        else {
            // assign food item for the next view
            self.foodSelectedToEdit         = [[NSString alloc ] initWithFormat:@"%@",[[[m_mealPlanArray objectAtIndex:indexPath.section] objectAtIndex:1]  objectAtIndex:indexPath.row]];
        }
        
        [NSString setFoodItemToSwitch:self.foodSelectedToEdit];

        self.selectedSection            = indexPath.section;

        [self movetoSwitchPlanItemViewController:indexPath];
    }
}

@end
