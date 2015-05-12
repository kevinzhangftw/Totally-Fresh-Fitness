//
//  ExerciseProfileViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-17.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//
#define FONT_SIZE           14.0f
#define CELL_CONTENT_WIDTH  320.0f
#define CELL_CONTENT_MARGIN 10.0f
#define MOVE_TIME_WEIGHT    10.0f;
#define MOVE_DIFFICULTY_REP 5.0f;

#import "ExerciseProfileViewController.h"
#import "WorkoutSelection.h"
#import "ProfileViewController.h"
#import "ExerciseListViewController.h"
#import "MealViewController.h"
#import "UIImageView+Scroll.h"
#import "UILabel+Scroll.h"
#import "UILabel+ChangeLabelNumbers.h"

@interface ExerciseProfileViewController ()

// Move to MealViewController
- (void)moveToMealViewController:(id)sender;
// Move to CalenderViewController
- (void)moveToCalenderViewController:(id)sender;
// Move to ExerciseViewController
- (void)moveToExerciseViewController:(id)sender;
// Move to supplements at website
- (void)moveToSupplementsAtWebsite:(id)sender;
// Move to MusicTracksViewController
- (void)moveToMusicTracksViewController:(id)sender;
// Move to SupplementPlanViewController
- (void)moveToSupplementPlanViewController:(id)sender;
// Display message to user with animation
- (void)displayMessage:(NSString *)message;
// Move Time Weight label to proper positions on the view
- (void)moveTimeWeightLabel:(UILabel *)sender;
// Move Difficulty Rep label to proper positions on the view
- (void)moveDifficultyRepLabel:(UILabel *)sender;
// Hide Exercise Report Details
- (void)hideExerciseReportDetails;
// Show Exercise Report Details
- (void)showExerciseReportDetails;
// Remove space before the first word
- (NSString *)removeWhiteSpaceBeforeFirstWord:(NSString *)nutritionBenefitsText;
// Exercise descriptions displayed on textview
- (void)addExerciseDescriptions:(NSMutableDictionary *)workoutDescriptionDictionary;
// Position exercise images properly
- (void)showExerciseImage:(NSString *)exerciseImage;
// Display exercise image
- (void)displayBigExerciseImage:(UIInterfaceOrientation)orientation;
// Change view on orientation change
- (void)orientationChanged:(NSNotification *)object;
// Set up big exercise image
- (void)setUpBigExerciseImage;
// Load up the exercise description from plist
- (void)loadUpExerciseDescriptionFromPlistUsingExerciseImageName:(NSString *)exerciseImageNameString;
// Capatalized first letter of each food name's words
- (NSString *)capatalizeFirstLetterOfWordsOfExerciseName:(NSString *)initialExerciseName;
//  Use previous view's selected image name to food image and choosing the right food nutrition benefits description
- (void)loadExerciseImagesAndDescription;
// Get Average of weekly data
- (void)getAverageFromWeeklyData:(NSMutableArray *)weeklyReportData;
// Initial week increment, called only once
- (int)incrementByTheDayOfTheWeek:(NSInteger)weekday;
// Get A Week Report each time called
- (void)getWeeklyReport;
// Load up weight and rep data
- (void)loadDataForGraph;
// Show Exercise description
- (void)showExerciseDescription;
// Show Report
- (void)showReport;
// Show Progress
- (void)showProgress;
// Show Exercise details
- (IBAction)showExerciseSections:(id)sender;
// Increment or Decrement time weight value
- (int)incrementOrDecrement:(NSString *)incrementOrDecrement WeightTimeValue:(UILabel *)label;
// Animate using the three visible labels as well as the two invisible labels
- (void)animateLeftOrRight:(NSString *)leftOrRight TimeWeightLabel:(UILabel *)label;
// Increment or Decrement time weight value
- (int)incrementOrDecrement:(NSString *)incrementOrDecrement DifficultyRepValue:(UILabel *)label;
//// Save Report
- (IBAction)saveReport:(id)sender;
// Adjust the height of the views for iphone5 size
- (void)setUpViews;
// In response to left or right swipe gesture, to move the next or previous image.
- (IBAction)handleSwipe:(UISwipeGestureRecognizer *)swipeRecognizer;
// Weight or Time, Rep or Difficult assignments
- (void)loadUpRightImagesAndValues:(UILabel *)label;
// Load up exercise report values
- (void)initialExerciseReportValues;
//Set up right image for the exercise report
- (void)setUpRightImagesForExerciseReport;
// Load up the exercises that should not have report or progress
- (void)loadUpExerciseWithoutReportOrProgress;
// Load up the exercises list that only has repititions
- (void)loadUpExerciseWithOnlyRepititions;
// Load up the exercises list that only has repititions
- (void)loadUpExerciseWithOnlyTime;
// Check if exercise is one of those that don't have report or progress
- (bool)checkIfExerciseIsWithoutReportOrProgress:(NSString *)exercise;
// Check if exercise is one of those that has only repititions
- (bool)checkIfExerciseIsWithOnlyRepititions:(NSString *)exercise;
// Check if exercise is one of those that has only time
- (bool)checkIfExerciseIsWithOnlyTime:(NSString *)exercise;


@property (strong, nonatomic) Database *m_database;
@property (strong, nonatomic) ProfileViewController *m_profileViewController;
@property (strong, nonatomic) ExerciseViewController *m_exerciseViewController;
@property (strong, nonatomic) MealViewController *m_mealViewController;
@property (strong, nonatomic) CalenderViewController *m_calenderViewController;
@property (strong, nonatomic) MusicTracksViewController *m_musicTracksViewController;
@property (strong, nonatomic) SupplementPlanViewController *m_supplementPlanViewController;
@property (strong, nonatomic) ExerciseListViewController *m_exerciseListViewController;
@property (strong, nonatomic) WorkoutSelection *m_workoutSelection;
@property (strong, nonatomic) ViewFactory *m_controllerViews;
@property (strong, nonatomic) ViewTransitions *m_transition;
@property (strong, nonatomic) NSMutableDictionary *m_workoutDescriptionDictionary;
@property (strong, nonatomic) NSString *m_exerciseDescriptionPlist;
@property (strong, nonatomic) NSString *m_exerciseImageNameString; //HAX = @"";
@property (strong, nonatomic) NSString *m_checkWhichExerciseButtonWasClicked; //HAX
@property (strong, nonatomic) NSMutableArray *m_weightArray;
@property (strong, nonatomic) NSMutableArray *m_repArray;
@property (nonatomic) int m_numberOfImages;
@property (nonatomic) int m_decrementWeek;
@property (strong, nonatomic) NSMutableArray *m_weeklyReportData;
@property (strong, nonatomic) NSDate *m_weekEndDate;
@property (strong, nonatomic) NSDate *m_weekStartDate;
@property (nonatomic) int m_totalNumberOfItemsInDataForGraph;
//@property (strong, nonatomic) NSString *m_exerciseImageNameString;
@property (strong, nonatomic) NSString *m_secondExerciseImageNameString;
@property (strong, nonatomic) NSString *m_thirdExerciseImageNameString;
@property (strong, nonatomic) NSString *m_bigExerciseImageNameString;
@property (nonatomic) int m_imageNumberOfSelectedImage;
@property (nonatomic) BOOL isBigImageVisible;
@property (nonatomic) CGRect m_beforeFirstFrame;
@property (nonatomic) CGRect m_firstFrame;
@property (nonatomic) CGRect m_secondFrame;
@property (nonatomic) CGRect m_thirdFrame;
@property (nonatomic) CGRect m_afterThirdFrame;
@property (nonatomic) CGRect m_beforeFirstDifficultyRepFrame;
@property (nonatomic) CGRect m_firstDifficultyRepFrame;
@property (nonatomic) CGRect m_secondDifficultyRepFrame;
@property (nonatomic) CGRect m_thirdDifficultyRepFrame;
@property (nonatomic) CGRect m_afterThirdDifficultyRepFrame;
@property (strong, nonatomic) UILabel *firstTimeWeightLabel;
@property (strong, nonatomic) UILabel *secondTimeWeightLabel;
@property (strong, nonatomic) UILabel *thirdTimeWeightLabel;
@property (strong, nonatomic) UILabel *afterThirdTimeWeightLabel;
@property (strong, nonatomic) UILabel *beforeFirstDifficultyRepLabel;
@property (strong, nonatomic) UILabel *firstDifficultyRepLabel;
@property (strong, nonatomic) UILabel *secondDifficultyRepLabel;
@property (strong, nonatomic) UILabel *thirdDifficultyRepLabel;
@property (strong, nonatomic) UILabel *afterThirdDifficultyRepLabel;
@property (strong, nonatomic) UILabel *setNameLabel;
@property (strong, nonatomic) UILabel *setNumberLabel;
@property (strong, nonatomic) UILabel *setMaxNumberLabel;
@property (strong, nonatomic) UIButton *saveReportButton;
@property (strong, nonatomic) UIButton *beforeFirstTimeWeightLabel;
@property (nonatomic) int m_selectedWeightTimeRepitition;
@property (nonatomic) int m_selectedDifficultyRep;
@property (nonatomic) int m_setNumber;
@property (strong, nonatomic) NSString *m_weightOrTimeOrRepititionImage;
@property (nonatomic) int m_beforeFirstWeightLabel;
@property (nonatomic) int m_beforeFirstDifficultyRepLabel;
@property (strong, nonatomic) NSString *m_previousExerciseName;
@property (strong, nonatomic) NSString *m_gender;
@property (strong, nonatomic) NSCalendar *m_calendar;
@property (strong, nonatomic) NSDate *m_today;
@property (strong, nonatomic) NSDateComponents *m_components;
@property (strong, nonatomic) NSDateComponents *m_dayComponent;
@property (strong, nonatomic) NSCalendar *m_theCalendar;
@property (strong, nonatomic) NSMutableArray *m_exercisesWithoutReportOrProgress;
@property (strong, nonatomic) NSMutableArray *m_exercisesWithOnlyRepititions;
@property (strong, nonatomic) NSMutableArray *m_exercisesWithOnlyTime;
@property (strong, nonatomic) NSString *m_exerciseNameDisplayed;
@property (strong, nonatomic) UIButton *workoutDescriptionButton;
@property (strong, nonatomic) UIButton *reportButton;
@property (strong, nonatomic) UIButton *progressButton;
@property (strong, nonatomic) UIImageView *reportTimeWeightRepImageView;
@property (strong, nonatomic) UIButton *m_minusTimeWeightRepButton;
@property (strong, nonatomic) UIButton *m_plusTimeWeightRepButton;
@property (strong, nonatomic) UIImageView *reportTimeWeightImageViewMask;
@property (strong, nonatomic) UIImageView *reportDifficultyRepImageViewMask;
@property (strong, nonatomic) UIButton *reportWeightRepNextDoneButton;
@property (strong, nonatomic) UIButton *reportTimeNextDoneButton;
@property (strong, nonatomic) UIButton *reportRepNextDoneButton;

@end

@implementation ExerciseProfileViewController



@synthesize exerciseNameLabel;
@synthesize bigExerciseBackgroundView;
@synthesize bigExerciseImageView;
@synthesize exerciseImageView;
@synthesize exerciseDetailsImageView;
@synthesize contentsTextView;
@synthesize timeWeightLeftSwipeGesture;
@synthesize timeWeightRightSwipeGesture;
@synthesize difficultyRepLeftSwipeGesture;
@synthesize difficultyRepRightSwipeGesture;
@synthesize graphView;
@synthesize weightBox;
@synthesize repBox;
@synthesize weightLabel;
@synthesize repLabel;
@synthesize bottomBarButton;
@synthesize musicPlayerButton;
@synthesize exercisePlanButton;
@synthesize calendarButton;
@synthesize mealPlanButton;
@synthesize nutritionPlanButton;
@synthesize messageButton;
@synthesize activityIndicator;

@synthesize hostView                = hostView_;

/*
 Singleton FoodProfileViewController object
 */
