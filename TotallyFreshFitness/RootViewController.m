//
//  RootViewController.m
//  Total Fitness & Nutrition
//
//  Created by Namgyal Damdul on 2012-10-26.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

// Tag ProfileViewController view to identify view hierrachy
#define kProfileViewControllerChangedAtRoot        3;

#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "RootViewController.h"
#import "AppDelegate.h"
#import "MealPlanSelection.h"
#import "ExerciseLevelViewController.h"
#import "TFNGateway.h"
#import "MealPlanManager.h"
#import "WorkOutDaysViewController.h"
#import "ProgressViewController.h"
#import "ExerciseLevelViewController.h"
#import "GoalsViewController.h"
#import "NSMutableArray+Homepage_Data.h"
#import <AVFoundation/AVFoundation.h>
#import "NSMutableArray+Music_Data.h"
#import "NSURL+SupplementOrder.h"
#import "SupplementOrderWebViewController.h"
#import <Parse/Parse.h>
#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface RootViewController ()

// ProfileViewController class object
@property (strong, nonatomic)ProfileViewController *m_profileViewController;
// ExerciseViewController class object
@property (strong, nonatomic)ExerciseViewController *m_exerciseViewController;
// CalenderViewController class object
@property (strong, nonatomic)CalenderViewController *m_calenderViewController;
// MealViewController class object
@property (strong, nonatomic)MealViewController *m_mealViewController;
// MusicTracksViewController class object
@property (strong, nonatomic)MusicTracksViewController *m_musicTracksViewController;
// SupplementPlanViewController class object
@property (strong, nonatomic)SupplementPlanViewController *m_supplementPlanViewController;
// ExerciseLevelViewController class object
@property (strong, nonatomic)ExerciseLevelViewController *m_exerciseLevelViewController;
// ProgressViewController class object
@property (strong, nonatomic)ProgressViewController *m_progressViewController;
// WorkOutDaysViewController class object
@property (strong, nonatomic)WorkOutDaysViewController *m_workoutDaysViewController;
// GoalsViewController class object
@property (strong, nonatomic)GoalsViewController *m_goalsViewController;
// MealPlanSelectin class object
@property (strong, nonatomic)MealPlanSelection *m_mealPlanSelection;
// Supplement Order View Controller
@property (strong, nonatomic)SupplementOrderWebViewController *m_supplementOrderWebViewController;
// ViewFactory class object
@property (strong, nonatomic)ViewFactory *m_controllerViews;
// Database class object
@property (strong, nonatomic)Database *m_database;
// ViewTransitions class object
@property (strong, nonatomic)ViewTransitions *m_transition;
// ServerGateways class object
@property (strong, nonatomic)TFNGateway *m_serverConnection;
// ExerciseLevelViewController class object
//@property (strong, nonatomic)ExerciseLevelViewController *m_exerciseLevelViewController;
//Other Home View Controller
@property (strong, nonatomic)HomeViewController *m_homeViewController;
// User status log string
@property (strong, nonatomic)NSString *m_logStatusString;
// NSMutableArray of links
@property (strong, nonatomic)NSMutableArray *m_linksArray;
// Motivational quotes array
@property (strong, nonatomic)NSMutableArray *m_motivationalQuotesArray;
// Facebook compose sheet
@property (strong, nonatomic)SLComposeViewController *m_facebookComploseSheet;
// Social message
@property (strong, nonatomic)NSString *m_socialMessage;

@property (strong, nonatomic)MBProgressHUD *HUD;

// Move to WorkOutDaysViewController's view
- (void)moveToWorkOutDaysViewController;
// Move to ProfileViewController
- (void)moveToProfileViewController:(id)sender;
// Move to MealViewController
- (void)moveToMealViewController:(id)sender;
// Move to CalenderViewController
- (void)moveToCalenderViewController:(id)sender;
// Move to ExerciseViewController
- (void)moveToExerciseViewController:(id)sender;
// Move to MusicTracksViewController
- (void)moveToMusicTracksViewController:(id)sender;
// Move to SupplementPlanViewController
- (void)moveToSupplementPlanViewController:(id)sender;
// Move to supplements at website
- (void)moveToSupplementsAtWebsite:(id)sender;
// Add methods to each control buttons
- (void)addSelectorToControlButtons;
// Show progress report
- (void)showProgressReport:(id)sender;
// Show difficulty level
- (void)showDifficultyLevel:(id)sender;
// Create customized meal plan
- (void)createCustomizedMealPlan:(id)sender;
// Facebook challenge
- (IBAction)facebookShare:(id)sender;
// Twitter challenge
- (IBAction)twitterShare:(id)sender;
// iMessage challenge
- (IBAction)sendSMS:(id)sender;
// Go to the relevant web pages when links clicked
- (void)goToPageWithLink:(UIButton *)sender;



