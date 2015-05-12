//
//  FoodProfileViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-11.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//
#define FOOD_DESCRIPTION_HEIGHT_ADUSTMENT 105.0f

#import "FoodProfileViewController.h"
#import "MealPlanSelection.h"
#import "ProfileViewController.h"
#import "ExerciseViewController.h"
#import "CalenderViewController.h"
#import "TFNGateway.h"
#import "MealGroceryList.h"

@interface FoodProfileViewController ()

// Move to MealViewController
- (void)moveToMealViewController:(id)sender;
// Move to CalenderViewController
- (void)moveToCalenderViewController:(id)sender;
// Move to ExerciseViewController
- (void)moveToExerciseViewController:(id)sender;
// Move to MusicTracksViewController
- (void)moveToMusicTracksViewController:(id)sender;
- (void)moveToSupplementsAtWebsite:(id)sender;
// Move to SupplementPlanViewController
- (void)moveToSupplementPlanViewController:(id)sender;
// Load up nutrition facts image
- (void)nutritionFactsImageLoadUp;
// Update display recipes
- (void)updateDisplayRecipes:(NSNotification *) notification;
// Display recipes
- (void)getRecipes;
// Capatalized first letter of each food name's words
- (NSString *)capatalizeFirstLetterOfWordsOfFoodName:(NSString *)initialFoodName;
// Nutrition Benefits descriptions displayed on textview
- (void)addNutritionBenefitsDescriptions;
//  Use previous view's selected image name to food image and choosing the right food nutrition benefits description
- (void) imageNameUsedToLoadNutritionBenefits;
// Add to grocery list
- (IBAction)addToGroceryList:(id)sender;
// Show Nutrition Benefits
- (void)showNutritionBenefits;
// Show Nutrition Facts
- (void)showNutritionFacts;
// Show Recipes
- (void)showRecipes;
// Show the nutrtions details
-(IBAction)showNutritions:(id)sender;
// Adjust the height of the views for iphone5 size
- (void)setUpViews;

@end

@implementation FoodProfileViewController

// ProfileViewController class object
ProfileViewController *m_profileViewController;
// ExerciseViewController class object
ExerciseViewController *m_exerciseViewController;
// CalenderViewController class object
CalenderViewController *m_calenderViewController;
// MealViewController class object
MealViewController *m_mealViewController;
// MusicTracksViewController class object
MusicTracksViewController *m_musicTracksViewController;
// SupplementPlanViewController class object
SupplementPlanViewController *m_supplementPlanViewController;
// MealPlanSelectin class object
MealPlanSelection *m_mealPlanSelection;
// ViewFactory class object
ViewFactory *m_controllerViews;
// ViewTransition class object
ViewTransitions *m_transition;
// Database class object
Database *m_database;
// ServerGateway class object
TFNGateway *m_serverConnection;
// MealGroceryList class object
MealGroceryList *m_mealGroceryList;
// NutritionSelection array
NSMutableArray *m_nutritionBenefitsArray;
// Food name derived from image name, for getting food description and
// adding to the grocery list
NSString *nutritionBenefitsPlist;
// The food profile image
NSString *m_imageNameString                     = @"";
// To avoid redisplaying an active section, initial value is nutritionBenefits
// as our default nutrtionbenefits view default, so we don't need to click on
// nutritionBenefits button
NSString *m_checkWhichFoodButtonWasClicked      = @"nutritionBenefits";
// If recipe direction text moved
BOOL m_recipeDirectionTextViewMoved;

UIImageView *foodImageView;
UIButton *addToGroceryButton;
UILabel *foodNameLabel;
UILabel *addToGroceryListInfo;
UIImageView *foodDescriptionImageView;
UIButton *nutritionBenefitsButton;
UIButton *nutritionFactsButton;
UIButton *nutritionRecipesButton;
UITextView *contentsTextView;
UIImageView *nutritionFactsImageView;
UIScrollView *nutritionFactsScrollView;
UILabel *recipeTitleLabel;
UITextView *recipeIngredientsTextView;
UIImageView *recipeImageView;
UILabel *recipeDirectionsLabel;
UITextView *recipeDirectionsTextView;

@synthesize recipesArray;
@synthesize bottomBarButton;
@synthesize musicPlayerButton;
@synthesize exercisePlanButton;
@synthesize calendarButton;
@synthesize mealPlanButton;
@synthesize nutritionPlanButton;
@synthesize messageButton;
@synthesize activityIndicator;

/*
 Singleton FoodProfileViewController object
 */