+ (ExerciseProfileViewController *)sharedInstance {
    static ExerciseProfileViewController *globalInstance;
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
    // Google Analytics Button click

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
    // Clean up the, if the big exercise is opened
    if (self.isBigImageVisible) {
        [self showOtherViewsAfterHidingBigImage];
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
    // Clean up the, if the big exercise is opened
    if (self.isBigImageVisible) {
        [self showOtherViewsAfterHidingBigImage];
    }
    
}

/*
 Move to ExerciseViewController
 */
- (void)moveToExerciseViewController:(id)sender
{
    if (!self.m_exerciseViewController) {
        self.m_exerciseViewController        = [ExerciseViewController sharedInstance];
    }
    
    id instanceObject                   = self.m_exerciseViewController;
    
    [self moveToView:self.m_exerciseViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    // Clean up the, if the big exercise is opened
    if (self.isBigImageVisible) {
        [self showOtherViewsAfterHidingBigImage];
    }

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
    // Clean up the, if the big exercise is opened
    if (self.isBigImageVisible) {
        [self showOtherViewsAfterHidingBigImage];
    }
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
 Display message to user with animation
 */
- (void)displayMessage:(NSString *)message
{
    self.messageButton.hidden               = NO;
    [UIButton animateWithDuration:3.0f animations:^{self.messageButton.alpha = 5.0;} completion:nil];
    
    [self.messageButton setTitle:message forState:UIControlStateNormal];
    
    if (!self.m_transition) {
        self.m_transition                        = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionFromBottom:self.messageButton];
    
    [UIButton animateWithDuration:5.0f animations:^{self.messageButton.alpha = 0.0;} completion:nil];
}

/*
 Hide rep details
 */
- (void)hideRepDetails
{
    self.beforeFirstDifficultyRepLabel.hidden           = YES;
    self.firstDifficultyRepLabel.hidden                 = YES;
    self.secondDifficultyRepLabel.hidden                = YES;
    self.thirdDifficultyRepLabel.hidden                 = YES;
    self.afterThirdDifficultyRepLabel.hidden            = YES;
}

/*
 Hide Exercise Report Details
 */
-(void)hideExerciseReportDetails
{
    if (!self.m_transition) {
        self.m_transition        = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionDisappear:self.reportTimeWeightRepImageView];
    [self.m_transition performTransitionDisappear:self.reportTimeWeightImageViewMask];
    [self.m_transition performTransitionDisappear:self.reportDifficultyRepImageViewMask];
    [self.m_transition performTransitionDisappear:self.reportWeightRepNextDoneButton];
    [self.m_transition performTransitionDisappear:self.saveReportButton];
    [self.m_transition performTransitionDisappear:self.reportTimeNextDoneButton];
    [self.m_transition performTransitionDisappear:self.reportRepNextDoneButton];
    
    self.reportTimeWeightRepImageView.hidden          = YES;
    self.reportTimeWeightImageViewMask.hidden         = YES;
    self.reportDifficultyRepImageViewMask.hidden      = YES;
    self.reportWeightRepNextDoneButton.hidden         = YES;
    self.reportTimeNextDoneButton.hidden              = YES;
    self.reportRepNextDoneButton.hidden               = YES;
    self.saveReportButton.hidden                      = YES;
    self.beforeFirstTimeWeightLabel.hidden            = YES;
    self.firstTimeWeightLabel.hidden                  = YES;
    self.secondTimeWeightLabel.hidden                 = YES;
    self.thirdTimeWeightLabel.hidden                  = YES;
    self.afterThirdTimeWeightLabel.hidden             = YES;
    self.m_plusTimeWeightRepButton.hidden             = YES;
    self.m_minusTimeWeightRepButton.hidden            = YES;
    
    [self hideRepDetails];
    if (![self.m_weightOrTimeOrRepititionImage isEqualToString:@"Time"]) {
        self.reportWeightRepNextDoneButton.hidden     = YES;
        self.setNameLabel.hidden                      = YES;
        self.setNumberLabel.hidden                    = YES;
        self.setMaxNumberLabel.hidden                 = YES;
    }
}

/*
 Show Rep Details
 */
- (void)showRepDetails:(UILabel *)label
{
    if (label.frame.origin.x == self.m_afterThirdDifficultyRepFrame.origin.x) {
        label.hidden           = YES;
        label.textColor        = [UIColor darkGrayColor];
    }
    else if(label.frame.origin.x == self.m_beforeFirstDifficultyRepFrame.origin.x) {
        label.hidden           = YES;
        label.textColor        = [UIColor darkGrayColor];
    }
    else if(label.frame.origin.x == self.m_firstDifficultyRepFrame.origin.x) {
        label.hidden           = NO;
        label.textColor        = [UIColor darkGrayColor];
    }
    else if(label.frame.origin.x == self.m_secondDifficultyRepFrame.origin.x) {
        label.hidden           = NO;
        label.textColor        = [UIColor redColor];
    }
    else if(label.frame.origin.x == self.m_thirdDifficultyRepFrame.origin.x) {
        label.hidden           = NO;
        label.textColor        = [UIColor darkGrayColor];
    }
}

/*
 Show Weight Rep Time Details
 */
- (void)showWeightTimeRepDetails:(UILabel *)label
{
    if (label.frame.origin.x == self.m_afterThirdFrame.origin.x) {
        label.hidden           = YES;
        label.textColor        = [UIColor darkGrayColor];
    }
    else if(label.frame.origin.x == self.m_beforeFirstFrame.origin.x) {
        label.hidden           = YES;
        label.textColor        = [UIColor darkGrayColor];
    }
    else if(label.frame.origin.x == self.m_firstFrame.origin.x) {
        label.hidden           = NO;
        label.textColor        = [UIColor darkGrayColor];
    }
    else if(label.frame.origin.x == self.m_secondFrame.origin.x) {
        label.hidden           = NO;
        label.textColor        = [UIColor redColor];
    }
    else if(label.frame.origin.x == self.m_thirdFrame.origin.x) {
        label.hidden           = NO;
        label.textColor        = [UIColor darkGrayColor];
    }
}


/*
 Show Exercise Report Details
 */
-(void)showExerciseReportDetails
{
    [self hideRepDetails];
    
    if (!self.m_transition) {
        self.m_transition        = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionAppear:self.reportTimeWeightRepImageView];
    
    if (![self.m_weightOrTimeOrRepititionImage isEqualToString:@"Time"]) {
        self.reportWeightRepNextDoneButton.hidden     = YES;
        self.setNameLabel.hidden                      = YES;
        self.setNumberLabel.hidden                    = YES;
        self.setMaxNumberLabel.hidden                 = YES;
        self.reportTimeNextDoneButton.hidden          = NO;
        self.m_plusTimeWeightRepButton.hidden           = YES;
        self.m_minusTimeWeightRepButton.hidden          = YES;
    }
    
    self.reportTimeWeightRepImageView.hidden            = NO;
    self.reportTimeWeightImageViewMask.hidden           = NO;
    if (([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Repitition"])) {
        self.reportDifficultyRepImageViewMask.hidden    = YES;
        self.reportRepNextDoneButton.hidden             = NO;
        self.reportTimeNextDoneButton.hidden            = YES;
        self.reportWeightRepNextDoneButton.hidden       = YES;
        self.setNameLabel.hidden                        = YES;
        self.setNumberLabel.hidden                      = YES;
        self.setMaxNumberLabel.hidden                   = YES;
        self.m_plusTimeWeightRepButton.hidden             = NO;
        self.m_minusTimeWeightRepButton.hidden            = NO;
    }
    else if ([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Time"]) {
        self.reportDifficultyRepImageViewMask.hidden    = YES;
        self.reportRepNextDoneButton.hidden             = YES;
        self.reportTimeNextDoneButton.hidden            = NO;
        self.reportWeightRepNextDoneButton.hidden       = YES;
        self.setNameLabel.hidden                        = NO;
        self.setNumberLabel.hidden                      = NO;
        self.setMaxNumberLabel.hidden                   = NO;
        self.m_plusTimeWeightRepButton.hidden           = YES;
        self.m_minusTimeWeightRepButton.hidden          = YES;
    }
    else {
        self.reportDifficultyRepImageViewMask.hidden    = NO;
        self.reportWeightRepNextDoneButton.hidden       = NO;
        self.reportRepNextDoneButton.hidden             = YES;
        self.reportTimeNextDoneButton.hidden            = YES;
        self.reportWeightRepNextDoneButton.hidden       = NO;
        self.setNameLabel.hidden                        = YES;
        self.setNumberLabel.hidden                      = YES;
        self.setMaxNumberLabel.hidden                   = YES;
        self.m_plusTimeWeightRepButton.hidden           = YES;
        self.m_minusTimeWeightRepButton.hidden          = YES;
    }
    
    self.saveReportButton.hidden                        = NO;
    if ([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Weight"]) { // if the excerise has weight
        [self showRepDetails:self.beforeFirstDifficultyRepLabel];
        [self showRepDetails:self.firstDifficultyRepLabel];
        [self showRepDetails:self.secondDifficultyRepLabel];
        [self showRepDetails:self.thirdDifficultyRepLabel];
        [self showRepDetails:self.afterThirdDifficultyRepLabel];
        self.m_plusTimeWeightRepButton.hidden             = NO;
        self.m_minusTimeWeightRepButton.hidden            = NO;
    }
    
    [self showWeightTimeRepDetails:self.beforeFirstTimeWeightLabel];
    [self showWeightTimeRepDetails:self.firstTimeWeightLabel];
    [self showWeightTimeRepDetails:self.secondTimeWeightLabel];
    [self showWeightTimeRepDetails:self.thirdTimeWeightLabel];
    [self showWeightTimeRepDetails:self.afterThirdTimeWeightLabel];
}

/*
 Load up right small repitition values
 */
- (void)loadUpRightSmallRepititionValues:(UILabel *)label
{
    if (label.frame.origin.x == self.m_beforeFirstFrame.origin.x) {
        label.text           = @"4";
    }
    else if(label.frame.origin.x == self.m_firstFrame.origin.x) {
        label.text           = @"5";
    }
    else if(label.frame.origin.x == self.m_secondFrame.origin.x) {
        label.text           = @"6";
    }
    else if(label.frame.origin.x == self.m_thirdFrame.origin.x) {
        label.text           = @"7";
    }
    else if(label.frame.origin.x == self.m_afterThirdFrame.origin.x) {
        label.text           = @"8";
    }
}

/*
 Load up exercise report values
 */
- (void)initialExerciseReportValues
{
    // load up right images and values for weight or time, rep or difficulty
    [self loadUpRightImagesAndValues:self.beforeFirstTimeWeightLabel];
    [self loadUpRightImagesAndValues:self.firstTimeWeightLabel];
    [self loadUpRightImagesAndValues:self.secondTimeWeightLabel];
    [self loadUpRightImagesAndValues:self.thirdTimeWeightLabel];
    [self loadUpRightImagesAndValues:self.afterThirdTimeWeightLabel];
    
    // load up right values for small rep
    [self loadUpRightSmallRepititionValues:self.beforeFirstDifficultyRepLabel];
    [self loadUpRightSmallRepititionValues:self.firstDifficultyRepLabel];
    [self loadUpRightSmallRepititionValues:self.secondDifficultyRepLabel];
    [self loadUpRightSmallRepititionValues:self.thirdDifficultyRepLabel];
    [self loadUpRightSmallRepititionValues:self.afterThirdDifficultyRepLabel];
    
    // update the set number to begin from 1
    self.setNumberLabel.text                         = @"1";
}

/*
 Hide Exercise progress graph
 */
- (void)hideProgress
{
    if (!self.m_transition) {
        self.m_transition        = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionDisappear:self.graphView];
    [self.m_transition performTransitionDisappear:self.weightBox];
    [self.m_transition performTransitionDisappear:self.repBox];
    [self.m_transition performTransitionDisappear:self.weightLabel];
    [self.m_transition performTransitionDisappear:self.repLabel];
    // Hide the graphview
    self.graphView.hidden                           = YES;
    // Hide the weight box
    self.weightBox.hidden                           = YES;
    // Hide the rep box
    self.repBox .hidden                             = YES;
    // Hide the weight label
    self.weightLabel.hidden                         = YES;
    // Hide the rep label
    self.repLabel.hidden                            = YES;
}

/*
 Show Exercise Description
 */
- (void)showExerciseDescription
{
    [self.exerciseDetailsImageView setImage:[UIImage imageNamed:@"tfn_description_active.png"]];
    
    if (!self.m_transition) {
        self.m_transition        = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionAppear:self.contentsTextView];
    // Show the exercise description
    self.contentsTextView.hidden                    = NO;
    
    // Hide exercise report details
    [self hideExerciseReportDetails];
    
    // Exercise progress graph
    [self hideProgress];
}

/*
 Show Report
 */
- (void)showReport
{
    if (!self.m_transition) {
        self.m_transition                                = [ViewTransitions sharedInstance];
    }
    [self.exerciseDetailsImageView setImage:[UIImage imageNamed:@"tfn_report_active.png"]];
    [self.m_transition performTransitionDisappear:self.contentsTextView];
    // Hide the textview
    self.contentsTextView.hidden                    = YES;
    
    // Exercise progress graph
    [self hideProgress];
    
    // Show the report details
    [self showExerciseReportDetails];
    
    if ([self.m_previousExerciseName isEqualToString:self.m_exerciseImageNameString]) { // Retain the exercise state from before, so do nothing
    }
    else { // if the previous view's exercise is not the same, update the m_previousExerciseName
        self.m_previousExerciseName                          = self.m_exerciseImageNameString;
        [self initialExerciseReportValues];
    }
}

/*
 Show Progress
 */
- (void)showProgress
{
    if (!self.m_transition) {
        self.m_transition                                = [ViewTransitions sharedInstance];
    }
    [self.exerciseDetailsImageView setImage:[UIImage imageNamed:@"tfn_progress_active.png"]];
    [self.m_transition performTransitionDisappear:self.contentsTextView];
    
    // Hide the textview
    self.contentsTextView.hidden                    = YES;
    // Hide exercise report details
    [self hideExerciseReportDetails];
    
    // Show graph
    [self loadDataForGraph];
}

/*
 Show Exercise details
 */
-(void)showExerciseSections:(id)sender
{
    
    if ((sender == self.workoutDescriptionButton) && (([self.m_checkWhichExerciseButtonWasClicked isEqualToString:@"exerciseReport"]) || ([self.m_checkWhichExerciseButtonWasClicked isEqualToString:@"exerciseProgress"]))) {
        self.m_checkWhichExerciseButtonWasClicked            = @"exerciseDescription";
        [self showExerciseDescription];
    }
    else if((sender == self.reportButton) && (([self.m_checkWhichExerciseButtonWasClicked isEqualToString:@"exerciseDescription"]) || ([self.m_checkWhichExerciseButtonWasClicked isEqualToString:@"exerciseProgress"]))) {
        if ([self checkIfExerciseIsWithoutReportOrProgress:self.m_exerciseNameDisplayed]) {
            // Hide exercise report details
            [self hideExerciseReportDetails];
            
            // Exercise progress graph
            [self hideProgress];
            
        }
        else {
            self.m_checkWhichExerciseButtonWasClicked            = @"exerciseReport";
            [self showReport];
        }
    }
    else if((sender == self.progressButton) && (([self.m_checkWhichExerciseButtonWasClicked isEqualToString:@"exerciseDescription"]) || ([self.m_checkWhichExerciseButtonWasClicked isEqualToString:@"exerciseReport"]))) {
        if ([self checkIfExerciseIsWithoutReportOrProgress:self.m_exerciseNameDisplayed]) {
            // Hide exercise report details
            [self hideExerciseReportDetails];
            
            // Exercise progress graph
            [self hideProgress];
        }
        else {
            self.m_checkWhichExerciseButtonWasClicked            = @"exerciseProgress";
            [self showProgress];
            self.setNameLabel.hidden                             = YES;
            self.setNumberLabel.hidden                           = YES;
            self.setMaxNumberLabel.hidden                        = YES;
            
        }
    }
}

/*
 Move Time Weight label to proper positions on the view
 */
- (void)moveTimeWeightLabel:(UILabel *)sender {
    CGRect frame = sender.frame;
    
    if (objectsMoved) {
        frame.origin.x -= MOVE_TIME_WEIGHT; // new y coordinate
    }
    else {
        frame.origin.x += MOVE_TIME_WEIGHT;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration: 0.25];
    sender.frame = frame;
    [UIView commitAnimations];
}

/*
 Move Difficult Rep label to proper positions on the view
 */
- (void)moveDifficultyRepLabel:(UILabel *)sender {
    CGRect frame = sender.frame;
    
    if (objectsMoved) {
        frame.origin.x -= MOVE_DIFFICULTY_REP; // new y coordinate
    }
    else {
        frame.origin.x += MOVE_DIFFICULTY_REP;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration: 0.25];
    sender.frame = frame;
    [UIView commitAnimations];
}

/*
 Save Report
 */
- (IBAction)saveReport:(id)sender
{
    NSString *exerciseReportStatus            = @"";
    NSDate *date                              = [NSDate date];
    
    self.m_setNumber                               = [self.setNumberLabel.text intValue];
    
    // Convert int weight time value into nsnumber
    NSNumber *numberSetOneWeightField         = 0;
    // Convert int weight time value into nsnumber
    NSNumber *numberSetOneTimeField           = 0;
    
    // Convert int difficulty rep value into nsnumber
    NSNumber *numberSetOneRepField            = [NSNumber numberWithInt:self.m_selectedDifficultyRep];
    
    // Convert int set number into nsnumber
    NSNumber *setNumber                       = [NSNumber numberWithInt:self.m_setNumber];
    if ([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Time"]) {
        numberSetOneTimeField                 = [NSNumber numberWithInt:self.m_selectedWeightTimeRepitition];
        numberSetOneRepField                  = 0;
    }
    else if([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Weight"]){
        numberSetOneWeightField               = [NSNumber numberWithInt:self.m_selectedWeightTimeRepitition];
    }
    else if([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Repitition"]){ // If it is repitition, it has big repitition image
        numberSetOneRepField                  = [NSNumber numberWithInt:self.m_selectedWeightTimeRepitition];
    }
    
    if ((numberSetOneWeightField != NULL) || (numberSetOneRepField != NULL) || (numberSetOneTimeField != NULL)) { // Make there is no null in the numbers
        
        if ([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Time"]) {
            
            if (self.m_setNumber < 7) { // Maximum number of set is 5
                
                if (!self.m_database) {
                    self.m_database      = [Database alloc];
                }
                if (self.m_setNumber > 1) { // When set is more than 1, data needs to be updated in database
                    exerciseReportStatus            = [self.m_database updateExerciseReport:self.exerciseNameLabel.text Email_Id:[NSString getUserEmail] Date:date Set:setNumber SetTheWeight:numberSetOneWeightField SetTheTime:numberSetOneTimeField SetTheRep:numberSetOneRepField];
                }
                else { // When set is 1, data needs to be inserted in database
                    exerciseReportStatus            = [self.m_database insertIntoExerciseReport:self.exerciseNameLabel.text Email_Id:[NSString getUserEmail] Date:date SetOneWeight:numberSetOneWeightField SetOneTime:numberSetOneTimeField SetOneRep:numberSetOneRepField];
                }
                
                if ([exerciseReportStatus isEqualToString:@"updated"]) {
                    [self displayMessage:[NSString stringWithFormat:@"Set number %d was successfully saved.", self.m_setNumber]];
                    
                    // Increment for the next set
                    self.m_setNumber++;
                    
                    // if the set number reaches 5 , then it should become 1 to start again
                    if (self.m_setNumber == 6) {
                        self.m_setNumber                         = 1;
                    }
                    // Update the set number, after pressing done
                    self.setNumberLabel.text                = [NSString stringWithFormat:@"%d", self.m_setNumber];
                }
                else {
                    [self displayMessage:@"This record failed to be saved."];
                }
            }
        }
        else { // for exercise other than time
            exerciseReportStatus            = [self.m_database insertIntoExerciseReport:self.exerciseNameLabel.text Email_Id:[NSString getUserEmail] Date:date SetOneWeight:numberSetOneWeightField SetOneTime:numberSetOneTimeField SetOneRep:numberSetOneRepField];
            if ([exerciseReportStatus isEqualToString:@"updated"]) {
                [self displayMessage:[NSString stringWithFormat:@"This record was successfully saved."]];
            }
        }
    }
    
}

/*
 Remove space before the first word
 */
- (NSString *)removeWhiteSpaceBeforeFirstWord:(NSString *)nutritionBenefitsText
{
    // trim the whitespace before the first character
    NSCharacterSet *whitespace                      = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    nutritionBenefitsText                           = [nutritionBenefitsText stringByTrimmingCharactersInSet:whitespace];
    return nutritionBenefitsText;
}

/*
 Exercise descriptions displayed on textview
 */
- (void)addExerciseDescriptions :(NSMutableDictionary *)workoutDescriptionDictionary
{
    NSString *exerciseDescriptionText                     = @"";
    
    if ([workoutDescriptionDictionary count] != 0) {
        NSArray *keys                       = [workoutDescriptionDictionary allKeys];
        if (([keys objectAtIndex:0] != NULL) && ([[keys objectAtIndex:0] length] != 0)) {
            exerciseDescriptionText         = [NSString stringWithFormat:@"%@ \n %@", exerciseDescriptionText,[keys objectAtIndex:0]];
            if (([workoutDescriptionDictionary objectForKey:[keys objectAtIndex:0]] != NULL) && ([[workoutDescriptionDictionary objectForKey:[keys objectAtIndex:0]] length] != 0)) {
                exerciseDescriptionText             = [NSString stringWithFormat:@"      %@ \n      %@ \n", exerciseDescriptionText,[workoutDescriptionDictionary objectForKey:[keys objectAtIndex:0]]];
            }
        }
    }
    // Remove the empty line from the exercise Description
    self.contentsTextView.text                              = [self removeWhiteSpaceBeforeFirstWord:exerciseDescriptionText];
    
    // Stop the activity indicator when text are loaded
    [self.activityIndicator stopAnimating];
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
 Position exercise images properly
 */
- (void)showExerciseImage:(NSString *)exerciseImageName
{
    NSString *exerciseImageThumbName                 = exerciseImageName;
    CGRect frame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        frame                                        = CGRectMake(0, 75, 320, 210);
        exerciseImageName                            = [exerciseImageName stringByReplacingOccurrencesOfString:@"thumb" withString:@"i5"];
        // add back with right size
        self.exerciseImageView                           = [[UIImageView alloc] initWithFrame:frame];
        [self.view addSubview:self.exerciseImageView];
    }
    else {
        exerciseImageName                            = [exerciseImageName stringByReplacingOccurrencesOfString:@"thumb" withString:@"i4"];
    }
    // Assign image to the single image view
    //self.exerciseImageView.image                     = [UIImage imageNamed:exerciseImageName];
    self.exerciseImageView.image = [self imageWithFilename:exerciseImageName];
    if (!self.exerciseImageView.image) { // If normal image not found, then use thumb image
        //self.exerciseImageView.image                 = [UIImage imageNamed:exerciseImageThumbName];
        self.exerciseImageView.image = [self imageWithFilename:exerciseImageThumbName];
    }
    [self.view bringSubviewToFront:self.exerciseNameLabel];
}



/*
 Hide views to show the big image
 */
- (void)hideOtherViewsForBigImage
{
    self.bigExerciseImageView.hidden                 = NO;
    
    // Set True
    self.isBigImageVisible                                = TRUE;
    [self.view addSubview:self.bigExerciseImageView];
}

/*
 Show other views to hide big image
 */
- (void)showOtherViewsAfterHidingBigImage
{
    if (!self.m_transition) {
        self.m_transition                                = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionDisappear:self.bigExerciseImageView];
    [self.bigExerciseImageView removeFromSuperview];
    
    // Big image make invisible
    self.isBigImageVisible                               = FALSE;
}

/*
 Display first exercise image
 */
- (void)displayBigExerciseImage:(UIInterfaceOrientation)orientation
{
    // assign selected image view
    self.m_bigExerciseImageNameString                    = self.m_exerciseImageNameString;
    
    // Remove the below line, only for testing
    self.m_bigExerciseImageNameString                    = [self.m_bigExerciseImageNameString stringByReplacingOccurrencesOfString:@"thumb" withString:@"landscape"];
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        self.bigExerciseImageView.image             = [[UIImage alloc] initWithCGImage: [UIImage imageNamed:self.m_bigExerciseImageNameString].CGImage
                                                                                 scale: 1.90
                                                                           orientation: UIImageOrientationLeft];
    }
    else if(orientation == UIInterfaceOrientationLandscapeRight) {
        self.bigExerciseImageView.image             = [[UIImage alloc] initWithCGImage: [UIImage imageNamed:self.m_bigExerciseImageNameString].CGImage
                                                                                 scale: 1.90
                                                                           orientation: UIImageOrientationRight];
    }
    [self hideOtherViewsForBigImage];
}

/*
 Set up big exercise image
 */
- (void)setUpBigExerciseImage
{
    self.bigExerciseImageView              = nil;
    CGRect frame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) {// if iphone 5
        frame                              = CGRectMake(0.0f, 62.0f, 320.0f, 508.0f);
    }
    else { // if other iphones
        frame                              = CGRectMake(0.0f, 62.0f, 320.0f, 420.0f);
    }
    self.bigExerciseImageView              = [[UIImageView alloc] initWithFrame:frame];
    [self.view addSubview:self.bigExerciseImageView];
}

/*
 Change view on orientation change
 */
- (void)orientationChanged:(NSNotification *)object
{
    UIDeviceOrientation deviceOrientation      = [[object object] orientation];
    if ((deviceOrientation == UIInterfaceOrientationLandscapeLeft) || (deviceOrientation == UIInterfaceOrientationLandscapeRight)) { // if landscape mode
        // Set up big exercise image
        [self setUpBigExerciseImage];
        // Display first big exercise image
        [self displayBigExerciseImage:deviceOrientation];
    }
    else { // Remove the big exercise image
        [self showOtherViewsAfterHidingBigImage];
        // Set True
        self.isBigImageVisible                       = FALSE;
    }
}

/*
 Increment  Time or Weight or Rep labels by 10
 */
- (void)plusTimeWeightRepby10:(id)sender
{
    [UILabel incrementBy10OnLabelOne:self.beforeFirstTimeWeightLabel LabelTwo:self.firstTimeWeightLabel  LabelThree:self.secondTimeWeightLabel LabelFour:self.thirdTimeWeightLabel LabelFive:self.afterThirdTimeWeightLabel];
}

/*
 Decrement Time or Weight or Rep labels by 10
 */
- (void)minusTimeWeightRepby10:(id)sender
{
    if ([self.secondTimeWeightLabel.text intValue] > 5) {
        [UILabel decrementBy10OnLabelOne:self.beforeFirstTimeWeightLabel LabelTwo:self.firstTimeWeightLabel  LabelThree:self.secondTimeWeightLabel LabelFour:self.thirdTimeWeightLabel LabelFive:self.afterThirdTimeWeightLabel];
    }
}

/*
 Increment or Decrement time weight value
 */
- (int)incrementOrDecrement:(NSString *)incrementOrDecrement WeightTimeValue:(UILabel *)label
{
    int value                               = [label.text intValue];
    
    if ([incrementOrDecrement isEqualToString:@"Left"]) {
        if (label.frame.origin.x == self.m_afterThirdFrame.origin.x) {
            if ([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Weight"]) {
                value                       = value + 25;
            }
            else if (([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Repitition"]) || ([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Time"])) {
                value                       = value + 5;
            }
        }
        else if (label.frame.origin.x == self.m_beforeFirstFrame.origin.x) {
            self.m_beforeFirstWeightLabel        = value;
        }
    }
    else if([incrementOrDecrement isEqualToString:@"Right"]) {
        if (label.frame.origin.x == self.m_beforeFirstFrame.origin.x) {
            if ([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Weight"]) {
                value                       = value - 25;
                self.m_beforeFirstWeightLabel    = value;
            }
            else if (([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Repitition"]) || ([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Time"])) {
                value                       = value - 5;
                self.m_beforeFirstWeightLabel    = value;
            }
        }
    }
    
    // Get the selected Weight or Time
    if (label.frame.origin.x == self.m_secondFrame.origin.x) {
        self.m_selectedWeightTimeRepitition                = [label.text intValue];
    }
    
    return value;
}

/*
 Increment or Decrement time weight value
 */
- (int)incrementOrDecrement:(NSString *)incrementOrDecrement DifficultyRepValue:(UILabel *)label
{
    int value                               = [label.text intValue];
    
    if ([incrementOrDecrement isEqualToString:@"Left"]) {
        if (label.frame.origin.x == self.m_afterThirdDifficultyRepFrame.origin.x) {
            value                           = value + 5;
        }
        else if (label.frame.origin.x == self.m_beforeFirstDifficultyRepFrame.origin.x) {
            self.m_beforeFirstDifficultyRepLabel = value;
        }
    }
    else if([incrementOrDecrement isEqualToString:@"Right"]) {
        if (label.frame.origin.x == self.m_beforeFirstDifficultyRepFrame.origin.x) {
            value                           = value - 5;
            self.m_beforeFirstDifficultyRepLabel = value;
        }
    }
    
    // Get the selected Difficulty / Rep
    if (label.frame.origin.x == self.m_secondDifficultyRepFrame.origin.x) {
        self.m_selectedDifficultyRep             = [label.text intValue];
    }
    
    return value;
}

/*
 Animate using the three visible labels as well as the two invisible labels
 */
- (void)animateLeftOrRight:(NSString *)leftOrRight DifficultyRepLabel:(UILabel *)label
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration: 0.25];
    
    if ([leftOrRight isEqualToString:@"Left"]) {
        if (label.frame.origin.x == self.m_beforeFirstDifficultyRepFrame.origin.x) {
            label.frame            = self.m_afterThirdDifficultyRepFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == self.m_firstDifficultyRepFrame.origin.x) {
            label.frame            = self.m_beforeFirstDifficultyRepFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == self.m_secondDifficultyRepFrame.origin.x) {
            label.frame            = self.m_firstDifficultyRepFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == self.m_thirdDifficultyRepFrame.origin.x) {
            label.frame            = self.m_secondDifficultyRepFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor redColor];
        }
        else if(label.frame.origin.x == self.m_afterThirdDifficultyRepFrame.origin.x) {
            label.frame            = self.m_thirdDifficultyRepFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor darkGrayColor];
        }
        [UIView commitAnimations];
        
        // Change the before first value
        label.text             = [NSString stringWithFormat:@"%d", [self incrementOrDecrement:@"Left" DifficultyRepValue:label]];
    }
    else if ([leftOrRight isEqualToString:@"Right"]) {
        if(label.frame.origin.x == self.m_beforeFirstDifficultyRepFrame.origin.x) {
            label.frame            = self.m_firstDifficultyRepFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if (label.frame.origin.x == self.m_afterThirdDifficultyRepFrame.origin.x) {
            label.frame            = self.m_beforeFirstDifficultyRepFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == self.m_thirdDifficultyRepFrame.origin.x) {
            label.frame            = self.m_afterThirdDifficultyRepFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == self.m_secondDifficultyRepFrame.origin.x) {
            label.frame            = self.m_thirdDifficultyRepFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == self.m_firstDifficultyRepFrame.origin.x) {
            label.frame            = self.m_secondDifficultyRepFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor redColor];
        }
        [UIView commitAnimations];
        
        // Change the before first value
        label.text             = [NSString stringWithFormat:@"%d", [self incrementOrDecrement:@"Right" DifficultyRepValue:label]];
    }
}

/*
 Animate using the three visible labels as well as the two invisible labels
 */
- (void)animateLeftOrRight:(NSString *)leftOrRight TimeWeightLabel:(UILabel *)label
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration: 0.25];
    
    if ([leftOrRight isEqualToString:@"Left"]) {
        if (label.frame.origin.x == self.m_beforeFirstFrame.origin.x) {
            label.frame            = self.m_afterThirdFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == self.m_firstFrame.origin.x) {
            label.frame            = self.m_beforeFirstFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == self.m_secondFrame.origin.x) {
            label.frame            = self.m_firstFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == self.m_thirdFrame.origin.x) {
            label.frame            = self.m_secondFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor redColor];
        }
        else if(label.frame.origin.x == self.m_afterThirdFrame.origin.x) {
            label.frame            = self.m_thirdFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor darkGrayColor];
        }
        [UIView commitAnimations];
        
        // Change the before first value
        label.text             = [NSString stringWithFormat:@"%d", [self incrementOrDecrement:@"Left" WeightTimeValue:label]];
    }
    else if ([leftOrRight isEqualToString:@"Right"]) {
        if(label.frame.origin.x == self.m_beforeFirstFrame.origin.x) {
            label.frame            = self.m_firstFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if (label.frame.origin.x == self.m_afterThirdFrame.origin.x) {
            label.frame            = self.m_beforeFirstFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == self.m_thirdFrame.origin.x) {
            label.frame            = self.m_afterThirdFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == self.m_secondFrame.origin.x) {
            label.frame            = self.m_thirdFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == self.m_firstFrame.origin.x) {
            label.frame            = self.m_secondFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor redColor];
        }
        [UIView commitAnimations];
        
        // Change the before first value
        label.text             = [NSString stringWithFormat:@"%d", [self incrementOrDecrement:@"Right" WeightTimeValue:label]];
    }
}

/*
 Animate left time weight rep labels
 */
- (void)animateLeftTimeWeightRepLabels
{
    // Animate the first label
    [self animateLeftOrRight:@"Left" TimeWeightLabel:self.firstTimeWeightLabel];
    // Animate the second label
    [self animateLeftOrRight:@"Left" TimeWeightLabel:self.secondTimeWeightLabel];
    // Animate the third label
    [self animateLeftOrRight:@"Left" TimeWeightLabel:self.thirdTimeWeightLabel];
    // Animate after third label
    [self animateLeftOrRight:@"Left" TimeWeightLabel:self.afterThirdTimeWeightLabel];
    // Animate before first label, do this last to get the value from the label to be used to check if it is zero
    [self animateLeftOrRight:@"Left" TimeWeightLabel:self.beforeFirstTimeWeightLabel];
}

/*
 Animate right time weight rep labels
 */
-(void)animateRightTimeWeightRepLabels
{
    if(self.m_beforeFirstWeightLabel >= 0) { // If before first label value is less than zero, do nothing
        // Animate first label
        [self animateLeftOrRight:@"Right" TimeWeightLabel:self.firstTimeWeightLabel];
        // Animate second label
        [self animateLeftOrRight:@"Right" TimeWeightLabel:self.secondTimeWeightLabel];
        // Animate third label
        [self animateLeftOrRight:@"Right" TimeWeightLabel:self.thirdTimeWeightLabel];
        // Animate after third label
        [self animateLeftOrRight:@"Right" TimeWeightLabel:self.afterThirdTimeWeightLabel];
        // Animate before first label, do this last to get the value from the label to be used to check if it is zero
        [self animateLeftOrRight:@"Right" TimeWeightLabel:self.beforeFirstTimeWeightLabel];
    }
}

/*
 In response to left or right swipe gesture, to move the next or previous image.
 */
- (IBAction)handleSwipe:(UISwipeGestureRecognizer *)swipeRecognizer
{
    if (swipeRecognizer == self.timeWeightLeftSwipeGesture) {
        
        [self animateLeftTimeWeightRepLabels];
    }
    else if (swipeRecognizer == self.difficultyRepLeftSwipeGesture) {
        
        // Animate the second label
        [self animateLeftOrRight:@"Left" DifficultyRepLabel:self.firstDifficultyRepLabel];
        // Animate the third label
        [self animateLeftOrRight:@"Left" DifficultyRepLabel:self.secondDifficultyRepLabel];
        // Animate after third label
        [self animateLeftOrRight:@"Left" DifficultyRepLabel:self.thirdDifficultyRepLabel];
        [self animateLeftOrRight:@"Left" DifficultyRepLabel:self.afterThirdDifficultyRepLabel];
        // Animate before first label, do this last to get the value from the label to be used to check if it is zero
        [self animateLeftOrRight:@"Left" DifficultyRepLabel:self.beforeFirstDifficultyRepLabel];
    }
    else if (swipeRecognizer == self.timeWeightRightSwipeGesture) {
        
        if(self.m_beforeFirstWeightLabel >= 0) { // If before first label value is less than zero, do nothing
            [self animateRightTimeWeightRepLabels];
        }
    }
    else if (swipeRecognizer == self.difficultyRepRightSwipeGesture) {
        
        if (self.m_beforeFirstDifficultyRepLabel >= 0) { // first value must be zero or more so that selected value cannot be less than 0
            
            // Animate the first label
            // Animate the second label
            [self animateLeftOrRight:@"Right" DifficultyRepLabel:self.firstDifficultyRepLabel];
            // Animate the third label
            [self animateLeftOrRight:@"Right" DifficultyRepLabel:self.secondDifficultyRepLabel];
            // Animate after third label
            [self animateLeftOrRight:@"Right" DifficultyRepLabel:self.thirdDifficultyRepLabel];
            [self animateLeftOrRight:@"Right" DifficultyRepLabel:self.afterThirdDifficultyRepLabel];
            // Animate before first label, do this last to get the value from the label to be used to check if it is zero
            [self animateLeftOrRight:@"Right" DifficultyRepLabel:self.beforeFirstDifficultyRepLabel];
        }
    }
}

/*
 Capatalized first letter of each food name's words
 */
- (NSString *)capatalizeFirstLetterOfWordsOfExerciseName:(NSString *)initialExerciseName
{
    NSString *firstCharCapatalized             = @"";
    NSArray *exerciseNameArray                  = [initialExerciseName componentsSeparatedByString:@" "];
    NSString *subExerciseName                   = @"";
    // Make sure each word in the exercise have first letter capatalized
    for (NSString *subString in exerciseNameArray) {
        firstCharCapatalized                    = [[subString substringToIndex:1] capitalizedString];
        
        subExerciseName                         = [NSString stringWithFormat:@"%@ %@",subExerciseName, [subString stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:firstCharCapatalized]];
    }
    return subExerciseName;
}

/*
 Load up the exercise description from plist
 */
- (void)loadUpExerciseDescriptionFromPlistUsingExerciseImageName:(NSString *)exerciseImageNameString
{
    NSString *underscore                    = @"_";
    // Remove underscore from the image name
    self.m_exerciseDescriptionPlist              = [exerciseImageNameString stringByReplacingOccurrencesOfString:underscore withString:@" "];
    self.m_exerciseDescriptionPlist              = [self.m_exerciseDescriptionPlist stringByReplacingOccurrencesOfString:@" male thumb" withString:@""]; // Remove male thumb
    self.m_exerciseDescriptionPlist              = [self.m_exerciseDescriptionPlist stringByReplacingOccurrencesOfString:@" female thumb" withString:@""]; // Remove female thumb
    // Then remove the .png image extensions, we get the name of the exercise
    self.m_exerciseDescriptionPlist              = [self.m_exerciseDescriptionPlist stringByReplacingOccurrencesOfString:@".png" withString:@""]; // Remove .png
    
    // Display exercise name with first letter of the each words capatalized
    self.self.exerciseNameLabel.text             = [self removeWhiteSpaceBeforeFirstWord:[self capatalizeFirstLetterOfWordsOfExerciseName:self.m_exerciseDescriptionPlist]];
    
    // save exercise name
    self.m_exerciseNameDisplayed                 = self.exerciseNameLabel.text;
    
    // Change it back to lowercase to retrive the related plist
    self.m_exerciseDescriptionPlist              = [self.m_exerciseDescriptionPlist lowercaseString];
    if ((self.m_exerciseDescriptionPlist != NULL) && (self.m_exerciseDescriptionPlist.length != 0)) {
        // Load dictionary from the plist having same image name
        self.m_workoutDescriptionDictionary      = nil;
        
        if (!self.m_workoutDescriptionDictionary) {
            self.m_workoutDescriptionDictionary  = [[NSMutableDictionary alloc] init];
        }
        self.m_workoutDescriptionDictionary      = [self.m_workoutSelection loadUpPlist:[self.m_exerciseDescriptionPlist lowercaseString]];
    }
    [self addExerciseDescriptions:self.m_workoutDescriptionDictionary];
}

/*
 Use previous view's selected image name to food image and choosing the right food exercise description
 */
- (void)loadExerciseImagesAndDescription
{
    if (!self.m_workoutDescriptionDictionary) {
        self.m_workoutDescriptionDictionary      = [[NSMutableDictionary alloc] init];
    }
    if (!self.m_workoutSelection) {
        self.m_workoutSelection                  = [WorkoutSelection  sharedInstance];
    }
    if (!self.m_calenderViewController) {
        self.m_calenderViewController            = [CalenderViewController sharedInstance];
    }
    if (!self.m_mealViewController) {
        self.m_mealViewController                = [MealViewController sharedInstance];
    }
    if (!self.m_exerciseViewController) {
        self.m_exerciseViewController            = [ExerciseViewController sharedInstance];
    }
    if (!self.m_exerciseListViewController) {
        self.m_exerciseListViewController        = [ExerciseListViewController sharedInstance];
    }
    
    // Present image for the exercise imageView
    if ([self.m_calenderViewController.selectedImage length] != 0) {
        self.m_exerciseImageNameString                       = [NSString stringWithFormat:@"%@.png", self.m_calenderViewController.selectedImage];
        self.m_calenderViewController.selectedImage          = nil;
    }
    else if([self.m_exerciseViewController.selectedImage length] != 0) { // If coming from ExerciseViewController's view
        self.m_exerciseImageNameString                       = [NSString stringWithFormat:@"%@.png", self.m_exerciseViewController.selectedImage];
        self.m_exerciseViewController.selectedImage          = nil;
    }
    else if([self.m_exerciseListViewController.selectedImage length] != 0) { // if coming from ExerciseListViewController's view
        self.m_exerciseImageNameString                       = [NSString stringWithFormat:@"%@.png", self.m_exerciseListViewController.selectedImage];
        self.m_exerciseListViewController.selectedImage      = nil;
    }
    
    // Position the images properly
    [self showExerciseImage:self.m_exerciseImageNameString];
    
    // load up Exercise description from plist
    [self loadUpExerciseDescriptionFromPlistUsingExerciseImageName:self.m_exerciseImageNameString];
}

/*
 Get Average of weekly data
 */
- (void)getAverageFromWeeklyData:(NSMutableArray *)weeklyReportData
{
    int theweight                                 = 0;
    int therep                                    = 0;
    if (weeklyReportData) {
        NSUInteger totalNumberOfItemsInDataForGraph      = [weeklyReportData count];
        int averageWeight                         = 0;
        int averageRep                            = 0;
        if (totalNumberOfItemsInDataForGraph) {
            if ([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Weight"]) {
                for (int i = 0; i < totalNumberOfItemsInDataForGraph; i = i+2) {
                    theweight          += [[weeklyReportData objectAtIndex:i]intValue];
                    
                    therep             += [[weeklyReportData objectAtIndex:i+1] intValue];
                }
                averageWeight                     = theweight/(totalNumberOfItemsInDataForGraph/2);
                averageRep                        = therep/(totalNumberOfItemsInDataForGraph/2);
            }
            else {
                for (int i = 0; i < totalNumberOfItemsInDataForGraph; i++) {
                    if ([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Time"]) {
                        theweight          += [[weeklyReportData objectAtIndex:i]intValue];
                        averageWeight                     = theweight/(totalNumberOfItemsInDataForGraph/2);
                    }
                    else if ([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Repitition"]) {
                        therep             += [[weeklyReportData objectAtIndex:i] intValue];
                    }
                }
                averageRep                        = therep/totalNumberOfItemsInDataForGraph;
            }
            [self.m_weightArray addObject:[NSNumber numberWithInt:averageWeight]];
            [self.m_repArray addObject:[NSNumber numberWithInt:averageRep]];
        }
    }
}

/*
 Initial week increment, called only once
 */
- (int)incrementByTheDayOfTheWeek:(NSInteger)weekday
{
    if(weekday == 1) { // Today is the sunday of the week
        self.m_decrementWeek         = -6;
    }
    else if (weekday == 2) { // Today is the monday of the week
        self.m_decrementWeek         = -5;
    }
    else if(weekday == 3) { // Today is the tuesday of the week
        self.m_decrementWeek         = -4;
    }
    else if(weekday == 4) { // Today is the wedday of the week
        self.m_decrementWeek         = -3;
    }
    else if(weekday == 5) { // Today is the thursday of the week
        self.m_decrementWeek         = -2;
    }
    else if(weekday == 6) { // Today is the fridaday of the week
        self.m_decrementWeek         = -1;
    }
    else if(weekday == 7) { // Today is the saturday of the week
        self.m_decrementWeek         = -0;
    }
    return self.m_decrementWeek;
}

// To avoid crashes due to memory over allocation
- (void)setupDateObjects
{
    // Calender
    if (!self.m_calendar) {
        self.m_calendar                    = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    
    // Today
    if (!self.m_today) {
        self.m_today                       = [NSDate date];
    }
    
    // Date Components
    if (!self.m_components) {
        self.m_components                  = [[NSDateComponents alloc] init];
        self.m_components                  = [self.m_calendar components: NSDayCalendarUnit | NSWeekdayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self.m_today];
    }
    
    // For getting the increment on each week
    if (!self.m_dayComponent) {
        self.m_dayComponent                = [[NSDateComponents alloc] init];
    }
    
    if (!self.m_theCalendar) {
        self.m_theCalendar                 = [NSCalendar currentCalendar];
    }
}

/*
 Get A Week Report each time called
 */
- (void)getWeeklyReport
{
    if (!self.m_weekStartDate) {
        self.m_weekStartDate               = [[NSDate date] init];
    }
    
    if (!self.m_weekEndDate) {
        self.m_weekEndDate                 = [[NSDate alloc] init];
    }
    
    NSInteger weekday               = [self.m_components weekday];
    
    if (!self.m_decrementWeek) {
        // clean up the week decrementor first
        self.m_decrementWeek             = [self incrementByTheDayOfTheWeek:weekday];
    }
    
    // Increment by 7 each time
    self.m_dayComponent.day                = self.m_decrementWeek;
    
    self.m_weekEndDate                   = [self.m_theCalendar dateByAddingComponents:self.m_dayComponent toDate:self.m_weekEndDate options:0];
    
    // drecrement by 7 days for the next week
    self.m_decrementWeek                -= 7;
    // Clean up the report data
    self.m_weeklyReportData              = nil;
    if (!self.m_weeklyReportData) {
        self.m_weeklyReportData          = [NSMutableArray mutableArrayObject];
    }
    
    if ((self.m_weekStartDate) && (self.m_weekEndDate)) {
        self.m_weeklyReportData          = [self.m_database getAverageExerciseReport:self.exerciseNameLabel.text ForAWeek:[NSString getUserEmail] StartDate:self.m_weekStartDate EndDate:self.m_weekEndDate];
        if (self.m_weeklyReportData != nil) {
            // Get average of the data for the week
            [self getAverageFromWeeklyData:self.m_weeklyReportData];
        }
    }
    // start week date for the next week
    self.m_weekStartDate                 = self.m_weekEndDate;
}

/*
 Load up weight and rep data
 */
- (void)loadDataForGraph
{
    // Show the graphview
    self.graphView.hidden                   = NO;
    
    // Initialize to store weight and rep data
    self.m_weightArray                           = nil;
    if (!self.m_weightArray) {
        self.m_weightArray                       = [NSMutableArray mutableArrayObject];
    }
    
    self.m_repArray                              = nil;
    if (!self.m_repArray) {
        self.m_repArray                          = [NSMutableArray mutableArrayObject];
    }
    
    // Clean up the week decrementor
    self.m_decrementWeek                         = 0;
    // Clean up the end week
    self.m_weekEndDate                           = 0;
    // Clean up the start week
    self.m_weekStartDate                         = 0;
    
    // Week's data
    for (int i = 0; i < 7; i++) {
        [self getWeeklyReport];
    }
    
    // Start up the graph
    [self initPlot];
    
    // Hide the rep box
    self.repBox .hidden                     = NO;
    // Show the rep label
    self.repLabel.hidden                    = NO;
    
    [self.graphView addSubview:self.weightBox];
    // Clean up first to avoid crashing when added to view
    [self.weightLabel removeFromSuperview];
    if ([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Weight"]) {
        // Show the weight label
        // Hide the weight box
        self.weightBox.hidden               = NO;
        self.weightLabel.hidden             = NO;
        self.weightLabel.text               = @"Weight";
    }
    else if([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Repitition"]) {
        // Hide the weight label
        // Hide the weight box
        self.weightBox.hidden               = YES;
        self.weightLabel.hidden             = YES;
    }
    else if ([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Time"]) {
        // Make it a time label
        self.weightLabel.text               = @"Time";
        // Hide the weight box
        self.weightBox.hidden               = NO;
        // Hide the rep box
        self.repBox .hidden                 = YES;
        self.weightLabel.hidden             = NO;
        // Show the rep label
        self.repLabel.hidden                = YES;
    }
    
    [self.graphView addSubview:self.weightLabel];
    
    // Clean up first to avoid crashing when added to view
    [self.repBox removeFromSuperview];
    [self.repLabel removeFromSuperview];
    [self.graphView addSubview:self.repBox];
    [self.graphView addSubview:self.repLabel];
    
    // Update the graphView
    [self.graphView setNeedsDisplay];
}

/*
 Go back to the previous view
 */
- (IBAction)goBack:(id)sender
{
    if (!self.m_transition) {
        self.m_transition        = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionFromLeft:self.view.superview];
    [self.view removeFromSuperview];
    
    // Place the below code before moving to supverview, or will crash as we try to work on the view already removed
    if (self.isBigImageVisible) {
        [self showOtherViewsAfterHidingBigImage];
    }
    
}

/*
 Check if exercise is one of those that don't have report or progress
 */
- (bool)checkIfExerciseIsWithoutReportOrProgress:(NSString *)exercise
{
    // Default is "NO"
    bool yesorNo                = NO;
    for (NSString *exerciseIntheList in self.m_exercisesWithoutReportOrProgress) {
        if ([exerciseIntheList isEqualToString:exercise]) {
            yesorNo             = YES;
            return yesorNo  ;
        }
    }
    return yesorNo;
}

/*
 Check if exercise is one of those that don't have report or progress
 */
- (bool)checkIfExerciseIsWithOnlyRepititions:(NSString *)exercise
{
    // Default is "NO"
    bool yesorNo                = NO;
    for (NSString *exerciseIntheList in self.m_exercisesWithOnlyRepititions) {
        if ([exerciseIntheList isEqualToString:exercise]) {
            yesorNo             = YES;
            return yesorNo  ;
        }
    }
    return yesorNo;
}

/*
 Check if exercise is one of those that don't have report or progress
 */
- (bool)checkIfExerciseIsWithOnlyTime:(NSString *)exercise
{
    // Default is "NO"
    bool yesorNo                = NO;
    for (NSString *exerciseIntheList in self.m_exercisesWithOnlyTime) {
        if ([exerciseIntheList isEqualToString:exercise]) {
            yesorNo             = YES;
            return yesorNo  ;
        }
    }
    return yesorNo;
}

/*
 Load up the exercises that should not have report or progress
 */
- (void)loadUpExerciseWithoutReportOrProgress
{
    if (!self.m_exercisesWithoutReportOrProgress) {
        self.m_exercisesWithoutReportOrProgress          = [NSMutableArray mutableArrayObject];
        [self.m_exercisesWithoutReportOrProgress addObject:@"Foam Roll"];
        [self.m_exercisesWithoutReportOrProgress addObject:@"Stretch"];
        [self.m_exercisesWithoutReportOrProgress addObject:@"Basketball"];
        [self.m_exercisesWithoutReportOrProgress addObject:@"Cycling"];
        [self.m_exercisesWithoutReportOrProgress addObject:@"Hockey"];
        [self.m_exercisesWithoutReportOrProgress addObject:@"Rowing"];
        [self.m_exercisesWithoutReportOrProgress addObject:@"Running"];
        [self.m_exercisesWithoutReportOrProgress addObject:@"Skiing"];
        [self.m_exercisesWithoutReportOrProgress addObject:@"Snowboarding"];
        [self.m_exercisesWithoutReportOrProgress addObject:@"Soccer"];
        [self.m_exercisesWithoutReportOrProgress addObject:@"Swimming"];
        [self.m_exercisesWithoutReportOrProgress addObject:@"Tennis"];
        [self.m_exercisesWithoutReportOrProgress addObject:@"Yoga"];
    }
}

/*
 Load up the exercises that only has repititions
 */
- (void)loadUpExerciseWithOnlyRepititions
{
    if (!self.m_exercisesWithOnlyRepititions) {
        self.m_exercisesWithOnlyRepititions          = [NSMutableArray mutableArrayObject];
        [self.m_exercisesWithOnlyRepititions addObject:@"Push Ups"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Narrow Grip Pull Up"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Wide Grip Pull Up"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Mountain Climbers"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Crunches"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Sit Ups"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Ball Hand To Feet"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Burpees"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Body Weight Squats"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Bicycle Crunch"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Bench Dips"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Bench V Sit"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Agility"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Ab Roller"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Ball Roll Ins"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Burpee Push up"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Butt Kicks"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Flutter Kicks"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Half Burpees"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Hanging leg Raises"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Inch Worm Push Up"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Jump Tucks"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Hip Raises"];
        [self.m_exercisesWithOnlyRepititions addObject:@"High Knees"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Jumping Jacks"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Jumping Split Squat"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Knee Abductions"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Laying Windshield Wipers"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Scissor Sit Ups"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Side Plank Hip Raises"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Supermans"];
        [self.m_exercisesWithOnlyRepititions addObject:@"Toe Touches"];
        [self.m_exercisesWithOnlyRepititions addObject:@"V Sit"];
    }
}

/*
 Load up the exercises that only has time
 */
- (void)loadUpExerciseWithOnlyTime
{
    if (!self.m_exercisesWithOnlyTime) {
        self.m_exercisesWithOnlyTime             = [NSMutableArray mutableArrayObject];
        [self.m_exercisesWithOnlyTime addObject:@"Elliptical"];
        [self.m_exercisesWithOnlyTime addObject:@"Plank"];
        [self.m_exercisesWithOnlyTime addObject:@"Side Plank"];
        [self.m_exercisesWithOnlyTime addObject:@"Jog"];
        [self.m_exercisesWithOnlyTime addObject:@"Sprint"];
        [self.m_exercisesWithOnlyTime addObject:@"Swimming"];
        [self.m_exercisesWithOnlyTime addObject:@"Rowing"];
        [self.m_exercisesWithOnlyTime addObject:@"Bike"];
        [self.m_exercisesWithOnlyTime addObject:@"Skip"];
        [self.m_exercisesWithOnlyTime addObject:@"Jogging"];
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
    // Add moveToMusicViewController method to move there
    [self.musicPlayerButton addTarget:self action:@selector(moveToMusicTracksViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    self.exercisePlanButton             = [controlButtonArrays objectAtIndex:2];
    // Add moveToExerciseViewController method to move there
    [self.exercisePlanButton addTarget:self action:@selector(moveToExerciseViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    self.calendarButton                 = [controlButtonArrays objectAtIndex:3];
    // Add CalenderViewController method to move there
    [self.calendarButton addTarget:self action:@selector(moveToCalenderViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    self.mealPlanButton                 = [controlButtonArrays objectAtIndex:4];
    // Add moveToMealViewController method to move there
    [self.mealPlanButton addTarget:self action:@selector(moveToMealViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nutritionPlanButton                     = [controlButtonArrays objectAtIndex:5];
    // Add MoreViewController method to move there
    [self.nutritionPlanButton addTarget:self action:@selector(moveToSupplementsAtWebsite:) forControlEvents:UIControlEventTouchUpInside];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // initialize this
        self.m_exerciseDescriptionPlist      = [[NSString alloc] init];
    }
    return self;
}

/*
 Adjust the height of the views for iphone5 size
 */
- (void)setUpViews
{
    //  Exercises menu images view
    CGRect exerciseDetailsImageViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        exerciseDetailsImageViewFrame               = CGRectMake(0.0f, 282.0f, 320.0f, 75.0f);
    }
    else {
        exerciseDetailsImageViewFrame               = CGRectMake(0.0f, 215.0f, 320.0f, 75.0f);
    }
    exerciseDetailsImageView                        = [[UIImageView alloc] initWithFrame:exerciseDetailsImageViewFrame];
    [self.view addSubview:exerciseDetailsImageView];
    exerciseDetailsImageView.image                  = [UIImage imageNamed:@"tfn_report_active.png"];
    exerciseDetailsImageView.userInteractionEnabled = YES;
    
    // Add Graph View
    [self.graphView removeFromSuperview];
    [self.view addSubview:self.graphView];
    
    //  Exercises menu buttons
    CGRect workoutDescriptionButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        workoutDescriptionButtonFrame                  = CGRectMake(0.0f, 282.0f, 107.0f, 75.0f);
    }
    else {
        workoutDescriptionButtonFrame                  = CGRectMake(0.0f, 215.0f, 107.0f, 75.0f);
    }
    self.workoutDescriptionButton                           = [[UIButton alloc] initWithFrame:workoutDescriptionButtonFrame];
    [self.view addSubview:self.workoutDescriptionButton];
    [self.workoutDescriptionButton addTarget:self action:@selector(showExerciseSections:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect reportButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportButtonFrame                              = CGRectMake(108.0f, 282.0f, 107.0f, 75.0f);
    }
    else {
        reportButtonFrame                              = CGRectMake(108.0f, 215.0f, 107.0f, 75.0f);
    }
    self.reportButton                                       = [[UIButton alloc] initWithFrame:reportButtonFrame];
    [self.view addSubview:self.reportButton];
    [self.reportButton addTarget:self action:@selector(showExerciseSections:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect progressButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        progressButtonFrame                            = CGRectMake(215.0f, 282.0f, 107.0f, 75.0f);
    }
    else {
        progressButtonFrame                            = CGRectMake(215.0f, 215.0f, 107.0f, 75.0f);
    }
    self.progressButton                                     = [[UIButton alloc] initWithFrame:progressButtonFrame];
    [self.view addSubview:self.progressButton];
    [self.progressButton addTarget:self action:@selector(showExerciseSections:) forControlEvents:UIControlEventTouchUpInside];
    
    // Weight, Time, Repitition ImageView
    CGRect reportTimeWeightRepImageViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportTimeWeightRepImageViewFrame              = CGRectMake(0.0f, 353.0f, 320.0f, 182.0f);
    }
    else {
        reportTimeWeightRepImageViewFrame              = CGRectMake(0.0f, 286.0f, 320.0f, 157.0f);
    }
    self.reportTimeWeightRepImageView                       = [[UIImageView alloc] initWithFrame:reportTimeWeightRepImageViewFrame];
    self.reportTimeWeightRepImageView.userInteractionEnabled= YES;
    self.reportTimeWeightRepImageView.multipleTouchEnabled  = YES;
    self.reportTimeWeightRepImageView.image                 = [UIImage imageNamed:@"report_weight_reps.png"];
    [self.view addSubview:self.reportTimeWeightRepImageView];
    
    // Add TimeWeightImageViewMask for gesture recognizing
    CGRect reportTimeWeightImageViewMaskFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportTimeWeightImageViewMaskFrame              = CGRectMake(0.0f, 368.0f, 320.0f, 50.0f);
    }
    else {
        reportTimeWeightImageViewMaskFrame              = CGRectMake(0.0f, 307.0f, 320.0f, 45.0f);
    }
    self.reportTimeWeightImageViewMask                       = [[UIImageView alloc] initWithFrame:reportTimeWeightImageViewMaskFrame];
    self.reportTimeWeightImageViewMask.userInteractionEnabled   = YES;
    [self.view addSubview:self.reportTimeWeightImageViewMask];
    self.timeWeightLeftSwipeGesture                                           = nil;
    self.timeWeightRightSwipeGesture                                          = nil;
    
    // Add left swipe gesture
    UISwipeGestureRecognizer *timeWeightLeftSwipeGestureLocal                 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [timeWeightLeftSwipeGestureLocal setDirection:UISwipeGestureRecognizerDirectionLeft];
    self.timeWeightLeftSwipeGesture             = timeWeightLeftSwipeGestureLocal;
    [self.reportTimeWeightImageViewMask addGestureRecognizer:self.timeWeightLeftSwipeGesture];
    
    // Add right swipe gesture
    UISwipeGestureRecognizer *timeWeightRightSwipeGestureLocal                = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [timeWeightRightSwipeGestureLocal setDirection:UISwipeGestureRecognizerDirectionRight];
    self.timeWeightRightSwipeGesture            = timeWeightRightSwipeGestureLocal;
    [self.reportTimeWeightImageViewMask addGestureRecognizer:self.timeWeightRightSwipeGesture];
    
    
    CGRect minusTimeWeightRepButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        minusTimeWeightRepButtonFrame              = CGRectMake(0.0f, 381.0f, 33.0f, 50.0f);
    }
    else {
        minusTimeWeightRepButtonFrame              = CGRectMake(0.0f, 286.0f, 33.0f, 157.0f);
    }
    self.m_minusTimeWeightRepButton                      = [[UIButton alloc] initWithFrame:minusTimeWeightRepButtonFrame];
    [self.view addSubview:self.m_minusTimeWeightRepButton];
    [self.m_minusTimeWeightRepButton addTarget:self action:@selector(minusTimeWeightRepby10:) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:self.m_minusTimeWeightRepButton];
    
    CGRect plusTimeWeightRepButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        plusTimeWeightRepButtonFrame              = CGRectMake(287.0f, 381.0f, 33.0f, 50.0f);
    }
    else {
        plusTimeWeightRepButtonFrame              = CGRectMake(287.0f, 286.0f, 33.0f, 157.0f);
    }
    self.m_plusTimeWeightRepButton                      = [[UIButton alloc] initWithFrame:plusTimeWeightRepButtonFrame];
    [self.view addSubview:self.m_plusTimeWeightRepButton];
    [self.m_plusTimeWeightRepButton addTarget:self action:@selector(plusTimeWeightRepby10:) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:self.m_plusTimeWeightRepButton];
    
    // before first time weight label
    CGRect beforeFirstTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        beforeFirstTimeWeightLabelFrame         = CGRectMake(20.0f, 396.0f, 40.0f, 20.0f);
    }
    else {
        beforeFirstTimeWeightLabelFrame         = CGRectMake(20.0f, 322.0f, 40.0f, 20.0f);
    }
    self.beforeFirstTimeWeightLabel                  = [[UILabel alloc] initWithFrame:beforeFirstTimeWeightLabelFrame];
    self.beforeFirstTimeWeightLabel.font             = [UIFont customFontWithSize:20];
    self.beforeFirstTimeWeightLabel.backgroundColor  = [UIColor clearColor];
    self.beforeFirstTimeWeightLabel.tintColor        = [UIColor darkGrayColor];
    // Helps when there is only a single digit value
//    self.beforeFirstTimeWeightLabel.textAlignment    = NSTextAlignmentCenter;
    self.beforeFirstTimeWeightLabel.hidden           = YES;
    [self.view addSubview:self.beforeFirstTimeWeightLabel];
    
    // first time weight label
    CGRect firstTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        firstTimeWeightLabelFrame               = CGRectMake(65.0f, 396.0f, 40.0f, 20.0f);
    }
    else {
        firstTimeWeightLabelFrame               = CGRectMake(65.0f, 322.0f, 40.0f, 20.0f);
    }
    self.firstTimeWeightLabel                        = [[UILabel alloc] initWithFrame:firstTimeWeightLabelFrame];
    self.firstTimeWeightLabel.font                   = [UIFont customFontWithSize:20];
    self.firstTimeWeightLabel.backgroundColor        = [UIColor clearColor];
    self.firstTimeWeightLabel.textColor              = [UIColor darkGrayColor];
    [self.view addSubview:self.firstTimeWeightLabel];
    // Helps when there is only a single digit value
    self.firstTimeWeightLabel.textAlignment          = NSTextAlignmentCenter;
    
    // second time weight label
    CGRect secondTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        secondTimeWeightLabelFrame              = CGRectMake(140.0f, 396.0f, 40.0f, 20.0f);
    }
    else {
        secondTimeWeightLabelFrame              = CGRectMake(140.0f, 322.0f, 40.0f, 20.0f);
    }
    self.secondTimeWeightLabel                       = [[UILabel alloc] initWithFrame:secondTimeWeightLabelFrame];
    self.secondTimeWeightLabel.font                  = [UIFont customFontWithSize:20];
    self.secondTimeWeightLabel.backgroundColor       = [UIColor clearColor];
    self.secondTimeWeightLabel.textColor             = [UIColor redColor];
    [self.view addSubview:self.secondTimeWeightLabel];
    // Helps when there is only a single digit value
    self.secondTimeWeightLabel.textAlignment         = NSTextAlignmentCenter;
    
    // third time weight label
    CGRect thirdTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        thirdTimeWeightLabelFrame               = CGRectMake(210.0f, 396.0f, 40.0f, 20.0f);
    }
    else {
        thirdTimeWeightLabelFrame               = CGRectMake(210.0f, 322.0f, 40.0f, 20.0f);
    }
    self.thirdTimeWeightLabel                        = [[UILabel alloc] initWithFrame:thirdTimeWeightLabelFrame];
    self.thirdTimeWeightLabel.font                   = [UIFont customFontWithSize:20];
    self.thirdTimeWeightLabel.backgroundColor        = [UIColor clearColor];
    self.thirdTimeWeightLabel.textColor              = [UIColor darkGrayColor];
    [self.view addSubview:self.thirdTimeWeightLabel];
    // Helps when there is only a single digit value
    self.thirdTimeWeightLabel.textAlignment          = NSTextAlignmentCenter;
    
    // before third time weight label
    CGRect afterThirdTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        afterThirdTimeWeightLabelFrame          = CGRectMake(255.0f, 396.0f, 40.0f, 20.0f);
    }
    else {
        afterThirdTimeWeightLabelFrame          = CGRectMake(255.0f, 322.0f, 40.0f, 20.0f);
    }
    self.afterThirdTimeWeightLabel                   = [[UILabel alloc] initWithFrame:afterThirdTimeWeightLabelFrame];
    self.afterThirdTimeWeightLabel.font              = [UIFont customFontWithSize:20];
    self.afterThirdTimeWeightLabel.backgroundColor   = [UIColor clearColor];
    self.afterThirdTimeWeightLabel.textColor         = [UIColor darkGrayColor];
    // Helps when there is only a single digit value
    self.afterThirdTimeWeightLabel.textAlignment     = NSTextAlignmentCenter;
    self.afterThirdTimeWeightLabel.hidden            = YES;
    [self.view addSubview:self.afterThirdTimeWeightLabel];
    
    CGRect reportDifficultyRepImageViewMaskFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportDifficultyRepImageViewMaskFrame   = CGRectMake(0.0f, 457.0f, 195.0f, 50.0f);
    }
    else {
        reportDifficultyRepImageViewMaskFrame   = CGRectMake(5.0f, 376.0f, 190.0f, 50.0f);
    }
    self.reportDifficultyRepImageViewMask            = [[UIImageView alloc] initWithFrame:reportDifficultyRepImageViewMaskFrame];
    self.reportDifficultyRepImageViewMask.userInteractionEnabled    = YES;
    self.reportDifficultyRepImageViewMask.multipleTouchEnabled      = YES;
    [self.view addSubview:self.reportDifficultyRepImageViewMask];
    self.difficultyRepLeftSwipeGesture                                        = nil;
    self.difficultyRepRightSwipeGesture                                       = nil;
    // Add left swipe gesture
    UISwipeGestureRecognizer *difficultyRepLeftSwipeGestureLocal              = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [difficultyRepLeftSwipeGestureLocal setDirection:UISwipeGestureRecognizerDirectionLeft];
    self.difficultyRepLeftSwipeGesture                                        = difficultyRepLeftSwipeGestureLocal;
    [self.reportDifficultyRepImageViewMask addGestureRecognizer:self.difficultyRepLeftSwipeGesture];
    
    // Add right swipe gesture
    UISwipeGestureRecognizer *difficultyRepRightSwipeGestureLocal             = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [difficultyRepRightSwipeGestureLocal setDirection:UISwipeGestureRecognizerDirectionRight];
    self.difficultyRepRightSwipeGesture                                       = difficultyRepRightSwipeGestureLocal;
    [self.reportDifficultyRepImageViewMask addGestureRecognizer:self.difficultyRepRightSwipeGesture];
    
    // before first difficulty rep label
    CGRect beforeFirstDifficultyRepLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        beforeFirstDifficultyRepLabelFrame        = CGRectMake(0.0f, 480.0f, 30.0f, 20.0f);
    }
    else {
        beforeFirstDifficultyRepLabelFrame        = CGRectMake(0.0f, 395.0f, 30.0f, 20.0f);
    }
    self.beforeFirstDifficultyRepLabel                 = [[UILabel alloc] initWithFrame:beforeFirstDifficultyRepLabelFrame];
    self.beforeFirstDifficultyRepLabel.text            = @"4";
    self.beforeFirstDifficultyRepLabel.font            = [UIFont customFontWithSize:20];
    self.beforeFirstDifficultyRepLabel.backgroundColor = [UIColor clearColor];
    self.beforeFirstDifficultyRepLabel.textColor       = [UIColor darkGrayColor];
    // Helps when there is only a single digit value
    self.beforeFirstDifficultyRepLabel.textAlignment   = NSTextAlignmentCenter;
    self.beforeFirstDifficultyRepLabel.hidden          = YES;
    [self.view addSubview:self.beforeFirstDifficultyRepLabel];
    
    // first difficulty rep label
    CGRect firstDifficultyRepLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        firstDifficultyRepLabelFrame              = CGRectMake(33.0f, 480.0f, 30.0f, 20.0f);
    }
    else {
        firstDifficultyRepLabelFrame              = CGRectMake(33.0f, 395.0f, 30.0f, 20.0f);
    }
    self.firstDifficultyRepLabel                       = [[UILabel alloc] initWithFrame:firstDifficultyRepLabelFrame];
    self.firstDifficultyRepLabel.text                  = @"5";
    self.firstDifficultyRepLabel.font                  = [UIFont customFontWithSize:20];
    self.firstDifficultyRepLabel.backgroundColor       = [UIColor clearColor];
    self.firstDifficultyRepLabel.textColor             = [UIColor darkGrayColor];
    // Helps when there is only a single digit value
    self.firstDifficultyRepLabel.textAlignment         = NSTextAlignmentCenter;
    [self.view addSubview:self.firstDifficultyRepLabel];
    
    // second difficulty rep label
    CGRect secondDifficultyRepLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        secondDifficultyRepLabelFrame              = CGRectMake(88.0f, 480.0f, 30.0f, 20.0f);
    }
    else {
        secondDifficultyRepLabelFrame              = CGRectMake(88.0f, 395.0f, 30.0f, 20.0f);
    }
    self.secondDifficultyRepLabel                       = [[UILabel alloc] initWithFrame:secondDifficultyRepLabelFrame];
    self.secondDifficultyRepLabel.text                  = @"6";
    self.secondDifficultyRepLabel.font                  = [UIFont customFontWithSize:20];
    self.secondDifficultyRepLabel.backgroundColor       = [UIColor clearColor];
    self.secondDifficultyRepLabel.textColor              = [UIColor redColor];
    // Helps when there is only a single digit value
    self.secondDifficultyRepLabel.textAlignment         = NSTextAlignmentCenter;
    [self.view addSubview:self.secondDifficultyRepLabel];
    
    // third difficulty rep label
    CGRect thirdDifficultyRepLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        thirdDifficultyRepLabelFrame              =  CGRectMake(143.0f, 480.0f, 30.0f, 20.0f);
    }
    else {
        thirdDifficultyRepLabelFrame              =  CGRectMake(143.0f, 395.0f, 30.0f, 20.0f);
    }
    self.thirdDifficultyRepLabel                       = [[UILabel alloc] initWithFrame:thirdDifficultyRepLabelFrame];
    self.thirdDifficultyRepLabel.text                  = @"7";
    self.thirdDifficultyRepLabel.font                  = [UIFont customFontWithSize:20];
    self.thirdDifficultyRepLabel.backgroundColor       = [UIColor clearColor];
    self.thirdDifficultyRepLabel.textColor             = [UIColor darkGrayColor];
    // Helps when there is only a single digit value
    self.thirdDifficultyRepLabel.textAlignment         = NSTextAlignmentCenter;
    [self.view addSubview:self.thirdDifficultyRepLabel];
    
    // ninth difficulty rep label
    CGRect afterThirdDifficultyRepLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        afterThirdDifficultyRepLabelFrame          = CGRectMake(175.0f, 480.0f, 30.0f, 20.0f);
    }
    else {
        afterThirdDifficultyRepLabelFrame          = CGRectMake(175.0f, 395.0f, 30.0f, 20.0f);
    }
    self.afterThirdDifficultyRepLabel                   = [[UILabel alloc] initWithFrame:afterThirdDifficultyRepLabelFrame];
    self.afterThirdDifficultyRepLabel.text              = @"8";
    self.afterThirdDifficultyRepLabel.font              = [UIFont customFontWithSize:20];
    self.afterThirdDifficultyRepLabel.backgroundColor   = [UIColor clearColor];
    self.afterThirdDifficultyRepLabel.textColor         = [UIColor darkGrayColor];
    // Helps when there is only a single digit value
    self.afterThirdDifficultyRepLabel.textAlignment     = NSTextAlignmentCenter;
    self.afterThirdDifficultyRepLabel.hidden            = YES;
    [self.view addSubview:self.afterThirdDifficultyRepLabel];
    
    CGRect reportWeightRepNextDoneButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportWeightRepNextDoneButtonFrame         = CGRectMake(205.0f, 467.0f, 110.0f, 45.0f);
    }
    else {
        reportWeightRepNextDoneButtonFrame         = CGRectMake(205.0f, 379.0f, 110.0f, 45.0f);
    }
    self.reportWeightRepNextDoneButton                  = [[UIButton alloc] initWithFrame:reportWeightRepNextDoneButtonFrame];
    [self.view addSubview:self.reportWeightRepNextDoneButton];
    [self.reportWeightRepNextDoneButton addTarget:self action:@selector(saveReport:) forControlEvents:UIControlEventTouchUpInside];
    
    // Add Time Save Report Button
    CGRect reportTimeDoneButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportTimeDoneButtonFrame                  = CGRectMake(143.0f, 441.0f, 170.0f, 45.f);
    }
    else {
        reportTimeDoneButtonFrame                  = CGRectMake(143.0f, 355.0f, 170.0f, 45.f);
    }
    self.reportTimeNextDoneButton                       = [[UIButton alloc] initWithFrame:reportTimeDoneButtonFrame];
    [self.reportTimeNextDoneButton addTarget:self action:@selector(saveReport:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.reportTimeNextDoneButton];
    
    CGRect reportRepNextDoneButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportRepNextDoneButtonFrame               = CGRectMake(10.0f, 462.0f, 300.0f, 45.0f);
    }
    else {
        reportRepNextDoneButtonFrame               = CGRectMake(10.0f, 375.0f, 300.0f, 45.0f);
    }
    self.reportRepNextDoneButton                        = [[UIButton alloc] initWithFrame:reportRepNextDoneButtonFrame];
    [self.view addSubview:self.reportRepNextDoneButton];
    [self.reportRepNextDoneButton addTarget:self action:@selector(saveReport:) forControlEvents:UIControlEventTouchUpInside];
    
    // Add set name label
    CGRect setNameLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        setNameLabelFrame                          = CGRectMake(30.0f, 440.0f, 40.0f, 50.0f);
    }
    else {
        setNameLabelFrame                          = CGRectMake(30.0f, 360.0f, 40.0f, 50.0f);
    }
    self.setNameLabel                                   = [[UILabel alloc] initWithFrame:setNameLabelFrame];
    self.setNameLabel.backgroundColor                   = [UIColor clearColor];
    self.setNameLabel.text                              = @"Sets";
    self.setNameLabel.textColor                         = [UIColor darkGrayColor];
    self.setNameLabel.font                              = [UIFont customFontWithSize:16];
    self.setNameLabel.textAlignment                     = NSTextAlignmentCenter;
    [self.view addSubview:self.setNameLabel];
    
    // Add set number label
    CGRect setNumberLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        setNumberLabelFrame                        = CGRectMake(70.0f, 440.0f, 20, 50);
    }
    else {
        setNumberLabelFrame                        = CGRectMake(70.0f, 360.0f, 20, 50);
    }
    self.setNumberLabel                                 = [[UILabel alloc] initWithFrame:setNumberLabelFrame];
    self.setNumberLabel.backgroundColor                 = [UIColor clearColor];
    self.setNumberLabel.text                            = @"1";
    self.setNumberLabel.textColor                       = [UIColor darkGrayColor];
    self.setNumberLabel.font                            = [UIFont customFontWithSize:16];
    self.setNumberLabel.textAlignment                   = NSTextAlignmentCenter;
    [self.view addSubview:self.setNumberLabel];
    
    // Add set number label
    CGRect setMaxNumberLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        setMaxNumberLabelFrame                     = CGRectMake(82.0f, 440.0f, 20, 50);
    }
    else {
        setMaxNumberLabelFrame                     = CGRectMake(82.0f, 360.0f, 20, 50);
    }
    self.setMaxNumberLabel                              = [[UILabel alloc] initWithFrame:setMaxNumberLabelFrame];
    self.setMaxNumberLabel.backgroundColor              = [UIColor clearColor];
    self.setMaxNumberLabel.text                         = @"/5";
    self.setMaxNumberLabel.textColor                    = [UIColor darkGrayColor];
    self.setMaxNumberLabel.font                         = [UIFont customFontWithSize:16];
    self.setMaxNumberLabel.textAlignment                = NSTextAlignmentCenter;
    [self.view addSubview:self.setMaxNumberLabel];
    
    // Content Text View height adjusted
    CGRect  contentsTextViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        contentsTextViewFrame                       = CGRectMake(0.0f, 352.0f, 320.0f, 152.0f);
    }
    else {
        contentsTextViewFrame                       = CGRectMake(0.0f, 285.0f, 320.0f, 140.0f);
    }
    self.contentsTextView                           = [[UITextView alloc] initWithFrame:contentsTextViewFrame];
    self.contentsTextView.textColor                 = [UIColor darkGrayColor];
    self.contentsTextView.scrollEnabled             = YES;
    self.contentsTextView.editable                  = NO;
    [self.contentsTextView setFont:[UIFont customFontWithSize:12.0f]];
    [self.view addSubview:self.contentsTextView];
}