@property (nonatomic, retain) NSArray *homeObjectArray;
@property (nonatomic, retain) NSArray *linkObjectArray;

@end

@implementation RootViewController



// Blog url to share
static NSString *m_blogURLToShare;



// Number of slides
const static int m_numberOfSlides           = 1;
const static float m_numberOfSlidesForI4 = 26.8;

/*
 Singleton RootViewController object
 */
+ (RootViewController *)sharedInstance {
	static RootViewController *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}



- (IBAction)goToOtherHome:(id)sender {
  [self moveToVC:[HomeViewController sharedInstance]];
}

- (void)hasUserSelectedDaysGoalsAndLevels{
    // Do any additional setup after loading the view.
    if (!self.m_database) {
        self.m_database              = [Database alloc];
    }
    if ([[self.m_database hasUserSelectedDays:[NSString getUserEmail] ] isEqualToString:@"YES"]) { // User has selected days once
        if ([[self.m_database hasUserSelectedGoal:[NSString getUserEmail] ] isEqualToString:@"YES"]) { // User has selected goal once
            if ([[self.m_database hasUserSelectedExerciseLevel:[NSString getUserEmail] ] isEqualToString:@"YES"]) { // User has selected level once
                    // Stay on the RootViewController
            }
            else {
                //[self moveToExerciseLevelViewController];
            }
        }
        else {
            //[self moveToGoalsViewController];
        }
    }
    else {
        //[self moveToWorkOutDaysViewController];
    }
}

/*
 Get User ID
 */
- (NSString *)getUserId
{
    if (!self.m_database) {
        self.m_database      = [[Database alloc] init];
    }
    
    NSString *user_ID   = [NSString getUserEmail];
    return user_ID;
}

/*
 Show progress report
 */
- (void)showProgressReport:(id)sender
{
    if (!self.m_progressViewController) {
        self.m_progressViewController     = [ProgressViewController alloc];
    }
    id instanceObject                = self.m_progressViewController;
    
    [self moveToView:self.m_progressViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];

}

/*
 Show difficulty level
 */
- (void)showDifficultyLevel:(id)sender
{
    if (!self.m_exerciseLevelViewController) {
        self.m_exerciseLevelViewController     = [ExerciseLevelViewController alloc];
    }
    id instanceObject                     = self.m_exerciseLevelViewController;
    
    [self moveToView:self.m_exerciseLevelViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];

}

/*
 Create customized meal plan
 */
- (void)createCustomizedMealPlan:(id)sender
{
    [self moveToProfileViewController:sender];
    
}

/*
 Move to SupplementPlanViewController
 */