+ (FoodProfileViewController *)sharedInstance {
	static FoodProfileViewController *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

- (void) adjustTheRecipeDirectionsTextViewPosition
{
    CGRect frame = recipeDirectionsTextView.frame;
    
    if (m_recipeDirectionTextViewMoved) {
        m_recipeDirectionTextViewMoved      = NO;
        frame.origin.y += FOOD_DESCRIPTION_HEIGHT_ADUSTMENT; // new y coordinate
    }
    recipeDirectionsTextView.frame     = frame;
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
    [self adjustTheRecipeDirectionsTextViewPosition];

    if (!m_exerciseViewController) {
        m_exerciseViewController        = [ExerciseViewController sharedInstance];
    }
    id instanceObject                   = m_exerciseViewController;
    [self moveToView:m_exerciseViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
}


/*
 Move to MealViewController
 */
- (void)moveToMealViewController:(id)sender
{
    [self adjustTheRecipeDirectionsTextViewPosition];

    if (!m_mealViewController) {
        m_mealViewController        = [MealViewController sharedInstance];
    }
    id instanceObject               = m_mealViewController;
    [self moveToView:m_mealViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to CalenderViewController
 */
- (void)moveToCalenderViewController:(id)sender
{
    [self adjustTheRecipeDirectionsTextViewPosition];

    if (!m_calenderViewController) {
        m_calenderViewController    = [CalenderViewController sharedInstance];
    }
   id instanceObject               = m_calenderViewController;
    [self moveToView:m_calenderViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to MusicTracksViewController
 */
- (void)moveToMusicTracksViewController:(id)sender
{
    [self adjustTheRecipeDirectionsTextViewPosition];

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
 Move to supplements at website
 */
- (void)moveToSupplementsAtWebsite:(id)sender
{
    NSURL *url                  = [[NSURL alloc] initWithString:@"http://totalfitness.com/supplements"];
    [[UIApplication sharedApplication] openURL:url];
}

/*
 Load up nutrition facts image
 */
- (void)nutritionFactsImageLoadUp
{
    // Present image for the food imageView
    NSString *imageNameString           = [m_imageNameString stringByReplacingOccurrencesOfString:@".png" withString:@""];
    // Add the string to get nutrition facts image
    imageNameString                     = [NSString stringWithFormat:@"%@_nutrition_facts.png", imageNameString];
    UIImage *imageName                  = [UIImage imageNamed:imageNameString];
    [nutritionFactsImageView setImage:imageName];
}

/*
 Check if the food already in the grocery list to update the button
 */
- (void)checkIfFoodAlreadyInTheGroceryList
{
    BOOL  isInTheListOrNot;
    if (!m_database) {
        m_database                  = [Database alloc];
    }
    if (!m_mealGroceryList) {
        m_mealGroceryList           = [MealGroceryList sharedInstance];
    }
    isInTheListOrNot                = [m_mealGroceryList checkIfMealAlreadyExistInGroceryList:nutritionBenefitsPlist];
    if (isInTheListOrNot == YES) { // is there in the grocery list
        [addToGroceryButton setBackgroundImage:[UIImage imageNamed:@"tfn_addGL_checked.png"] forState:UIControlStateNormal];
        addToGroceryButton.userInteractionEnabled          = NO;
        addToGroceryListInfo.text                          = @"Added to grocery list";
    }
    else {
        [addToGroceryButton setBackgroundImage:[UIImage imageNamed:@"tfn_addGL_ready.png"] forState:UIControlStateNormal];
        addToGroceryButton.userInteractionEnabled         = YES;
        addToGroceryListInfo.text                         = @"Add to grocery list";
    }
}

/*
 Add to grocery list
 */
- (IBAction)addToGroceryList:(id)sender
{
    NSString *groceryUpdate         = @"";
    if (!m_database) {
        m_database                  = [Database alloc];
    }
    if (([nutritionBenefitsPlist length] != 0) && (nutritionBenefitsPlist != NULL)) {
        if (!m_mealGroceryList) {
            m_mealGroceryList           = [MealGroceryList sharedInstance];
        }
        groceryUpdate               = [m_mealGroceryList addToGroceryList:nutritionBenefitsPlist];
//        groceryUpdate               = [m_database insertIntoGroceryEmail_Id:[NSString getUserEmail] Date:date food:nutritionBenefitsPlist];
    }
    if ([groceryUpdate isEqualToString:@"updated"]) { // if successed in grocery list update, update to check image
        [addToGroceryButton setBackgroundImage:[UIImage imageNamed:@"tfn_addGL_checked.png"] forState:UIControlStateNormal];
        addToGroceryButton.userInteractionEnabled      = NO;
        addToGroceryListInfo.text                      = @"Added to grocery list";
    }
}

/*
 Show Nutrition Benefits
 */
- (void)showNutritionBenefits
{
    if (!m_transition) {
        m_transition        = [ViewTransitions sharedInstance];
    }
    [foodDescriptionImageView setImage:[UIImage imageNamed:@"tfn_NutritionalBenefits_active.png"]];
    // Hide the textview
    [m_transition performTransitionAppear:contentsTextView];
    contentsTextView.hidden               = NO;
    
    // Hide nutrition facts details
    nutritionFactsScrollView.hidden       = YES;
    
    // Hide recipes the details
    recipeTitleLabel.hidden               = YES;
    recipeImageView.hidden                = YES;
    recipeIngredientsTextView.hidden      = YES;
    recipeDirectionsLabel.hidden          = YES;
    recipeDirectionsTextView.hidden       = YES;
}

/*
 Show Nutrition Facts
 */
- (void)showNutritionFacts
{
    // load up the nutrition facts image
    [self nutritionFactsImageLoadUp];
    
    if (!m_transition) {
        m_transition        = [ViewTransitions sharedInstance];
    }
    if (recipeDirectionsLabel.hidden == NO) { // hide food recipes details
        [m_transition performTransitionDisappear:recipeTitleLabel];
        [m_transition performTransitionDisappear:recipeImageView];
        [m_transition performTransitionDisappear:recipeIngredientsTextView];
        [m_transition performTransitionDisappear:recipeDirectionsLabel];
        [m_transition performTransitionDisappear:recipeDirectionsTextView];
        
        // Hide recipes the details
        recipeTitleLabel.hidden               = YES;
        recipeImageView.hidden                = YES;
        recipeIngredientsTextView.hidden      = YES;
        recipeDirectionsLabel.hidden          = YES;
        recipeDirectionsTextView.hidden       = YES;
    }
    
    [foodDescriptionImageView setImage:[UIImage imageNamed:@"tfn_NutritionalFacts_active.png"]];
    
    // Hide the textview
    contentsTextView.hidden             = YES;
    
    [m_transition performTransitionAppear:nutritionFactsScrollView];
    nutritionFactsScrollView.hidden     = NO;
    nutritionFactsImageView.hidden      = NO;
}

/*
 Show Recipes
 */
- (void)showRecipes
{    
    // change the button
    [foodDescriptionImageView setImage:[UIImage imageNamed:@"tfn_recipes_active.png"]];
    
    if (!m_transition) {
        m_transition                = [ViewTransitions sharedInstance];
    }
    
    [m_transition performTransitionDisappear:nutritionFactsScrollView];
    [m_transition performTransitionDisappear:nutritionFactsImageView];
    [m_transition performTransitionDisappear:contentsTextView];
    
    // Hide nutrition facts details
    nutritionFactsScrollView.hidden        = YES;
    nutritionFactsImageView.hidden         = YES;
    // Hide the textview
    contentsTextView.hidden                = YES;
    
    [self getRecipes];
}

/*
 Show the nutrtions details
 */
-(IBAction)showNutritions:(id)sender
{


    if ((sender == nutritionBenefitsButton)  && (([m_checkWhichFoodButtonWasClicked isEqualToString:@"nutritionRecipes"]) || ([m_checkWhichFoodButtonWasClicked isEqualToString:@"nutritionFacts"]))) {
        m_checkWhichFoodButtonWasClicked    = @"nutritionBenefits";
        [self showNutritionBenefits];

    }
    else if((sender == nutritionFactsButton) && (([m_checkWhichFoodButtonWasClicked isEqualToString:@"nutritionBenefits"]) || ([m_checkWhichFoodButtonWasClicked isEqualToString:@"nutritionRecipes"]))) {
        m_checkWhichFoodButtonWasClicked    = @"nutritionFacts";
        [self showNutritionFacts];

    }
    else if((sender == nutritionRecipesButton) && (([m_checkWhichFoodButtonWasClicked isEqualToString:@"nutritionBenefits"]) || ([m_checkWhichFoodButtonWasClicked isEqualToString:@"nutritionFacts"]))) {
        m_checkWhichFoodButtonWasClicked    = @"nutritionRecipes";
        [self showRecipes];

    }
}

/*
 Update display recipes
 */
- (void)updateDisplayRecipes:(NSNotification *) notification
{
    if ([notification.name isEqualToString:@"Food Recipes Notification"]) {
        if (!m_database) {
            m_database          = [Database alloc];
        }
        if (([m_database getFoodRecipes] != NULL) && ([[m_database getFoodRecipes] count] > 0)) {
            // Retreive food recipes store in core data
            self.recipesArray       = [m_database getFoodRecipes];
            if (self.recipesArray) {
                // Delete food recipes from core data as soon as it is recieved in recipesArray
                [m_database deleteFoodRecipes];
            }
        }
                
        if ([self.recipesArray count] > 0) { // make sure the array received is not empty
            recipeTitleLabel.text              = [[self recipesArray] objectAtIndex:0];
    
            // weak self created to avoid strong hold to self by queue
            __weak FoodProfileViewController *weakSelf  = self;
            dispatch_queue_t downloadQueue              = dispatch_queue_create("com.koolappsfactory.downloadQueue", NULL);
            dispatch_async(downloadQueue, ^{ // Get nsdata from web server in download queue so that we don't block the main thread
                NSData *imageData                               =  [NSData dataWithContentsOfURL:
                                                            [NSURL URLWithString: [[weakSelf recipesArray] objectAtIndex:1]]];
                dispatch_async(dispatch_get_main_queue(), ^{ // When data is retrieved push it to the main thread
                    UIImage *recipeImage                        = [UIImage imageWithData:imageData];
                    recipeImageView.image              = recipeImage;
                    recipeIngredientsTextView.text     = [[weakSelf recipesArray] objectAtIndex:2];
                    recipeDirectionsTextView.text      = [[weakSelf recipesArray] objectAtIndex:3];

                });
            });
        }
        [self.activityIndicator stopAnimating];
    }
}

/*
 Display recipes
 */
- (void)getRecipes
{
    // Cleanup the previous data
    recipeTitleLabel.text                  = @"";
    recipeImageView.image                  = nil;
    recipeIngredientsTextView.text         = @"";
    recipeDirectionsTextView.text          = @"";

    // start the activity indicator
    [self.activityIndicator startAnimating];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateDisplayRecipes:)
                                                 name:@"Food Recipes Notification" object:nil];

    // initialize the recipesArray first
    self.recipesArray                          = [NSMutableArray mutableArrayObject];
    
    if (!m_transition) {
        m_transition        = [ViewTransitions sharedInstance];
    }

    [m_transition performTransitionAppear:recipeTitleLabel];
    [m_transition performTransitionAppear:recipeImageView];
    [m_transition performTransitionAppear:recipeIngredientsTextView];
    [m_transition performTransitionAppear:recipeDirectionsLabel];
    [m_transition performTransitionAppear:recipeDirectionsTextView];
    
    // Show the details
    recipeTitleLabel.hidden               = NO;
    recipeImageView.hidden                = NO;
    recipeIngredientsTextView.hidden      = NO;
    recipeDirectionsLabel.hidden          = NO;
    recipeDirectionsTextView.hidden       = NO;
    
    if (!m_serverConnection) {
        m_serverConnection          = [TFNGateway sharedInstance];
    }
    if ([nutritionBenefitsPlist isEqualToString:@"dressing made with olive oil"]) {
        nutritionBenefitsPlist            = @"olive oil";
    }

    [m_serverConnection getFoodRecipesFromWebServer:[nutritionBenefitsPlist stringByReplacingOccurrencesOfString:@" " withString:@"_"]];
}

/*
 Remove space before the first word
 */
- (NSString *)removeWhiteSpaceBeforeFirstWord:(NSString *)nutritionBenefitsText
{
    // trim the whitespace before the first character
    NSCharacterSet *whitespace      = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    nutritionBenefitsText           = [nutritionBenefitsText stringByTrimmingCharactersInSet:whitespace];
    return nutritionBenefitsText;
}

/*
 Nutrition Benefits descriptions displayed on textview
 */
- (void)addNutritionBenefitsDescriptions
{
    NSMutableDictionary *nutritionBenefitsDictionary;
    NSInteger numberOfItemsInArray                            = [m_nutritionBenefitsArray count];
    NSString *nutritionBenefitsText                     = @"";
    
    if(numberOfItemsInArray != 0) {
        for (int i = 0; i < numberOfItemsInArray; i++) {
            nutritionBenefitsDictionary         = [m_nutritionBenefitsArray  objectAtIndex:i];
            NSArray *keys                       = [nutritionBenefitsDictionary allKeys];
            if (((![[keys objectAtIndex:0] isEqualToString:@"Introduction"]) || ([[keys objectAtIndex:0] length] != 0)) && ([keys objectAtIndex:0] != NULL)) {
                nutritionBenefitsText           = [NSString stringWithFormat:@"%@ \n %@", nutritionBenefitsText,[keys objectAtIndex:0]];
            }
            nutritionBenefitsText                           = [NSString stringWithFormat:@"      %@ \n      %@ \n", nutritionBenefitsText,[nutritionBenefitsDictionary objectForKey:[keys objectAtIndex:0]]];
        }
    }
    nutritionBenefitsText                        = [self removeWhiteSpaceBeforeFirstWord:nutritionBenefitsText];
    if ([nutritionBenefitsText length] != 0) {
        contentsTextView.text                          = nutritionBenefitsText;
        // scroll to the top
        [contentsTextView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    // Stop the activity indicator when text are loaded
    [self.activityIndicator stopAnimating];
}

/*
 Capatalized first letter of each food name's words
 */
- (NSString *)capatalizeFirstLetterOfWordsOfFoodName:(NSString *)initialFoodName
{
    NSString *firstCharCapatalized      = @"";
    NSArray *foodNameArray              = [initialFoodName componentsSeparatedByString:@" "];
    NSString *subFoodName               = @"";
    // Make sure each word in the exercise have first letter capatalized
    for (NSString *subString in foodNameArray) {
        firstCharCapatalized            = [[subString substringToIndex:1] capitalizedString];

        subFoodName                     = [NSString stringWithFormat:@"%@ %@",subFoodName, [subString stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:firstCharCapatalized]];
    }
    return subFoodName;
}

/*
 Use previous view's selected image name to food image and choosing the right food nutrition benefits description
 */
- (void)imageNameUsedToLoadNutritionBenefits
{
    if (!m_nutritionBenefitsArray) {
        m_nutritionBenefitsArray            = [NSMutableArray mutableArrayObject];
    }
    if (!m_mealPlanSelection) {
        m_mealPlanSelection                 = [MealPlanSelection  sharedInstance];
    }
    if (!m_calenderViewController) {
        m_calenderViewController            = [CalenderViewController sharedInstance];
    }
    if (!m_mealViewController) {
        m_mealViewController                = [MealViewController alloc];
    }

    // Present image for the food imageView
    if ([m_calenderViewController.selectedImage length] != 0) { // If coming from CalenderViewController's view
        m_imageNameString                           = [NSString stringWithFormat:@"%@.png", m_calenderViewController.selectedImage];
        // Clean the selectedImage from the calenderviewcontroller to not confuse when coming from mealview controller
        m_calenderViewController.selectedImage      = nil;
    }
    else if([m_mealViewController.selectedImage length] != 0){ // If coming from MealViewController's view
        m_imageNameString                           = [NSString stringWithFormat:@"%@.png", m_mealViewController.selectedImage];
        m_mealViewController.selectedImage          = nil;
    }
    
    // Display this image
    UIImage *imageName                  = [UIImage imageNamed:m_imageNameString];
    [foodImageView setImage:imageName];

    // We need to remove underscore from the image name
    NSString *underscore                = @"_";
    // Remove underscore from the image name
    nutritionBenefitsPlist              = [m_imageNameString stringByReplacingOccurrencesOfString:underscore withString:@" "];
    // Then remove the .png image extensions, we get the name of the food
    nutritionBenefitsPlist              = [nutritionBenefitsPlist stringByReplacingOccurrencesOfString:@".png" withString:@""];
    
   
    // Display name of the food
    foodNameLabel.text             = [self capatalizeFirstLetterOfWordsOfFoodName:nutritionBenefitsPlist];
    
    // Load array from the plist having same image name
    m_nutritionBenefitsArray            = [m_mealPlanSelection loadUpPlist:[nutritionBenefitsPlist lowercaseString]];
    [self addNutritionBenefitsDescriptions];
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
}

/*
 Adjust the height of the views for iphone5 size
 */
- (void)setUpViews
{
    // Adjust the height of the view
    self.view.backgroundColor                               = [UIColor whiteColor];
    
    // Food Image View 
    CGRect foodImageViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        foodImageViewFrame                               = CGRectMake(0.0f, 70.0f, 200.0f, 160.0f);
    }
    else {
        foodImageViewFrame                               = CGRectMake(0.0f, 80.0f, 150.0f, 100.0f);
    }
    foodImageView                                      = [[UIImageView alloc] initWithFrame:foodImageViewFrame];
    [self.view addSubview:foodImageView];
    
    // Food Name Label
    CGRect foodNameLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        foodNameLabelFrame                               = CGRectMake(200.0f, 110.0f, 120.0f, 60.0f);
    }
    else {
        foodNameLabelFrame                               = CGRectMake(200.0f, 90.0f, 120.0f, 60.0f);
    }
    foodNameLabel                                      = [[UILabel alloc] initWithFrame:foodNameLabelFrame];
    foodNameLabel.font                                 = [UIFont customFontWithSize:15];
    foodNameLabel.lineBreakMode                        = NSLineBreakByWordWrapping;
    foodNameLabel.textAlignment                        = NSTextAlignmentLeft;
    foodNameLabel.numberOfLines                        = 2;
    [self.view addSubview:foodNameLabel];
    
    CGRect addToGroceryListInfoFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        addToGroceryListInfoFrame                        = CGRectMake(150.0f, 230.0f, 140.0f, 25.0f);
    }
    else {
        addToGroceryListInfoFrame                        = CGRectMake(150.0f, 180.0f, 140.0f, 25.0f);
    }
    addToGroceryButton                                 = [[UIButton alloc] initWithFrame:addToGroceryListInfoFrame];
    [addToGroceryButton setBackgroundImage:[UIImage imageNamed:@"tfn_addGL-ready.png"] forState:UIControlStateNormal];
    [self.view addSubview:addToGroceryButton];
    [addToGroceryButton addTarget:self action:@selector(addToGroceryList:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect foodDescriptionImageViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
         foodDescriptionImageViewFrame               = CGRectMake(0.0f, 260.0f, 320.0f, 75.0f);
    }
    else {
         foodDescriptionImageViewFrame               = CGRectMake(0.0f, 210.0f, 320.0f, 75.0f);
    }
    foodDescriptionImageView                           = [[UIImageView alloc] initWithFrame:foodDescriptionImageViewFrame];
    [self.view addSubview:foodDescriptionImageView];
    foodDescriptionImageView.image                     = [UIImage imageNamed:@"tfn_NutritionalBenefits_active.png"];
    
    // Sections buttons positions should be adjusted
    CGRect nutritionBenefitsButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        nutritionBenefitsButtonFrame                     = CGRectMake(0.0f, 263.0f, 105.0f, 75.0f);
    }
    else {
        nutritionBenefitsButtonFrame                     = CGRectMake(0.0f, 213.0f, 105.0f, 75.0f);
    }
    nutritionBenefitsButton                            = [[UIButton alloc] initWithFrame:nutritionBenefitsButtonFrame];
    [self.view addSubview:nutritionBenefitsButton];
    [nutritionBenefitsButton addTarget:self action:@selector(showNutritions:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect nutritionFactsButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        nutritionFactsButtonFrame                        = CGRectMake(106.0f, 263.0f, 106.0f, 75.0f);
    }
    else{
        nutritionFactsButtonFrame                        = CGRectMake(106.0f, 213.0f, 106.0f, 75.0f);
    }
    nutritionFactsButton                               = [[UIButton alloc] initWithFrame:nutritionFactsButtonFrame];
    [self.view addSubview:nutritionFactsButton];
    [nutritionFactsButton addTarget:self action:@selector(showNutritions:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect nutritionRecipesButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        nutritionRecipesButtonFrame                      = CGRectMake(213.0f, 263.0f, 106.0f, 75.0f);
    }
    else {
        nutritionRecipesButtonFrame                      = CGRectMake(213.0f, 213.0f, 106.0f, 75.0f);
    }
    nutritionRecipesButton                             = [[UIButton alloc] initWithFrame:nutritionRecipesButtonFrame];
    [self.view addSubview:nutritionRecipesButton];
    [nutritionRecipesButton addTarget:self action:@selector(showNutritions:) forControlEvents:UIControlEventTouchUpInside];

    // Nutrtion Facts ScrollView height adjusted
    CGRect nutritionFactsScrollViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        nutritionFactsScrollViewFrame                    = CGRectMake(0.0f, 338.0f, 320.0f, 230.0f);
    }
    else {
        nutritionFactsScrollViewFrame                    = CGRectMake(0.0f, 290.0f, 320.0f, 200.0f);
    }
    nutritionFactsScrollView                           = [[UIScrollView alloc] initWithFrame:nutritionFactsScrollViewFrame];
    nutritionFactsScrollView.backgroundColor           = [UIColor whiteColor];
    nutritionFactsScrollView.scrollEnabled             = YES;
    nutritionFactsScrollView.userInteractionEnabled    = YES;
    [self.view addSubview:nutritionFactsScrollView];
    nutritionFactsScrollView.hidden                    = YES;

    // Add nutrition facts imageview to the scroll view
    CGRect nutritionFactsImageViewFrame                     = CGRectMake(20.0f, 0.0f, 280.0f, 400.0f);
    nutritionFactsImageView                            = [[UIImageView alloc] initWithFrame:nutritionFactsImageViewFrame];
    [nutritionFactsScrollView addSubview:nutritionFactsImageView];

    // Setup scroll view
    [nutritionFactsScrollView
     setContentSize:CGSizeMake(nutritionFactsImageView.frame.size.width,
                               nutritionFactsImageView.frame.size.height + 100.0f)];
    
    // Content Text View height adjusted

    CGRect contentsTextViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        contentsTextViewFrame                            = CGRectMake(0.0f, 330.0f, 320.0f, 185.0f);
    }
    else {
        contentsTextViewFrame                            = CGRectMake(0.0f, 280.0f, 320.0f, 140.0f);
    }
    contentsTextView                                   = [[UITextView alloc] initWithFrame:contentsTextViewFrame];
    contentsTextView.backgroundColor                   = [UIColor whiteColor];
    contentsTextView.textColor                         = [UIColor darkGrayColor];
    contentsTextView.scrollEnabled                     = YES;
    contentsTextView.editable                          = NO;
    [contentsTextView setFont:[UIFont customFontWithSize:14]];
    [self.view addSubview:contentsTextView];

    // Recipe Title Label
    CGRect recipeTitleLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        recipeTitleLabelFrame                            = CGRectMake(0.0f, 338.0f, 320.0f, 15.0f);
    }
    else {
        recipeTitleLabelFrame                            = CGRectMake(0.0f, 288.0f, 320.0f, 15.0f);
    }
    recipeTitleLabel                                   = [[UILabel alloc] initWithFrame:recipeTitleLabelFrame];
    recipeTitleLabel.backgroundColor                   = [UIColor whiteColor];
    recipeTitleLabel.textColor                         = [UIColor darkGrayColor];
    [recipeTitleLabel setFont:[UIFont customFontWithSize:11]];
    [self.view addSubview:recipeTitleLabel];
    recipeTitleLabel.hidden                            = YES;
    recipeTitleLabel.textAlignment                     = NSTextAlignmentCenter;

    // Recipe Ingredients Text View height adjusted
    CGRect recipeIngredientsTextViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        recipeIngredientsTextViewFrame                   = CGRectMake(150.0f, 355.0f, 168.0f, 90.0f);
    }
    else {
        recipeIngredientsTextViewFrame                   = CGRectMake(150.0f, 305.0f, 168.0f, 80.0f);
    }
    recipeIngredientsTextView                          = [[UITextView alloc] initWithFrame:recipeIngredientsTextViewFrame];
    recipeIngredientsTextView.backgroundColor          = [UIColor whiteColor];
    recipeIngredientsTextView.textColor                = [UIColor darkGrayColor];
    recipeIngredientsTextView.scrollEnabled            = YES;
    recipeIngredientsTextView.editable                 = NO;
    recipeIngredientsTextView.userInteractionEnabled   = YES;
    [recipeIngredientsTextView setFont:[UIFont customFontWithSize:11]];
    [self.view addSubview:recipeIngredientsTextView];
    recipeIngredientsTextView.hidden                   = YES;
    
    // Recipe Image view position adjusted
    CGRect recipeImageViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        recipeImageViewFrame                           = CGRectMake(12.0f, 355.0f, 135.0f, 80.0f);
    }
    else {
        recipeImageViewFrame                           = CGRectMake(12.0f, 305.0f, 135.0f, 80.0f);
    }
    recipeImageView                                    = [[UIImageView alloc] initWithFrame:recipeImageViewFrame];
    [self.view addSubview:recipeImageView];
    
    // Recipe Directions Label
    CGRect recipeDirectionsLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        recipeDirectionsLabelFrame                     = CGRectMake(12.0f, 435.0f, 132.0f, 10.0f);
    }
    else {
        recipeDirectionsLabelFrame                     = CGRectMake(12.0f, 385.0f, 132.0f, 8.0f);
    }
    recipeDirectionsLabel                              = [[UILabel alloc] initWithFrame:recipeDirectionsLabelFrame];
    recipeDirectionsLabel.text                         = @"Directions:";
    recipeDirectionsLabel.backgroundColor              = [UIColor whiteColor];
    recipeDirectionsLabel.textColor                    = [UIColor darkGrayColor];
    [recipeDirectionsLabel setFont:[UIFont customFontWithSize:11]];
    [self.view addSubview:recipeDirectionsLabel];
    recipeDirectionsLabel.hidden                       = YES;

    // Recipe Directions Text View height adjusted
    CGRect recipeDirectionsTextViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        recipeDirectionsTextViewFrame                  = CGRectMake(12.0f, 445.0f, 300.0f, 180.0f);
    }
    else {
        recipeDirectionsTextViewFrame                  = CGRectMake(12.0f, 395.0f, 300.0f, 130.0f);
    }
    recipeDirectionsTextView                           = [[UITextView alloc] initWithFrame:recipeDirectionsTextViewFrame];
    recipeDirectionsTextView.backgroundColor           = [UIColor whiteColor];
    recipeDirectionsTextView.textColor                 = [UIColor darkGrayColor];
    recipeDirectionsTextView.scrollEnabled             = YES;
    recipeDirectionsTextView.editable                  = NO;
    recipeDirectionsTextView.userInteractionEnabled    = YES;
    [recipeDirectionsTextView setFont:[UIFont customFontWithSize:11]];
    [self.view addSubview:recipeDirectionsTextView];
    recipeDirectionsTextView.hidden                    = YES;

    self.activityIndicator                             = [self reAddActivityIndicatorforiPhone5:self.activityIndicator];
    [self.view addSubview:self.activityIndicator];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // initialize this
        nutritionBenefitsPlist      = [[NSString alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.messageButton removeFromSuperview];
    self.messageButton.titleLabel.font          = [UIFont customFontWithSize:13];
    self.messageButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messageButton.titleLabel.numberOfLines = 2;
    self.messageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.messageButton];
    
    // Adjust views height for iphone5
    [self setUpViews];

    // Add tap gesture
    UITapGestureRecognizer *recipeDirectionTap      = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapRecognized:)];
    recipeDirectionTap.numberOfTapsRequired         = 1;
    [recipeDirectionsTextView addGestureRecognizer:recipeDirectionTap];

    // start the activity indicator
    [self.activityIndicator startAnimating];
    
    // Set up the bottom bar buttom
    [self addSelectorToControlButtons];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    // Set up food image and show nutrition benefits description
    // place the below method here to update contents when coming back from a different view
    [self imageNameUsedToLoadNutritionBenefits];
    
    // Check if the food is already in the grocery list
    // place the below method here to update button image when coming back from a different view
    [self checkIfFoodAlreadyInTheGroceryList];

    // Default view should be nutrition benefits
    m_checkWhichFoodButtonWasClicked    = @"nutritionFacts";
    [self showNutritionFacts];
    
    // Default is NO
    m_recipeDirectionTextViewMoved                                    = NO;

    // Refresh the view
    [self.view setNeedsDisplay];

   /* // place the below method here to update nutrition benefits text when coming back from a different view
    if (!self.contentsTextView.hidden) {
        [self addNutritionBenefitsDescriptions];        
    }

    // load up the nutrition facts image
    // place the below method here to update button image when coming back from a different view
    if ((self.contentsTextView.hidden) && (!self.nutritionFactsScrollView.hidden)) {
        [self nutritionFactsImageLoadUp];
    }
    
    if ((self.contentsTextView.hidden) && (self.nutritionFactsScrollView.hidden)) { // If the returning view has the food recipes section opened
        [self getRecipes];
    }*/
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (m_recipeDirectionTextViewMoved) {
        [self adjustTheRecipeDirectionsTextViewPosition];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
 Single Tap gesture
 */
- (void)singleTapRecognized:(UIGestureRecognizer *)gestureRecognizer {
    CGRect frame = recipeDirectionsTextView.frame;
    
    if (m_recipeDirectionTextViewMoved) {
        m_recipeDirectionTextViewMoved    = NO;
        frame.origin.y += FOOD_DESCRIPTION_HEIGHT_ADUSTMENT; // new y coordinate
    }
    else {
        m_recipeDirectionTextViewMoved    = YES;
        frame.origin.y -= FOOD_DESCRIPTION_HEIGHT_ADUSTMENT;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration: 0.25];
    recipeDirectionsTextView.frame = frame;
    [UIView commitAnimations];
}

@end