/*
 Weight or Time, Rep or Difficult assignments
 */
- (void)loadUpRightImagesAndValues:(UILabel *)label
{
    // Set the image for rep or difficulty
    if ([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Weight"]) {
        // Weights values
        NSString *beforeFirstLabelWeight;
        NSString *firstLabelWeight;
        NSString *secondLabelWeight;
        NSString *thirdLabelWeight;
        NSString *afterThirdLabelWeight;
        
        if ([self.m_gender isEqualToString:@"Male"]) { // if male
            beforeFirstLabelWeight                   = @"0";
            firstLabelWeight                         = @"5";
            secondLabelWeight                        = @"10";
            thirdLabelWeight                         = @"15";
            afterThirdLabelWeight                    = @"20";
        }
        else if([self.m_gender isEqualToString:@"Female"]) { // if female
            beforeFirstLabelWeight                   = @"0";
            firstLabelWeight                         = @"5";
            secondLabelWeight                        = @"10";
            thirdLabelWeight                         = @"15";
            afterThirdLabelWeight                    = @"20";
        }
        
        // Assign values for the labels
        self.m_beforeFirstWeightLabel                     = beforeFirstLabelWeight;
        
        if (label.frame.origin.x == self.m_beforeFirstFrame.origin.x) {
            label.text                               = beforeFirstLabelWeight;
        }
        else if(label.frame.origin.x == self.m_firstFrame.origin.x) {
            label.text                               = firstLabelWeight;
        }
        else if(label.frame.origin.x == self.m_secondFrame.origin.x) {
            label.text                               = secondLabelWeight;
        }
        else if(label.frame.origin.x == self.m_thirdFrame.origin.x) {
            label.text                               = thirdLabelWeight;
        }
        else if(label.frame.origin.x == self.m_afterThirdFrame.origin.x) {
            label.text                               = afterThirdLabelWeight;
        }
        // Default weight value
        self.m_selectedWeightTimeRepitition               = [secondLabelWeight intValue];
        // Default rep value is 8
        self.m_selectedDifficultyRep                      = 7;
    }
    else if (([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Repitition"]) || ([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Time"])) {
        // Assign values for the labels
        if (label.frame.origin.x == self.m_beforeFirstFrame.origin.x) {
            label.text                               = @"6";
        }
        else if(label.frame.origin.x == self.m_firstFrame.origin.x) {
            label.text                               = @"7";
        }
        else if(label.frame.origin.x == self.m_secondFrame.origin.x) {
            label.text                               = @"8";
            // Default time
            self.m_selectedWeightTimeRepitition           = [label.text intValue];
        }
        else if(label.frame.origin.x == self.m_thirdFrame.origin.x) {
            label.text                               = @"9";
        }
        else if(label.frame.origin.x == self.m_afterThirdFrame.origin.x) {
            label.text                               = @"10";
        }
    }
}

/*
 Set up right image for the exercise report
 */
- (void)setUpRightImagesForExerciseReport
{
    // load up the exercises with repitition and time images
    [self loadUpExerciseWithOnlyRepititions];
    [self loadUpExerciseWithOnlyTime];
    
    // Check exercise name to decide the image display
    if ([self checkIfExerciseIsWithOnlyRepititions:self.m_exerciseNameDisplayed]) {
        self.reportTimeWeightRepImageView.image        = [UIImage imageNamed:@"report_reps"];
        self.m_weightOrTimeOrRepititionImage           = @"Repitition";
        self.reportDifficultyRepImageViewMask.hidden   = YES;
        self.reportWeightRepNextDoneButton.hidden      = YES;
        self.reportRepNextDoneButton.hidden            = NO;
        self.reportTimeNextDoneButton.hidden           = YES;
        [self hideRepDetails];
    }
    else if([self checkIfExerciseIsWithOnlyTime:self.m_exerciseNameDisplayed]) {
        self.reportTimeWeightRepImageView.image        = [UIImage imageNamed:@"report_time"];
        self.m_weightOrTimeOrRepititionImage           = @"Time";
        self.reportDifficultyRepImageViewMask.hidden   = YES;
        [self hideRepDetails];
        self.reportWeightRepNextDoneButton.hidden      = YES;
        self.reportRepNextDoneButton.hidden            = YES;
        self.reportTimeNextDoneButton.hidden           = NO;
    }
    else {
        self.reportTimeWeightRepImageView.image        = [UIImage imageNamed:@"report_weight_reps"];
        self.m_weightOrTimeOrRepititionImage           = @"Weight";
        [self hideRepDetails];
        self.reportWeightRepNextDoneButton.hidden      = NO;
        self.reportRepNextDoneButton.hidden            = YES;
        self.reportTimeNextDoneButton.hidden           = YES;
    }
}

/*
 Set up initial report number labels frame
 */
- (void)setUpInitialReportNumberLabelsFrame
{
    // Number label frames
    self.m_beforeFirstFrame                      = self.beforeFirstTimeWeightLabel.frame;
    self.m_firstFrame                            = self.firstTimeWeightLabel.frame;
    self.m_secondFrame                           = self.secondTimeWeightLabel.frame;
    self.m_thirdFrame                            = self.thirdTimeWeightLabel.frame;
    self.m_afterThirdFrame                       = self.afterThirdTimeWeightLabel.frame;
    
    // Initial frames for the difficulty/rep labels
    self.m_beforeFirstDifficultyRepFrame         = self.beforeFirstDifficultyRepLabel.frame;
    self.m_firstDifficultyRepFrame               = self.firstDifficultyRepLabel.frame;
    self.m_secondDifficultyRepFrame              = self.secondDifficultyRepLabel.frame;
    self.m_thirdDifficultyRepFrame               = self.thirdDifficultyRepLabel.frame;
    self.m_afterThirdDifficultyRepFrame          = self.afterThirdDifficultyRepLabel.frame;
}

- (void)setUpViewToDisplayCorrectReportValues
{
    // if iphone 5 adjust the height
    [self setUpViews];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        CGRect graphViewFrame               = CGRectMake(-15, 353, 350, 190);
        self.graphView                      = [[UIView alloc] initWithFrame:graphViewFrame];
        [self.view addSubview:self.graphView];
    }
    else { // To Remove third label issue of not animating
        // Add Graph View
        [self.graphView removeFromSuperview];
        CGRect frame                        = self.graphView.frame;
        UIView *theGraphView                = [[UIView alloc] initWithFrame:frame];
        self.graphView                      = theGraphView;
        [self.view addSubview:self.graphView];
    }
    
    // set up initial report numbers label frames
    [self setUpInitialReportNumberLabelsFrame];
    
    // set up the control buttons
    [self addSelectorToControlButtons];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor             = [UIColor whiteColor];
    
    // set up the date objects
    [self setupDateObjects];
    
    // Place it here to fix the report value misplacement when coming back
    [self setUpViewToDisplayCorrectReportValues];
    
    // set up initial report values
    [self initialExerciseReportValues];
    
    // start the activity indicator
    [self.activityIndicator startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    // Load up the list of exercise that doesn't have report or progress
    [self loadUpExerciseWithoutReportOrProgress];
    
    // unhide the view
    self.view.hidden                                = NO;
    
    // Default section active is exercise report
    self.m_checkWhichExerciseButtonWasClicked            = @"exerciseReport";
    
    if (!self.m_database) {
        self.m_database                                  = [Database alloc];
    }
    // Get gender of the user
    self.m_gender                                        = [self.m_database getGender:[NSString getUserEmail]];
    
    // Set up food image and show nutrition benefits description
    // place the below method here to update contents when coming back from a different view
    [self loadExerciseImagesAndDescription];
    
    if ([self checkIfExerciseIsWithoutReportOrProgress:self.m_exerciseNameDisplayed]) {
        // Hide exercise report details
        [self hideExerciseReportDetails];
        
        // Exercise progress graph
        [self hideProgress];
        
        // Default section active is exercise report
        self.m_checkWhichExerciseButtonWasClicked            = @"exerciseDescription";
        // Show exercise description
        [self.exerciseDetailsImageView setImage:[UIImage imageNamed:@"tfn_description_active.png"]];
        [self showExerciseDescription];
    }
    else {
        // Set up right image for the report
        [self setUpRightImagesForExerciseReport];
        
        // Show report
        [self showReport];
    }
    
    // Begin detecting device orientation
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    
    [self.messageButton removeFromSuperview];
    self.messageButton.titleLabel.font          = [UIFont customFontWithSize:13];
    self.messageButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messageButton.titleLabel.numberOfLines = 2;
    self.messageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.messageButton];
    [self.messageButton addTarget:self action:@selector(displayMessage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:self.messageButton];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    // Will remove the big image
    self.bigExerciseImageView.image         = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark UIGestureRecognizer Delegate Methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark -
#pragma mark - Chart behavior
-(void)initPlot {
    [self configureHost];
}

-(void)configureHost {
    CGRect frame;
    if ([UIScreen mainScreen].bounds.size.height == 568.0f) {
        frame.origin.x                              = -285.0f;
        frame.origin.y                              = 0.0f;
        frame.size.width                            = 670.0f;
        frame.size.height                           = 290.0f;
    }
    else {
        frame.origin.x                              = -285.0f;
        frame.origin.y                              = 0.0f;
        frame.size.width                            = 670.0f;
        frame.size.height                           = 270.0f;
    }
    
    if (!self.hostView) {
        self.hostView                                   = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:frame];
        self.hostView.allowPinchScaling                 = YES;
        [self.graphView addSubview:self.hostView];
        
        [self configureGraph];
        [self configurePlots];
        [self configureAxes];
    }
}

-(void)configureGraph {
    // 1 - Create the graph
    CPTGraph *graph                                 = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
    //	[graph applyTheme:[CPTTheme themeNamed:kCPTPlainBlackTheme]];
    graph.plotAreaFrame.borderLineStyle             = nil;
    /*CPTColor *graphColor                            = [CPTColor clearColor];
     graph.fill                                      = [CPTFill fillWithColor:graphColor];*/
    self.hostView.hostedGraph                       = graph;
    // 2 - Set graph title
    // 3 - Create and set text style
    CPTMutableTextStyle *titleStyle                 = [CPTMutableTextStyle textStyle];
    titleStyle.color                                = [CPTColor darkGrayColor];
    titleStyle.fontName                             = @"Helvetica-Bold";
    titleStyle.fontSize                             = 16.0f;
    graph.titleTextStyle                            = titleStyle;
    graph.titlePlotAreaFrameAnchor                  = CPTRectAnchorTop;
    graph.titleDisplacement                         = CGPointMake(5.0f, 5.0f);
    // 4 - Set padding for plot area
    [graph.plotAreaFrame setPaddingLeft:15.0f];
    if ([UIScreen mainScreen].bounds.size.height == 568.0f) {
        [graph.plotAreaFrame setPaddingBottom:17.0f];
    }
    else {
        [graph.plotAreaFrame setPaddingBottom:25.0f];
    }
    // 5 - Enable user interactions for plot space
    CPTXYPlotSpace *plotSpace                       = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction                 = YES;
}

-(void)configurePlots {
    // 1 - Get graph and plot space
    CPTGraph *graph                                 = self.hostView.hostedGraph;
    CPTXYPlotSpace *plotSpace                       = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    // 2 - Create the three plots
    CPTScatterPlot *weightPlot                      = [[CPTScatterPlot alloc] init];
    weightPlot.dataSource                           = self;
    weightPlot.identifier                           = CPDTickerSymbolWeight;
    CPTColor *weightColor                           = [CPTColor grayColor];
    [graph addPlot:weightPlot toPlotSpace:plotSpace];
    CPTScatterPlot *repPlot                         = [[CPTScatterPlot alloc] init];
    repPlot.dataSource                              = self;
    repPlot.identifier                              = CPDTickerSymbolRep;
    CPTColor *repColor                              = [CPTColor redColor];
    [graph addPlot:repPlot toPlotSpace:plotSpace];
    // 3 - Set up plot space
    [plotSpace scaleToFitPlots:[NSArray arrayWithObjects:weightPlot, repPlot, nil]];
    CPTMutablePlotRange *xRange                     = [plotSpace.xRange mutableCopy];
    [xRange expandRangeByFactor:CPTDecimalFromCGFloat(16.0f)];
    plotSpace.xRange                                = xRange;
    CPTMutablePlotRange *yRange                     = [plotSpace.yRange mutableCopy];
    if ([self.m_weightArray count] >= 1) {
        if ([UIScreen mainScreen].bounds.size.height == 568.0f) {
            [yRange expandRangeByFactor:CPTDecimalFromCGFloat(5.0f)];
        }
        else {
            float CPTDecimalInput                    = 5.0f;
            [yRange expandRangeByFactor:CPTDecimalFromCGFloat(CPTDecimalInput)];
        }
    }
    else {
        if ([UIScreen mainScreen].bounds.size.height == 568.0f) {
            [yRange expandRangeByFactor:CPTDecimalFromCGFloat(300.0f)];
        }
        else {
            float CPTDecimalInput                   = 150.0f;
            [yRange expandRangeByFactor:CPTDecimalFromCGFloat(CPTDecimalInput)];
        }
    }
    plotSpace.yRange                                = yRange;
    // 4 - Create styles and symbols
    if (![self.m_weightOrTimeOrRepititionImage isEqualToString:@"Repitition"]) {
        
        CPTMutableLineStyle *weightLineStyle            = [weightPlot.dataLineStyle mutableCopy];
        weightLineStyle.lineWidth                       = 2.5;
        weightLineStyle.lineColor                       = weightColor;
        weightPlot.dataLineStyle                        = weightLineStyle;
        CPTMutableLineStyle *weightSymbolLineStyle      = [CPTMutableLineStyle lineStyle];
        weightSymbolLineStyle.lineColor                 = weightColor;
        CPTPlotSymbol *weightSymbol                     = [CPTPlotSymbol ellipsePlotSymbol];
        weightSymbol.fill                               = [CPTFill fillWithColor:weightColor];
        weightSymbol.lineStyle                          = weightSymbolLineStyle;
        weightSymbol.size                               = CGSizeMake(15.0f, 15.0f);
        weightPlot.plotSymbol                           = weightSymbol;
    }
    
    if (![self.m_weightOrTimeOrRepititionImage isEqualToString:@"Time"]) {
        CPTMutableLineStyle *repLineStyle               = [repPlot.dataLineStyle mutableCopy];
        repLineStyle.lineWidth                          = 2.5;
        repLineStyle.lineColor                          = repColor;
        repPlot.dataLineStyle                           = repLineStyle;
        CPTMutableLineStyle *repSymbolLineStyle         = [CPTMutableLineStyle lineStyle];
        repSymbolLineStyle.lineColor                    = repColor;
        CPTPlotSymbol *repSymbol                        = [CPTPlotSymbol ellipsePlotSymbol];
        repSymbol.fill                                  = [CPTFill fillWithColor:repColor];
        repSymbol.lineStyle                             = repSymbolLineStyle;
        repSymbol.size                                  = CGSizeMake(15.0f, 15.0f);
        repPlot.plotSymbol                              = repSymbol;
    }
}

-(void)configureAxes {
    // 1 - Create styles
    CPTMutableTextStyle *axisTitleStyle             = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color                            = [CPTColor grayColor];
    axisTitleStyle.fontName                         = @"Helvetica-Bold";
    axisTitleStyle.fontSize                         = 8.0f;
    CPTMutableLineStyle *axisLineStyle              = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth                         = 2.0f;
    axisLineStyle.lineColor                         = [CPTColor grayColor];
    CPTMutableTextStyle *axisTextStyle              = [[CPTMutableTextStyle alloc] init];
    axisTextStyle.color                             = [CPTColor redColor];
    axisTextStyle.fontName                          = @"Helvetica-Bold";
    axisTextStyle.fontSize                          = 8.0f;
    CPTMutableLineStyle *tickLineStyle              = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor                         = [CPTColor redColor];
    tickLineStyle.lineWidth                         = 2.0f;
    //	CPTMutableLineStyle *gridLineStyle              = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor                         = [CPTColor grayColor];
    tickLineStyle.lineWidth                         = 1.0f;
    // 2 - Get axis set
    CPTXYAxisSet *axisSet                           = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
    // 3 - Configure x-axis
    CPTAxis *x                                      = axisSet.xAxis;
    x.axisLineStyle                                 = axisLineStyle;
    x.labelingPolicy                                = CPTAxisLabelingPolicyNone;
    x.labelTextStyle                                = axisTextStyle;
    x.labelOffset                                   = 16.0f;
    x.majorTickLineStyle                            = axisLineStyle;
    x.majorTickLength                               = 4.0f;
    x.tickDirection                                 = CPTSignNegative;
    CGFloat dateCount                               = [[[CPDExerciseProgress sharedInstance] eightWeeks] count];
    NSMutableSet *xLabels                           = [NSMutableSet setWithCapacity:dateCount];
    NSMutableSet *xLocations                        = [NSMutableSet setWithCapacity:dateCount];
    NSInteger i                                     = 0;
    for (NSString *date in [[CPDExerciseProgress sharedInstance] eightWeeks]) {
        CPTAxisLabel *label         = [[CPTAxisLabel alloc] initWithText:date  textStyle:x.labelTextStyle];
        CGFloat location            = i++;
        label.tickLocation          = CPTDecimalFromCGFloat(location);
        label.offset                = x.majorTickLength;
        if (label) {
            [xLabels addObject:label];
            [xLocations addObject:[NSNumber numberWithFloat:location]];
        }
    }
    x.axisLabels                                    = xLabels;
    x.majorTickLocations                            = xLocations;
    // 4 - Configure y-axis
    CPTAxis *y                                      = axisSet.yAxis;
    y.axisLineStyle                                 = axisLineStyle;
    //	y.majorGridLineStyle                            = gridLineStyle;
    y.labelingPolicy                                = CPTAxisLabelingPolicyNone;
    y.labelTextStyle                                = axisTextStyle;
    y.labelOffset                                   = 16.0f;
    y.majorTickLineStyle                            = axisLineStyle;
    y.majorTickLength                               = 4.0f;
    y.minorTickLength                               = 10.0f;
    y.tickDirection                                 = CPTSignPositive;
    NSInteger majorIncrement                        = 25;
    NSInteger minorIncrement                        = 25;
    CGFloat yMax                                    = 700.0f;  // should determine dynamically based on max price
    NSMutableSet *yLabels                           = [NSMutableSet set];
    NSMutableSet *yMajorLocations                   = [NSMutableSet set];
    NSMutableSet *yMinorLocations                   = [NSMutableSet set];
    for (NSInteger j = minorIncrement; j <= yMax; j += minorIncrement) {
        NSUInteger mod      = j % majorIncrement;
        if (mod == 0) {
            CPTAxisLabel *label         = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%i", j] textStyle:y.labelTextStyle];
            NSDecimal location          = CPTDecimalFromInteger(j);
            label.tickLocation          = location;
            label.offset                = -y.majorTickLength - y.labelOffset;
            if (label) {
                [yLabels addObject:label];
            }
            [yMajorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:location]];
        } else {
            [yMinorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:CPTDecimalFromInteger(j)]];
        }
    }
    y.axisLabels                                    = yLabels;
    y.majorTickLocations                            = yMajorLocations;
    y.minorTickLocations                            = yMinorLocations;
}

#pragma mark - CPTPlotDataSource methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    
    if ([self.m_weightOrTimeOrRepititionImage isEqualToString:@"Repitition"]) {
        return [self.m_repArray count];
    }
    else {
        return [self.m_weightArray count];
    }
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
    NSInteger valueCount = [[[CPDExerciseProgress sharedInstance] eightWeeks] count];
    switch (fieldEnum) {
        case CPTScatterPlotFieldX:
            if (index < valueCount) {
                return [NSNumber numberWithUnsignedInteger:index];
            }
            break;
            
        case CPTScatterPlotFieldY:
            
            if ([plot.identifier isEqual:CPDTickerSymbolWeight] == YES) {
                if (![self.m_weightOrTimeOrRepititionImage isEqualToString:@"Repitition"]) {
                    if (self.m_weightArray) {
                        return [self.m_weightArray objectAtIndex:index];
                    }
                }
            } else if ([plot.identifier isEqual:CPDTickerSymbolRep] == YES) {
                if (self.m_repArray) {
                    return [self.m_repArray objectAtIndex:index];
                }
            }
            break;
    }
    return [NSDecimalNumber zero];
}

@end