- (void)showSupplementOrder:(id)sender
{
    if (!self.m_supplementOrderWebViewController) {
        self.m_supplementOrderWebViewController         = [SupplementOrderWebViewController sharedInstance];
    }
    id instanceObject               = self.m_supplementOrderWebViewController;
    [NSURL setSupplementOrderUrl:@"http://www.totalfitness.com/shop.html"];
    
    [self moveToView:self.m_supplementOrderWebViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
}

-(NSURL *)shareMessage:(UIButton *)sender{
    NSURL *shareMessage = [[NSURL alloc] init];
    
    if (sender.tag == 1) {
        shareMessage = [self.m_linksArray objectAtIndex:0];
    }
    else if(sender.tag == 2) {
        shareMessage = [self.m_linksArray objectAtIndex:1];
    }
    else if(sender.tag == 3) {
        shareMessage = [self.m_linksArray objectAtIndex:2];
    }
    else if(sender.tag == 4) {
        shareMessage = [self.m_linksArray objectAtIndex:3];
    }
    else if(sender.tag == 5) {
        shareMessage = [self.m_linksArray objectAtIndex:4];
    }
    else if(sender.tag == 6) {
        shareMessage = [self.m_linksArray objectAtIndex:5];
    }
    else if(sender.tag == 7) {
        shareMessage = [self.m_linksArray objectAtIndex:6];
    }
    else if(sender.tag == 8) {
        shareMessage = [self.m_linksArray objectAtIndex:7];
    }
    else if(sender.tag == 9) {
        shareMessage = [self.m_linksArray objectAtIndex:8];
    }
    else if(sender.tag == 10) {
        shareMessage = [self.m_linksArray objectAtIndex:9];
    }
    else if(sender.tag == 11) {
        shareMessage = [self.m_linksArray objectAtIndex:10];
    }
    else if(sender.tag == 12) {
        shareMessage = [self.m_linksArray objectAtIndex:11];
    }
    else if(sender.tag == 13) {
        shareMessage = [self.m_linksArray objectAtIndex:12];
    }
    else if(sender.tag == 14) {
        shareMessage = [self.m_linksArray objectAtIndex:13];
    }
    else if(sender.tag == 15) {
        shareMessage = [self.m_linksArray objectAtIndex:14];
    }
    else if(sender.tag == 16) {
        shareMessage = [self.m_linksArray objectAtIndex:15];
    }
    else if(sender.tag == 17) {
        shareMessage = [self.m_linksArray objectAtIndex:16];
    }
    else if(sender.tag == 18) {
        shareMessage = [self.m_linksArray objectAtIndex:17];
    }
    else if(sender.tag == 19) {
        shareMessage = [self.m_linksArray objectAtIndex:18];
    }
    else if(sender.tag == 20) {
        shareMessage = [self.m_linksArray objectAtIndex:19];
    }
    else if(sender.tag == 21) {
        shareMessage = [self.m_linksArray objectAtIndex:20];
    }
    
    return shareMessage;
}

/*
 Go to the relevant web pages when links clicked
 */
- (void)goToPageWithLink:(UIButton *)sender
{
    if (sender.tag == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/training/top-tips-for-getting-leaner.html"]];
    }
    else if(sender.tag == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/training/why-women-must-strength-train.html"]];
    }
    else if(sender.tag == 3) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/nutrition/why-a-cheat-meal-is-a-must.html"]];
    }
    else if(sender.tag == 4) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/nutrition/should-you-take-creatine.html"]];
    }
    else if(sender.tag == 5) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/nutrition/supplements-that-aid-in-burning-fat.html"]];
    }
    else if(sender.tag == 6) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/manufacturers/cellucor"]];
    }
    else if(sender.tag == 7) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/nutrition/7-unbelievable-protein-shakes-you-haven-t-tried-yet.html"]];
    }
    else if(sender.tag == 8) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/motivation/top-men-of-instagram.html"]];
    }
    else if(sender.tag == 9) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/nutrition/are-you-eating-enough-avocado-trust-us-it-will-rock-your-diet.html"]];
    }
    else if(sender.tag == 10) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/nutrition/5-amazing-ted-talks-that-will-change-the-way-you-think-about-nutrition.html"]];
    }
    else if(sender.tag == 11) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/motivation/top-women-of-instagram.html"]];
    }
    else if(sender.tag == 12) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/training/how-you-can-turn-sex-into-sexercise-best-workout-ever.html"]];
    }
    else if(sender.tag == 13) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/motivation/what-do-men-really-think-is-the-sexiest-muscle-on-a-woman-hint-it-s-not-her-dimples.html"]];
    }
    else if(sender.tag == 14) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/nutrition/should-i-take-amino-acids-after-my-workout.html"]];
    }
    else if(sender.tag == 15) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/training/spartan-strength-training-stolen-workout-secrets-from-the-set-of-the-new-300-movie.html"]];
    }
    else if(sender.tag == 16) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/training/build-a-better-butt-with-these-key-moves.html"]];
    }
    else if(sender.tag == 17) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/training/leg-exercises-for-power.html"]];
    }
    else if(sender.tag == 18) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/training/exercise-effects-on-your-brain.html"]];
    }
    else if(sender.tag == 19) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/training/how-to-design-a-quick-at-home-fat-burning-workout.html"]];
    }
    else if(sender.tag == 20) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/training/top-exercises-for-burning-fat.html"]];
    }
    else if(sender.tag == 21) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.totalfitness.com/training/top-three-tricep-exercises-you-should-be-doing.html"]];
    }
}
-(NSURL *)shareMessaging:(UIButton *)sender{
    NSURL *shareMessage = [[NSURL alloc] init];
    
    if (sender.tag == 1) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/training/top-tips-for-getting-leaner.html"];
    }
    else if(sender.tag == 2) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/training/why-women-must-strength-train.html"];
    }
    else if(sender.tag == 3) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/nutrition/why-a-cheat-meal-is-a-must.html"];
    }
    else if(sender.tag == 4) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/nutrition/should-you-take-creatine.html"];
    }
    else if(sender.tag == 5) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/nutrition/supplements-that-aid-in-burning-fat.html"];
    }
    else if(sender.tag == 6) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/manufacturers/cellucor"];
    }
    else if(sender.tag == 7) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/nutrition/7-unbelievable-protein-shakes-you-haven-t-tried-yet.html"];
    }
    else if(sender.tag == 8) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/motivation/top-men-of-instagram.html"];
    }
    else if(sender.tag == 9) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/nutrition/are-you-eating-enough-avocado-trust-us-it-will-rock-your-diet.html"];
    }
    else if(sender.tag == 10) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/nutrition/5-amazing-ted-talks-that-will-change-the-way-you-think-about-nutrition.html"];
    }
    else if(sender.tag == 11) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/motivation/top-women-of-instagram.html"];
    }
    else if(sender.tag == 12) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/training/how-you-can-turn-sex-into-sexercise-best-workout-ever.html"];
    }
    else if(sender.tag == 13) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/motivation/what-do-men-really-think-is-the-sexiest-muscle-on-a-woman-hint-it-s-not-her-dimples.html"];
    }
    else if(sender.tag == 14) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/nutrition/should-i-take-amino-acids-after-my-workout.html"];
    }
    else if(sender.tag == 15) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/training/spartan-strength-training-stolen-workout-secrets-from-the-set-of-the-new-300-movie.html"];
    }
    else if(sender.tag == 16) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/training/build-a-better-butt-with-these-key-moves.html"];
    }
    else if(sender.tag == 17) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/training/leg-exercises-for-power.html"];
    }
    else if(sender.tag == 18) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/training/exercise-effects-on-your-brain.html"];
    }
    else if(sender.tag == 19) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/training/how-to-design-a-quick-at-home-fat-burning-workout.html"];
    }
    else if(sender.tag == 20) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/training/top-exercises-for-burning-fat.html"];
    }
    else if(sender.tag == 21) {
        shareMessage = [NSURL URLWithString:@"http://www.totalfitness.com/training/top-three-tricep-exercises-you-should-be-doing.html"];
    }
    return shareMessage;
}


