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
    else if ([m_weightOrTimeOrRepititionImage isEqualToString:@"Time"]) {
        reportDifficultyRepImageViewMask.hidden    = YES;
        reportRepNextDoneButton.hidden             = YES;
        reportTimeNextDoneButton.hidden            = NO;
        reportWeightRepNextDoneButton.hidden       = YES;
        setNameLabel.hidden                        = NO;
        setNumberLabel.hidden                      = NO;
        setMaxNumberLabel.hidden                   = NO;
        m_plusTimeWeightRepButton.hidden           = YES;
        m_minusTimeWeightRepButton.hidden          = YES;
    }
    else {
        reportDifficultyRepImageViewMask.hidden    = NO;
        reportWeightRepNextDoneButton.hidden       = NO;
        reportRepNextDoneButton.hidden             = YES;
        reportTimeNextDoneButton.hidden            = YES;
        reportWeightRepNextDoneButton.hidden       = NO;
        setNameLabel.hidden                        = YES;
        setNumberLabel.hidden                      = YES;
        setMaxNumberLabel.hidden                   = YES;
        m_plusTimeWeightRepButton.hidden           = YES;
        m_minusTimeWeightRepButton.hidden          = YES;
    }
    
    saveReportButton.hidden                        = NO;
    if ([m_weightOrTimeOrRepititionImage isEqualToString:@"Weight"]) { // if the excerise has weight
        [self showRepDetails:beforeFirstDifficultyRepLabel];
        [self showRepDetails:firstDifficultyRepLabel];
        [self showRepDetails:secondDifficultyRepLabel];
        [self showRepDetails:thirdDifficultyRepLabel];
        [self showRepDetails:afterThirdDifficultyRepLabel];
        m_plusTimeWeightRepButton.hidden             = NO;
        m_minusTimeWeightRepButton.hidden            = NO;
    }
    
    [self showWeightTimeRepDetails:beforeFirstTimeWeightLabel];
    [self showWeightTimeRepDetails:firstTimeWeightLabel];
    [self showWeightTimeRepDetails:secondTimeWeightLabel];
    [self showWeightTimeRepDetails:thirdTimeWeightLabel];
    [self showWeightTimeRepDetails:afterThirdTimeWeightLabel];
}

/*
 Load up right small repitition values
 */
- (void)loadUpRightSmallRepititionValues:(UILabel *)label
{
    if (label.frame.origin.x == m_beforeFirstFrame.origin.x) {
        label.text           = @"4";
    }
    else if(label.frame.origin.x == m_firstFrame.origin.x) {
        label.text           = @"5";
    }
    else if(label.frame.origin.x == m_secondFrame.origin.x) {
        label.text           = @"6";
    }
    else if(label.frame.origin.x == m_thirdFrame.origin.x) {
        label.text           = @"7";
    }
    else if(label.frame.origin.x == m_afterThirdFrame.origin.x) {
        label.text           = @"8";
    }
}

/*
 Load up exercise report values
 */
- (void)initialExerciseReportValues
{
    // load up right images and values for weight or time, rep or difficulty
    [self loadUpRightImagesAndValues:beforeFirstTimeWeightLabel];
    [self loadUpRightImagesAndValues:firstTimeWeightLabel];
    [self loadUpRightImagesAndValues:secondTimeWeightLabel];
    [self loadUpRightImagesAndValues:thirdTimeWeightLabel];
    [self loadUpRightImagesAndValues:afterThirdTimeWeightLabel];
    
    // load up right values for small rep
    [self loadUpRightSmallRepititionValues:beforeFirstDifficultyRepLabel];
    [self loadUpRightSmallRepititionValues:firstDifficultyRepLabel];
    [self loadUpRightSmallRepititionValues:secondDifficultyRepLabel];
    [self loadUpRightSmallRepititionValues:thirdDifficultyRepLabel];
    [self loadUpRightSmallRepititionValues:afterThirdDifficultyRepLabel];
    
    // update the set number to begin from 1
    setNumberLabel.text                         = @"1";
}

/*
 Hide Exercise progress graph
 */
- (void)hideProgress
{
    if (!m_transition) {
        m_transition        = [ViewTransitions sharedInstance];
    }
    [m_transition performTransitionDisappear:self.graphView];
    [m_transition performTransitionDisappear:self.weightBox];
    [m_transition performTransitionDisappear:self.repBox];
    [m_transition performTransitionDisappear:self.weightLabel];
    [m_transition performTransitionDisappear:self.repLabel];
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
    
    if (!m_transition) {
        m_transition        = [ViewTransitions sharedInstance];
    }
    [m_transition performTransitionAppear:self.contentsTextView];
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
    if (!m_transition) {
        m_transition                                = [ViewTransitions sharedInstance];
    }
    [self.exerciseDetailsImageView setImage:[UIImage imageNamed:@"tfn_report_active.png"]];
    [m_transition performTransitionDisappear:self.contentsTextView];
    // Hide the textview
    self.contentsTextView.hidden                    = YES;
    
    // Exercise progress graph
    [self hideProgress];
    
    // Show the report details
    [self showExerciseReportDetails];
    
    if ([m_previousExerciseName isEqualToString:m_exerciseImageNameString]) { // Retain the exercise state from before, so do nothing
    }
    else { // if the previous view's exercise is not the same, update the m_previousExerciseName
        m_previousExerciseName                          = m_exerciseImageNameString;
        [self initialExerciseReportValues];
    }
}

/*
 Show Progress
 */
