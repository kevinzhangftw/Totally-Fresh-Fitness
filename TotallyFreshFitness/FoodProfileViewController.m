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

@property (strong, nonatomic) Database *m_database;
@property (strong, nonatomic) ProfileViewController *m_profileViewController;
@property (strong, nonatomic) ExerciseViewController *m_exerciseViewController;
@property (strong, nonatomic) CalenderViewController *m_calenderViewController;
@property (strong, nonatomic) MealViewController *m_mealViewController;
@property (strong, nonatomic) MusicTracksViewController *m_musicTracksViewController;
@property (strong, nonatomic) SupplementPlanViewController *m_supplementPlanViewController;
@property (strong, nonatomic) MealPlanSelection *m_mealPlanSelection;
@property (strong, nonatomic) ViewFactory *m_controllerViews;
@property (strong, nonatomic) ViewTransitions *m_transition;
@property (strong, nonatomic) TFNGateway *m_serverConnection;
@property (strong, nonatomic) MealGroceryList *m_mealGroceryList;
@property (strong, nonatomic) NSMutableArray *m_nutritionBenefitsArray;
@property (strong, nonatomic) NSString *nutritionBenefitsPlist;
@property (strong, nonatomic) NSString *m_imageNameString; //= @"";
@property (strong, nonatomic) NSString *m_checkWhichFoodButtonWasClicked; // = @"nutritionBenefits";
@property (nonatomic) BOOL m_recipeDirectionTextViewMoved;
@property (strong, nonatomic) UIImageView *foodImageView;
@property (strong, nonatomic) UIButton *addToGroceryButton;
@property (strong, nonatomic) UILabel *foodNameLabel;
@property (strong, nonatomic) UILabel *addToGroceryListInfo;
@property (strong, nonatomic) UIImageView *foodDescriptionImageView;
@property (strong, nonatomic) UIButton *nutritionBenefitsButton;
@property (strong, nonatomic) UIButton *nutritionFactsButton;
@property (strong, nonatomic) UIButton *nutritionRecipesButton;
@property (strong, nonatomic) UITextView *contentsTextView;
@property (strong, nonatomic) UIImageView *nutritionFactsImageView;
@property (strong, nonatomic) UIScrollView *nutritionFactsScrollView;
@property (strong, nonatomic) UILabel *recipeTitleLabel;
@property (strong, nonatomic) UITextView *recipeIngredientsTextView;
@property (strong, nonatomic) UIImageView *recipeImageView;
@property (strong, nonatomic) UILabel *recipeDirectionsLabel;
@property (strong, nonatomic) UITextView *recipeDirectionsTextView;


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
    CGRect frame = self.recipeDirectionsTextView.frame;
    
    if (self.m_recipeDirectionTextViewMoved) {
        self.m_recipeDirectionTextViewMoved      = NO;
        frame.origin.y += FOOD_DESCRIPTION_HEIGHT_ADUSTMENT; // new y coordinate
    }
    self.recipeDirectionsTextView.frame     = frame;
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
    [self adjustTheRecipeDirectionsTextViewPosition];

    if (!self.m_exerciseViewController) {
        self.m_exerciseViewController        = [ExerciseViewController sharedInstance];
    }
    id instanceObject                   = self.m_exerciseViewController;
    [self moveToView:self.m_exerciseViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
}


/*
 Move to MealViewController
 */