/*
 Get blog url for current slide
 */
- (NSURL *)blogUrlForCurrentSlide:(UIButton *)sender
{
    NSURL *appstoreURL      = [[NSURL alloc] initWithString:@"https://itunes.apple.com/ca/app/totalfitness.com/id777948628?mt=8"];
    return appstoreURL;
}

/*
 Facebook share
 */
- (IBAction)facebookShare:(id)sender
{
    NSURL *bloglink                                  = [self blogUrlForCurrentSlide:sender];
    SLComposeViewController *facebookControllerSLC   = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [facebookControllerSLC addURL:bloglink];
    [facebookControllerSLC addImage:[UIImage imageNamed:@"Icon@2x.png"]];
    [self presentViewController:facebookControllerSLC animated:YES completion:Nil];

}


/*
 Twitter share
 */
- (IBAction)twitterShare:(id)sender
{
    NSString *textToShare                              = [NSString stringWithFormat:@"%@", [self blogUrlForCurrentSlide:sender]];
    NSURL *bloglink                                    = [self blogUrlForCurrentSlide:sender];
    SLComposeViewController *twitterControllerSLC      = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [twitterControllerSLC setInitialText:textToShare];
    [twitterControllerSLC addURL:bloglink];
    [twitterControllerSLC addImage:[UIImage imageNamed:@"Icon@2x.png"]];
    [self presentViewController:twitterControllerSLC animated:YES completion:Nil];
    

}

- (IBAction)sendSMS:(id)sender
{
    MFMessageComposeViewController *controller          = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        NSString *textToShare                           = [NSString stringWithFormat:@"%@", [self blogUrlForCurrentSlide:sender]];
        controller.body                                 = textToShare;
        controller.messageComposeDelegate               = self;
        [self presentViewController:controller animated:YES completion:nil];

    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MessageComposeResultCancelled)
        NSLog(@"Message cancelled");
    else if (result == MessageComposeResultSent)
        NSLog(@"Message sent");
    else
        NSLog(@"Message failed");
}

