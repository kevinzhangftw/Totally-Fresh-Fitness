//
//  ProgressViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-02-03.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "ProgressViewController.h"
#import "RootViewController.h"
#import "UIImageView+Scroll.h"
#import "UILabel+ChangeLabelNumbers.h"

@interface ProgressViewController ()

// Move to RootViewController
- (IBAction)moveToRootViewController:(id)sender;
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
// Get Average of weekly data
- (void)getAverageFromWeeklyData:(NSMutableArray *)weeklyReportData;
// Initial week increment, called only once
- (int)incrementByTheDayOfTheWeek:(NSInteger)weekday;
// Get A Week Report each time called
- (void)getWeeklyReport;
//// Save Report
- (void)saveReport:(id)sender;

@end


@implementation ProgressViewController

@synthesize graphView;
@synthesize weightLeftSwipeGesture;
@synthesize weightRightSwipeGesture;
@synthesize bottomBarButton;
@synthesize musicPlayerButton;
@synthesize exercisePlanButton;
@synthesize calendarButton;
@synthesize mealPlanButton;
@synthesize nutritionPlanButton;
@synthesize messageButton;
@synthesize activityIndicator;

// RootViewController class object
RootViewController *m_rootViewController;
// ExerciseViewController class object
ExerciseViewController *m_exerciseViewController;
// MealViewContrioller class object
MealViewController *m_mealViewController;
// CalenderViewController class object
CalenderViewController *m_calenderViewController;
// MusicTracksViewController class object
MusicTracksViewController *m_musicTracksViewController;
// MealViewController class object
MealViewController *m_mealViewController;
// MusicTracksViewController class object
MusicTracksViewController *m_musicTracksViewController;
// SupplementPlanViewController class object
SupplementPlanViewController *m_supplementPlanViewController;
// ViewFactory class object
ViewFactory *m_controllerViews;
// ViewTransition class object
ViewTransitions *m_transition;
// Database class object
Database *m_database;
// Weight data
NSMutableArray *m_weightArray;
// Number of images to display
int m_numberOfImages;
// Week decrementor
int m_decrementWeek;
// Report data
NSMutableArray *m_weeklyReportData;
// End date for weekly work report
NSDate *m_weekEndDate;
// Start date for weekly work report
NSDate *m_weekStartDate;
// Total number of items in work report
int m_totalNumberOfItemsInDataForGraph;
// Selected weight
int m_selectedWeight;
// Before the first label TimeWeight
CGRect m_beforeFirstFrame;
// First Label TimeWeight
CGRect m_firstFrame;
// Second Label TimeWeight
CGRect m_secondFrame;
// Third Label TimeWeight
CGRect m_thirdFrame;
// After the Third Label TimeWeight
CGRect m_afterThirdFrame;
// Check if before first Label value is less zero
int m_beforeFirstWeightLabel;
// To set NSDate to day
NSDateFormatter *m_dateFormatter;
// NSCalender
NSCalendar *m_calendar;
// Today
NSDate *m_today;
// NSDate Componenets
NSDateComponents *m_components;
// For getting the increment on each week
NSDateComponents *m_dayComponent;
NSCalendar *m_theCalendar;
// Set date components
NSDateComponents *m_setDateComponents;
// Month Day
NSDate* m_monthDate;
// Month string
NSString *m_monthString;

UIImageView *reportTimeWeightRepImageView;
UIImageView *reportTimeWeightImageViewMask;
UILabel *weightColorLabel;
UILabel *weightTextLabel;
UILabel *dateLabel;
UIButton *reportButton;
UILabel *beforeFirstWeightLabel;
UILabel *firstWeightLabel;
UILabel *secondWeightLabel;
UILabel *thirdWeightLabel;
UILabel *afterThirdWeightLabel;
UIButton *m_minusTimeWeightRepButton;
UIButton *m_plusTimeWeightRepButton;

/*
 Singleton ProgressViewController object
 */
