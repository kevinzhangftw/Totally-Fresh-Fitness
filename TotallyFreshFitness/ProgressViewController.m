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

// RootViewController class object
@property (strong, nonatomic)RootViewController *m_rootViewController;
// ExerciseViewController class object
@property (strong, nonatomic)ExerciseViewController *m_exerciseViewController;
// MealViewContrioller class object
@property (strong, nonatomic)MealViewController *m_mealViewController;
// CalenderViewController class object
@property (strong, nonatomic)CalenderViewController *m_calenderViewController;
// MusicTracksViewController class object
@property (strong, nonatomic)MusicTracksViewController *m_musicTracksViewController;
//// MealViewController class object
//@property (strong, nonatomic)MealViewController *m_mealViewController;
//// MusicTracksViewController class object
//@property (strong, nonatomic)MusicTracksViewController *m_musicTracksViewController;
// SupplementPlanViewController class object
@property (strong, nonatomic)SupplementPlanViewController *m_supplementPlanViewController;
// ViewFactory class object
@property (strong, nonatomic)ViewFactory *m_controllerViews;
// ViewTransition class object
@property (strong, nonatomic)ViewTransitions *m_transition;
// Database class object
@property (strong, nonatomic)Database *m_database;
// Weight data
@property (strong, nonatomic)NSMutableArray *m_weightArray;
// Number of images to display
@property (nonatomic)int m_numberOfImages;
// Week decrementor
@property (nonatomic)int m_decrementWeek;
// Report data
@property (strong, nonatomic)NSMutableArray *m_weeklyReportData;
// End date for weekly work report
@property (strong, nonatomic)NSDate *m_weekEndDate;
// Start date for weekly work report
@property (strong, nonatomic)NSDate *m_weekStartDate;
// Total number of items in work report
@property (nonatomic)int m_totalNumberOfItemsInDataForGraph;
// Selected weight
@property (nonatomic)int m_selectedWeight;
// Before the first label TimeWeight
@property (nonatomic)CGRect m_beforeFirstFrame;
// First Label TimeWeight
@property (nonatomic)CGRect m_firstFrame;
// Second Label TimeWeight
@property (nonatomic)CGRect m_secondFrame;
// Third Label TimeWeight
@property (nonatomic)CGRect m_thirdFrame;
// After the Third Label TimeWeight
@property (nonatomic)CGRect m_afterThirdFrame;
// Check if before first Label value is less zero
@property (nonatomic)int m_beforeFirstWeightLabel;
// To set NSDate to day
@property (strong, nonatomic)NSDateFormatter *m_dateFormatter;
// NSCalender
@property (strong, nonatomic)NSCalendar *m_calendar;
// Today
@property (strong, nonatomic)NSDate *m_today;
// NSDate Componenets
@property (strong, nonatomic)NSDateComponents *m_components;
// For getting the increment on each week
@property (strong, nonatomic)NSDateComponents *m_dayComponent;
@property (strong, nonatomic)NSCalendar *m_theCalendar;
// Set date components
@property (strong, nonatomic)NSDateComponents *m_setDateComponents;
// Month Day
@property (strong, nonatomic)NSDate* m_monthDate;
// Month string
@property (strong, nonatomic)NSString *m_monthString;

@property (strong, nonatomic)UIImageView *reportTimeWeightRepImageView;
@property (strong, nonatomic)UIImageView *reportTimeWeightImageViewMask;
@property (strong, nonatomic)UILabel *weightColorLabel;
@property (strong, nonatomic)UILabel *weightTextLabel;
@property (strong, nonatomic)UILabel *dateLabel;
@property (strong, nonatomic)UIButton *reportButton;
@property (strong, nonatomic)UILabel *beforeFirstWeightLabel;
@property (strong, nonatomic)UILabel *firstWeightLabel;
@property (strong, nonatomic)UILabel *secondWeightLabel;
@property (strong, nonatomic)UILabel *thirdWeightLabel;
@property (strong, nonatomic)UILabel *afterThirdWeightLabel;
@property (strong, nonatomic)UIButton *m_minusTimeWeightRepButton;
@property (strong, nonatomic)UIButton *m_plusTimeWeightRepButton;

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
    [self.navigationController popToRootViewControllerAnimated:NO];

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
        self.m_transition    = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionFromBottom:self.messageButton];
    
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
    if (!self.m_calendar) {
        self.m_calendar                = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }

    if (!self.m_today) {
        self.m_today                   = [NSDate date];
    }
    
    NSString * dateString;
    // Set Date components
    if (!self.m_setDateComponents) {
        self.m_setDateComponents              = [[NSDateComponents alloc] init];
        self.m_setDateComponents              = [self.m_calendar components: NSDayCalendarUnit | NSWeekdayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    }

    NSInteger month                  = [self.m_setDateComponents month];
    NSInteger year                   = [self.m_setDateComponents year];
    NSInteger day                    = [self.m_setDateComponents day];
    
    dateString                       = [NSString stringWithFormat: @"%ld", (long)month];

    if (!self.m_dateFormatter) {
        self.m_dateFormatter         = [[NSDateFormatter alloc] init];
    }
    [self.m_dateFormatter setDateFormat:@"MM"];
    
    self.m_monthDate                 = [self.m_dateFormatter dateFromString:dateString];
    
    [self.m_dateFormatter setDateFormat:@"MMMM"];
    self.m_monthString               = [self.m_dateFormatter stringFromDate:self.m_monthDate];
    
    // Display the month and year
    self.dateLabel.text              = [NSString stringWithFormat:@"%@ %ld/%ld", self.m_monthString, (long)day, (long)year];
}

