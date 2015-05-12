//
//  SupplementOrderWebViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/10/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "SupplementOrderWebViewController.h"
#import "NSURL+SupplementOrder.h"
#import "Database.h"
#import "Goals.h"
#import "NSString+UserEmail.h"

@interface SupplementOrderWebViewController ()

@end

@implementation SupplementOrderWebViewController

// ViewTransition class object
ViewTransitions *m_transition;
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
// Database
Database *m_database;
// WebView object
UIWebView *m_orderPageView;
NSString *m_userEmail;
NSString *m_gender;
NSString *m_goal;

@synthesize indicatorView;

/*
 Singleton SupplementOrderWebViewController object
 */
+ (SupplementOrderWebViewController *)sharedInstance {
	static SupplementOrderWebViewController *globalInstance;
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
        m_transition                    = [ViewTransitions sharedInstance];
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
    
    // Google Analytics Button click

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
    
    // Google Analytics Button click

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
    
    self.nutritionPlanButton            = [controlButtonArrays objectAtIndex:5];
    
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
	// Do any additional setup after loading the view

}

- (void)viewWillAppear:(BOOL)animated
{
    [self.indicatorView removeFromSuperview];
    
    CGRect webViewframe;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        webViewframe             = CGRectMake(0.0f, 62.0f, 320.0f, 400.0f);
    }
    else {
        webViewframe             = CGRectMake(0.0f, 62.0f, 320.0f, 363.0f);
    }
    m_orderPageView              = [[UIWebView alloc] initWithFrame:webViewframe];
    
    //self.toolbar =  [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, webViewframe.size.width, 50)];
    //UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:nil];
    
    //self.toolbar.items = [NSArray arrayWithObjects:back, nil];
    
    
    
    //[m_orderPageView addSubview:self.toolbar];
    NSURL *url;
    NSURLRequest *request;
    
    m_orderPageView.delegate        = self;
    //[self.view addSubview:m_orderPageView];
    

    
    m_goal = [m_database getLatestExerciseGoal:m_userEmail];
    m_gender = [m_database getGender:m_userEmail];
    NSLog(@"Gender: %@", m_gender);
    if([m_goal isEqualToString:@"SHRED FAT"] && [m_gender isEqualToString:@"Male"]){
        url = [NSURL URLWithString:@"http://www.totalfitness.com/shop/shredfatmen"];
        request = [NSURLRequest requestWithURL:url];
    }
    else if([m_goal isEqualToString:@"BUILD MUSCLE MASS"] && [m_gender isEqualToString:@"Male"]){
        url = [NSURL URLWithString:@"http://www.totalfitness.com/shop/buildmusclemen"];
        request = [NSURLRequest requestWithURL:url];
        
    }
    else if([m_goal isEqualToString:@"GET TONED"] && [m_gender isEqualToString:@"Male"]){
        url = [NSURL URLWithString:@"http://www.totalfitness.com/shop/buildmusclemen"];
        request = [NSURLRequest requestWithURL:url];
    }
    else if([m_goal isEqualToString:@"MUSCLE ISOLATION"] && [m_gender isEqualToString:@"Male"]){
        url = [NSURL URLWithString:@"http://www.totalfitness.com/shop/buildmusclemen"];
        request = [NSURLRequest requestWithURL:url];
    }
    else if([m_goal isEqualToString:@"SHRED FAT"] && [m_gender isEqualToString:@"Female"]){
        url = [NSURL URLWithString:@"http://www.totalfitness.com/shop/shredfatwomen"];
        request = [NSURLRequest requestWithURL:url];
    }
    else if([m_goal isEqualToString:@"BUILD MUSCLE MASS"] && [m_gender isEqualToString:@"Female"]){
        url = [NSURL URLWithString:@"http://www.totalfitness.com/shop/gettonedwomen"];
        request = [NSURLRequest requestWithURL:url];
        
    }
    else if([m_goal isEqualToString:@"GET TONED"] && [m_gender isEqualToString:@"Female"]){
        url = [NSURL URLWithString:@"http://www.totalfitness.com/shop/gettonedwomen"];
        request = [NSURLRequest requestWithURL:url];
    }
    else if([m_goal isEqualToString:@"MUSCLE ISOLATION"] && [m_gender isEqualToString:@"Female"]){
        url = [NSURL URLWithString:@"http://www.totalfitness.com/shop/gettonedwomen"];
        request = [NSURLRequest requestWithURL:url];
    }

    [self.view addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
    [self.indicatorView hidesWhenStopped];
    
    [self.webView loadRequest:request];
    
    [self addSelectorToControlButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 
#pragma UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.indicatorView stopAnimating];
}


@end