-(void)getHomePage{
    
    PFQuery *query = [PFQuery queryWithClassName:@"HomePage"];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            self.homeObjectArray = nil;
            self.homeObjectArray = [[NSArray alloc] initWithArray:objects];
            
            //[self loadWallView];
        }
        else{
            [self.activityIndicator stopAnimating];
            [self.activityIndicator removeFromSuperview];
            
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            [self showErrorView:errorString];
        }
    }];
}

-(void)showErrorView:(NSString *)errorMsg{
    
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
}

/*
 Display home page images and text
 */
- (void)displaySlideImagesAndText
{
    //    if ([notification.name isEqualToString:@"Home Page Notification" ]) {
    // set up the scroll view
    [self setupScrollView:self.featuredScrollView];
    //    }
}

- (void)setUpNotificationForSlideDisplay
{
    __block id weakSelf        = self;
    __block id observer =  [[NSNotificationCenter defaultCenter] addObserverForName:@"Home Page Notification" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf displaySlideImagesAndText];
            [[NSNotificationCenter defaultCenter] removeObserver:observer];
        });
    }];
}

#pragma LOAD WALL (FROM JSON)
- (void)setupScrollView:(UIScrollView*)featuredScroll {

    // we will add all images into a scrollView & set the appropriate size.
    NSError *error;
    int i                              = 0;
    int originY = 0;
    int originYHeading = 315;
    int originYShare = 350;
    for (NSDictionary *dictionary in [NSMutableArray getHomePageData]) {
        i++;
        if ( !dictionary ) {
            NSLog( @"The data received is : %@", error );
        } else {
            if (([dictionary objectForKey : @"Image"]) != NULL && ([[dictionary objectForKey : @"Image"] length] != 0)) {
                dispatch_queue_t downloadQueue              = dispatch_queue_create("com.koolappsfactory.downloadQueue", NULL);
                dispatch_async(downloadQueue, ^{ // Get nsdata from web server in download queue so that we don't block the main thread
                
                NSURL *imageURL                               = [NSURL URLWithString: [dictionary objectForKey : @"Image"]];
                UIImage *featuredImage                        = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
                dispatch_async(dispatch_get_main_queue(), ^{ // When data is retrieved push it to the main
                // create imageView
                    if([[UIScreen mainScreen]bounds].size.height == 568){
                        UIImageView *localFeaturedImageview           = [[UIImageView alloc] initWithFrame:CGRectMake(0,(i - 1)*featuredScroll.frame.size.height, featuredScroll.frame.size.width, 320.0f)];
                        localFeaturedImageview.backgroundColor        = [UIColor blackColor];
                        // set scale to fill
                        localFeaturedImageview.contentMode            = UIViewContentModeScaleToFill;
                        // Assign each image
                        [localFeaturedImageview setImage:featuredImage];
                        localFeaturedImageview.backgroundColor        = [UIColor clearColor];
                        // apply tag to access in future
                        localFeaturedImageview.tag                    = i;
                        // add to scrollView
                        [featuredScroll addSubview:localFeaturedImageview];
                        // set the content size to m_numberOfSlides image width
                        [featuredScroll setContentSize:CGSizeMake(featuredScroll.frame.size.width, featuredScroll.frame.size.height*m_numberOfSlides)];
                        
                        // Link button
                        UIButton *linkButton                          = [UIButton buttonWithType:UIButtonTypeCustom];
                        linkButton                                    = [[UIButton alloc] initWithFrame:localFeaturedImageview.frame];
                        [linkButton addTarget:self action:@selector(goToPageWithLink:) forControlEvents:UIControlEventTouchUpInside];
                        linkButton.tag                                = i;
                        [featuredScroll addSubview:linkButton];
                        if (([dictionary objectForKey : @"Heading"] != NULL) && ([[dictionary objectForKey : @"Heading"] length] != 0)) {
                            UILabel *featuredHeadingLabel;
                            featuredHeadingLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(0, (i - 1)*featuredScroll.frame.size.height + 320, 320.0f, 40.0f)];
                            //                    }
                            featuredHeadingLabel.text                     = [dictionary objectForKey : @"Heading"];
                            featuredHeadingLabel.tag                      = i;
                            featuredHeadingLabel.numberOfLines            = 2;
                            featuredHeadingLabel.contentMode              = NSLineBreakByWordWrapping;
                            featuredHeadingLabel.font                     = [UIFont customFontWithSize:15];
                            featuredHeadingLabel.textAlignment            = NSTextAlignmentCenter;
                            featuredHeadingLabel.textColor                = [UIColor redColor];
                            [featuredScroll addSubview:featuredHeadingLabel];
                            featuredHeadingLabel.backgroundColor          = [UIColor clearColor];
                        }
//                        if (([dictionary objectForKey : @"Link"] != NULL) && ([[dictionary objectForKey : @"Link"] length] != 0)) {
//                            NSURL *url = [NSURL URLWithString:[dictionary objectForKey : @"Link"]];
//                            [m_linksArray addObject:url];
//                        }
                        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        [shareButton setFrame:CGRectMake(20, (i - 1)*featuredScroll.frame.size.height + 360, 50, 25)];
                        [shareButton setImage:[UIImage imageNamed:@"ShareButton.png"] forState:UIControlStateNormal];
                        [shareButton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
                        shareButton.tag = i;
                        [featuredScroll addSubview:shareButton];
                        
                    }
                    else{
                        UIImageView *localFeaturedImageview           = [[UIImageView alloc] initWithFrame:CGRectMake(0,(i - 1)*featuredScroll.frame.size.height + originY, featuredScroll.frame.size.width, 320.0f)];
                        localFeaturedImageview.backgroundColor        = [UIColor blackColor];
                        // set scale to fill
                        localFeaturedImageview.contentMode            = UIViewContentModeScaleToFill;
                        // Assign each image
                        [localFeaturedImageview setImage:featuredImage];
                        localFeaturedImageview.backgroundColor        = [UIColor clearColor];
                        // apply tag to access in future
                        localFeaturedImageview.tag                    = i;
                        // add to scrollView
                        [featuredScroll addSubview:localFeaturedImageview];
                        // set the content size to m_numberOfSlides image width
                        [featuredScroll setContentSize:CGSizeMake(featuredScroll.frame.size.width, featuredScroll.frame.size.height*m_numberOfSlidesForI4)];
                        
                        // Link button
                        UIButton *linkButton                          = [UIButton buttonWithType:UIButtonTypeCustom];
                        linkButton                                    = [[UIButton alloc] initWithFrame:localFeaturedImageview.frame];
                        [linkButton addTarget:self action:@selector(goToPageWithLink:) forControlEvents:UIControlEventTouchUpInside];
                        linkButton.tag                                = i;
                        [featuredScroll addSubview:linkButton];
                        if (([dictionary objectForKey : @"Heading"] != NULL) && ([[dictionary objectForKey : @"Heading"] length] != 0)) {
                            UILabel *featuredHeadingLabel;
                            //                    if([[UIScreen mainScreen] bounds].size.height == 568) {
                            //                        featuredHeadingLabel                 = [[UILabel alloc] initWithFrame:CGRectMake((i - 1)*featuredScroll.frame.size.width, featuredScroll.frame.origin.y + 50.0f, 320.0f, 30.0f)];
                            //                    }
                            //                    else {
                            featuredHeadingLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(0, (i - 1)*featuredScroll.frame.size.height + originYHeading, 320.0f, 40.0f)];
                            //                    }
                            featuredHeadingLabel.text                     = [dictionary objectForKey : @"Heading"];
                            featuredHeadingLabel.tag                      = i;
                            featuredHeadingLabel.numberOfLines            = 2;
                            featuredHeadingLabel.contentMode              = NSLineBreakByWordWrapping;
                            featuredHeadingLabel.font                     = [UIFont customFontWithSize:15];
                            featuredHeadingLabel.textAlignment            = NSTextAlignmentCenter;
                            featuredHeadingLabel.textColor                = [UIColor redColor];
                            [featuredScroll addSubview:featuredHeadingLabel];
                            featuredHeadingLabel.backgroundColor          = [UIColor clearColor];
                        }
//                        if (([dictionary objectForKey : @"Link"] != NULL) && ([[dictionary objectForKey : @"Link"] length] != 0)) {
//                            NSURL *url = [NSURL URLWithString:[dictionary objectForKey : @"Link"]];
//                            [m_linksArray addObject:url];
//                        }

                        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
                        [shareButton setFrame:CGRectMake(20, (i - 1)*featuredScroll.frame.size.height + originYShare, 50, 25)];
                        [shareButton setImage:[UIImage imageNamed:@"ShareButton.png"] forState:UIControlStateNormal];
                        [shareButton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
                        shareButton.tag = i;
                        [featuredScroll addSubview:shareButton];
                        
                    }
                });
                });
                originY = originY + 80;
                originYHeading = originYHeading + 80;
                originYShare = originYShare + 80;
            }
        }
    }
    
    // stop activity indicator
    [self.activityIndicator stopAnimating];
    
}
-(void)showHUD{
    self.HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:self.HUD];
    
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    self.HUD.delegate = self;
    self.HUD.labelText = @"Updating Exercises";
    self.HUD.progress = 0.0;
    [self.HUD showWhileExecuting:@selector(fetchJSON) onTarget:self withObject:nil animated:YES];
}