- (void)moveToMealViewController:(id)sender
{
    [self adjustTheRecipeDirectionsTextViewPosition];

    if (!self.m_mealViewController) {
        self.m_mealViewController        = [MealViewController sharedInstance];
    }
    id instanceObject               = self.m_mealViewController;
    [self moveToView:self.m_mealViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to CalenderViewController
 */
- (void)moveToCalenderViewController:(id)sender
{
    [self adjustTheRecipeDirectionsTextViewPosition];

    if (!self.m_calenderViewController) {
        self.m_calenderViewController    = [CalenderViewController sharedInstance];
    }
   id instanceObject               = self.m_calenderViewController;
    [self moveToView:self.m_calenderViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to MusicTracksViewController
 */
- (void)moveToMusicTracksViewController:(id)sender
{
    [self adjustTheRecipeDirectionsTextViewPosition];

    if (!self.m_musicTracksViewController) {
        self.m_musicTracksViewController         = [MusicTracksViewController sharedInstance];
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
 Load up nutrition facts image
 */
- (void)nutritionFactsImageLoadUp
{
    // Present image for the food imageView
    NSString *imageNameString           = [self.m_imageNameString stringByReplacingOccurrencesOfString:@".png" withString:@""];
    // Add the string to get nutrition facts image
    imageNameString                     = [NSString stringWithFormat:@"%@_nutrition_facts.png", imageNameString];
    UIImage *imageName                  = [UIImage imageNamed:imageNameString];
    [self.nutritionFactsImageView setImage:imageName];
}

/*
 Check if the food already in the grocery list to update the button
 */
- (void)checkIfFoodAlreadyInTheGroceryList
{
    BOOL  isInTheListOrNot;
    if (!self.m_database) {
        self.m_database                  = [Database alloc];
    }
    if (!self.m_mealGroceryList) {
        self.m_mealGroceryList           = [MealGroceryList sharedInstance];
    }
    isInTheListOrNot                = [self.m_mealGroceryList checkIfMealAlreadyExistInGroceryList:self.nutritionBenefitsPlist];
    if (isInTheListOrNot == YES) { // is there in the grocery list
        [self.addToGroceryButton setBackgroundImage:[UIImage imageNamed:@"tfn_addGL_checked.png"] forState:UIControlStateNormal];
        self.addToGroceryButton.userInteractionEnabled          = NO;
        self.addToGroceryListInfo.text                          = @"Added to grocery list";
    }
    else {
        [self.addToGroceryButton setBackgroundImage:[UIImage imageNamed:@"tfn_addGL_ready.png"] forState:UIControlStateNormal];
        self.addToGroceryButton.userInteractionEnabled         = YES;
        self.addToGroceryListInfo.text                         = @"Add to grocery list";
    }
}

/*
 Add to grocery list
 */
- (IBAction)addToGroceryList:(id)sender
{
    NSString *groceryUpdate         = @"";
    if (!self.m_database) {
        self.m_database                  = [Database alloc];
    }
    if (([self.nutritionBenefitsPlist length] != 0) && (self.nutritionBenefitsPlist != NULL)) {
        if (!self.m_mealGroceryList) {
            self.m_mealGroceryList           = [MealGroceryList sharedInstance];
        }
        groceryUpdate               = [self.m_mealGroceryList addToGroceryList:self.nutritionBenefitsPlist];
//        groceryUpdate               = [m_database insertIntoGroceryEmail_Id:[NSString getUserEmail] Date:date food:nutritionBenefitsPlist];
    }
    if ([groceryUpdate isEqualToString:@"updated"]) { // if successed in grocery list update, update to check image
        [self.addToGroceryButton setBackgroundImage:[UIImage imageNamed:@"tfn_addGL_checked.png"] forState:UIControlStateNormal];
        self.addToGroceryButton.userInteractionEnabled      = NO;
        self.addToGroceryListInfo.text                      = @"Added to grocery list";
    }
}

/*
 Show Nutrition Benefits
 */
- (void)showNutritionBenefits
{
    if (!self.m_transition) {
        self.m_transition        = [ViewTransitions sharedInstance];
    }
    [self.foodDescriptionImageView setImage:[UIImage imageNamed:@"tfn_NutritionalBenefits_active.png"]];
    // Hide the textview
    [self.m_transition performTransitionAppear:self.contentsTextView];
    self.contentsTextView.hidden               = NO;
    
    // Hide nutrition facts details
    self.nutritionFactsScrollView.hidden       = YES;
    
    // Hide recipes the details
    self.recipeTitleLabel.hidden               = YES;
    self.recipeImageView.hidden                = YES;
    self.recipeIngredientsTextView.hidden      = YES;
    self.recipeDirectionsLabel.hidden          = YES;
    self.recipeDirectionsTextView.hidden       = YES;
}

/*
 Show Nutrition Facts
 */
- (void)showNutritionFacts
{
    // load up the nutrition facts image
    [self nutritionFactsImageLoadUp];
    
    if (!self.m_transition) {
        self.m_transition        = [ViewTransitions sharedInstance];
    }
    if (self.recipeDirectionsLabel.hidden == NO) { // hide food recipes details
        [self.m_transition performTransitionDisappear:self.recipeTitleLabel];
        [self.m_transition performTransitionDisappear:self.recipeImageView];
        [self.m_transition performTransitionDisappear:self.recipeIngredientsTextView];
        [self.m_transition performTransitionDisappear:self.recipeDirectionsLabel];
        [self.m_transition performTransitionDisappear:self.recipeDirectionsTextView];
        
        // Hide recipes the details
        self.recipeTitleLabel.hidden               = YES;
        self.recipeImageView.hidden                = YES;
        self.recipeIngredientsTextView.hidden      = YES;
        self.recipeDirectionsLabel.hidden          = YES;
        self.recipeDirectionsTextView.hidden       = YES;
    }
    
    [self.foodDescriptionImageView setImage:[UIImage imageNamed:@"tfn_NutritionalFacts_active.png"]];
    
    // Hide the textview
    self.contentsTextView.hidden             = YES;
    
    [self.m_transition performTransitionAppear:self.nutritionFactsScrollView];
    self.nutritionFactsScrollView.hidden     = NO;
    self.nutritionFactsImageView.hidden      = NO;
}

/*
 Show Recipes
 */
- (void)showRecipes
{    
    // change the button
    [self.foodDescriptionImageView setImage:[UIImage imageNamed:@"tfn_recipes_active.png"]];
    
    if (!self.m_transition) {
        self.m_transition                = [ViewTransitions sharedInstance];
    }
    
    [self.m_transition performTransitionDisappear:self.nutritionFactsScrollView];
    [self.m_transition performTransitionDisappear:self.nutritionFactsImageView];
    [self.m_transition performTransitionDisappear:self.contentsTextView];
    
    // Hide nutrition facts details
    self.nutritionFactsScrollView.hidden        = YES;
    self.nutritionFactsImageView.hidden         = YES;
    // Hide the textview
    self.contentsTextView.hidden                = YES;
    
    [self getRecipes];
}

/*
 Show the nutrtions details
 */
-(IBAction)showNutritions:(id)sender
{


    if ((sender == self.nutritionBenefitsButton)  && (([self.m_checkWhichFoodButtonWasClicked isEqualToString:@"nutritionRecipes"]) || ([self.m_checkWhichFoodButtonWasClicked isEqualToString:@"nutritionFacts"]))) {
        self.m_checkWhichFoodButtonWasClicked    = @"nutritionBenefits";
        [self showNutritionBenefits];

    }
    else if((sender == self.nutritionFactsButton) && (([self.m_checkWhichFoodButtonWasClicked isEqualToString:@"nutritionBenefits"]) || ([self.m_checkWhichFoodButtonWasClicked isEqualToString:@"nutritionRecipes"]))) {
        self.m_checkWhichFoodButtonWasClicked    = @"nutritionFacts";
        [self showNutritionFacts];

    }
    else if((sender == self.nutritionRecipesButton) && (([self.m_checkWhichFoodButtonWasClicked isEqualToString:@"nutritionBenefits"]) || ([self.m_checkWhichFoodButtonWasClicked isEqualToString:@"nutritionFacts"]))) {
        self.m_checkWhichFoodButtonWasClicked    = @"nutritionRecipes";
        [self showRecipes];

    }
}

/*
 Update display recipes
 */
- (void)updateDisplayRecipes:(NSNotification *) notification
{
    if ([notification.name isEqualToString:@"Food Recipes Notification"]) {
        if (!self.m_database) {
            self.m_database          = [Database alloc];
        }
        if (([self.m_database getFoodRecipes] != NULL) && ([[self.m_database getFoodRecipes] count] > 0)) {
            // Retreive food recipes store in core data
            self.recipesArray       = [self.m_database getFoodRecipes];
            if (self.recipesArray) {
                // Delete food recipes from core data as soon as it is recieved in recipesArray
                [self.m_database deleteFoodRecipes];
            }
        }
                
        if ([self.recipesArray count] > 0) { // make sure the array received is not empty
            self.recipeTitleLabel.text              = [[self recipesArray] objectAtIndex:0];
    
            // weak self created to avoid strong hold to self by queue
            __weak FoodProfileViewController *weakSelf  = self;
            dispatch_queue_t downloadQueue              = dispatch_queue_create("com.koolappsfactory.downloadQueue", NULL);
            dispatch_async(downloadQueue, ^{ // Get nsdata from web server in download queue so that we don't block the main thread
                NSData *imageData                               =  [NSData dataWithContentsOfURL:
                                                            [NSURL URLWithString: [[weakSelf recipesArray] objectAtIndex:1]]];
                dispatch_async(dispatch_get_main_queue(), ^{ // When data is retrieved push it to the main thread
                    UIImage *recipeImage                        = [UIImage imageWithData:imageData];
                    self.recipeImageView.image              = recipeImage;
                    self.recipeIngredientsTextView.text     = [[weakSelf recipesArray] objectAtIndex:2];
                    self.recipeDirectionsTextView.text      = [[weakSelf recipesArray] objectAtIndex:3];

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
    self.recipeTitleLabel.text                  = @"";
    self.recipeImageView.image                  = nil;
    self.recipeIngredientsTextView.text         = @"";
    self.recipeDirectionsTextView.text          = @"";

    // start the activity indicator
    [self.activityIndicator startAnimating];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateDisplayRecipes:)
                                                 name:@"Food Recipes Notification" object:nil];

    // initialize the recipesArray first
    self.recipesArray                          = [NSMutableArray mutableArrayObject];
    
    if (!self.m_transition) {
        self.m_transition        = [ViewTransitions sharedInstance];
    }

    [self.m_transition performTransitionAppear:self.recipeTitleLabel];
    [self.m_transition performTransitionAppear:self.recipeImageView];
    [self.m_transition performTransitionAppear:self.recipeIngredientsTextView];
    [self.m_transition performTransitionAppear:self.recipeDirectionsLabel];
    [self.m_transition performTransitionAppear:self.recipeDirectionsTextView];
    
    // Show the details
    self.recipeTitleLabel.hidden               = NO;
    self.recipeImageView.hidden                = NO;
    self.recipeIngredientsTextView.hidden      = NO;
    self.recipeDirectionsLabel.hidden          = NO;
    self.recipeDirectionsTextView.hidden       = NO;
    
    if (!self.m_serverConnection) {
        self.m_serverConnection          = [TFNGateway sharedInstance];
    }
    if ([self.nutritionBenefitsPlist isEqualToString:@"dressing made with olive oil"]) {
        self.nutritionBenefitsPlist            = @"olive oil";
    }

    [self.m_serverConnection getFoodRecipesFromWebServer:[self.nutritionBenefitsPlist stringByReplacingOccurrencesOfString:@" " withString:@"_"]];
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
    NSInteger numberOfItemsInArray                            = [self.m_nutritionBenefitsArray count];
    NSString *nutritionBenefitsText                     = @"";
    
    if(numberOfItemsInArray != 0) {
        for (int i = 0; i < numberOfItemsInArray; i++) {
            nutritionBenefitsDictionary         = [self.m_nutritionBenefitsArray  objectAtIndex:i];
            NSArray *keys                       = [nutritionBenefitsDictionary allKeys];
            if (((![[keys objectAtIndex:0] isEqualToString:@"Introduction"]) || ([[keys objectAtIndex:0] length] != 0)) && ([keys objectAtIndex:0] != NULL)) {
                nutritionBenefitsText           = [NSString stringWithFormat:@"%@ \n %@", nutritionBenefitsText,[keys objectAtIndex:0]];
            }
            nutritionBenefitsText                           = [NSString stringWithFormat:@"      %@ \n      %@ \n", nutritionBenefitsText,[nutritionBenefitsDictionary objectForKey:[keys objectAtIndex:0]]];
        }
    }
    nutritionBenefitsText                        = [self removeWhiteSpaceBeforeFirstWord:nutritionBenefitsText];
    if ([nutritionBenefitsText length] != 0) {
        self.contentsTextView.text                          = nutritionBenefitsText;
        // scroll to the top
        [self.contentsTextView setContentOffset:CGPointMake(0, 0) animated:YES];
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
    if (!self.m_nutritionBenefitsArray) {
        self.m_nutritionBenefitsArray            = [NSMutableArray mutableArrayObject];
    }
    if (!self.m_mealPlanSelection) {
        self.m_mealPlanSelection                 = [MealPlanSelection  sharedInstance];
    }
    if (!self.m_calenderViewController) {
        self.m_calenderViewController            = [CalenderViewController sharedInstance];
    }
    if (!self.m_mealViewController) {
        self.m_mealViewController                = [MealViewController alloc];
    }

    // Present image for the food imageView
    if ([self.m_calenderViewController.selectedImage length] != 0) { // If coming from CalenderViewController's view
        self.m_imageNameString                           = [NSString stringWithFormat:@"%@.png", self.m_calenderViewController.selectedImage];
        // Clean the selectedImage from the calenderviewcontroller to not confuse when coming from mealview controller
        self.m_calenderViewController.selectedImage      = nil;
    }
    else if([self.m_mealViewController.selectedImage length] != 0){ // If coming from MealViewController's view
        self.m_imageNameString                           = [NSString stringWithFormat:@"%@.png", self.m_mealViewController.selectedImage];
        self.m_mealViewController.selectedImage          = nil;
    }
    
    // Display this image
    UIImage *imageName                  = [UIImage imageNamed:self.m_imageNameString];
    [self.foodImageView setImage:imageName];

    // We need to remove underscore from the image name
    NSString *underscore                = @"_";
    // Remove underscore from the image name
    self.nutritionBenefitsPlist              = [self.m_imageNameString stringByReplacingOccurrencesOfString:underscore withString:@" "];
    // Then remove the .png image extensions, we get the name of the food
    self.nutritionBenefitsPlist              = [self.nutritionBenefitsPlist stringByReplacingOccurrencesOfString:@".png" withString:@""];
    
   
    // Display name of the food
    self.foodNameLabel.text             = [self capatalizeFirstLetterOfWordsOfFoodName:self.nutritionBenefitsPlist];
    
    // Load array from the plist having same image name
    self.m_nutritionBenefitsArray            = [self.m_mealPlanSelection loadUpPlist:[self.nutritionBenefitsPlist lowercaseString]];
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
    self.foodImageView                                      = [[UIImageView alloc] initWithFrame:foodImageViewFrame];
    [self.view addSubview:self.foodImageView];
    
    // Food Name Label
    CGRect foodNameLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        foodNameLabelFrame                               = CGRectMake(200.0f, 110.0f, 120.0f, 60.0f);
    }
    else {
        foodNameLabelFrame                               = CGRectMake(200.0f, 90.0f, 120.0f, 60.0f);
    }
    self.foodNameLabel                                      = [[UILabel alloc] initWithFrame:foodNameLabelFrame];
    self.foodNameLabel.font                                 = [UIFont customFontWithSize:15];
    self.foodNameLabel.lineBreakMode                        = NSLineBreakByWordWrapping;
    self.foodNameLabel.textAlignment                        = NSTextAlignmentLeft;
    self.foodNameLabel.numberOfLines                        = 2;
    [self.view addSubview:self.foodNameLabel];
    
    CGRect addToGroceryListInfoFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        addToGroceryListInfoFrame                        = CGRectMake(150.0f, 230.0f, 140.0f, 25.0f);
    }
    else {
        addToGroceryListInfoFrame                        = CGRectMake(150.0f, 180.0f, 140.0f, 25.0f);
    }
    self.addToGroceryButton                                 = [[UIButton alloc] initWithFrame:addToGroceryListInfoFrame];
    [self.addToGroceryButton setBackgroundImage:[UIImage imageNamed:@"tfn_addGL-ready.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.addToGroceryButton];
    [self.addToGroceryButton addTarget:self action:@selector(addToGroceryList:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect foodDescriptionImageViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
         foodDescriptionImageViewFrame               = CGRectMake(0.0f, 260.0f, 320.0f, 75.0f);
    }
    else {
         foodDescriptionImageViewFrame               = CGRectMake(0.0f, 210.0f, 320.0f, 75.0f);
    }
    self.foodDescriptionImageView                           = [[UIImageView alloc] initWithFrame:foodDescriptionImageViewFrame];
    [self.view addSubview:self.foodDescriptionImageView];
    self.foodDescriptionImageView.image                     = [UIImage imageNamed:@"tfn_NutritionalBenefits_active.png"];
    
    // Sections buttons positions should be adjusted
    CGRect nutritionBenefitsButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        nutritionBenefitsButtonFrame                     = CGRectMake(0.0f, 263.0f, 105.0f, 75.0f);
    }
    else {
        nutritionBenefitsButtonFrame                     = CGRectMake(0.0f, 213.0f, 105.0f, 75.0f);
    }
    self.nutritionBenefitsButton                            = [[UIButton alloc] initWithFrame:nutritionBenefitsButtonFrame];
    [self.view addSubview:self.nutritionBenefitsButton];
    [self.nutritionBenefitsButton addTarget:self action:@selector(showNutritions:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect nutritionFactsButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        nutritionFactsButtonFrame                        = CGRectMake(106.0f, 263.0f, 106.0f, 75.0f);
    }
    else{
        nutritionFactsButtonFrame                        = CGRectMake(106.0f, 213.0f, 106.0f, 75.0f);
    }
    self.nutritionFactsButton                               = [[UIButton alloc] initWithFrame:nutritionFactsButtonFrame];
    [self.view addSubview:self.nutritionFactsButton];
    [self.nutritionFactsButton addTarget:self action:@selector(showNutritions:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect nutritionRecipesButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        nutritionRecipesButtonFrame                      = CGRectMake(213.0f, 263.0f, 106.0f, 75.0f);
    }
    else {
        nutritionRecipesButtonFrame                      = CGRectMake(213.0f, 213.0f, 106.0f, 75.0f);
    }
    self.nutritionRecipesButton                             = [[UIButton alloc] initWithFrame:nutritionRecipesButtonFrame];
    [self.view addSubview:self.nutritionRecipesButton];
    [self.nutritionRecipesButton addTarget:self action:@selector(showNutritions:) forControlEvents:UIControlEventTouchUpInside];

    // Nutrtion Facts ScrollView height adjusted
    CGRect nutritionFactsScrollViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        nutritionFactsScrollViewFrame                    = CGRectMake(0.0f, 338.0f, 320.0f, 230.0f);
    }
    else {
        nutritionFactsScrollViewFrame                    = CGRectMake(0.0f, 290.0f, 320.0f, 200.0f);
    }
    self.nutritionFactsScrollView                           = [[UIScrollView alloc] initWithFrame:nutritionFactsScrollViewFrame];
    self.nutritionFactsScrollView.backgroundColor           = [UIColor whiteColor];
    self.nutritionFactsScrollView.scrollEnabled             = YES;
    self.nutritionFactsScrollView.userInteractionEnabled    = YES;
    [self.view addSubview:self.nutritionFactsScrollView];
    self.nutritionFactsScrollView.hidden                    = YES;

    // Add nutrition facts imageview to the scroll view
    CGRect nutritionFactsImageViewFrame                     = CGRectMake(20.0f, 0.0f, 280.0f, 400.0f);
    self.nutritionFactsImageView                            = [[UIImageView alloc] initWithFrame:nutritionFactsImageViewFrame];
    [self.nutritionFactsScrollView addSubview:self.nutritionFactsImageView];

    // Setup scroll view
    [self.nutritionFactsScrollView
     setContentSize:CGSizeMake(self.nutritionFactsImageView.frame.size.width,
                               self.nutritionFactsImageView.frame.size.height + 100.0f)];
    
    // Content Text View height adjusted

    CGRect contentsTextViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        contentsTextViewFrame                            = CGRectMake(0.0f, 330.0f, 320.0f, 185.0f);
    }
    else {
        contentsTextViewFrame                            = CGRectMake(0.0f, 280.0f, 320.0f, 140.0f);
    }
    self.contentsTextView                                   = [[UITextView alloc] initWithFrame:contentsTextViewFrame];
    self.contentsTextView.backgroundColor                   = [UIColor whiteColor];
    self.contentsTextView.textColor                         = [UIColor darkGrayColor];
    self.contentsTextView.scrollEnabled                     = YES;
    self.contentsTextView.editable                          = NO;
    [self.contentsTextView setFont:[UIFont customFontWithSize:14]];
    [self.view addSubview:self.contentsTextView];

    // Recipe Title Label
    CGRect recipeTitleLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        recipeTitleLabelFrame                            = CGRectMake(0.0f, 338.0f, 320.0f, 15.0f);
    }
    else {
        recipeTitleLabelFrame                            = CGRectMake(0.0f, 288.0f, 320.0f, 15.0f);
    }
    self.recipeTitleLabel                                   = [[UILabel alloc] initWithFrame:recipeTitleLabelFrame];
    self.recipeTitleLabel.backgroundColor                   = [UIColor whiteColor];
    self.recipeTitleLabel.textColor                         = [UIColor darkGrayColor];
    [self.recipeTitleLabel setFont:[UIFont customFontWithSize:11]];
    [self.view addSubview:self.recipeTitleLabel];
    self.recipeTitleLabel.hidden                            = YES;
    self.recipeTitleLabel.textAlignment                     = NSTextAlignmentCenter;

    // Recipe Ingredients Text View height adjusted
    CGRect recipeIngredientsTextViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        recipeIngredientsTextViewFrame                   = CGRectMake(150.0f, 355.0f, 168.0f, 90.0f);
    }
    else {
        recipeIngredientsTextViewFrame                   = CGRectMake(150.0f, 305.0f, 168.0f, 80.0f);
    }
    self.recipeIngredientsTextView                          = [[UITextView alloc] initWithFrame:recipeIngredientsTextViewFrame];
    self.recipeIngredientsTextView.backgroundColor          = [UIColor whiteColor];
    self.recipeIngredientsTextView.textColor                = [UIColor darkGrayColor];
    self.recipeIngredientsTextView.scrollEnabled            = YES;
    self.recipeIngredientsTextView.editable                 = NO;
    self.recipeIngredientsTextView.userInteractionEnabled   = YES;
    [self.recipeIngredientsTextView setFont:[UIFont customFontWithSize:11]];
    [self.view addSubview:self.recipeIngredientsTextView];
    self.recipeIngredientsTextView.hidden                   = YES;
    
    // Recipe Image view position adjusted
    CGRect recipeImageViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        recipeImageViewFrame                           = CGRectMake(12.0f, 355.0f, 135.0f, 80.0f);
    }
    else {
        recipeImageViewFrame                           = CGRectMake(12.0f, 305.0f, 135.0f, 80.0f);
    }
    self.recipeImageView                                    = [[UIImageView alloc] initWithFrame:recipeImageViewFrame];
    [self.view addSubview:self.recipeImageView];
    
    // Recipe Directions Label
    CGRect recipeDirectionsLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        recipeDirectionsLabelFrame                     = CGRectMake(12.0f, 435.0f, 132.0f, 10.0f);
    }
    else {
        recipeDirectionsLabelFrame                     = CGRectMake(12.0f, 385.0f, 132.0f, 8.0f);
    }
    self.recipeDirectionsLabel                              = [[UILabel alloc] initWithFrame:recipeDirectionsLabelFrame];
    self.recipeDirectionsLabel.text                         = @"Directions:";
    self.recipeDirectionsLabel.backgroundColor              = [UIColor whiteColor];
   self.recipeDirectionsLabel.textColor                    = [UIColor darkGrayColor];
    [self.recipeDirectionsLabel setFont:[UIFont customFontWithSize:11]];
    [self.view addSubview:self.recipeDirectionsLabel];
    self.recipeDirectionsLabel.hidden                       = YES;

    // Recipe Directions Text View height adjusted
    CGRect recipeDirectionsTextViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        recipeDirectionsTextViewFrame                  = CGRectMake(12.0f, 445.0f, 300.0f, 180.0f);
    }
    else {
        recipeDirectionsTextViewFrame                  = CGRectMake(12.0f, 395.0f, 300.0f, 130.0f);
    }
    self.recipeDirectionsTextView                           = [[UITextView alloc] initWithFrame:recipeDirectionsTextViewFrame];
    self.recipeDirectionsTextView.backgroundColor           = [UIColor whiteColor];
    self.recipeDirectionsTextView.textColor                 = [UIColor darkGrayColor];
    self.recipeDirectionsTextView.scrollEnabled             = YES;
    self.recipeDirectionsTextView.editable                  = NO;
    self.recipeDirectionsTextView.userInteractionEnabled    = YES;
    [self.recipeDirectionsTextView setFont:[UIFont customFontWithSize:11]];
    [self.view addSubview:self.recipeDirectionsTextView];
    self.recipeDirectionsTextView.hidden                    = YES;

    self.activityIndicator                             = [self reAddActivityIndicatorforiPhone5:self.activityIndicator];
    [self.view addSubview:self.activityIndicator];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // initialize this
        self.nutritionBenefitsPlist      = [[NSString alloc] init];
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
    [self.recipeDirectionsTextView addGestureRecognizer:recipeDirectionTap];

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
    self.m_checkWhichFoodButtonWasClicked    = @"nutritionFacts";
    [self showNutritionFacts];
    
    // Default is NO
    self.m_recipeDirectionTextViewMoved                                    = NO;

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
    if (self.m_recipeDirectionTextViewMoved) {
        [self adjustTheRecipeDirectionsTextViewPosition];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
 Single Tap gesture
 */
- (void)singleTapRecognized:(UIGestureRecognizer *)gestureRecognizer {
    CGRect frame = self.recipeDirectionsTextView.frame;
    
    if (self.m_recipeDirectionTextViewMoved) {
        self.m_recipeDirectionTextViewMoved    = NO;
        frame.origin.y += FOOD_DESCRIPTION_HEIGHT_ADUSTMENT; // new y coordinate
    }
    else {
        self.m_recipeDirectionTextViewMoved    = YES;
        frame.origin.y -= FOOD_DESCRIPTION_HEIGHT_ADUSTMENT;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration: 0.25];
    self.recipeDirectionsTextView.frame = frame;
    [UIView commitAnimations];
}

@end
