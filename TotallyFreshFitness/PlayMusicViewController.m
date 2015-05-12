//
//  PlayMusicViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-06-08.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "PlayMusicViewController.h"
#import "NSString+Music_Mix.h"

@interface PlayMusicViewController ()

@end

// ExerciseViewController class object
ExerciseViewController *m_exerciseViewController;
// MealViewContrioller class object
MealViewController *m_mealViewController;
// CalenderViewController class object
CalenderViewController *m_calenderViewController;
// MusicTracksViewController class object
MusicTracksViewController *m_musicTracksViewController;
// SupplementPlanViewController class object
SupplementPlanViewController *m_supplementPlanViewController;
// ViewFactory class object
ViewFactory *m_controllerViews;
// ViewTransitions class object
ViewTransitions *m_transition;

@implementation PlayMusicViewController

@synthesize topNavigationBar;
@synthesize backButton;
@synthesize bottomBarButton;
@synthesize musicPlayerButton;
@synthesize exercisePlanButton;
@synthesize calendarButton;
@synthesize mealPlanButton;
@synthesize nutritionPlanButton;
@synthesize webView;

/*
 Singleton PlayMusicViewController object
 */
+ (PlayMusicViewController *)sharedInstance {
	static PlayMusicViewController *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 Move to Back
 */
- (IBAction)goBack:(id)sender
{
    if (!m_transition) {
        m_transition    = [ViewTransitions sharedInstance];
    }
    [m_transition performTransitionFromLeft:self.view.superview];
    [self.view removeFromSuperview];
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
 Move to MusicTracksViewController
 */
- (void)moveToMusicTracksViewController:(id)sender
{
    if (!m_musicTracksViewController) {
        m_musicTracksViewController = [MusicTracksViewController sharedInstance];
    }
    id instanceObject               = m_musicTracksViewController;
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
        CGRect frame                = CGRectMake(0.0f, 64.0f, 320.0f, 460.0f);
        [self.webView removeFromSuperview];
        self.webView                = [[UIWebView alloc] initWithFrame:frame];
        [self.view addSubview:self.webView];
    }
    
    self.webView.delegate       = self;
    
    // set selector control buttons
    [self addSelectorToControlButtons];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.activityIndicator removeFromSuperview];
    
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.activityIndicator hidesWhenStopped];

    NSURL *url                        = [NSURL URLWithString:[NSString getSelectedMusicRestfulURL]];
    NSURLRequest *requestObj          = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma
#pragma UIWebviewDelegate Method
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
}

@end