-(void)fetchJSON{
    
    float progress = 0.0f;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"pictures" ofType:@"json"];
    //NSURL *urlString = [NSURL URLWithString:@"http://total-fitnessandnutrition.com/TotalFitnessAndNutritionApp/HomePage/homepageTextandImage.json"];
    
    //NSData *jsonData = [NSData dataWithContentsOfURL:urlString];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    
    if(jsonData != nil){
        while(progress < 1.0f){
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
            
            for(id record in json){
                id jsonStuff;
                jsonStuff = [record objectForKey:@"filename"];
                
                NSString *URL = @"http://162.242.223.184:3000/images/";
                NSString *encodedURL = [URL stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
                
                NSString *urlString = [NSString stringWithFormat:@"%@%@",encodedURL,jsonStuff];
                NSURL *url = [NSURL URLWithString:urlString];
                NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:180];
                
                AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                operation.responseSerializer = [AFImageResponseSerializer serializer];
                
                [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
                    [self saveImage:responseObject withFilename:jsonStuff];
                }failure:^(AFHTTPRequestOperation *operation, NSError *error){
                    NSLog(@"Error: %@", error);
                }];
                
                [operation start];
                progress += 0.0013f;
                self.HUD.progress = progress;
                usleep(100000);
            }
        }
    }
    NSLog(@"Done Downloading");
}