/*
 Save the initial label frames
 */
- (void)initialLabelFrames
{
    // Initial frames for the weight/time labels
    self.m_beforeFirstFrame                 = self.beforeFirstWeightLabel.frame;
    self.m_firstFrame                       = self.firstWeightLabel.frame;
    self.m_secondFrame                      = self.secondWeightLabel.frame;
    self.m_thirdFrame                       = self.thirdWeightLabel.frame;
    self.m_afterThirdFrame                  = self.afterThirdWeightLabel.frame;
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
    self.weightColorLabel                                    = [[UILabel alloc] initWithFrame:weightColorLabelFrame];
    self.weightColorLabel.backgroundColor                    = [UIColor redColor];
    [self.view addSubview:self.weightColorLabel];
    
    // Weight text label
    CGRect weightTextLabelFrame;
    weightTextLabelFrame                                = CGRectMake(265.0f, 66.0f, 50.0f, 20.0f);
    self.weightTextLabel                                     = [[UILabel alloc] initWithFrame:weightTextLabelFrame];
    self.weightTextLabel.font                                = [UIFont customFontWithSize:11];
    [self.view addSubview:self.weightTextLabel];
    self.weightTextLabel.text                                = @"Weight";
    
    // Month and Date label
    CGRect dateLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        dateLabelFrame                                  = CGRectMake(0.0f, 280.0f, 320.0f, 20.0f);
    }
    else {
        dateLabelFrame                                  = CGRectMake(0.0f, 250.0f, 320.0f, 20.0f);
    }
    self.dateLabel                                           = [[UILabel alloc] initWithFrame:dateLabelFrame];
    self.dateLabel.font                                      = [UIFont customFontWithSize:15];
    self.dateLabel.textColor                                 = [UIColor darkGrayColor];
    self.dateLabel.textAlignment                             = NSTextAlignmentCenter;
    [self.view addSubview:self.dateLabel];

    // Weight, Time, Repitition ImageView
    CGRect reportWeightImageViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportWeightImageViewFrame                      = CGRectMake(0.0f, 310.0f, 320.0f, 180.0f);
    }
    else {
        reportWeightImageViewFrame                      = CGRectMake(0.0f, 270.0f, 320.0f, 180.0f);
    }
    self.reportTimeWeightRepImageView                        = [[UIImageView alloc] initWithFrame:reportWeightImageViewFrame];
    self.reportTimeWeightRepImageView.userInteractionEnabled = YES;
    self.reportTimeWeightRepImageView.multipleTouchEnabled   = YES;
    self.reportTimeWeightRepImageView.image                  = [UIImage imageNamed:@"report_weight.png"];
    [self.view addSubview:self.reportTimeWeightRepImageView];
    
    // Add TimeWeightImageViewMask for gesture recognizing
    CGRect reportTimeWeightImageViewMaskFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportTimeWeightImageViewMaskFrame              = CGRectMake(0.0f, 336.0f, 320.0f, 50.0f);
    }
    else {
        reportTimeWeightImageViewMaskFrame              = CGRectMake(0.0f, 296.0f, 320.0f, 50.0f);
    }
    self.reportTimeWeightImageViewMask                       = [[UIImageView alloc] initWithFrame:reportTimeWeightImageViewMaskFrame];
    self.reportTimeWeightImageViewMask.userInteractionEnabled= YES;
    [self.view addSubview:self.reportTimeWeightImageViewMask];
    self.weightLeftSwipeGesture                         = nil;
    self.weightRightSwipeGesture                        = nil;
    
    // Add left swipe gesture
    UISwipeGestureRecognizer *timeWeightLeftSwipeGestureLocal                 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [timeWeightLeftSwipeGestureLocal setDirection:UISwipeGestureRecognizerDirectionLeft];
    self.weightLeftSwipeGesture             = timeWeightLeftSwipeGestureLocal;
    [self.reportTimeWeightImageViewMask addGestureRecognizer:self.weightLeftSwipeGesture];
    
    // Add right swipe gesture
    UISwipeGestureRecognizer *timeWeightRightSwipeGestureLocal                = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [timeWeightRightSwipeGestureLocal setDirection:UISwipeGestureRecognizerDirectionRight];
    self.weightRightSwipeGesture            = timeWeightRightSwipeGestureLocal;
    [self.reportTimeWeightImageViewMask addGestureRecognizer:self.weightRightSwipeGesture];

    CGRect minusTimeWeightRepButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        minusTimeWeightRepButtonFrame              = CGRectMake(0.0f, 337.0f, 33.0f, 50.0f);
    }
    else {
        minusTimeWeightRepButtonFrame              = CGRectMake(0.0f, 286.0f, 33.0f, 157.0f);
    }
    self.m_minusTimeWeightRepButton                      = [[UIButton alloc] initWithFrame:minusTimeWeightRepButtonFrame];
    [self.view addSubview:self.m_minusTimeWeightRepButton];
    [self.m_minusTimeWeightRepButton addTarget:self action:@selector(minusWeightby10:) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:self.m_minusTimeWeightRepButton];
    
    CGRect plusTimeWeightRepButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        plusTimeWeightRepButtonFrame              = CGRectMake(287.0f, 337.0f, 33.0f, 50.0f);
    }
    else {
        plusTimeWeightRepButtonFrame              = CGRectMake(287.0f, 286.0f, 33.0f, 157.0f);
    }
    self.m_plusTimeWeightRepButton                      = [[UIButton alloc] initWithFrame:plusTimeWeightRepButtonFrame];
    [self.view addSubview:self.m_plusTimeWeightRepButton];
    [self.m_plusTimeWeightRepButton addTarget:self action:@selector(plusWeightby10:) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:self.m_plusTimeWeightRepButton];

    // Add Time Save Report Button
    CGRect reportTimeDoneButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        reportTimeDoneButtonFrame                  = CGRectMake(10.0f, 417.0f, 300.0f, 45.f);
    }
    else {
        reportTimeDoneButtonFrame                  = CGRectMake(10.0f, 377.0f, 300.0f, 45.f);
    }
    self.reportButton                                   = [[UIButton alloc] initWithFrame:reportTimeDoneButtonFrame];
    [self.reportButton addTarget:self action:@selector(saveReport:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.reportButton];

    // Default weight is 150 pnds
    self.m_selectedWeight                             = 150;
    
    // Assign values for the labels
    self.m_beforeFirstWeightLabel                     = 148;
    
    // before first time weight label
    CGRect beforeFirstTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        beforeFirstTimeWeightLabelFrame     = CGRectMake(20.0f, 355.0f, 40.0f, 20.0f);
    }
    else {
        beforeFirstTimeWeightLabelFrame     = CGRectMake(20.0f, 315.0f, 40.0f, 20.0f);
    }
    self.beforeFirstWeightLabel                  = [[UILabel alloc] initWithFrame:beforeFirstTimeWeightLabelFrame];
    self.beforeFirstWeightLabel.font             = [UIFont customFontWithSize:20];
    self.beforeFirstWeightLabel.backgroundColor  = [UIColor clearColor];
    self.beforeFirstWeightLabel.textColor        = [UIColor darkGrayColor];
    // Helps when there is only a single digit value
    self.beforeFirstWeightLabel.textAlignment    = NSTextAlignmentCenter;
    self.beforeFirstWeightLabel.hidden           = YES;
    [self.view addSubview:self.beforeFirstWeightLabel];
    self.beforeFirstWeightLabel.text             = @"148";
    
    // first time weight label
    CGRect firstTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        firstTimeWeightLabelFrame           = CGRectMake(65.0f, 355.0f, 40.0f, 20.0f);
    }
    else {
        firstTimeWeightLabelFrame           = CGRectMake(65.0f, 315.0f, 40.0f, 20.0f);
    }
    self.firstWeightLabel                        = [[UILabel alloc] initWithFrame:firstTimeWeightLabelFrame];
    self.firstWeightLabel.font                   = [UIFont customFontWithSize:20];
    self.firstWeightLabel.backgroundColor        = [UIColor clearColor];
    self.firstWeightLabel.textColor              = [UIColor darkGrayColor];
    // Helps when there is only a single digit value
    self.firstWeightLabel.textAlignment          = NSTextAlignmentCenter;
    [self.view addSubview:self.firstWeightLabel];
    self.firstWeightLabel.text                   = @"149";
    
    // second time weight label
    CGRect secondTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        secondTimeWeightLabelFrame          = CGRectMake(140.0f, 355.0f, 40.0f, 20.0f);
    }
    else {
        secondTimeWeightLabelFrame          = CGRectMake(140.0f, 315.0f, 40.0f, 20.0f);
    }
    self.secondWeightLabel                       = [[UILabel alloc] initWithFrame:secondTimeWeightLabelFrame];
    self.secondWeightLabel.font                  = [UIFont customFontWithSize:20];
    self.secondWeightLabel.backgroundColor       = [UIColor clearColor];
    self.secondWeightLabel.textColor             = [UIColor redColor];
    // Helps when there is only a single digit value
    self.secondWeightLabel.textAlignment         = NSTextAlignmentCenter;
    [self.view addSubview:self.secondWeightLabel];
    self.secondWeightLabel.text                  = @"150";
    
    // third time weight label
    CGRect thirdTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        thirdTimeWeightLabelFrame           = CGRectMake(210.0f, 355.0f, 40.0f, 20.0f);
    }
    else {
        thirdTimeWeightLabelFrame           = CGRectMake(210.0f, 315.0f, 40.0f, 20.0f);
    }
    self.thirdWeightLabel                        = [[UILabel alloc] initWithFrame:thirdTimeWeightLabelFrame];
    self.thirdWeightLabel.font                   = [UIFont customFontWithSize:20];
    self.thirdWeightLabel.backgroundColor        = [UIColor clearColor];
    self.thirdWeightLabel.textColor              = [UIColor darkGrayColor];
    [self.view addSubview:self.thirdWeightLabel];
    self.thirdWeightLabel.text                   = @"151";
    // Helps when there is only a single digit value
    self.thirdWeightLabel.textAlignment          = NSTextAlignmentCenter;
    
    // before third time weight label
    CGRect afterThirdTimeWeightLabelFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        afterThirdTimeWeightLabelFrame      = CGRectMake(255.0f, 355.0f, 40.0f, 20.0f);
    }
    else {
        afterThirdTimeWeightLabelFrame      = CGRectMake(255.0f, 315.0f, 40.0f, 20.0f);
    }
    self.afterThirdWeightLabel                   = [[UILabel alloc] initWithFrame:afterThirdTimeWeightLabelFrame];
    self.afterThirdWeightLabel.font              = [UIFont customFontWithSize:20];
    self.afterThirdWeightLabel.backgroundColor   = [UIColor clearColor];
    self.afterThirdWeightLabel.textColor         = [UIColor darkGrayColor];
    self.afterThirdWeightLabel.hidden            = YES;
    [self.view addSubview:self.afterThirdWeightLabel];
    self.afterThirdWeightLabel.text              = @"152";
    // Helps when there is only a single digit value
    self.afterThirdWeightLabel.textAlignment     = NSTextAlignmentCenter;

    // save initial label frames
    [self initialLabelFrames];
    
    // set up the control buttons
    [self addSelectorToControlButtons];
    
    // start the activity indicator
    [self.activityIndicator startAnimating];
    
    if (!self.m_database) {
        self.m_database                  = [Database alloc];
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
    self.m_dateFormatter         = nil;
    self.m_theCalendar           = nil;
    // Set date components
    self.m_setDateComponents     = nil;
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
            [self.m_weightArray addObject:[NSNumber numberWithInt:averageWeight]];
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
   self. m_dayComponent.day              = self.m_decrementWeek;
    
    self.m_weekEndDate                   = [self.m_theCalendar dateByAddingComponents:self.m_dayComponent toDate:self.m_weekEndDate options:0];
    
    // drecrement by 7 days for the next week
    self.m_decrementWeek                -= 7;
    // Clean up the report data
    self.m_weeklyReportData              = nil;
    if (!self.m_weeklyReportData) {
        self.m_weeklyReportData          = [NSMutableArray mutableArrayObject];
    }
    
    if ((self.m_weekStartDate) && (self.m_weekEndDate)) {
        self.m_weeklyReportData          = [self.m_database getAverageExerciseReportForAWeek:[NSString getUserEmail] StartDate:self.m_weekStartDate EndDate:self.m_weekEndDate];
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
    // Initialize to store weight
    self.m_weightArray                           = nil;
    if (!self.m_weightArray) {
        self.m_weightArray                       = [NSMutableArray mutableArrayObject];
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
}

/*
 Increment Weight labels by 10
 */
- (void)plusWeightby10:(id)sender
{
    [UILabel incrementBy10OnLabelOne:self.beforeFirstWeightLabel LabelTwo:self.firstWeightLabel  LabelThree:self.secondWeightLabel LabelFour:self.thirdWeightLabel LabelFive:self.afterThirdWeightLabel];
}

/*
 Decrement Weight labels by 10
 */
- (void)minusWeightby10:(id)sender
{
    if ([self.secondWeightLabel.text intValue] > 5) {
        [UILabel decrementBy10OnLabelOne:self.beforeFirstWeightLabel LabelTwo:self.firstWeightLabel  LabelThree:self.secondWeightLabel LabelFour:self.thirdWeightLabel LabelFive:self.afterThirdWeightLabel];
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
                value                       = value + 5;
        }
        else if (label.frame.origin.x == self.m_beforeFirstFrame.origin.x) {
            self.m_beforeFirstWeightLabel        = value;
        }
    }
    else if([incrementOrDecrement isEqualToString:@"Right"]) {
        if (label.frame.origin.x == self.m_beforeFirstFrame.origin.x) {
                value                       = value - 5;
                self.m_beforeFirstWeightLabel    = value;
        }
    }
    
    // Get the selected Weight or Time
    if (label.frame.origin.x == self.m_secondFrame.origin.x) {
        self.m_selectedWeight                    = [label.text intValue];
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
        else if(label.frame.origin.x == self.m_firstFrame.origin.x) {
            label.frame            = self.m_secondFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor redColor];
        }
        else if(label.frame.origin.x == self.m_secondFrame.origin.x) {
            label.frame            = self.m_thirdFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if(label.frame.origin.x == self.m_thirdFrame.origin.x) {
            label.frame            = self.m_afterThirdFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor darkGrayColor];
        }
        else if (label.frame.origin.x == self.m_afterThirdFrame.origin.x) {
            label.frame            = self.m_beforeFirstFrame;
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
    [self animateLeftOrRight:@"Left" TimeWeightLabel:self.firstWeightLabel];
    // Animate the second label
    [self animateLeftOrRight:@"Left" TimeWeightLabel:self.secondWeightLabel];
    // Animate the third label
    [self animateLeftOrRight:@"Left" TimeWeightLabel:self.thirdWeightLabel];
    // Animate after third label
    [self animateLeftOrRight:@"Left" TimeWeightLabel:self.afterThirdWeightLabel];
    // Animate before first label, do this last to get the value from the label to be used to check if it is zero
    [self animateLeftOrRight:@"Left" TimeWeightLabel:self.beforeFirstWeightLabel];
}

/*
 Animate weight labels to right
 */
- (void)animateWeightLabelsToRight
{
    // Animate first label
    [self animateLeftOrRight:@"Right" TimeWeightLabel:self.firstWeightLabel];
    // Animate second label
    [self animateLeftOrRight:@"Right" TimeWeightLabel:self.secondWeightLabel];
    // Animate third label
    [self animateLeftOrRight:@"Right" TimeWeightLabel:self.thirdWeightLabel];
    // Animate after third label
    [self animateLeftOrRight:@"Right" TimeWeightLabel:self.afterThirdWeightLabel];
    // Animate before first label, do this last to get the value from the label to be used to check if it is zero
    [self animateLeftOrRight:@"Right" TimeWeightLabel:self.beforeFirstWeightLabel];
    
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
        
        if(self.m_beforeFirstWeightLabel >= 0) { // If before first label value is less than zero, do nothing
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
    NSNumber *weight                          = [NSNumber numberWithInt:self.m_selectedWeight];
    
    if ((weight)) { // make sure that weight and rep of the first set is not empty
        if (weight != NULL) { // Make there is no null in the numbers
            
            if (!self.m_database) {
                self.m_database                    = [Database alloc];
            }
            exerciseReportStatus              = [self.m_database insertIntoExerciseReportWeight:weight Email_Id:[NSString getUserEmail]];
        
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