+ (ProgressViewController *)sharedInstance {
	static ProgressViewController *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 Move to RootViewController
 */
- (IBAction)moveToRootViewController:(id)sender
{
    if (!m_rootViewController) {
        m_rootViewController        = [RootViewController sharedInstance];
    }
    id instanceObject               = m_rootViewController;
    [self moveToView:m_rootViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];

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
 Move to MealViewController
 */
- (void)moveToMealViewController:(id)sender
{
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
    if (!m_calenderViewController) {
        m_calenderViewController    = [CalenderViewController sharedInstance];
    }
    id instanceObject               = m_calenderViewController;
    [self moveToView:m_calenderViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
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
    
    if (!m_transition) {
        m_transition    = [ViewTransitions sharedInstance];
    }
    [m_transition performTransitionFromBottom:self.messageButton];
    
    [UIButton animateWithDuration:5.0f animations:^{self.messageButton.alpha = 0.0;} completion:nil];
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
 Set date with day, month and year
 */
- (void)setDate
{
    if (!m_calendar) {
        m_calendar                = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }

    if (!m_today) {
        m_today                   = [NSDate date];
    }
    
    NSString * dateString;
    // Set Date components
    if (!m_setDateComponents) {
        m_setDateComponents              = [[NSDateComponents alloc] init];
        m_setDateComponents              = [m_calendar components: NSDayCalendarUnit | NSWeekdayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    }

    NSInteger month                  = [m_setDateComponents month];
    NSInteger year                   = [m_setDateComponents year];
    NSInteger day                    = [m_setDateComponents day];
    
    dateString                       = [NSString stringWithFormat: @"%ld", (long)month];

    if (!m_dateFormatter) {
        m_dateFormatter         = [[NSDateFormatter alloc] init];
    }
    [m_dateFormatter setDateFormat:@"MM"];
    
    m_monthDate                 = [m_dateFormatter dateFromString:dateString];
    
    [m_dateFormatter setDateFormat:@"MMMM"];
    m_monthString               = [m_dateFormatter stringFromDate:m_monthDate];
    
    // Display the month and year
    dateLabel.text              = [NSString stringWithFormat:@"%@ %ld/%ld", m_monthString, (long)day, (long)year];
}

/*
 Save the initial label frames
 */
- (void)initialLabelFrames
{
    // Initial frames for the weight/time labels
    m_beforeFirstFrame                 = beforeFirstWeightLabel.frame;
    m_firstFrame                       = firstWeightLabel.frame;
    m_secondFrame                      = secondWeightLabel.frame;
    m_thirdFrame                       = thirdWeightLabel.frame;
    m_afterThirdFrame                  = afterThirdWeightLabel.frame;
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
    
    [self.messageButton removeFromSuperview];
    self.messageButton.titleLabel.font          = [UIFont customFontWithSize:13];
    self.messageButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messageButton.titleLabel.numberOfLines = 2;
    self.messageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.messageButton];
    
    [self setupDateObjects];

    // Weight color label
    CGRect weightColorLabelFrame;
    weightColorLabelFrame                               = CGRectMake(250.0f, 70.0f, 12.0f, 12.0f);
    weightColorLabel                                    = [[UILabel alloc] initWithFrame:weightColorLabelFrame];
    weightColorLabel.backgroundColor                    = [UIColor redColor];
    [self.view addSubview:weightColorLabel];
    
    // Weight text label
    CGRect weightTextLabelFrame;
    weightTextLabelFrame                                = CGRectMake(265.0f, 66.0f, 50.0f, 20.0f);
    weightTextLabel                                     = [[UILabel alloc] initWithFrame:weightTextLabelFrame];
    weightTextLabel.font                                = [UIFont customFontWithSize:11];
    [self.view addSubview:weightTextLabel];
    weightTextLabel.text                                = @"Weight";
    
    // Month and Date label
    CGRect dateLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        dateLabelFrame                                  = CGRectMake(0.0f, 280.0f, 320.0f, 20.0f);
    }
    else {
        dateLabelFrame                                  = CGRectMake(0.0f, 250.0f, 320.0f, 20.0f);
    }
    dateLabel                                           = [[UILabel alloc] initWithFrame:dateLabelFrame];
    dateLabel.font                                      = [UIFont customFontWithSize:15];
    dateLabel.textColor                                 = [UIColor darkGrayColor];
    dateLabel.textAlignment                             = NSTextAlignmentCenter;
    [self.view addSubview:dateLabel];

    // Weight, Time, Repitition ImageView
    CGRect reportWeightImageViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportWeightImageViewFrame                      = CGRectMake(0.0f, 310.0f, 320.0f, 180.0f);
    }
    else {
        reportWeightImageViewFrame                      = CGRectMake(0.0f, 270.0f, 320.0f, 180.0f);
    }
    reportTimeWeightRepImageView                        = [[UIImageView alloc] initWithFrame:reportWeightImageViewFrame];
    reportTimeWeightRepImageView.userInteractionEnabled = YES;
    reportTimeWeightRepImageView.multipleTouchEnabled   = YES;
    reportTimeWeightRepImageView.image                  = [UIImage imageNamed:@"report_weight.png"];
    [self.view addSubview:reportTimeWeightRepImageView];
    
    // Add TimeWeightImageViewMask for gesture recognizing
    CGRect reportTimeWeightImageViewMaskFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportTimeWeightImageViewMaskFrame              = CGRectMake(0.0f, 336.0f, 320.0f, 50.0f);
    }
    else {
        reportTimeWeightImageViewMaskFrame              = CGRectMake(0.0f, 296.0f, 320.0f, 50.0f);
    }
    reportTimeWeightImageViewMask                       = [[UIImageView alloc] initWithFrame:reportTimeWeightImageViewMaskFrame];
    reportTimeWeightImageViewMask.userInteractionEnabled= YES;
    [self.view addSubview:reportTimeWeightImageViewMask];
    self.weightLeftSwipeGesture                         = nil;
    self.weightRightSwipeGesture                        = nil;
    
    // Add left swipe gesture
    UISwipeGestureRecognizer *timeWeightLeftSwipeGestureLocal                 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [timeWeightLeftSwipeGestureLocal setDirection:UISwipeGestureRecognizerDirectionLeft];
    self.weightLeftSwipeGesture             = timeWeightLeftSwipeGestureLocal;
    [reportTimeWeightImageViewMask addGestureRecognizer:self.weightLeftSwipeGesture];
    
    // Add right swipe gesture
    UISwipeGestureRecognizer *timeWeightRightSwipeGestureLocal                = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [timeWeightRightSwipeGestureLocal setDirection:UISwipeGestureRecognizerDirectionRight];
    self.weightRightSwipeGesture            = timeWeightRightSwipeGestureLocal;
    [reportTimeWeightImageViewMask addGestureRecognizer:self.weightRightSwipeGesture];

    CGRect minusTimeWeightRepButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        minusTimeWeightRepButtonFrame              = CGRectMake(0.0f, 337.0f, 33.0f, 50.0f);
    }
    else {
        minusTimeWeightRepButtonFrame              = CGRectMake(0.0f, 286.0f, 33.0f, 157.0f);
    }
    m_minusTimeWeightRepButton                      = [[UIButton alloc] initWithFrame:minusTimeWeightRepButtonFrame];
    [self.view addSubview:m_minusTimeWeightRepButton];
    [m_minusTimeWeightRepButton addTarget:self action:@selector(minusWeightby10:) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:m_minusTimeWeightRepButton];
    
    CGRect plusTimeWeightRepButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        plusTimeWeightRepButtonFrame              = CGRectMake(287.0f, 337.0f, 33.0f, 50.0f);
    }
    else {
        plusTimeWeightRepButtonFrame              = CGRectMake(287.0f, 286.0f, 33.0f, 157.0f);
    }
    m_plusTimeWeightRepButton                      = [[UIButton alloc] initWithFrame:plusTimeWeightRepButtonFrame];
    [self.view addSubview:m_plusTimeWeightRepButton];
    [m_plusTimeWeightRepButton addTarget:self action:@selector(plusWeightby10:) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:m_plusTimeWeightRepButton];

    // Add Time Save Report Button
    CGRect reportTimeDoneButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportTimeDoneButtonFrame                  = CGRectMake(10.0f, 417.0f, 300.0f, 45.f);
    }
    else {
        reportTimeDoneButtonFrame                  = CGRectMake(10.0f, 377.0f, 300.0f, 45.f);
    }
    reportButton                                   = [[UIButton alloc] initWithFrame:reportTimeDoneButtonFrame];
    [reportButton addTarget:self action:@selector(saveReport:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reportButton];

    // Default weight is 150 pnds
    m_selectedWeight                             = 150;
    
    // Assign values for the labels
    m_beforeFirstWeightLabel                     = 148;
    
    // before first time weight label
    CGRect beforeFirstTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        beforeFirstTimeWeightLabelFrame     = CGRectMake(20.0f, 355.0f, 40.0f, 20.0f);
    }
    else {
        beforeFirstTimeWeightLabelFrame     = CGRectMake(20.0f, 315.0f, 40.0f, 20.0f);
    }
    beforeFirstWeightLabel                  = [[UILabel alloc] initWithFrame:beforeFirstTimeWeightLabelFrame];
    beforeFirstWeightLabel.font             = [UIFont customFontWithSize:20];
    beforeFirstWeightLabel.backgroundColor  = [UIColor clearColor];
    beforeFirstWeightLabel.textColor        = [UIColor darkGrayColor];
    // Helps when there is only a single digit value
    beforeFirstWeightLabel.textAlignment    = NSTextAlignmentCenter;
    beforeFirstWeightLabel.hidden           = YES;
    [self.view addSubview:beforeFirstWeightLabel];
    beforeFirstWeightLabel.text             = @"148";
    
    // first time weight label
    CGRect firstTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        firstTimeWeightLabelFrame           = CGRectMake(65.0f, 355.0f, 40.0f, 20.0f);
    }
    else {
        firstTimeWeightLabelFrame           = CGRectMake(65.0f, 315.0f, 40.0f, 20.0f);
    }
    firstWeightLabel                        = [[UILabel alloc] initWithFrame:firstTimeWeightLabelFrame];
    firstWeightLabel.font                   = [UIFont customFontWithSize:20];
    firstWeightLabel.backgroundColor        = [UIColor clearColor];
    firstWeightLabel.textColor              = [UIColor darkGrayColor];
    // Helps when there is only a single digit value
    firstWeightLabel.textAlignment          = NSTextAlignmentCenter;
    [self.view addSubview:firstWeightLabel];
    firstWeightLabel.text                   = @"149";
    
    // second time weight label
    CGRect secondTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        secondTimeWeightLabelFrame          = CGRectMake(140.0f, 355.0f, 40.0f, 20.0f);
    }
    else {
        secondTimeWeightLabelFrame          = CGRectMake(140.0f, 315.0f, 40.0f, 20.0f);
    }
    secondWeightLabel                       = [[UILabel alloc] initWithFrame:secondTimeWeightLabelFrame];
    secondWeightLabel.font                  = [UIFont customFontWithSize:20];
    secondWeightLabel.backgroundColor       = [UIColor clearColor];
    secondWeightLabel.textColor             = [UIColor redColor];
    // Helps when there is only a single digit value
    secondWeightLabel.textAlignment         = NSTextAlignmentCenter;
    [self.view addSubview:secondWeightLabel];
    secondWeightLabel.text                  = @"150";
    
    // third time weight label
    CGRect thirdTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        thirdTimeWeightLabelFrame           = CGRectMake(210.0f, 355.0f, 40.0f, 20.0f);
    }
    else {
        thirdTimeWeightLabelFrame           = CGRectMake(210.0f, 315.0f, 40.0f, 20.0f);
    }
    thirdWeightLabel                        = [[UILabel alloc] initWithFrame:thirdTimeWeightLabelFrame];
    thirdWeightLabel.font                   = [UIFont customFontWithSize:20];
    thirdWeightLabel.backgroundColor        = [UIColor clearColor];
    thirdWeightLabel.textColor              = [UIColor darkGrayColor];
    [self.view addSubview:thirdWeightLabel];
    thirdWeightLabel.text                   = @"151";
    // Helps when there is only a single digit value
    thirdWeightLabel.textAlignment          = NSTextAlignmentCenter;
    
    // before third time weight label
    CGRect afterThirdTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        afterThirdTimeWeightLabelFrame      = CGRectMake(255.0f, 355.0f, 40.0f, 20.0f);
    }
    else {
        afterThirdTimeWeightLabelFrame      = CGRectMake(255.0f, 315.0f, 40.0f, 20.0f);
    }
    afterThirdWeightLabel                   = [[UILabel alloc] initWithFrame:afterThirdTimeWeightLabelFrame];
    afterThirdWeightLabel.font              = [UIFont customFontWithSize:20];
    afterThirdWeightLabel.backgroundColor   = [UIColor clearColor];
    afterThirdWeightLabel.textColor         = [UIColor darkGrayColor];
    afterThirdWeightLabel.hidden            = YES;
    [self.view addSubview:afterThirdWeightLabel];
    afterThirdWeightLabel.text              = @"152";
    // Helps when there is only a single digit value
    afterThirdWeightLabel.textAlignment     = NSTextAlignmentCenter;

    // save initial label frames
    [self initialLabelFrames];
    
    // set up the control buttons
    [self addSelectorToControlButtons];
    
    // start the activity indicator
    [self.activityIndicator startAnimating];
    
    if (!m_database) {
        m_database                  = [Database alloc];
    }
    
    [self setDate];

}