- (IBAction)refreshImages:(id)sender {
    [self showHUD];
}

- (void)saveImage:(UIImage *)image withFilename:(NSString *)filename
{
	NSString *path;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	path = [paths[0] stringByAppendingPathComponent:@""];
    
    BOOL isDir;
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]) {
        if(!isDir) {
            NSError *error;
            [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
            
            NSLog(@"%@",error);
        }
    }
    
    path = [path stringByAppendingPathComponent:filename];
    NSData *imageData = UIImagePNGRepresentation(image);
    NSLog(@"Written: %d",[imageData writeToFile:path atomically:YES]);
}



/*
 Share Activity Sheet
 
 */
- (IBAction)shareButton:(UIButton *)sender{
    
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:@[[self shareMessaging:sender]] applicationActivities:nil];
    
    [self presentViewController:activity animated:YES completion:nil];
    
}

-(void)alertView:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Button Works!" message:@"The Button Works!!!" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [alert show];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // get data from web server
        TFNGateway *serverConnection          = [TFNGateway sharedInstance];
        [serverConnection getHomePageImagesAndTextFromWebServer];
    }
    return self;
}

-(void)testRefresh:(UIRefreshControl *)refreshControl{
    
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];

    [NSThread sleepForTimeInterval:3];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdate = [NSString stringWithFormat:@"Last updated on %@", [formatter stringFromDate:[NSDate date]]];
    
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdate];
    [self setUpNotificationForSlideDisplay];
    [refreshControl endRefreshing];
    NSLog(@"refresh end");
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    }
    
    NSDictionary *titleLabels = [self.titleLabels objectAtIndex:indexPath.row];
    NSString *label = [titleLabels objectForKey:@"Heading"];
    NSURL *imageURL = [NSURL URLWithString:[titleLabels objectForKey:@"Image"]];
    
    //UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
    
    
    //cell.imageView.image = image;
    [cell.imageView setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholders.png"]];
    cell.label.text = label;
    cell.cardView.frame = CGRectMake(10, 5, 300, 395);
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 405;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *titleLabels = [self.titleLabels objectAtIndex:indexPath.row];
    NSString *URLforTitle = [titleLabels objectForKey:@"Link"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLforTitle]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.messageButton removeFromSuperview];
    self.messageButton.titleLabel.font          = [UIFont customFontWithSize:13];
    self.messageButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messageButton.titleLabel.numberOfLines = 2;
    self.messageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.messageButton];