- (void)showProgress
{
    if (!m_transition) {
        m_transition                                = [ViewTransitions sharedInstance];
    }
    [self.exerciseDetailsImageView setImage:[UIImage imageNamed:@"tfn_progress_active.png"]];
    [m_transition performTransitionDisappear:self.contentsTextView];
    
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
    
    if ((sender == workoutDescriptionButton) && (([m_checkWhichExerciseButtonWasClicked isEqualToString:@"exerciseReport"]) || ([m_checkWhichExerciseButtonWasClicked isEqualToString:@"exerciseProgress"]))) {
        m_checkWhichExerciseButtonWasClicked            = @"exerciseDescription";
        [self showExerciseDescription];
    }
    else if((sender == reportButton) && (([m_checkWhichExerciseButtonWasClicked isEqualToString:@"exerciseDescription"]) || ([m_checkWhichExerciseButtonWasClicked isEqualToString:@"exerciseProgress"]))) {
        if ([self checkIfExerciseIsWithoutReportOrProgress:m_exerciseNameDisplayed]) {
            // Hide exercise report details
            [self hideExerciseReportDetails];
            
            // Exercise progress graph
            [self hideProgress];
            
        }
        else {
            m_checkWhichExerciseButtonWasClicked            = @"exerciseReport";
            [self showReport];
        }
    }
    else if((sender == progressButton) && (([m_checkWhichExerciseButtonWasClicked isEqualToString:@"exerciseDescription"]) || ([m_checkWhichExerciseButtonWasClicked isEqualToString:@"exerciseReport"]))) {
        if ([self checkIfExerciseIsWithoutReportOrProgress:m_exerciseNameDisplayed]) {
            // Hide exercise report details
            [self hideExerciseReportDetails];
            
            // Exercise progress graph
            [self hideProgress];
        }
        else {
            m_checkWhichExerciseButtonWasClicked            = @"exerciseProgress";
            [self showProgress];
            setNameLabel.hidden                             = YES;
            setNumberLabel.hidden                           = YES;
            setMaxNumberLabel.hidden                        = YES;
            
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
    
    m_setNumber                               = [setNumberLabel.text intValue];
    
    // Convert int weight time value into nsnumber
    NSNumber *numberSetOneWeightField         = 0;
    // Convert int weight time value into nsnumber
    NSNumber *numberSetOneTimeField           = 0;
    
    // Convert int difficulty rep value into nsnumber
    NSNumber *numberSetOneRepField            = [NSNumber numberWithInt:m_selectedDifficultyRep];
    
    // Convert int set number into nsnumber
    NSNumber *setNumber                       = [NSNumber numberWithInt:m_setNumber];
    if ([m_weightOrTimeOrRepititionImage isEqualToString:@"Time"]) {
        numberSetOneTimeField                 = [NSNumber numberWithInt:m_selectedWeightTimeRepitition];
        numberSetOneRepField                  = 0;
    }
    else if([m_weightOrTimeOrRepititionImage isEqualToString:@"Weight"]){
        numberSetOneWeightField               = [NSNumber numberWithInt:m_selectedWeightTimeRepitition];
    }
    else if([m_weightOrTimeOrRepititionImage isEqualToString:@"Repitition"]){ // If it is repitition, it has big repitition image
        numberSetOneRepField                  = [NSNumber numberWithInt:m_selectedWeightTimeRepitition];
    }
    
    if ((numberSetOneWeightField != NULL) || (numberSetOneRepField != NULL) || (numberSetOneTimeField != NULL)) { // Make there is no null in the numbers
        
        if ([m_weightOrTimeOrRepititionImage isEqualToString:@"Time"]) {
            
            if (m_setNumber < 7) { // Maximum number of set is 5
                
                if (!m_database) {
                    m_database      = [Database alloc];
                }
                if (m_setNumber > 1) { // When set is more than 1, data needs to be updated in database
                    exerciseReportStatus            = [m_database updateExerciseReport:self.exerciseNameLabel.text Email_Id:[NSString getUserEmail] Date:date Set:setNumber SetTheWeight:numberSetOneWeightField SetTheTime:numberSetOneTimeField SetTheRep:numberSetOneRepField];
                }
                else { // When set is 1, data needs to be inserted in database
                    exerciseReportStatus            = [m_database insertIntoExerciseReport:self.exerciseNameLabel.text Email_Id:[NSString getUserEmail] Date:date SetOneWeight:numberSetOneWeightField SetOneTime:numberSetOneTimeField SetOneRep:numberSetOneRepField];
                }
                
                if ([exerciseReportStatus isEqualToString:@"updated"]) {
                    [self displayMessage:[NSString stringWithFormat:@"Set number %d was successfully saved.", m_setNumber]];
                    
                    // Increment for the next set
                    m_setNumber++;
                    
                    // if the set number reaches 5 , then it should become 1 to start again
                    if (m_setNumber == 6) {
                        m_setNumber                         = 1;
                    }
                    // Update the set number, after pressing done
                    setNumberLabel.text                = [NSString stringWithFormat:@"%d", m_setNumber];
                }
                else {
                    [self displayMessage:@"This record failed to be saved."];
                }
            }
        }
        else { // for exercise other than time
            exerciseReportStatus            = [m_database insertIntoExerciseReport:self.exerciseNameLabel.text Email_Id:[NSString getUserEmail] Date:date SetOneWeight:numberSetOneWeightField SetOneTime:numberSetOneTimeField SetOneRep:numberSetOneRepField];
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
    isBigImageVisible                                = TRUE;
    [self.view addSubview:self.bigExerciseImageView];
}

/*
 Show other views to hide big image
 */
- (void)showOtherViewsAfterHidingBigImage
{
    if (!m_transition) {
        m_transition                                = [ViewTransitions sharedInstance];
    }
    [m_transition performTransitionDisappear:self.bigExerciseImageView];
    [self.bigExerciseImageView removeFromSuperview];
    
    // Big image make invisible
    isBigImageVisible                               = FALSE;
}

/*
 Display first exercise image
 */
- (void)displayBigExerciseImage:(UIInterfaceOrientation)orientation
{
    // assign selected image view
    m_bigExerciseImageNameString                    = m_exerciseImageNameString;
    
    // Remove the below line, only for testing
    m_bigExerciseImageNameString                    = [m_bigExerciseImageNameString stringByReplacingOccurrencesOfString:@"thumb" withString:@"landscape"];
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        self.bigExerciseImageView.image             = [[UIImage alloc] initWithCGImage: [UIImage imageNamed:m_bigExerciseImageNameString].CGImage
                                                                                 scale: 1.90
                                                                           orientation: UIImageOrientationLeft];
    }
    else if(orientation == UIInterfaceOrientationLandscapeRight) {
        self.bigExerciseImageView.image             = [[UIImage alloc] initWithCGImage: [UIImage imageNamed:m_bigExerciseImageNameString].CGImage
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
        isBigImageVisible                       = FALSE;
    }
}

/*
 Increment  Time or Weight or Rep labels by 10
 */
- (void)plusTimeWeightRepby10:(id)sender
{
    [UILabel incrementBy10OnLabelOne:beforeFirstTimeWeightLabel LabelTwo:firstTimeWeightLabel  LabelThree:secondTimeWeightLabel LabelFour:thirdTimeWeightLabel LabelFive:afterThirdTimeWeightLabel];
}

/*
 Decrement Time or Weight or Rep labels by 10
 */
- (void)minusTimeWeightRepby10:(id)sender
{
    if ([secondTimeWeightLabel.text intValue] > 5) {
        [UILabel decrementBy10OnLabelOne:beforeFirstTimeWeightLabel LabelTwo:firstTimeWeightLabel  LabelThree:secondTimeWeightLabel LabelFour:thirdTimeWeightLabel LabelFive:afterThirdTimeWeightLabel];
    }
}

/*
 Increment or Decrement time weight value
 */
- (int)incrementOrDecrement:(NSString *)incrementOrDecrement WeightTimeValue:(UILabel *)label
{
    int value                               = [label.text intValue];
    
    if ([incrementOrDecrement isEqualToString:@"Left"]) {
        if (label.frame.origin.x == m_afterThirdFrame.origin.x) {
            if ([m_weightOrTimeOrRepititionImage isEqualToString:@"Weight"]) {
                value                       = value + 25;
            }
            else if (([m_weightOrTimeOrRepititionImage isEqualToString:@"Repitition"]) || ([m_weightOrTimeOrRepititionImage isEqualToString:@"Time"])) {
                value                       = value + 5;
            }
        }
        else if (label.frame.origin.x == m_beforeFirstFrame.origin.x) {
            m_beforeFirstWeightLabel        = value;
        }
    }
    else if([incrementOrDecrement isEqualToString:@"Right"]) {
        if (label.frame.origin.x == m_beforeFirstFrame.origin.x) {
            if ([m_weightOrTimeOrRepititionImage isEqualToString:@"Weight"]) {
                value                       = value - 25;
                m_beforeFirstWeightLabel    = value;
            }
            else if (([m_weightOrTimeOrRepititionImage isEqualToString:@"Repitition"]) || ([m_weightOrTimeOrRepititionImage isEqualToString:@"Time"])) {
                value                       = value - 5;
                m_beforeFirstWeightLabel    = value;
            }
        }
    }
    
    // Get the selected Weight or Time
    if (label.frame.origin.x == m_secondFrame.origin.x) {
        m_selectedWeightTimeRepitition                = [label.text intValue];
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
        if (label.frame.origin.x == m_afterThirdDifficultyRepFrame.origin.x) {
            value                           = value + 5;
        }
        else if (label.frame.origin.x == m_beforeFirstDifficultyRepFrame.origin.x) {
            m_beforeFirstDifficultyRepLabel = value;
        }
    }
    else if([incrementOrDecrement isEqualToString:@"Right"]) {
        if (label.frame.origin.x == m_beforeFirstDifficultyRepFrame.origin.x) {
            value                           = value - 5;
            m_beforeFirstDifficultyRepLabel = value;
        }
    }
    
    // Get the selected Difficulty / Rep
    if (label.frame.origin.x == m_secondDifficultyRepFrame.origin.x) {
        m_selectedDifficultyRep             = [label.text intValue];
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
        if (label.frame.origin.x == m_beforeFirstDifficultyRepFrame.origin.x) {
            label.frame            = m_afterThirdDifficultyRepFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == m_firstDifficultyRepFrame.origin.x) {
            label.frame            = m_beforeFirstDifficultyRepFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == m_secondDifficultyRepFrame.origin.x) {
            label.frame            = m_firstDifficultyRepFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == m_thirdDifficultyRepFrame.origin.x) {
            label.frame            = m_secondDifficultyRepFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor redColor];
        }
        else if(label.frame.origin.x == m_afterThirdDifficultyRepFrame.origin.x) {
            label.frame            = m_thirdDifficultyRepFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor darkGrayColor];
        }
        [UIView commitAnimations];
        
        // Change the before first value
        label.text             = [NSString stringWithFormat:@"%d", [self incrementOrDecrement:@"Left" DifficultyRepValue:label]];
    }
    else if ([leftOrRight isEqualToString:@"Right"]) {
        if(label.frame.origin.x == m_beforeFirstDifficultyRepFrame.origin.x) {
            label.frame            = m_firstDifficultyRepFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if (label.frame.origin.x == m_afterThirdDifficultyRepFrame.origin.x) {
            label.frame            = m_beforeFirstDifficultyRepFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == m_thirdDifficultyRepFrame.origin.x) {
            label.frame            = m_afterThirdDifficultyRepFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == m_secondDifficultyRepFrame.origin.x) {
            label.frame            = m_thirdDifficultyRepFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == m_firstDifficultyRepFrame.origin.x) {
            label.frame            = m_secondDifficultyRepFrame;
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
        if (label.frame.origin.x == m_beforeFirstFrame.origin.x) {
            label.frame            = m_afterThirdFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == m_firstFrame.origin.x) {
            label.frame            = m_beforeFirstFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == m_secondFrame.origin.x) {
            label.frame            = m_firstFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == m_thirdFrame.origin.x) {
            label.frame            = m_secondFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor redColor];
        }
        else if(label.frame.origin.x == m_afterThirdFrame.origin.x) {
            label.frame            = m_thirdFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor darkGrayColor];
        }
        [UIView commitAnimations];
        
        // Change the before first value
        label.text             = [NSString stringWithFormat:@"%d", [self incrementOrDecrement:@"Left" WeightTimeValue:label]];
    }
    else if ([leftOrRight isEqualToString:@"Right"]) {
        if(label.frame.origin.x == m_beforeFirstFrame.origin.x) {
            label.frame            = m_firstFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if (label.frame.origin.x == m_afterThirdFrame.origin.x) {
            label.frame            = m_beforeFirstFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == m_thirdFrame.origin.x) {
            label.frame            = m_afterThirdFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == m_secondFrame.origin.x) {
            label.frame            = m_thirdFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == m_firstFrame.origin.x) {
            label.frame            = m_secondFrame;
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
    [self animateLeftOrRight:@"Left" TimeWeightLabel:firstTimeWeightLabel];
    // Animate the second label
    [self animateLeftOrRight:@"Left" TimeWeightLabel:secondTimeWeightLabel];
    // Animate the third label
    [self animateLeftOrRight:@"Left" TimeWeightLabel:thirdTimeWeightLabel];
    // Animate after third label
    [self animateLeftOrRight:@"Left" TimeWeightLabel:afterThirdTimeWeightLabel];
    // Animate before first label, do this last to get the value from the label to be used to check if it is zero
    [self animateLeftOrRight:@"Left" TimeWeightLabel:beforeFirstTimeWeightLabel];
}

/*
 Animate right time weight rep labels
 */
-(void)animateRightTimeWeightRepLabels
{
    if(m_beforeFirstWeightLabel >= 0) { // If before first label value is less than zero, do nothing
        // Animate first label
        [self animateLeftOrRight:@"Right" TimeWeightLabel:firstTimeWeightLabel];
        // Animate second label
        [self animateLeftOrRight:@"Right" TimeWeightLabel:secondTimeWeightLabel];
        // Animate third label
        [self animateLeftOrRight:@"Right" TimeWeightLabel:thirdTimeWeightLabel];
        // Animate after third label
        [self animateLeftOrRight:@"Right" TimeWeightLabel:afterThirdTimeWeightLabel];
        // Animate before first label, do this last to get the value from the label to be used to check if it is zero
        [self animateLeftOrRight:@"Right" TimeWeightLabel:beforeFirstTimeWeightLabel];
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
        [self animateLeftOrRight:@"Left" DifficultyRepLabel:firstDifficultyRepLabel];
        // Animate the third label
        [self animateLeftOrRight:@"Left" DifficultyRepLabel:secondDifficultyRepLabel];
        // Animate after third label
        [self animateLeftOrRight:@"Left" DifficultyRepLabel:thirdDifficultyRepLabel];
        [self animateLeftOrRight:@"Left" DifficultyRepLabel:afterThirdDifficultyRepLabel];
        // Animate before first label, do this last to get the value from the label to be used to check if it is zero
        [self animateLeftOrRight:@"Left" DifficultyRepLabel:beforeFirstDifficultyRepLabel];
    }
    else if (swipeRecognizer == self.timeWeightRightSwipeGesture) {
        
        if(m_beforeFirstWeightLabel >= 0) { // If before first label value is less than zero, do nothing
            [self animateRightTimeWeightRepLabels];
        }
    }
    else if (swipeRecognizer == self.difficultyRepRightSwipeGesture) {
        
        if (m_beforeFirstDifficultyRepLabel >= 0) { // first value must be zero or more so that selected value cannot be less than 0
            
            // Animate the first label
            // Animate the second label
            [self animateLeftOrRight:@"Right" DifficultyRepLabel:firstDifficultyRepLabel];
            // Animate the third label
            [self animateLeftOrRight:@"Right" DifficultyRepLabel:secondDifficultyRepLabel];
            // Animate after third label
            [self animateLeftOrRight:@"Right" DifficultyRepLabel:thirdDifficultyRepLabel];
            [self animateLeftOrRight:@"Right" DifficultyRepLabel:afterThirdDifficultyRepLabel];
            // Animate before first label, do this last to get the value from the label to be used to check if it is zero
            [self animateLeftOrRight:@"Right" DifficultyRepLabel:beforeFirstDifficultyRepLabel];
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
    m_exerciseDescriptionPlist              = [exerciseImageNameString stringByReplacingOccurrencesOfString:underscore withString:@" "];
    m_exerciseDescriptionPlist              = [m_exerciseDescriptionPlist stringByReplacingOccurrencesOfString:@" male thumb" withString:@""]; // Remove male thumb
    m_exerciseDescriptionPlist              = [m_exerciseDescriptionPlist stringByReplacingOccurrencesOfString:@" female thumb" withString:@""]; // Remove female thumb
    // Then remove the .png image extensions, we get the name of the exercise
    m_exerciseDescriptionPlist              = [m_exerciseDescriptionPlist stringByReplacingOccurrencesOfString:@".png" withString:@""]; // Remove .png
    
    // Display exercise name with first letter of the each words capatalized
    self.exerciseNameLabel.text             = [self removeWhiteSpaceBeforeFirstWord:[self capatalizeFirstLetterOfWordsOfExerciseName:m_exerciseDescriptionPlist]];
    
    // save exercise name
    m_exerciseNameDisplayed                 = self.exerciseNameLabel.text;
    
    // Change it back to lowercase to retrive the related plist
    m_exerciseDescriptionPlist              = [m_exerciseDescriptionPlist lowercaseString];
    if ((m_exerciseDescriptionPlist != NULL) && (m_exerciseDescriptionPlist.length != 0)) {
        // Load dictionary from the plist having same image name
        m_workoutDescriptionDictionary      = nil;
        
        if (!m_workoutDescriptionDictionary) {
            m_workoutDescriptionDictionary  = [[NSMutableDictionary alloc] init];
        }
        m_workoutDescriptionDictionary      = [m_workoutSelection loadUpPlist:[m_exerciseDescriptionPlist lowercaseString]];
    }
    [self addExerciseDescriptions:m_workoutDescriptionDictionary];
}

/*
 Use previous view's selected image name to food image and choosing the right food exercise description
 */
- (void)loadExerciseImagesAndDescription
{
    if (!m_workoutDescriptionDictionary) {
        m_workoutDescriptionDictionary      = [[NSMutableDictionary alloc] init];
    }
    if (!m_workoutSelection) {
        m_workoutSelection                  = [WorkoutSelection  sharedInstance];
    }
    if (!m_calenderViewController) {
        m_calenderViewController            = [CalenderViewController sharedInstance];
    }
    if (!m_mealViewController) {
        m_mealViewController                = [MealViewController sharedInstance];
    }
    if (!m_exerciseViewController) {
        m_exerciseViewController            = [ExerciseViewController sharedInstance];
    }
    if (!m_exerciseListViewController) {
        m_exerciseListViewController        = [ExerciseListViewController sharedInstance];
    }
    
    // Present image for the exercise imageView
    if ([m_calenderViewController.selectedImage length] != 0) {
        m_exerciseImageNameString                       = [NSString stringWithFormat:@"%@.png", m_calenderViewController.selectedImage];
        m_calenderViewController.selectedImage          = nil;
    }
    else if([m_exerciseViewController.selectedImage length] != 0) { // If coming from ExerciseViewController's view
        m_exerciseImageNameString                       = [NSString stringWithFormat:@"%@.png", m_exerciseViewController.selectedImage];
        m_exerciseViewController.selectedImage          = nil;
    }
    else if([m_exerciseListViewController.selectedImage length] != 0) { // if coming from ExerciseListViewController's view
        m_exerciseImageNameString                       = [NSString stringWithFormat:@"%@.png", m_exerciseListViewController.selectedImage];
        m_exerciseListViewController.selectedImage      = nil;
    }
    
    // Position the images properly
    [self showExerciseImage:m_exerciseImageNameString];
    
    // load up Exercise description from plist
    [self loadUpExerciseDescriptionFromPlistUsingExerciseImageName:m_exerciseImageNameString];
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
            if ([m_weightOrTimeOrRepititionImage isEqualToString:@"Weight"]) {
                for (int i = 0; i < totalNumberOfItemsInDataForGraph; i = i+2) {
                    theweight          += [[weeklyReportData objectAtIndex:i]intValue];
                    
                    therep             += [[weeklyReportData objectAtIndex:i+1] intValue];
                }
                averageWeight                     = theweight/(totalNumberOfItemsInDataForGraph/2);
                averageRep                        = therep/(totalNumberOfItemsInDataForGraph/2);
            }
            else {
                for (int i = 0; i < totalNumberOfItemsInDataForGraph; i++) {
                    if ([m_weightOrTimeOrRepititionImage isEqualToString:@"Time"]) {
                        theweight          += [[weeklyReportData objectAtIndex:i]intValue];
                        averageWeight                     = theweight/(totalNumberOfItemsInDataForGraph/2);
                    }
                    else if ([m_weightOrTimeOrRepititionImage isEqualToString:@"Repitition"]) {
                        therep             += [[weeklyReportData objectAtIndex:i] intValue];
                    }
                }
                averageRep                        = therep/totalNumberOfItemsInDataForGraph;
            }
            [m_weightArray addObject:[NSNumber numberWithInt:averageWeight]];
            [m_repArray addObject:[NSNumber numberWithInt:averageRep]];
        }
    }
}

/*
 Initial week increment, called only once
 */
- (int)incrementByTheDayOfTheWeek:(NSInteger)weekday
{
    if(weekday == 1) { // Today is the sunday of the week
        m_decrementWeek         = -6;
    }
    else if (weekday == 2) { // Today is the monday of the week
        m_decrementWeek         = -5;
    }
    else if(weekday == 3) { // Today is the tuesday of the week
        m_decrementWeek         = -4;
    }
    else if(weekday == 4) { // Today is the wedday of the week
        m_decrementWeek         = -3;
    }
    else if(weekday == 5) { // Today is the thursday of the week
        m_decrementWeek         = -2;
    }
    else if(weekday == 6) { // Today is the fridaday of the week
        m_decrementWeek         = -1;
    }
    else if(weekday == 7) { // Today is the saturday of the week
        m_decrementWeek         = -0;
    }
    return m_decrementWeek;
}

// To avoid crashes due to memory over allocation
- (void)setupDateObjects
{
    // Calender
    if (!m_calendar) {
        m_calendar                    = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    
    // Today
    if (!m_today) {
        m_today                       = [NSDate date];
    }
    
    // Date Components
    if (!m_components) {
        m_components                  = [[NSDateComponents alloc] init];
        m_components                  = [m_calendar components: NSDayCalendarUnit | NSWeekdayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:m_today];
    }
    
    // For getting the increment on each week
    if (!m_dayComponent) {
        m_dayComponent                = [[NSDateComponents alloc] init];
    }
    
    if (!m_theCalendar) {
        m_theCalendar                 = [NSCalendar currentCalendar];
    }
}

/*
 Get A Week Report each time called
 */
- (void)getWeeklyReport
{
    if (!m_weekStartDate) {
        m_weekStartDate               = [[NSDate date] init];
    }
    
    if (!m_weekEndDate) {
        m_weekEndDate                 = [[NSDate alloc] init];
    }
    
    NSInteger weekday               = [m_components weekday];
    
    if (!m_decrementWeek) {
        // clean up the week decrementor first
        m_decrementWeek             = [self incrementByTheDayOfTheWeek:weekday];
    }
    
    // Increment by 7 each time
    m_dayComponent.day                = m_decrementWeek;
    
    m_weekEndDate                   = [m_theCalendar dateByAddingComponents:m_dayComponent toDate:m_weekEndDate options:0];
    
    // drecrement by 7 days for the next week
    m_decrementWeek                -= 7;
    // Clean up the report data
    m_weeklyReportData              = nil;
    if (!m_weeklyReportData) {
        m_weeklyReportData          = [NSMutableArray mutableArrayObject];
    }
    
    if ((m_weekStartDate) && (m_weekEndDate)) {
        m_weeklyReportData          = [m_database getAverageExerciseReport:self.exerciseNameLabel.text ForAWeek:[NSString getUserEmail] StartDate:m_weekStartDate EndDate:m_weekEndDate];
        if (m_weeklyReportData != nil) {
            // Get average of the data for the week
            [self getAverageFromWeeklyData:m_weeklyReportData];
        }
    }
    // start week date for the next week
    m_weekStartDate                 = m_weekEndDate;
}

/*
 Load up weight and rep data
 */
- (void)loadDataForGraph
{
    // Show the graphview
    self.graphView.hidden                   = NO;
    
    // Initialize to store weight and rep data
    m_weightArray                           = nil;
    if (!m_weightArray) {
        m_weightArray                       = [NSMutableArray mutableArrayObject];
    }
    
    m_repArray                              = nil;
    if (!m_repArray) {
        m_repArray                          = [NSMutableArray mutableArrayObject];
    }
    
    // Clean up the week decrementor
    m_decrementWeek                         = 0;
    // Clean up the end week
    m_weekEndDate                           = 0;
    // Clean up the start week
    m_weekStartDate                         = 0;
    
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
    if ([m_weightOrTimeOrRepititionImage isEqualToString:@"Weight"]) {
        // Show the weight label
        // Hide the weight box
        self.weightBox.hidden               = NO;
        self.weightLabel.hidden             = NO;
        self.weightLabel.text               = @"Weight";
    }
    else if([m_weightOrTimeOrRepititionImage isEqualToString:@"Repitition"]) {
        // Hide the weight label
        // Hide the weight box
        self.weightBox.hidden               = YES;
        self.weightLabel.hidden             = YES;
    }
    else if ([m_weightOrTimeOrRepititionImage isEqualToString:@"Time"]) {
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
    if (!m_transition) {
        m_transition        = [ViewTransitions sharedInstance];
    }
    [m_transition performTransitionFromLeft:self.view.superview];
    [self.view removeFromSuperview];
    
    // Place the below code before moving to supverview, or will crash as we try to work on the view already removed
    if (isBigImageVisible) {
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
    for (NSString *exerciseIntheList in m_exercisesWithoutReportOrProgress) {
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
    for (NSString *exerciseIntheList in m_exercisesWithOnlyRepititions) {
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
    for (NSString *exerciseIntheList in m_exercisesWithOnlyTime) {
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
    if (!m_exercisesWithoutReportOrProgress) {
        m_exercisesWithoutReportOrProgress          = [NSMutableArray mutableArrayObject];
        [m_exercisesWithoutReportOrProgress addObject:@"Foam Roll"];
        [m_exercisesWithoutReportOrProgress addObject:@"Stretch"];
        [m_exercisesWithoutReportOrProgress addObject:@"Basketball"];
        [m_exercisesWithoutReportOrProgress addObject:@"Cycling"];
        [m_exercisesWithoutReportOrProgress addObject:@"Hockey"];
        [m_exercisesWithoutReportOrProgress addObject:@"Rowing"];
        [m_exercisesWithoutReportOrProgress addObject:@"Running"];
        [m_exercisesWithoutReportOrProgress addObject:@"Skiing"];
        [m_exercisesWithoutReportOrProgress addObject:@"Snowboarding"];
        [m_exercisesWithoutReportOrProgress addObject:@"Soccer"];
        [m_exercisesWithoutReportOrProgress addObject:@"Swimming"];
        [m_exercisesWithoutReportOrProgress addObject:@"Tennis"];
        [m_exercisesWithoutReportOrProgress addObject:@"Yoga"];
    }
}

/*
 Load up the exercises that only has repititions
 */
- (void)loadUpExerciseWithOnlyRepititions
{
    if (!m_exercisesWithOnlyRepititions) {
        m_exercisesWithOnlyRepititions          = [NSMutableArray mutableArrayObject];
        [m_exercisesWithOnlyRepititions addObject:@"Push Ups"];
        [m_exercisesWithOnlyRepititions addObject:@"Narrow Grip Pull Up"];
        [m_exercisesWithOnlyRepititions addObject:@"Wide Grip Pull Up"];
        [m_exercisesWithOnlyRepititions addObject:@"Mountain Climbers"];
        [m_exercisesWithOnlyRepititions addObject:@"Crunches"];
        [m_exercisesWithOnlyRepititions addObject:@"Sit Ups"];
        [m_exercisesWithOnlyRepititions addObject:@"Ball Hand To Feet"];
        [m_exercisesWithOnlyRepititions addObject:@"Burpees"];
        [m_exercisesWithOnlyRepititions addObject:@"Body Weight Squats"];
        [m_exercisesWithOnlyRepititions addObject:@"Bicycle Crunch"];
        [m_exercisesWithOnlyRepititions addObject:@"Bench Dips"];
        [m_exercisesWithOnlyRepititions addObject:@"Bench V Sit"];
        [m_exercisesWithOnlyRepititions addObject:@"Agility"];
        [m_exercisesWithOnlyRepititions addObject:@"Ab Roller"];
        [m_exercisesWithOnlyRepititions addObject:@"Ball Roll Ins"];
        [m_exercisesWithOnlyRepititions addObject:@"Burpee Push up"];
        [m_exercisesWithOnlyRepititions addObject:@"Butt Kicks"];
        [m_exercisesWithOnlyRepititions addObject:@"Flutter Kicks"];
        [m_exercisesWithOnlyRepititions addObject:@"Half Burpees"];
        [m_exercisesWithOnlyRepititions addObject:@"Hanging leg Raises"];
        [m_exercisesWithOnlyRepititions addObject:@"Inch Worm Push Up"];
        [m_exercisesWithOnlyRepititions addObject:@"Jump Tucks"];
        [m_exercisesWithOnlyRepititions addObject:@"Hip Raises"];
        [m_exercisesWithOnlyRepititions addObject:@"High Knees"];
        [m_exercisesWithOnlyRepititions addObject:@"Jumping Jacks"];
        [m_exercisesWithOnlyRepititions addObject:@"Jumping Split Squat"];
        [m_exercisesWithOnlyRepititions addObject:@"Knee Abductions"];
        [m_exercisesWithOnlyRepititions addObject:@"Laying Windshield Wipers"];
        [m_exercisesWithOnlyRepititions addObject:@"Scissor Sit Ups"];
        [m_exercisesWithOnlyRepititions addObject:@"Side Plank Hip Raises"];
        [m_exercisesWithOnlyRepititions addObject:@"Supermans"];
        [m_exercisesWithOnlyRepititions addObject:@"Toe Touches"];
        [m_exercisesWithOnlyRepititions addObject:@"V Sit"];
    }
}

/*
 Load up the exercises that only has time
 */
- (void)loadUpExerciseWithOnlyTime
{
    if (!m_exercisesWithOnlyTime) {
        m_exercisesWithOnlyTime             = [NSMutableArray mutableArrayObject];
        [m_exercisesWithOnlyTime addObject:@"Elliptical"];
        [m_exercisesWithOnlyTime addObject:@"Plank"];
        [m_exercisesWithOnlyTime addObject:@"Side Plank"];
        [m_exercisesWithOnlyTime addObject:@"Jog"];
        [m_exercisesWithOnlyTime addObject:@"Sprint"];
        [m_exercisesWithOnlyTime addObject:@"Swimming"];
        [m_exercisesWithOnlyTime addObject:@"Rowing"];
        [m_exercisesWithOnlyTime addObject:@"Bike"];
        [m_exercisesWithOnlyTime addObject:@"Skip"];
        [m_exercisesWithOnlyTime addObject:@"Jogging"];
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
        m_exerciseDescriptionPlist      = [[NSString alloc] init];
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
    workoutDescriptionButton                           = [[UIButton alloc] initWithFrame:workoutDescriptionButtonFrame];
    [self.view addSubview:workoutDescriptionButton];
    [workoutDescriptionButton addTarget:self action:@selector(showExerciseSections:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect reportButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportButtonFrame                              = CGRectMake(108.0f, 282.0f, 107.0f, 75.0f);
    }
    else {
        reportButtonFrame                              = CGRectMake(108.0f, 215.0f, 107.0f, 75.0f);
    }
    reportButton                                       = [[UIButton alloc] initWithFrame:reportButtonFrame];
    [self.view addSubview:reportButton];
    [reportButton addTarget:self action:@selector(showExerciseSections:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect progressButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        progressButtonFrame                            = CGRectMake(215.0f, 282.0f, 107.0f, 75.0f);
    }
    else {
        progressButtonFrame                            = CGRectMake(215.0f, 215.0f, 107.0f, 75.0f);
    }
    progressButton                                     = [[UIButton alloc] initWithFrame:progressButtonFrame];
    [self.view addSubview:progressButton];
    [progressButton addTarget:self action:@selector(showExerciseSections:) forControlEvents:UIControlEventTouchUpInside];
    
    // Weight, Time, Repitition ImageView
    CGRect reportTimeWeightRepImageViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportTimeWeightRepImageViewFrame              = CGRectMake(0.0f, 353.0f, 320.0f, 182.0f);
    }
    else {
        reportTimeWeightRepImageViewFrame              = CGRectMake(0.0f, 286.0f, 320.0f, 157.0f);
    }
    reportTimeWeightRepImageView                       = [[UIImageView alloc] initWithFrame:reportTimeWeightRepImageViewFrame];
    reportTimeWeightRepImageView.userInteractionEnabled= YES;
    reportTimeWeightRepImageView.multipleTouchEnabled  = YES;
    reportTimeWeightRepImageView.image                 = [UIImage imageNamed:@"report_weight_reps.png"];
    [self.view addSubview:reportTimeWeightRepImageView];
    
    // Add TimeWeightImageViewMask for gesture recognizing
    CGRect reportTimeWeightImageViewMaskFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportTimeWeightImageViewMaskFrame              = CGRectMake(0.0f, 368.0f, 320.0f, 50.0f);
    }
    else {
        reportTimeWeightImageViewMaskFrame              = CGRectMake(0.0f, 307.0f, 320.0f, 45.0f);
    }
    reportTimeWeightImageViewMask                       = [[UIImageView alloc] initWithFrame:reportTimeWeightImageViewMaskFrame];
    reportTimeWeightImageViewMask.userInteractionEnabled   = YES;
    [self.view addSubview:reportTimeWeightImageViewMask];
    self.timeWeightLeftSwipeGesture                                           = nil;
    self.timeWeightRightSwipeGesture                                          = nil;
    
    // Add left swipe gesture
    UISwipeGestureRecognizer *timeWeightLeftSwipeGestureLocal                 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [timeWeightLeftSwipeGestureLocal setDirection:UISwipeGestureRecognizerDirectionLeft];
    self.timeWeightLeftSwipeGesture             = timeWeightLeftSwipeGestureLocal;
    [reportTimeWeightImageViewMask addGestureRecognizer:self.timeWeightLeftSwipeGesture];
    
    // Add right swipe gesture
    UISwipeGestureRecognizer *timeWeightRightSwipeGestureLocal                = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [timeWeightRightSwipeGestureLocal setDirection:UISwipeGestureRecognizerDirectionRight];
    self.timeWeightRightSwipeGesture            = timeWeightRightSwipeGestureLocal;
    [reportTimeWeightImageViewMask addGestureRecognizer:self.timeWeightRightSwipeGesture];
    
    
    CGRect minusTimeWeightRepButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        minusTimeWeightRepButtonFrame              = CGRectMake(0.0f, 381.0f, 33.0f, 50.0f);
    }
    else {
        minusTimeWeightRepButtonFrame              = CGRectMake(0.0f, 286.0f, 33.0f, 157.0f);
    }
    m_minusTimeWeightRepButton                      = [[UIButton alloc] initWithFrame:minusTimeWeightRepButtonFrame];
    [self.view addSubview:m_minusTimeWeightRepButton];
    [m_minusTimeWeightRepButton addTarget:self action:@selector(minusTimeWeightRepby10:) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:m_minusTimeWeightRepButton];
    
    CGRect plusTimeWeightRepButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        plusTimeWeightRepButtonFrame              = CGRectMake(287.0f, 381.0f, 33.0f, 50.0f);
    }
    else {
        plusTimeWeightRepButtonFrame              = CGRectMake(287.0f, 286.0f, 33.0f, 157.0f);
    }
    m_plusTimeWeightRepButton                      = [[UIButton alloc] initWithFrame:plusTimeWeightRepButtonFrame];
    [self.view addSubview:m_plusTimeWeightRepButton];
    [m_plusTimeWeightRepButton addTarget:self action:@selector(plusTimeWeightRepby10:) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:m_plusTimeWeightRepButton];
    
    // before first time weight label
    CGRect beforeFirstTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        beforeFirstTimeWeightLabelFrame         = CGRectMake(20.0f, 396.0f, 40.0f, 20.0f);
    }
    else {
        beforeFirstTimeWeightLabelFrame         = CGRectMake(20.0f, 322.0f, 40.0f, 20.0f);
    }
    beforeFirstTimeWeightLabel                  = [[UILabel alloc] initWithFrame:beforeFirstTimeWeightLabelFrame];
    beforeFirstTimeWeightLabel.font             = [UIFont customFontWithSize:20];
    beforeFirstTimeWeightLabel.backgroundColor  = [UIColor clearColor];
    beforeFirstTimeWeightLabel.textColor        = [UIColor darkGrayColor];
    // Helps when there is only a single digit value
    beforeFirstTimeWeightLabel.textAlignment    = NSTextAlignmentCenter;
    beforeFirstTimeWeightLabel.hidden           = YES;
    [self.view addSubview:beforeFirstTimeWeightLabel];
    
    // first time weight label
    CGRect firstTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        firstTimeWeightLabelFrame               = CGRectMake(65.0f, 396.0f, 40.0f, 20.0f);
    }
    else {
        firstTimeWeightLabelFrame               = CGRectMake(65.0f, 322.0f, 40.0f, 20.0f);
    }
    firstTimeWeightLabel                        = [[UILabel alloc] initWithFrame:firstTimeWeightLabelFrame];
    firstTimeWeightLabel.font                   = [UIFont customFontWithSize:20];
    firstTimeWeightLabel.backgroundColor        = [UIColor clearColor];
    firstTimeWeightLabel.textColor              = [UIColor darkGrayColor];
    [self.view addSubview:firstTimeWeightLabel];
    // Helps when there is only a single digit value
    firstTimeWeightLabel.textAlignment          = NSTextAlignmentCenter;
    
    // second time weight label
    CGRect secondTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        secondTimeWeightLabelFrame              = CGRectMake(140.0f, 396.0f, 40.0f, 20.0f);
    }
    else {
        secondTimeWeightLabelFrame              = CGRectMake(140.0f, 322.0f, 40.0f, 20.0f);
    }
    secondTimeWeightLabel                       = [[UILabel alloc] initWithFrame:secondTimeWeightLabelFrame];
    secondTimeWeightLabel.font                  = [UIFont customFontWithSize:20];
    secondTimeWeightLabel.backgroundColor       = [UIColor clearColor];
    secondTimeWeightLabel.textColor             = [UIColor redColor];
    [self.view addSubview:secondTimeWeightLabel];
    // Helps when there is only a single digit value
    secondTimeWeightLabel.textAlignment         = NSTextAlignmentCenter;
    
    // third time weight label
    CGRect thirdTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        thirdTimeWeightLabelFrame               = CGRectMake(210.0f, 396.0f, 40.0f, 20.0f);
    }
    else {
        thirdTimeWeightLabelFrame               = CGRectMake(210.0f, 322.0f, 40.0f, 20.0f);
    }
    thirdTimeWeightLabel                        = [[UILabel alloc] initWithFrame:thirdTimeWeightLabelFrame];
    thirdTimeWeightLabel.font                   = [UIFont customFontWithSize:20];
    thirdTimeWeightLabel.backgroundColor        = [UIColor clearColor];
    thirdTimeWeightLabel.textColor              = [UIColor darkGrayColor];
    [self.view addSubview:thirdTimeWeightLabel];
    // Helps when there is only a single digit value
    thirdTimeWeightLabel.textAlignment          = NSTextAlignmentCenter;
    
    // before third time weight label
    CGRect afterThirdTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        afterThirdTimeWeightLabelFrame          = CGRectMake(255.0f, 396.0f, 40.0f, 20.0f);
    }
    else {
        afterThirdTimeWeightLabelFrame          = CGRectMake(255.0f, 322.0f, 40.0f, 20.0f);
    }
    afterThirdTimeWeightLabel                   = [[UILabel alloc] initWithFrame:afterThirdTimeWeightLabelFrame];
    afterThirdTimeWeightLabel.font              = [UIFont customFontWithSize:20];
    afterThirdTimeWeightLabel.backgroundColor   = [UIColor clearColor];
    afterThirdTimeWeightLabel.textColor         = [UIColor darkGrayColor];
    // Helps when there is only a single digit value
    afterThirdTimeWeightLabel.textAlignment     = NSTextAlignmentCenter;
    afterThirdTimeWeightLabel.hidden            = YES;
    [self.view addSubview:afterThirdTimeWeightLabel];
    
    CGRect reportDifficultyRepImageViewMaskFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportDifficultyRepImageViewMaskFrame   = CGRectMake(0.0f, 457.0f, 195.0f, 50.0f);
    }
    else {
        reportDifficultyRepImageViewMaskFrame   = CGRectMake(5.0f, 376.0f, 190.0f, 50.0f);
    }
    reportDifficultyRepImageViewMask            = [[UIImageView alloc] initWithFrame:reportDifficultyRepImageViewMaskFrame];
    reportDifficultyRepImageViewMask.userInteractionEnabled    = YES;
    reportDifficultyRepImageViewMask.multipleTouchEnabled      = YES;
    [self.view addSubview:reportDifficultyRepImageViewMask];
    self.difficultyRepLeftSwipeGesture                                        = nil;
    self.difficultyRepRightSwipeGesture                                       = nil;
    // Add left swipe gesture
    UISwipeGestureRecognizer *difficultyRepLeftSwipeGestureLocal              = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [difficultyRepLeftSwipeGestureLocal setDirection:UISwipeGestureRecognizerDirectionLeft];
    self.difficultyRepLeftSwipeGesture                                        = difficultyRepLeftSwipeGestureLocal;
    [reportDifficultyRepImageViewMask addGestureRecognizer:self.difficultyRepLeftSwipeGesture];
    
    // Add right swipe gesture
    UISwipeGestureRecognizer *difficultyRepRightSwipeGestureLocal             = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [difficultyRepRightSwipeGestureLocal setDirection:UISwipeGestureRecognizerDirectionRight];
    self.difficultyRepRightSwipeGesture                                       = difficultyRepRightSwipeGestureLocal;
    [reportDifficultyRepImageViewMask addGestureRecognizer:self.difficultyRepRightSwipeGesture];
    
    // before first difficulty rep label
    CGRect beforeFirstDifficultyRepLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        beforeFirstDifficultyRepLabelFrame        = CGRectMake(0.0f, 480.0f, 30.0f, 20.0f);
    }
    else {
        beforeFirstDifficultyRepLabelFrame        = CGRectMake(0.0f, 395.0f, 30.0f, 20.0f);
    }
    beforeFirstDifficultyRepLabel                 = [[UILabel alloc] initWithFrame:beforeFirstDifficultyRepLabelFrame];
    beforeFirstDifficultyRepLabel.text            = @"4";
    beforeFirstDifficultyRepLabel.font            = [UIFont customFontWithSize:20];
    beforeFirstDifficultyRepLabel.backgroundColor = [UIColor clearColor];
    beforeFirstDifficultyRepLabel.textColor       = [UIColor darkGrayColor];
    // Helps when there is only a single digit value
    beforeFirstDifficultyRepLabel.textAlignment   = NSTextAlignmentCenter;
    beforeFirstDifficultyRepLabel.hidden          = YES;
    [self.view addSubview:beforeFirstDifficultyRepLabel];
    
    // first difficulty rep label
    CGRect firstDifficultyRepLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        firstDifficultyRepLabelFrame              = CGRectMake(33.0f, 480.0f, 30.0f, 20.0f);
    }
    else {
        firstDifficultyRepLabelFrame              = CGRectMake(33.0f, 395.0f, 30.0f, 20.0f);
    }
    firstDifficultyRepLabel                       = [[UILabel alloc] initWithFrame:firstDifficultyRepLabelFrame];
    firstDifficultyRepLabel.text                  = @"5";
    firstDifficultyRepLabel.font                  = [UIFont customFontWithSize:20];
    firstDifficultyRepLabel.backgroundColor       = [UIColor clearColor];
    firstDifficultyRepLabel.textColor             = [UIColor darkGrayColor];
    // Helps when there is only a single digit value
    firstDifficultyRepLabel.textAlignment         = NSTextAlignmentCenter;
    [self.view addSubview:firstDifficultyRepLabel];
    
    // second difficulty rep label
    CGRect secondDifficultyRepLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        secondDifficultyRepLabelFrame              = CGRectMake(88.0f, 480.0f, 30.0f, 20.0f);
    }
    else {
        secondDifficultyRepLabelFrame              = CGRectMake(88.0f, 395.0f, 30.0f, 20.0f);
    }
    secondDifficultyRepLabel                       = [[UILabel alloc] initWithFrame:secondDifficultyRepLabelFrame];
    secondDifficultyRepLabel.text                  = @"6";
    secondDifficultyRepLabel.font                  = [UIFont customFontWithSize:20];
    secondDifficultyRepLabel.backgroundColor       = [UIColor clearColor];
    secondDifficultyRepLabel.textColor              = [UIColor redColor];
    // Helps when there is only a single digit value
    secondDifficultyRepLabel.textAlignment         = NSTextAlignmentCenter;
    [self.view addSubview:secondDifficultyRepLabel];
    
    // third difficulty rep label
    CGRect thirdDifficultyRepLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        thirdDifficultyRepLabelFrame              =  CGRectMake(143.0f, 480.0f, 30.0f, 20.0f);
    }
    else {
        thirdDifficultyRepLabelFrame              =  CGRectMake(143.0f, 395.0f, 30.0f, 20.0f);
    }
    thirdDifficultyRepLabel                       = [[UILabel alloc] initWithFrame:thirdDifficultyRepLabelFrame];
    thirdDifficultyRepLabel.text                  = @"7";
    thirdDifficultyRepLabel.font                  = [UIFont customFontWithSize:20];
    thirdDifficultyRepLabel.backgroundColor       = [UIColor clearColor];
    thirdDifficultyRepLabel.textColor             = [UIColor darkGrayColor];
    // Helps when there is only a single digit value
    thirdDifficultyRepLabel.textAlignment         = NSTextAlignmentCenter;
    [self.view addSubview:thirdDifficultyRepLabel];
    
    // ninth difficulty rep label
    CGRect afterThirdDifficultyRepLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        afterThirdDifficultyRepLabelFrame          = CGRectMake(175.0f, 480.0f, 30.0f, 20.0f);
    }
    else {
        afterThirdDifficultyRepLabelFrame          = CGRectMake(175.0f, 395.0f, 30.0f, 20.0f);
    }
    afterThirdDifficultyRepLabel                   = [[UILabel alloc] initWithFrame:afterThirdDifficultyRepLabelFrame];
    afterThirdDifficultyRepLabel.text              = @"8";
    afterThirdDifficultyRepLabel.font              = [UIFont customFontWithSize:20];
    afterThirdDifficultyRepLabel.backgroundColor   = [UIColor clearColor];
    afterThirdDifficultyRepLabel.textColor         = [UIColor darkGrayColor];
    // Helps when there is only a single digit value
    afterThirdDifficultyRepLabel.textAlignment     = NSTextAlignmentCenter;
    afterThirdDifficultyRepLabel.hidden            = YES;
    [self.view addSubview:afterThirdDifficultyRepLabel];
    
    CGRect reportWeightRepNextDoneButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportWeightRepNextDoneButtonFrame         = CGRectMake(205.0f, 467.0f, 110.0f, 45.0f);
    }
    else {
        reportWeightRepNextDoneButtonFrame         = CGRectMake(205.0f, 379.0f, 110.0f, 45.0f);
    }
    reportWeightRepNextDoneButton                  = [[UIButton alloc] initWithFrame:reportWeightRepNextDoneButtonFrame];
    [self.view addSubview:reportWeightRepNextDoneButton];
    [reportWeightRepNextDoneButton addTarget:self action:@selector(saveReport:) forControlEvents:UIControlEventTouchUpInside];
    
    // Add Time Save Report Button
    CGRect reportTimeDoneButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportTimeDoneButtonFrame                  = CGRectMake(143.0f, 441.0f, 170.0f, 45.f);
    }
    else {
        reportTimeDoneButtonFrame                  = CGRectMake(143.0f, 355.0f, 170.0f, 45.f);
    }
    reportTimeNextDoneButton                       = [[UIButton alloc] initWithFrame:reportTimeDoneButtonFrame];
    [reportTimeNextDoneButton addTarget:self action:@selector(saveReport:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reportTimeNextDoneButton];
    
    CGRect reportRepNextDoneButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportRepNextDoneButtonFrame               = CGRectMake(10.0f, 462.0f, 300.0f, 45.0f);
    }
    else {
        reportRepNextDoneButtonFrame               = CGRectMake(10.0f, 375.0f, 300.0f, 45.0f);
    }
    reportRepNextDoneButton                        = [[UIButton alloc] initWithFrame:reportRepNextDoneButtonFrame];
    [self.view addSubview:reportRepNextDoneButton];
    [reportRepNextDoneButton addTarget:self action:@selector(saveReport:) forControlEvents:UIControlEventTouchUpInside];
    
    // Add set name label
    CGRect setNameLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        setNameLabelFrame                          = CGRectMake(30.0f, 440.0f, 40.0f, 50.0f);
    }
    else {
        setNameLabelFrame                          = CGRectMake(30.0f, 360.0f, 40.0f, 50.0f);
    }
    setNameLabel                                   = [[UILabel alloc] initWithFrame:setNameLabelFrame];
    setNameLabel.backgroundColor                   = [UIColor clearColor];
    setNameLabel.text                              = @"Sets";
    setNameLabel.textColor                         = [UIColor darkGrayColor];
    setNameLabel.font                              = [UIFont customFontWithSize:16];
    setNameLabel.textAlignment                     = NSTextAlignmentCenter;
    [self.view addSubview:setNameLabel];
    
    // Add set number label
    CGRect setNumberLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        setNumberLabelFrame                        = CGRectMake(70.0f, 440.0f, 20, 50);
    }
    else {
        setNumberLabelFrame                        = CGRectMake(70.0f, 360.0f, 20, 50);
    }
    setNumberLabel                                 = [[UILabel alloc] initWithFrame:setNumberLabelFrame];
    setNumberLabel.backgroundColor                 = [UIColor clearColor];
    setNumberLabel.text                            = @"1";
    setNumberLabel.textColor                       = [UIColor darkGrayColor];
    setNumberLabel.font                            = [UIFont customFontWithSize:16];
    setNumberLabel.textAlignment                   = NSTextAlignmentCenter;
    [self.view addSubview:setNumberLabel];
    
    // Add set number label
    CGRect setMaxNumberLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        setMaxNumberLabelFrame                     = CGRectMake(82.0f, 440.0f, 20, 50);
    }
    else {
        setMaxNumberLabelFrame                     = CGRectMake(82.0f, 360.0f, 20, 50);
    }
    setMaxNumberLabel                              = [[UILabel alloc] initWithFrame:setMaxNumberLabelFrame];
    setMaxNumberLabel.backgroundColor              = [UIColor clearColor];
    setMaxNumberLabel.text                         = @"/5";
    setMaxNumberLabel.textColor                    = [UIColor darkGrayColor];
    setMaxNumberLabel.font                         = [UIFont customFontWithSize:16];
    setMaxNumberLabel.textAlignment                = NSTextAlignmentCenter;
    [self.view addSubview:setMaxNumberLabel];
    
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
    if ([m_weightOrTimeOrRepititionImage isEqualToString:@"Weight"]) {
        // Weights values
        NSString *beforeFirstLabelWeight;
        NSString *firstLabelWeight;
        NSString *secondLabelWeight;
        NSString *thirdLabelWeight;
        NSString *afterThirdLabelWeight;
        
        if ([m_gender isEqualToString:@"Male"]) { // if male
            beforeFirstLabelWeight                   = @"0";
            firstLabelWeight                         = @"5";
            secondLabelWeight                        = @"10";
            thirdLabelWeight                         = @"15";
            afterThirdLabelWeight                    = @"20";
        }
        else if([m_gender isEqualToString:@"Female"]) { // if female
            beforeFirstLabelWeight                   = @"0";
            firstLabelWeight                         = @"5";
            secondLabelWeight                        = @"10";
            thirdLabelWeight                         = @"15";
            afterThirdLabelWeight                    = @"20";
        }
        
        // Assign values for the labels
        m_beforeFirstWeightLabel                     = beforeFirstLabelWeight;
        
        if (label.frame.origin.x == m_beforeFirstFrame.origin.x) {
            label.text                               = beforeFirstLabelWeight;
        }
        else if(label.frame.origin.x == m_firstFrame.origin.x) {
            label.text                               = firstLabelWeight;
        }
        else if(label.frame.origin.x == m_secondFrame.origin.x) {
            label.text                               = secondLabelWeight;
        }
        else if(label.frame.origin.x == m_thirdFrame.origin.x) {
            label.text                               = thirdLabelWeight;
        }
        else if(label.frame.origin.x == m_afterThirdFrame.origin.x) {
            label.text                               = afterThirdLabelWeight;
        }
        // Default weight value
        m_selectedWeightTimeRepitition               = [secondLabelWeight intValue];
        // Default rep value is 8
        m_selectedDifficultyRep                      = 7;
    }
    else if (([m_weightOrTimeOrRepititionImage isEqualToString:@"Repitition"]) || ([m_weightOrTimeOrRepititionImage isEqualToString:@"Time"])) {
        // Assign values for the labels
        if (label.frame.origin.x == m_beforeFirstFrame.origin.x) {
            label.text                               = @"6";
        }
        else if(label.frame.origin.x == m_firstFrame.origin.x) {
            label.text                               = @"7";
        }
        else if(label.frame.origin.x == m_secondFrame.origin.x) {
            label.text                               = @"8";
            // Default time
            m_selectedWeightTimeRepitition           = [label.text intValue];
        }
        else if(label.frame.origin.x == m_thirdFrame.origin.x) {
            label.text                               = @"9";
        }
        else if(label.frame.origin.x == m_afterThirdFrame.origin.x) {
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
    if ([self checkIfExerciseIsWithOnlyRepititions:m_exerciseNameDisplayed]) {
        reportTimeWeightRepImageView.image        = [UIImage imageNamed:@"report_reps"];
        m_weightOrTimeOrRepititionImage           = @"Repitition";
        reportDifficultyRepImageViewMask.hidden   = YES;
        reportWeightRepNextDoneButton.hidden      = YES;
        reportRepNextDoneButton.hidden            = NO;
        reportTimeNextDoneButton.hidden           = YES;
        [self hideRepDetails];
    }
    else if([self checkIfExerciseIsWithOnlyTime:m_exerciseNameDisplayed]) {
        reportTimeWeightRepImageView.image        = [UIImage imageNamed:@"report_time"];
        m_weightOrTimeOrRepititionImage           = @"Time";
        reportDifficultyRepImageViewMask.hidden   = YES;
        [self hideRepDetails];
        reportWeightRepNextDoneButton.hidden      = YES;
        reportRepNextDoneButton.hidden            = YES;
        reportTimeNextDoneButton.hidden           = NO;
    }
    else {
        reportTimeWeightRepImageView.image        = [UIImage imageNamed:@"report_weight_reps"];
        m_weightOrTimeOrRepititionImage           = @"Weight";
        [self hideRepDetails];
        reportWeightRepNextDoneButton.hidden      = NO;
        reportRepNextDoneButton.hidden            = YES;
        reportTimeNextDoneButton.hidden           = YES;
    }
}

/*
 Set up initial report number labels frame
 */
- (void)setUpInitialReportNumberLabelsFrame
{
    // Number label frames
    m_beforeFirstFrame                      = beforeFirstTimeWeightLabel.frame;
    m_firstFrame                            = firstTimeWeightLabel.frame;
    m_secondFrame                           = secondTimeWeightLabel.frame;
    m_thirdFrame                            = thirdTimeWeightLabel.frame;
    m_afterThirdFrame                       = afterThirdTimeWeightLabel.frame;
    
    // Initial frames for the difficulty/rep labels
    m_beforeFirstDifficultyRepFrame         = beforeFirstDifficultyRepLabel.frame;
    m_firstDifficultyRepFrame               = firstDifficultyRepLabel.frame;
    m_secondDifficultyRepFrame              = secondDifficultyRepLabel.frame;
    m_thirdDifficultyRepFrame               = thirdDifficultyRepLabel.frame;
    m_afterThirdDifficultyRepFrame          = afterThirdDifficultyRepLabel.frame;
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
    m_checkWhichExerciseButtonWasClicked            = @"exerciseReport";
    
    if (!m_database) {
        m_database                                  = [Database alloc];
    }
    // Get gender of the user
    m_gender                                        = [m_database getGender:[NSString getUserEmail]];
    
    // Set up food image and show nutrition benefits description
    // place the below method here to update contents when coming back from a different view
    [self loadExerciseImagesAndDescription];
    
    if ([self checkIfExerciseIsWithoutReportOrProgress:m_exerciseNameDisplayed]) {
        // Hide exercise report details
        [self hideExerciseReportDetails];
        
        // Exercise progress graph
        [self hideProgress];
        
        // Default section active is exercise report
        m_checkWhichExerciseButtonWasClicked            = @"exerciseDescription";
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
    if ([m_weightArray count] >= 1) {
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
    if (![m_weightOrTimeOrRepititionImage isEqualToString:@"Repitition"]) {
        
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
    
    if (![m_weightOrTimeOrRepititionImage isEqualToString:@"Time"]) {
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
    
    if ([m_weightOrTimeOrRepititionImage isEqualToString:@"Repitition"]) {
        return [m_repArray count];
    }
    else {
        return [m_weightArray count];
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
                if (![m_weightOrTimeOrRepititionImage isEqualToString:@"Repitition"]) {
                    if (m_weightArray) {
                        return [m_weightArray objectAtIndex:index];
                    }
                }
            } else if ([plot.identifier isEqual:CPDTickerSymbolRep] == YES) {
                if (m_repArray) {
                    return [m_repArray objectAtIndex:index];
                }
            }
            break;
    }
    return [NSDecimalNumber zero];
}

@end