- (void)viewWillAppear:(BOOL)animated
{
    // loadup the graph
    [self loadDataForGraph];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    // To set NSDate to day
    m_dateFormatter         = nil;
    m_theCalendar           = nil;
    // Set date components
    m_setDateComponents     = nil;
}

/*
 Get Average of weekly data
 */
- (void)getAverageFromWeeklyData:(NSMutableArray *)weeklyReportData
{
    int theweight                                 = 0;
    if (weeklyReportData) {
        NSUInteger totalNumberOfItemsInDataForGraph      = [weeklyReportData count];
        if (totalNumberOfItemsInDataForGraph) {
            for (int i = 0; i < totalNumberOfItemsInDataForGraph; i++) {
                theweight          += [[weeklyReportData objectAtIndex:i]   intValue];
            }
            int averageWeight                     = theweight/totalNumberOfItemsInDataForGraph;
            [m_weightArray addObject:[NSNumber numberWithInt:averageWeight]];
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
    m_dayComponent.day              = m_decrementWeek;
    
    m_weekEndDate                   = [m_theCalendar dateByAddingComponents:m_dayComponent toDate:m_weekEndDate options:0];
    
    // drecrement by 7 days for the next week
    m_decrementWeek                -= 7;
    // Clean up the report data
    m_weeklyReportData              = nil;
    if (!m_weeklyReportData) {
        m_weeklyReportData          = [NSMutableArray mutableArrayObject];
    }
    
    if ((m_weekStartDate) && (m_weekEndDate)) {
        m_weeklyReportData          = [m_database getAverageExerciseReportForAWeek:[NSString getUserEmail] StartDate:m_weekStartDate EndDate:m_weekEndDate];
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
    // Initialize to store weight
    m_weightArray                           = nil;
    if (!m_weightArray) {
        m_weightArray                       = [NSMutableArray mutableArrayObject];
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
}

/*
 Increment Weight labels by 10
 */
- (void)plusWeightby10:(id)sender
{
    [UILabel incrementBy10OnLabelOne:beforeFirstWeightLabel LabelTwo:firstWeightLabel  LabelThree:secondWeightLabel LabelFour:thirdWeightLabel LabelFive:afterThirdWeightLabel];
}

/*
 Decrement Weight labels by 10
 */
- (void)minusWeightby10:(id)sender
{
    if ([secondWeightLabel.text intValue] > 5) {
        [UILabel decrementBy10OnLabelOne:beforeFirstWeightLabel LabelTwo:firstWeightLabel  LabelThree:secondWeightLabel LabelFour:thirdWeightLabel LabelFive:afterThirdWeightLabel];
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
                value                       = value + 5;
        }
        else if (label.frame.origin.x == m_beforeFirstFrame.origin.x) {
            m_beforeFirstWeightLabel        = value;
        }
    }
    else if([incrementOrDecrement isEqualToString:@"Right"]) {
        if (label.frame.origin.x == m_beforeFirstFrame.origin.x) {
                value                       = value - 5;
                m_beforeFirstWeightLabel    = value;
        }
    }
    
    // Get the selected Weight or Time
    if (label.frame.origin.x == m_secondFrame.origin.x) {
        m_selectedWeight                    = [label.text intValue];
    }
    
    return value;
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
        else if(label.frame.origin.x == m_firstFrame.origin.x) {
            label.frame            = m_secondFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor redColor];
        }
        else if(label.frame.origin.x == m_secondFrame.origin.x) {
            label.frame            = m_thirdFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == m_thirdFrame.origin.x) {
            label.frame            = m_afterThirdFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if (label.frame.origin.x == m_afterThirdFrame.origin.x) {
            label.frame            = m_beforeFirstFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor darkGrayColor];
        }
        [UIView commitAnimations];
        
        // Change the before first value
        label.text             = [NSString stringWithFormat:@"%d", [self incrementOrDecrement:@"Right" WeightTimeValue:label]];
    }
}

/*
 Animate weight labels to left
 */
- (void)animateWeightLabelsToLeft
{
    // Animate the first label
    [self animateLeftOrRight:@"Left" TimeWeightLabel:firstWeightLabel];
    // Animate the second label
    [self animateLeftOrRight:@"Left" TimeWeightLabel:secondWeightLabel];
    // Animate the third label
    [self animateLeftOrRight:@"Left" TimeWeightLabel:thirdWeightLabel];
    // Animate after third label
    [self animateLeftOrRight:@"Left" TimeWeightLabel:afterThirdWeightLabel];
    // Animate before first label, do this last to get the value from the label to be used to check if it is zero
    [self animateLeftOrRight:@"Left" TimeWeightLabel:beforeFirstWeightLabel];
}

/*
 Animate weight labels to right
 */
- (void)animateWeightLabelsToRight
{
    // Animate first label
    [self animateLeftOrRight:@"Right" TimeWeightLabel:firstWeightLabel];
    // Animate second label
    [self animateLeftOrRight:@"Right" TimeWeightLabel:secondWeightLabel];
    // Animate third label
    [self animateLeftOrRight:@"Right" TimeWeightLabel:thirdWeightLabel];
    // Animate after third label
    [self animateLeftOrRight:@"Right" TimeWeightLabel:afterThirdWeightLabel];
    // Animate before first label, do this last to get the value from the label to be used to check if it is zero
    [self animateLeftOrRight:@"Right" TimeWeightLabel:beforeFirstWeightLabel];
    
}

/*
 In response to left or right swipe gesture, to move the next or previous image.
 */
- (IBAction)handleSwipe:(UISwipeGestureRecognizer *)swipeRecognizer
{    
    if (swipeRecognizer == self.weightLeftSwipeGesture) {
        [self animateWeightLabelsToLeft];
    }
    else if (swipeRecognizer == self.weightRightSwipeGesture) {
        
        if(m_beforeFirstWeightLabel >= 0) { // If before first label value is less than zero, do nothing
            [self animateWeightLabelsToRight];
        }
    }
}

/*
 Save Report
 */
- (void)saveReport:(id)sender
{
    NSString *exerciseReportStatus            = @"";
            
    // Convert int weight time value into nsnumber
    NSNumber *weight                          = [NSNumber numberWithInt:m_selectedWeight];
    
    if ((weight)) { // make sure that weight and rep of the first set is not empty
        if (weight != NULL) { // Make there is no null in the numbers
            
            if (!m_database) {
                m_database                    = [Database alloc];
            }
            exerciseReportStatus              = [m_database insertIntoExerciseReportWeight:weight Email_Id:[NSString getUserEmail]];
        
            if ([exerciseReportStatus isEqualToString:@"inserted"]) {
                [self displayMessage:@"Weight was successfully saved."];
            }
            else {
                [self displayMessage:@"Failed to save weight."];
            }
        }
    }
    else {
        [self displayMessage:@"Please enter weight and rep from the first set."];
    }
    
    // loadup the graph
    [self loadDataForGraph];
    
}

-(void)configureHost {
    CGRect frame;
    frame.origin.x                                  = -290.0f;
    frame.origin.y                                  = 0.0f;
    frame.size.width                                = 650.0f;
    frame.size.height                               = 340.0f;

}



@end