//    
//    if([[UIScreen mainScreen] bounds].size.height == 568) {
//        self.tableView                      = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 120.0f, 320.0f, 393.0f)];
//    }
//    else {
//        self.tableView                      = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 120.0f, 320.0f, 300.0f)];
//    }
    
    //self.tableView.delegate                 = self;
    //self.tableView.autoresizingMask         = UIViewAutoresizingNone;
    //[self.featuredScrollView setPagingEnabled:NO];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    //[self.view addSubview:self.tableView];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(testRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.featuredScrollView addSubview:refreshControl];
    
    

    // Add target to the buttons to make it funtional
    [self.showProgressReportButton addTarget:self action:@selector(showProgressReport:) forControlEvents:UIControlEventTouchUpInside];

    [self.showDifficultyLevelButton addTarget:self action:@selector(showDifficultyLevel:) forControlEvents:UIControlEventTouchUpInside];

    [self.createPersonalizedMealPlanButton addTarget:self action:@selector(createCustomizedMealPlan:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.showSupplementOrderButton addTarget:self action:@selector(showSupplementOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareButton;
    if([[UIScreen mainScreen] bounds].size.height == 568) {
        shareButton                             = [[UIButton alloc] initWithFrame:CGRectMake(30.0f, 453.0f, 250.0f, 50.0f)];
    }
    else {
        shareButton                             = [[UIButton alloc] initWithFrame:CGRectMake(30.0f, 374.0f, 250.0f, 50.0f)];
    }
    //[self.view addSubview:shareButton];
    [shareButton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    
   
    
    // Add nav buttons
    [self addSelectorToControlButtons];
   
    [self.tableView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    

    // check if those are selected here, to go to the respective view quicker
    [self hasUserSelectedDaysGoalsAndLevels];
    
    // Initial every time
    self.m_linksArray                                        = [NSMutableArray mutableArrayObject];


    
    [self setUpNotificationForSlideDisplay];
    
    //Clean the scroll view
//    for (id viewToRemove in [self.featuredScrollView subviews]){
//        if ([viewToRemove isMemberOfClass:[UIView class]])
//            [viewToRemove removeFromSuperview];
//    }
//    
//    [self getHomePage];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TotalFitnessHomePage" ofType:@"json"];
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        self.titleLabels = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    });
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 Add methods to each control buttons
 */
- (void)addSelectorToControlButtons
{
    // Set up the bottom bar control buttons
    NSMutableArray *controlButtonArrays = [self bottomBar:self.bottomBarButton MusicPlayerButton:self.musicPlayerButton ExercisePlanButton:self.exercisePlanButton Calendar:self.calendarButton MealPlan:self.mealPlanButton MoreButton:self.nutritionPlanButton InView:self.view];
    
    self.bottomBarButton                = [controlButtonArrays objectAtIndex:0];
    
    self.musicPlayerButton              = [controlButtonArrays objectAtIndex:1];
    
    self.exercisePlanButton             = [controlButtonArrays objectAtIndex:2];
    
    self.calendarButton                 = [controlButtonArrays objectAtIndex:3];
    
    self.mealPlanButton                 = [controlButtonArrays objectAtIndex:4];
    
    self.nutritionPlanButton            = [controlButtonArrays objectAtIndex:5];
}

/*
 Adjust the height of the views for iphone5 size
 */
- (void)adjustHeightOfViewsForiPhone5
{
    // Adjust the height of the view
    self.view                                           = [self adjustiPhone5HeightOfView:self.view];
}

/*
 Display message to user with animation
 */
- (void)displayMessage:(NSString *)message
{
    self.messageButton.hidden  = NO;
    
    [UIButton animateWithDuration:3.0f animations:^{self.messageButton.alpha = 5.0;} completion:nil];
    
    [self.messageButton setTitle:message forState:UIControlStateNormal];
    
    if (!self.m_transition) {
        self.m_transition    = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionFromBottom:self.messageButton];
    
    [UIButton animateWithDuration:5.0f animations:^{self.messageButton.alpha = 0.0;} completion:nil];
}

@end
