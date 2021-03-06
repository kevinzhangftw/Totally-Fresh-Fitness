//
//  LoginViewController.m
//  Total Fitness & Nutrition
//
//  Created by Namgyal Damdul on 2012-10-26.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//
#define kOFFSET_FOR_KEYBOARD 185.0

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ProfileViewController.h"
#import "RootViewController.h"
#import "TFNGateway.h"
#import "STTwitter.h"
#import "STTwitterOS.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import "NSMutableArray+MotivationalQuote.h"
#import "RegisterViewController.h"
#import <Parse/Parse.h>


@interface LoginViewController ()

// Login using via facebook
- (void)loginToFacebook:(id)sender;
// Register and login user via database
- (void)registerUser:(id)sender;
// Forgot your password
- (void)forgotPassword:(id)sender;
// Move to RootViewController or ProfileViewController
- (void)moveToRootOrProfileViewController: (NSString *)userStatus;
// Move View to proper positions on the view
- (void)moveView:(UIView *)sender;
// Controls hidden to show emails list to send password
- (void)hideSigninView;
// Show to login view
- (void)showSigninView:(id)sender;
- (void)moveToRegisterViewController:(id)sender;

// STTwitterAPI instance
@property (nonatomic, strong) STTwitterAPI *twitter;
// STTwitterOS instance
@property (nonatomic, strong) STTwitterOS *twitterOS;

// AppDelegate class object
@property (nonatomic, strong)AppDelegate *m_appDelegate;
// ProfileViewController class object
@property (nonatomic, strong)ProfileViewController *m_profileViewController;
// RootViewController class object
@property (nonatomic, strong)RootViewController *m_rootViewController;
// ViewFactory class object
@property (nonatomic, strong)ViewFactory *m_controllerViews;
// Database class object
@property (nonatomic, strong)Database *m_database;
// ViewTransition class object
@property (nonatomic, strong)ViewTransitions *m_transition;
// ServerGateway class object
@property (nonatomic, strong)TFNGateway *m_serverConnection;
//Register
@property (nonatomic, strong)RegisterViewController *m_registerViewController;
// All Email Ids
@property (nonatomic, strong)NSMutableArray *m_emailIDsArray;
// Initial y position of facebookbutton
@property (nonatomic)int initialYOfFacebookButton;
// move to RootViewController has already been called
@property (nonatomic)BOOL m_rootViewControllerAlreadyCalled;
// move to ProfileViewController has already been called
@property (nonatomic)BOOL m_profileViewControllerAlreadyCalled;
// User email id retreived from database
@property (nonatomic, strong)NSString *m_userEmailID;
// Terms and Condition Image View
@property (nonatomic, strong)UIImageView *m_terms_And_Conditions_ImageView;
// Terms and Condition Text View
@property (nonatomic, strong)UITextView *m_terms_And_Conditions_TextView;
// Click Terms and conditions button
@property (nonatomic, strong)UIButton *m_click_Terms_And_Conditions;
// Mode of registration
@property (nonatomic, strong)NSString *m_mode_Of_Registration;
// Cusumer key
@property (nonatomic, strong)UIImageView *m_loginBackgroundImageView;
@property (nonatomic, strong)UIView *m_signinBackgroundView;
@property (nonatomic, strong)UIImageView *m_signinBackgroundImageView;
//@property (nonatomic, strong)UIButton *m_facebookLoginButton;
//@property (nonatomic, strong)UIButton *m_twitterLoginButton;
@property (nonatomic, strong)UIButton *googlePlusLoginButton;
@property (nonatomic, strong)UIButton *m_showSignInViewButton;
@property (nonatomic, strong)UIButton *m_registerViewButton;
@property (nonatomic, strong)UITextField *m_email_ID;
@property (nonatomic, strong)UITextField *m_password;
@property (nonatomic, strong)UIButton *m_signInButton;
@property (nonatomic, strong)UIButton *m_registerButton;
@property (nonatomic, strong)UIImageView *movingImageOneView;
@property (nonatomic)CGRect movingImageTargetOne;
@property (nonatomic)CGRect movingImageTargetOneInitial;
@property (nonatomic)int movingImageTargetOneState;
@property (nonatomic, strong)UIImageView *movingImageTwoView;
@property (nonatomic)CGRect movingImageTargetTwo;
@property (nonatomic)CGRect movingImageTargetTwoInitial;
@property (nonatomic)int movingImageTargetTwoState;
@property (nonatomic, strong)UIImageView *movingImageThreeView;
@property (nonatomic)CGRect movingImageTargetThree;
@property (nonatomic)CGRect movingImageTargetThreeInitial;
@property (nonatomic)int movingImageTargetThreeState;
@property (nonatomic, strong)UIImageView *movingImageFourView;
@property (nonatomic)CGRect movingImageTargetFour;
@property (nonatomic)CGRect movingImageTargetFourInitial;
@property (nonatomic)int movingImageTargetFourState;
@property (nonatomic, strong)UIImageView *movingImageFiveView;
@property (nonatomic)CGRect movingImageTargetFive;
@property (nonatomic)CGRect movingImageTargetFiveInitial;
@property (nonatomic)int movingImageTargetFiveState;
@property (nonatomic, strong)UIImageView *movingImageSixView;
@property (nonatomic)CGRect movingImageTargetSix;
@property (nonatomic)CGRect movingImageTargetSixInitial;
@property (nonatomic)int movingImageTargetSixState;
@property (nonatomic, strong)NSArray *movingImageXPositions;
//@property (strong)UIPageControl *pageControl;
@property (nonatomic, strong)UIView *socialButtonsView;
@property (nonatomic, strong)UIView *motivationalQouteView;
@property (nonatomic, strong)UIImageView *m_signin_fields;
@property (nonatomic, strong)UIButton *m_downloadImages;
@property (nonatomic)int i;
@property (nonatomic, strong)MBProgressHUD *HUD;

@end

@implementation LoginViewController

static NSString * const m_consumer_key       = @"Tj1YiFQLaJJqfjexnBmgw";
// Cusumer secret
static NSString * const m_consumer_secret    = @"kS6kLMBi5zjUHDJA8pUFpawktEwofuN4it8ypdc2wv4";
// Google Plus client id
static NSString * const kClientId            = @"670642597699-5a6lm63qetdsqom5nve7orjc67v8sf1g.apps.googleusercontent.com";

@synthesize messageButton;
@synthesize userFacebookEmailID;
@synthesize userFacebookBirthday;
@synthesize userFacebookDetailsCheck;
@synthesize termsAndConditionTextView;
@synthesize featuredScrollView;

/*
 Singleton LoginViewController object
 */
+ (LoginViewController *)sharedInstance {
	static LoginViewController *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 Check email string
 */
- (BOOL) validateEmail: (NSString *) email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

/*
 Move view to proper positions on the view
 */
- (void)moveView:(UIView *)sender {
    CGRect frame = sender.frame;
    
    if (objectsMoved) {
        frame.origin.y -= kOFFSET_FOR_KEYBOARD; // new y coordinate
    }
    else {
        frame.origin.y += kOFFSET_FOR_KEYBOARD;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration: 0.25];
    sender.frame = frame;
    [UIView commitAnimations];
}

/*
 Move buttons, textfields, imageviews to proper position
 */
- (void)moveObjectsToProperPositions
{
    [self moveView:self.view];
}

-(void)moveToRegisterViewController:(id)sender{
    
    if(!self.m_registerViewController){
        self.m_registerViewController = [RegisterViewController sharedInstance];
    }
    id instanceObject = self.m_registerViewController;
    
    [self moveToView:self.m_registerViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
Hide sign in view
*/
- (void)hideSigninView
{
    if (!self.m_transition) {
        self.m_transition                = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionDisappear:self.m_signinBackgroundImageView];
    self.featuredScrollView.hidden                = NO;
    self.pageControl.hidden                       = YES;
    self.m_facebookLoginButton.hidden                  = NO;
    self.m_twitterLoginButton.hidden                   = NO;
    self.m_loginBackgroundImageView.hidden             = NO;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.googlePlusLoginButtonOne.hidden      = NO;
    }
    else {
        self.googlePlusLoginButtonTwo.hidden      = NO;
    }
    self.m_signinBackgroundImageView.hidden            = YES;
    self.m_email_ID.hidden                             = YES;
    self.m_password.hidden                             = YES;
    self.m_registerButton.hidden                       = YES;
    self.m_signInButton.hidden                         = YES;
}

/*
 Show signin view
 */
- (void)showSigninView:(id)sender
{
    if (!self.m_transition) {
        self.m_transition                = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionAppear:self.m_signinBackgroundImageView];
    self.m_signinBackgroundView.hidden                 = NO;
    self.m_signinBackgroundImageView.hidden            = NO;
    self.m_email_ID.hidden                             = NO;
    self.m_password.hidden                             = NO;
    self.m_registerButton.hidden                       = NO;
    self.m_signInButton.hidden                         = NO;
    [self hideLoginDetails];
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

/*
 Check whether user is logged in or out
 */
- (NSString *) checkUserLogState
{
    if (!self.m_database) {
        self.m_database                  = [[Database alloc] init];
    }
    NSString *checkLoginString      = [[NSString alloc] initWithFormat:@"%@",[self.m_database checkUserLogInStatus]];
    
    return checkLoginString;
}

/*
 Move to RootViewController
 */
- (void)rootViewController:(id)sender
{
    // Hide keypad
    [self.m_email_ID resignFirstResponder];
    [self.m_password resignFirstResponder];

    if (!self.m_rootViewController) {
        self.m_rootViewController                    = [RootViewController sharedInstance];
    }
    
    id instanceObject                               = self.m_rootViewController;
    [self moveToView:self.m_rootViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    self.m_rootViewController.view.tag               = 20;
    // The method is now called, now don't call when facebook session changes
    self.m_rootViewControllerAlreadyCalled           = TRUE;
}

/*
 Move to ProfileViewController
 */
- (void)profileViewController:(id)sender
{
    // Hide keypad
    [self.m_email_ID resignFirstResponder];
    [self.m_password resignFirstResponder];
    
    if (!self.m_profileViewController) {
        self.m_profileViewController             = [ProfileViewController sharedInstance];
    }
    id instanceObject                       = self.m_profileViewController;
    self.m_profileViewController.view.tag        = 2;
    [self moveToView:self.m_profileViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    // The method is now called, now don't call when facebook session changes
    self.m_profileViewControllerAlreadyCalled    = TRUE;
}


/*
 Login using facebook when datas are confirmed retreived
 */
- (void)loginUsingFacebook
{
    [self registerUserWithUsername:self.userFacebookEmailID AndPassword:self.userFacebookBirthday];
}

// Move to RootViewController or ProfileViewController
- (void)moveToRootOrProfileViewController: (NSString *)userStatus
{
    if ([userStatus isEqualToString:@"New User"]) { // If new user present the profile page
        // Present the profile page
        [self profileViewController:self];
    }
    else {
        if (!self.m_database) {
            self.m_database      = [Database alloc];
        }
        if (!self.m_userEmailID) {
            self.m_userEmailID   = [NSString getUserEmail];
            
        }
        if ([self.m_database checkEmailIDInBMR:self.m_userEmailID]) { // Make sure that user has created a BMR detail first
            // Present the home page
            [self rootViewController:self];
        }
        else { // If not, ask user to enter a BMR detail
            // Present the profile page
            [self profileViewController:self];
        }
    }
}

/*
 Accept terms and conditions
 */
- (void)acceptTermsAndConditions:(id)sender
{
    NSString *status        = @"No";
    
    if (!self.m_database) {
        self.m_database          = [Database alloc];
    }
    status                  = [self.m_database insertIntoTermsAndConditionsToAccept:@"Yes"];
    if ([status isEqualToString:@"inserted"]) {
        if ([self.m_mode_Of_Registration isEqualToString:@"registerUser"]) {
            [self insertUserIntoDatabase];
        }
        else if([self.m_mode_Of_Registration isEqualToString:@"registerUsingFacebook"]) {
            [self loginWithFacebook];
        }
        else if([self.m_mode_Of_Registration isEqualToString:@"registerUsingTwitter"]) {
            [self loginWithTwitter];
        }
        else if([self.m_mode_Of_Registration isEqualToString:@"registerUsingGooglePlus"]) {
            [self loginWithGooglePlus];
        }
        // remove terms and conditions form
        [self removeTermsAndConditionsForm];
    }
    else { // failed to accept 
        [self displayMessage:@"Please accept the Terms & Conditions to proceed"];
    }
    
}

/*
 Hide login details
 */
- (void)hideLoginDetails
{
    // hide the login details
    self.m_showSignInViewButton.hidden                 = YES;
    self.m_registerViewButton.hidden                   = YES;
    self.featuredScrollView.hidden                = YES;
    self.pageControl.hidden                       = YES;
    self.m_facebookLoginButton.hidden                  = YES;
    self.m_twitterLoginButton.hidden                   = YES;
    self.m_loginBackgroundImageView.hidden             = YES;
    self.googlePlusLoginButtonOne.hidden          = YES;
    self.googlePlusLoginButtonTwo.hidden          = YES;
}

/*
 Show login details
 */
- (void)showLoginDetails
{
    // show the login details
   self. m_showSignInViewButton.hidden                 = NO;
    self.m_registerViewButton.hidden                   = NO;
    self.featuredScrollView.hidden                = NO;
    self.pageControl.hidden                       = NO;
    self.m_facebookLoginButton.hidden                  = NO;
    self.m_twitterLoginButton.hidden                   = NO;
    self.m_loginBackgroundImageView.hidden             = NO;
    self.googlePlusLoginButtonOne.hidden          = NO;
    self.googlePlusLoginButtonTwo.hidden          = NO;
}

/*
 Create terms and conditions if not signed
 */
- (void)createTermsAndConditionsForms
{
    if (!self.m_transition) {
        self.m_transition    = [ViewTransitions sharedInstance];
    }
    
    [self hideLoginDetails];
    
    // Terms and Conditions frames
    CGRect termsAndConditionsImageViewFrame;
    CGRect termsAndConditionsTextViewFrame;
    CGRect termsAndConditionsClickButtonFrame;
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        termsAndConditionsImageViewFrame                = CGRectMake(0.0f, 0.0f, 320.0f, 568.0f);
        self.m_terms_And_Conditions_ImageView                = [[UIImageView alloc] initWithFrame:termsAndConditionsImageViewFrame];
        self.m_terms_And_Conditions_ImageView.image          = [UIImage imageNamed:@"terms_condition_iPhone5.png"];
        termsAndConditionsTextViewFrame                 = CGRectMake(35.0f, 185.0f, 260.0f, 265.0f);
        termsAndConditionsClickButtonFrame              = CGRectMake(69.0f, 480.0f, 182.0f, 50.0f);
    }
    else { // if iphones other than iphone 5
        termsAndConditionsImageViewFrame                = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
       self. m_terms_And_Conditions_ImageView                = [[UIImageView alloc] initWithFrame:termsAndConditionsImageViewFrame];
        self.m_terms_And_Conditions_ImageView.image          = [UIImage imageNamed:@"terms_condition_iPhone4.png"];
        termsAndConditionsTextViewFrame                 = CGRectMake(35.0f, 130.0f, 260.0f, 260.0f);
        termsAndConditionsClickButtonFrame              = CGRectMake(69.0f, 420.0f, 182.0f, 50.0f);
    }
    
    [self.view addSubview:self.m_terms_And_Conditions_ImageView];
    [self.m_transition performTransitionAppear:self.m_terms_And_Conditions_ImageView];
    self.m_terms_And_Conditions_TextView                 = [[UITextView alloc] initWithFrame:termsAndConditionsTextViewFrame];
    [self.view addSubview:self.m_terms_And_Conditions_TextView];
    self.m_terms_And_Conditions_TextView.backgroundColor = [UIColor clearColor];
    self.m_terms_And_Conditions_TextView.text            = termsAndConditionTextView.text;
    self.m_terms_And_Conditions_TextView.textColor       = [UIColor whiteColor];
    self.m_terms_And_Conditions_TextView.editable        = NO;
    self.m_terms_And_Conditions_TextView.scrollEnabled   = YES;
    [self.m_transition performTransitionAppear:self.m_terms_And_Conditions_TextView];
    
    self.m_click_Terms_And_Conditions                    = [[UIButton alloc] initWithFrame:termsAndConditionsClickButtonFrame];
    [self.view addSubview:self.m_click_Terms_And_Conditions];
    [self.m_click_Terms_And_Conditions addTarget:self action:@selector(acceptTermsAndConditions:) forControlEvents:UIControlEventTouchUpInside];
    [self.m_transition performTransitionAppear:self.m_click_Terms_And_Conditions];

}

/*
 Remove terms and conditions
 */
- (void)removeTermsAndConditionsForm
{
    if (!self.m_transition) {
        self.m_transition                = [ViewTransitions sharedInstance];
    }
    
    [self.m_transition performTransitionAppear:self.m_loginBackgroundImageView];
    // Show the background login image view
    self.m_loginBackgroundImageView.hidden                     = NO;
    self.m_signinBackgroundView.hidden                         = YES;
    self.m_signinBackgroundImageView.hidden                    = YES;
    self.featuredScrollView.hidden                        = YES;
    [self.m_click_Terms_And_Conditions removeFromSuperview];
    [self.m_terms_And_Conditions_ImageView removeFromSuperview];
    [self.m_terms_And_Conditions_TextView removeFromSuperview];
}

/*
 Insert user into database
 */
- (void)insertUserIntoDatabase
{
    if ([self validateEmail:self.m_email_ID.text]) { // Validate to be an Email Id
        [self registerUserWithUsername:self.m_email_ID.text AndPassword:self.m_password.text];
    
    }
    else {
        [self displayMessage:@"Please enter a valid email id."];
    }
}

/*
 Register user with username and password
 */
- (void)registerUserWithUsername:(NSString *)usernameInput AndPassword:(NSString *)passwordInput
{
    NSString *userStatus;
    if ( !self.m_database ) {
        self.m_database      = [ Database alloc ];
    }
    // if the string is not null or empty or nil or false
    if ((usernameInput != NULL && passwordInput != NULL) || (([usernameInput length] != 0) && [passwordInput length] != 0)) {// If the data has been retrieved
        userStatus          = [[NSString alloc] initWithFormat:@"%@", [self.m_database insertIntoUserEmail_Id:usernameInput Password:passwordInput Log:@"in"]];
        
        if ([userStatus length] != 0) { // if inserted into database or check if already existing
            // move to root or profile view controller
            [self moveToRootOrProfileViewController:userStatus];
            PFObject *object = [PFObject objectWithClassName:@"RegisteredUsers"];
            object[@"email"] = usernameInput;
            [object saveInBackground];
        }
        else {
            [self displayMessage:@"Login failed, please try again"];
        }
    }
    else {// if not
        userStatus          = @"";
    }
}

/*
 Register and login, if already registered, just login
 */
- (void)registerUser:(id)sender
{
   NSString *userStatus;
    if (((self.m_email_ID.text == NULL) || ([self.m_email_ID.text length] == 0)) || (self.m_password.text == NULL || ([self.m_password.text length] == 0))) {
        [self displayMessage:@"User Id field or Password field cannot be empty."];
    }
    else { // Textfields not empty
        self.m_mode_Of_Registration              = @"registerUser";
        
        if (!self.m_database) {
            self.m_database          = [Database alloc];
        }
        
        if ([[self.m_database checkIfTermsAndConditionsAccepted] isEqualToString:@"Yes"]) { // if terms and conditions is accepted

            // register into database
            [self insertUserIntoDatabase];
        }
        else {
            [self createTermsAndConditionsForms];
        }
        if (userStatus == NULL || [userStatus length] == 0) {
            // Hide the keypad
            [self.m_email_ID resignFirstResponder];
            [self.m_password resignFirstResponder];
        }
    }
}
/*
 Login using facebook
 */
- (NSString *)loginWithFacebook
{
    NSString *userStatus;

    if (!self.m_appDelegate) {
        self.m_appDelegate       = [[UIApplication sharedApplication] delegate];
    }
    //DEBUG
//    //  Log in when the button is clicked.
//    if (!FBSession.activeSession.isOpen) {
//        // The user has initiated a login, so call the openSession method
//        // and show the login UX if necessary.
//        [m_appDelegate openSessionWithAllowLoginUI:YES];
//    }
  
    // Register or Login User using facebook email id and dateofBirth
    /*userStatus                                  = [self registerUserEmailId:self.userFacebookEmailID Password:self.userFacebookBirthday];
    if ((userStatus != NULL && [userStatus length] != 0) { // Move to Root or Profile View Controller
        [self moveToRootOrProfileViewController:userStatus];
    }
    else { // Refresh the view
        [self.view setNeedsDisplay];
    }*/
    return userStatus;
}

/*
 Login using facebook
 */
- (void)loginToFacebook:(id)sender
{
    NSString *userStatus;
    
    if (!self.m_database) {
        self.m_database          = [Database alloc];
    }
    
    if ([[self.m_database checkIfTermsAndConditionsAccepted] isEqualToString:@"Yes"]) { // if terms and conditions is accepted
        // login using facebook
        userStatus          = [self loginWithFacebook];
    }
    else {
        // register using facebook
        self.m_mode_Of_Registration              = @"registerUsingFacebook";

        [self createTermsAndConditionsForms];
    }
    if (userStatus == NULL || [userStatus length] == 0) {
        // Hide the keypad
        [self.m_email_ID resignFirstResponder];
        [self.m_password resignFirstResponder];
    }

}

/*
 Forgot your password
 */
- (void)forgotPassword:(id)sender
{    
    if (!self.m_database) {
        self.m_database                  = [Database alloc];
    }

    // Get number of users
    int numberOfUsers               = [self.m_database countNumberOfUsers];
    // Retrive email ID(s)
    if (!self.m_emailIDsArray) {
        self.m_emailIDsArray             = [self.m_database getAllEmailIds];
    }
    if (numberOfUsers < 1) {
        [self displayMessage:@"Please register by any of below methods."];
    }
    else if (numberOfUsers > 1) { // If there is more than one user, show the list of email ids
        [self hideSigninView];
    }
    else if (numberOfUsers == 1){ // If there is only one user, just send the password
        if (!self.m_serverConnection) {
            self.m_serverConnection      = [TFNGateway sharedInstance];
        }
        [self.m_serverConnection sendPasswordToUser:[self.m_emailIDsArray objectAtIndex:0]];
    }
    

}

/*
 Login with Twitter
 */
- (void)loginWithTwitter
{
    // Login with iOS twitter first
    self.twitter = [STTwitterAPI twitterAPIOSWithFirstAccount];
    [_twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
        [self registerUserWithUsername:username AndPassword:@"oauthtoken"];
    } errorBlock:^(NSError *error) {
        // if iOS twitter is not available, try safari
        [self loginWithTwitterUsingSafari];
    }];
}

/* Login using twitter action */
- (void)loginWithTwitterAction:(id)sender {
    
    if (!self.m_database) {
        self.m_database          = [Database alloc];
    }
    
    if ([[self.m_database checkIfTermsAndConditionsAccepted] isEqualToString:@"Yes"]) { // if terms and conditions is accepted
        [self loginWithTwitter];
    }
    else {
        // register using facebook
        self.m_mode_Of_Registration              = @"registerUsingTwitter";
        
        [self createTermsAndConditionsForms];
    }
}

/*
 Login with Twitter using safari
 */
- (void)loginWithTwitterUsingSafari
{
    self.twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:m_consumer_key
                                                 consumerSecret:m_consumer_secret];
    [_twitter postTokenRequest:^(NSURL *url, NSString *oauthToken) {
        [[UIApplication sharedApplication] openURL:url];
    } oauthCallback:@"totalfitness://twitter_access_tokens/"
                    errorBlock:^(NSError *error) {
                        NSLog(@"-- error: %@", error);
                    }];
}

- (void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verfier {
    
    [_twitter postAccessTokenRequestWithPIN:verfier successBlock:^(NSString *oauthToken, NSString *oauthTokenSecret, NSString *userID, NSString *screenName) {
        [self registerUserWithUsername:screenName AndPassword:@"oauthtoken"];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"-- %@", [error localizedDescription]);
    }];
}

/*
 Login with google plus
 */
- (void)loginWithGooglePlus
{
    if ([GPPSignIn sharedInstance].authentication) {
        GTLPlusPerson *person = [GPPSignIn sharedInstance].googlePlusUser;
        if (person == nil) {
            return;
        }
        [self registerUserWithUsername:[GPPSignIn sharedInstance].userEmail AndPassword:[GPPSignIn sharedInstance].userID];
    }
}

/*
 Animate moving image one
 */
- (void)animateMovingImageOne
{
    __block int movingImageTargetOneStateBlock  = self.movingImageTargetOneState;
    [UIView animateWithDuration:25.0
                          delay:1.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (movingImageTargetOneStateBlock == 0) {
                             movingImageTargetOneStateBlock = 1;
                             self.movingImageOneView.frame   = self.movingImageTargetOne;
                         }
                         else {
                             movingImageTargetOneStateBlock = 0;
                             self.movingImageOneView.frame    = self.movingImageTargetOneInitial;
                         }
                     }
                     completion:^(BOOL finished){
                         self.movingImageTargetOneState           = movingImageTargetOneStateBlock;
                         [self animateMovingImageOne];
                     }];
}

/*
 Animate moving image two
 */
- (void)animateMovingImageTwo
{
    __block int movingImageTargetTwoStateBlock  = self.movingImageTargetTwoState;
    [UIView animateWithDuration:25.0
                          delay:1.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (movingImageTargetTwoStateBlock == 0) {
                             movingImageTargetTwoStateBlock = 1;
                             self.movingImageTwoView.frame   = self.movingImageTargetTwo;
                         }
                         else {
                             movingImageTargetTwoStateBlock = 0;
                             self.movingImageTwoView.frame   = self.movingImageTargetTwoInitial;
                         }
                     }
                     completion:^(BOOL finished){
                         self.movingImageTargetTwoState           = movingImageTargetTwoStateBlock;
                         [self animateMovingImageTwo];
                     }];
}

/*
 Animate moving image three
 */
- (void)animateMovingImageThree
{
    __block int movingImageTargetThreeStateBlock  = self.movingImageTargetThreeState;
    [UIView animateWithDuration:25.0
                          delay:1.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (movingImageTargetThreeStateBlock == 0) {
                             movingImageTargetThreeStateBlock = 1;
                             self.movingImageThreeView.frame   = self.movingImageTargetThree;
                         }
                         else {
                             movingImageTargetThreeStateBlock = 0;
                             self.movingImageThreeView.frame   = self.movingImageTargetThreeInitial;
                         }
                     }
                     completion:^(BOOL finished){
                         self.movingImageTargetThreeState           = movingImageTargetThreeStateBlock;
                         [self animateMovingImageThree];
                     }];
}

/*
 Animate moving image four
 */
- (void)animateMovingImageFour
{
    __block int movingImageTargetFourStateBlock  = self.movingImageTargetFourState;
    [UIView animateWithDuration:25.0
                          delay:1.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (movingImageTargetFourStateBlock == 0) {
                             movingImageTargetFourStateBlock = 1;
                             self.movingImageFourView.frame   = self.movingImageTargetFour;
                         }
                         else {
                             movingImageTargetFourStateBlock = 0;
                             self.movingImageFourView.frame   = self.movingImageTargetFourInitial;
                         }
                     }
                     completion:^(BOOL finished){
                         self.movingImageTargetFourState           = movingImageTargetFourStateBlock;
                         [self animateMovingImageFour];
                     }];
}

/*
 Animate moving image five
 */
- (void)animateMovingImageFive
{
    __block int movingImageTargetFiveStateBlock  = self.movingImageTargetFiveState;
    [UIView animateWithDuration:25.0
                          delay:1.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (movingImageTargetFiveStateBlock == 0) {
                             movingImageTargetFiveStateBlock = 1;
                             self.movingImageFiveView.frame   = self.movingImageTargetFive;
                         }
                         else {
                             movingImageTargetFiveStateBlock = 0;
                             self.movingImageFiveView.frame   = self.movingImageTargetFiveInitial;
                         }
                     }
                     completion:^(BOOL finished){
                         self.movingImageTargetFiveState           = movingImageTargetFiveStateBlock;
                         [self animateMovingImageFive];
                     }];
}

/*
 Animate moving image six
 */
- (void)animateMovingImageSix
{
    __block int movingImageTargetSixStateBlock  = self.movingImageTargetSixState;
    [UIView animateWithDuration:25.0
                          delay:1.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (movingImageTargetSixStateBlock == 0) {
                             movingImageTargetSixStateBlock = 1;
                             self.movingImageSixView.frame   = self.movingImageTargetSix;
                         }
                         else {
                             movingImageTargetSixStateBlock = 0;
                             self.movingImageSixView.frame   = self.movingImageTargetSixInitial;
                         }
                     }
                     completion:^(BOOL finished){
                         self.movingImageTargetSixState           = movingImageTargetSixStateBlock;
                         [self animateMovingImageSix];
                     }];
}

///*
// Get random X CGFloat
// */
//- (CGFloat)getRandomXForMovingImage
//{
//    NSUInteger randomIndex                           = arc4random() % [movingImageXPositions count];
//    CGFloat ramdomX                                  = [[movingImageXPositions objectAtIndex:randomIndex] floatValue];
//    return ramdomX;
//}

- (void)loginFailed
{
    // User switched back to the app without authorizing. Stay here, but
}

- (id)initWithTermsAndConditions:(NSString *)terms
{
    [self createTermsAndConditionsForms];
    return self;
}
/*
 Set up background moving images
 */
- (void)setUpBackgroundMovingImages
{
//    movingImageXPositions                           = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f], [NSNumber numberWithFloat:10.0f], [NSNumber numberWithFloat:20.0f], [NSNumber numberWithFloat:30.0f],[NSNumber numberWithFloat:40.0f],[NSNumber numberWithFloat:50.0f],[NSNumber numberWithFloat:60.0f],[NSNumber numberWithFloat:70.0f],[NSNumber numberWithFloat:80.0f],[NSNumber numberWithFloat:90.0f],[NSNumber numberWithFloat:100.0f],[NSNumber numberWithFloat:110.0f],[NSNumber numberWithFloat:120.0f],[NSNumber numberWithFloat:130.0f],[NSNumber numberWithFloat:140.0f],[NSNumber numberWithFloat:150.0f],[NSNumber numberWithFloat:160.0f],[NSNumber numberWithFloat:170.0f],[NSNumber numberWithFloat:180.0f], [NSNumber numberWithFloat:180.0f], [NSNumber numberWithFloat:180.0f], [NSNumber numberWithFloat:190.0f], [NSNumber numberWithFloat:200.0f], [NSNumber numberWithFloat:210.0f], [NSNumber numberWithFloat:220.0f], [NSNumber numberWithFloat:230.0f], [NSNumber numberWithFloat:240.0f], [NSNumber numberWithFloat:250.0f], [NSNumber numberWithFloat:260.0f], [NSNumber numberWithFloat:270.0f], [NSNumber numberWithFloat:280.0f], [NSNumber numberWithFloat:290.0f], [NSNumber numberWithFloat:300.0f], [NSNumber numberWithFloat:310.0f], [NSNumber numberWithFloat:320.0f], [NSNumber numberWithFloat:-10.0f], [NSNumber numberWithFloat:-20.0f], [NSNumber numberWithFloat:-30.0f],[NSNumber numberWithFloat:-40.0f],[NSNumber numberWithFloat:-50.0f],[NSNumber numberWithFloat:-60.0f],[NSNumber numberWithFloat:-70.0f],[NSNumber numberWithFloat:-80.0f],[NSNumber numberWithFloat:-90.0f],[NSNumber numberWithFloat:-100.0f],[NSNumber numberWithFloat:-110.0f],[NSNumber numberWithFloat:-120.0f],[NSNumber numberWithFloat:-130.0f],[NSNumber numberWithFloat:-140.0f],[NSNumber numberWithFloat:-150.0f],[NSNumber numberWithFloat:-160.0f],[NSNumber numberWithFloat:-170.0f],[NSNumber numberWithFloat:-180.0f], [NSNumber numberWithFloat:-180.0f], [NSNumber numberWithFloat:-190.0f], [NSNumber numberWithFloat:-200.0f], [NSNumber numberWithFloat:-210.0f], [NSNumber numberWithFloat:-220.0f], [NSNumber numberWithFloat:-230.0f], [NSNumber numberWithFloat:-240.0f], [NSNumber numberWithFloat:-250.0f], [NSNumber numberWithFloat:-260.0f], [NSNumber numberWithFloat:-270.0f], [NSNumber numberWithFloat:-280.0f], [NSNumber numberWithFloat:-290.0f], [NSNumber numberWithFloat:-300.0f], [NSNumber numberWithFloat:-310.0f], [NSNumber numberWithFloat:-320.0f], nil];
    
    self.movingImageTargetOne                             = CGRectMake(-490.0f, 20.0f, 852.0f, 105.0f);
    UIImage *movingImageOne                          = [UIImage imageNamed:@"moving image 1.png"];
    self.movingImageOneView                               = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, 852.0f, 105.0f)];
    self.movingImageOneView.image                         = movingImageOne;
    self.movingImageTargetOneInitial                      = self.movingImageOneView.frame;
    [self.view addSubview:self.movingImageOneView];
    if (!self.m_transition) {
        self.m_transition            = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionAppearForMovingImages:self.movingImageOneView];
    [self animateMovingImageOne];
    
    self.movingImageTargetTwo                             = CGRectMake(-50.0f, 127.0f, 852.0f, 105.0f);
    UIImage *movingImageTwo                          = [UIImage imageNamed:@"moving image 2.png"];
    self.movingImageTwoView                               = [[UIImageView alloc] initWithFrame:CGRectMake(-490.0f, 127.0f, 852.0f, 105.0f)];
    self.movingImageTwoView.image                         = movingImageTwo;
    self.movingImageTargetTwoInitial                      = self.movingImageTwoView.frame;
    [self.view addSubview:self.movingImageTwoView];
    [self.m_transition performTransitionAppearForMovingImages:self.movingImageTwoView];
    [self animateMovingImageTwo];
    
    self.movingImageTargetThree                             = CGRectMake(-490.0f, 234.0f, 812.0f, 105.0f);
    UIImage *movingImageThree                          = [UIImage imageNamed:@"moving image 3.png"];
    self.movingImageThreeView                               = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 234.0f, 852.0f, 105.0f)];
    self.movingImageThreeView.image                         = movingImageThree;
    self.movingImageTargetThreeInitial                      = self.movingImageThreeView.frame;
    [self.view addSubview:self.movingImageThreeView];
    [self.m_transition performTransitionAppearForMovingImages:self.movingImageThreeView];
    [self animateMovingImageThree];
    
    self.movingImageTargetFour                             = CGRectMake(-50.0f, 341.0f, 852.0f, 105.0f);
    UIImage *movingImageFour                          = [UIImage imageNamed:@"moving image 1.png"];
    self.movingImageFourView                               = [[UIImageView alloc] initWithFrame:CGRectMake(-490.0f, 341.0f, 852.0f, 105.0f)];
    self.movingImageFourView.image                         = movingImageFour;
    self.movingImageTargetFourInitial                      = self.movingImageFourView.frame;
    [self.view addSubview:self.movingImageFourView];
    [self.m_transition performTransitionAppearForMovingImages:self.movingImageFourView];
    [self animateMovingImageFour];
    
    self.movingImageTargetFive                             = CGRectMake(-490.0f, 448.0f, 852.0f, 105.0f);
    UIImage *movingImageFive                          = [UIImage imageNamed:@"moving image 2.png"];
    self.movingImageFiveView                               = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 448.0f, 852.0f, 105.0f)];
    self.movingImageFiveView.image                         = movingImageFive;
    self.movingImageTargetFiveInitial                      = self.movingImageFiveView.frame;
    [self.view addSubview:self.movingImageFiveView];
    [self.m_transition performTransitionAppearForMovingImages:self.movingImageFiveView];
    [self animateMovingImageFive];

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.movingImageTargetSix                             = CGRectMake(0.0f, 555.0f, 852.0f, 105.0f);
        UIImage *movingImageSix                          = [UIImage imageNamed:@"moving image 3.png"];
        self.movingImageSixView                               = [[UIImageView alloc] initWithFrame:CGRectMake(-490.0f, 555.0f, 852.0f, 105.0f)];
        self.movingImageSixView.image                         = movingImageSix;
        self.movingImageTargetSixInitial                      = self.movingImageSixView.frame;
        [self.view addSubview:self.movingImageSixView];
        [self.m_transition performTransitionAppearForMovingImages:self.movingImageSixView];
        [self animateMovingImageSix];
    }
}

/*
 Scrolling timer for the slides - pagecontrollers
 */
- (void)scrollingTimer {
    // same way, access pagecontroll access
    UIPageControl *localPageControl                 = (UIPageControl*) [self.view viewWithTag:2];
    
    // get the current offset ( which page is being displayed )
    CGFloat contentOffset                           = self.featuredScrollView.contentOffset.x;
    // calculate next page to display
    int nextPage                                    = (int)(contentOffset/self.featuredScrollView.frame.size.width) + 1 ;
    // if page is not 2, display it
    if( nextPage != 2 )  {
        [self.featuredScrollView scrollRectToVisible:CGRectMake(nextPage*self.featuredScrollView.frame.size.width, 0, self.featuredScrollView.frame.size.width, self.featuredScrollView.frame.size.height) animated:YES];
        localPageControl.currentPage                = nextPage;
        // else start sliding form 1 :)
    } else {
        [self.featuredScrollView scrollRectToVisible:CGRectMake(0, 0, self.featuredScrollView.frame.size.width, self.featuredScrollView.frame.size.height) animated:YES];
        localPageControl.currentPage                = 0;
    }
}

/*
 Set up scrollview
 */
- (void)setupScrollView {
    // we will add all images into a scrollView & set the appropriate size.
    CGRect facebookLoginButtonframe;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        facebookLoginButtonframe                    = CGRectMake(24.0f, 48.0f, 273.0f, 55.0f);
    }
    else {
        facebookLoginButtonframe                    = CGRectMake(24.0f, 60.0f, 273.0f, 55.0f);
    }
    [self.m_facebookLoginButton removeFromSuperview];
    self.m_facebookLoginButton                           = [[UIButton alloc] initWithFrame:facebookLoginButtonframe];
    [self.socialButtonsView addSubview:self.m_facebookLoginButton];
    [self.m_facebookLoginButton addTarget:self action:@selector(loginToFacebook:) forControlEvents:UIControlEventTouchUpInside];
    [self.m_facebookLoginButton setBackgroundImage:[UIImage imageNamed:@"facebook_login"] forState:UIControlStateNormal];
    
    CGRect twitterLoginButtonframe;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        twitterLoginButtonframe                     = CGRectMake(169.0f, 119.0f, 130.0f, 55.0f);
    }
    else {
        twitterLoginButtonframe                     = CGRectMake(169.0f, 131.0f, 130.0f, 55.0f);
    }
    [self.m_twitterLoginButton removeFromSuperview];
    self.m_twitterLoginButton                            = [[UIButton alloc] initWithFrame:twitterLoginButtonframe];
    [self.socialButtonsView addSubview:self.m_twitterLoginButton];
    [self.m_twitterLoginButton addTarget:self action:@selector(loginWithTwitterAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.m_twitterLoginButton setBackgroundImage:[UIImage imageNamed:@"twitter_login"] forState:UIControlStateNormal];

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        [self.googlePlusLoginButtonOne removeFromSuperview];
        self.googlePlusLoginButtonOne = [GPPSignInButton buttonWithType:UIButtonTypeCustom];
        self.googlePlusLoginButtonOne.frame = CGRectMake(20.0f, 121.0f, 130.0f, 55.0f);
        [self.googlePlusLoginButtonOne setBackgroundImage:[UIImage imageNamed:@"google_plus_login"] forState:UIControlStateNormal];
        [self.socialButtonsView addSubview:self.googlePlusLoginButtonOne];
    }
    else {
        [self.googlePlusLoginButtonTwo removeFromSuperview];
        self.googlePlusLoginButtonTwo = [GPPSignInButton buttonWithType:UIButtonTypeCustom];
        self.googlePlusLoginButtonTwo.frame = CGRectMake(20.0f, 133.0f, 130.0f, 55.0f);
        [self.googlePlusLoginButtonTwo setBackgroundImage:[UIImage imageNamed:@"google_plus_login"] forState:UIControlStateNormal];
        [self.socialButtonsView addSubview:self.googlePlusLoginButtonTwo];
    }
    
    
    UILabel *motivationalQuote                      = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 50.0f,280.0f, 100.0f)];
    motivationalQuote.text                          = [NSMutableArray randomlySelectAMotivationalQuote];
    motivationalQuote.font                          = [UIFont customFontWithSize:15];
    motivationalQuote.numberOfLines                 = 4;
    motivationalQuote.textColor                     = [UIColor whiteColor];
    motivationalQuote.textAlignment                 = NSTextAlignmentCenter;
    [self.motivationalQouteView addSubview:motivationalQuote];
    [self.featuredScrollView addSubview:self.motivationalQouteView];
}

-(void)showHUD{
    self.HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:self.HUD];
    
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    self.HUD.delegate = self;
    self.HUD.labelText = @"Initializing";
    self.HUD.progress = 0.0;
    [self.HUD showWhileExecuting:@selector(downloadAction) onTarget:self withObject:nil animated:YES];
}

- (void)downloadAction {
    
    float progress = 0.0f;

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"pictures" ofType:@"json"];
    //NSURL *urlString = [NSURL URLWithString:@"http://total-fitnessandnutrition.com/TotalFitnessAndNutritionApp/HomePage/homepageTextandImage.json"];
    
    //NSData *jsonData = [NSData dataWithContentsOfURL:urlString];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    self.i = 0;
    
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
            self.i++;
            progress += 0.0013f;
            self.HUD.progress = progress;
            usleep(25000);
        }
        }
    }
    NSLog(@"Done Downloading");
    
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[self.HUD removeFromSuperview];
	self.HUD = nil;
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
 Set up slides
 */
- (void)setUpSlides
{
    if([[UIScreen mainScreen] bounds].size.height == 568) {
        self.featuredScrollView                  = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 320.0f, 320.0f, 200.0f)];
    }
    else {
        self.featuredScrollView                  = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 220.0f, 320.0f, 185.0f)];
    }
    self.featuredScrollView.delegate = self;
    self.featuredScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.featuredScrollView];
    CGSize scrollViewContentSize;
    if([[UIScreen mainScreen] bounds].size.height == 568) {
        scrollViewContentSize                = CGSizeMake(640, 200.0f);
    }
    else {
        scrollViewContentSize                = CGSizeMake(640, 185.0f);
    }
    [self.featuredScrollView setContentSize:scrollViewContentSize];

    if([[UIScreen mainScreen] bounds].size.height == 568) {
        self.socialButtonsView                  = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 200.0f)];
    }
    else {
        self.socialButtonsView                  = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 185.0f)];
    }
    [self.featuredScrollView addSubview:self.socialButtonsView];

    if([[UIScreen mainScreen] bounds].size.height == 568) {
        self.motivationalQouteView              = [[UIView alloc] initWithFrame:CGRectMake(320.0f, 0.0f, 320.0f, 200.0f)];
    }
    else {
        self.motivationalQouteView              = [[UIView alloc] initWithFrame:CGRectMake(320.0f, 0.0f, 320.0f, 185.0f)];
    }
    [self.featuredScrollView addSubview:self.motivationalQouteView];
    [self.featuredScrollView setPagingEnabled:YES];
    [self setupScrollView];

    if([[UIScreen mainScreen] bounds].size.height == 568) {
        self.pageControl                        = [[UIPageControl alloc] initWithFrame:CGRectMake(110.0f, 540.0f, 100.0f, 20.0f)];
    }
    else {
        self.pageControl                        = [[UIPageControl alloc] initWithFrame:CGRectMake(110.0f, 440.0f, 100.0f, 20.0f)];
    }
    // tag the page control
    self.pageControl.numberOfPages         = 2;
    self.pageControl.currentPage           = 0;
    //[self.view addSubview:self.pageControl];
}

/*
 Set up sign in view
 */
- (void)setUpSignInView
{
    CGRect m_signinBackgroundViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        m_signinBackgroundViewFrame                   = CGRectMake(0.0f, 0.0f, 320.0f, 568.0f);
    }
    else {
        m_signinBackgroundViewFrame                   = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
    }
    self.m_signinBackgroundView                            = [[UIView alloc] initWithFrame:m_signinBackgroundViewFrame];
    [self.view addSubview:self.m_signinBackgroundView];
    self.m_signinBackgroundView.hidden                   = YES;
//    m_signinBackgroundView.backgroundColor            = [UIColor whiteColor];
    
    CGRect signinBackgroundImageViewframe;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        signinBackgroundImageViewframe              = CGRectMake(0, 0, 320.0f, 568.0f);
        self.m_signinBackgroundImageView                   = [[UIImageView alloc] initWithFrame:signinBackgroundImageViewframe];
       self. m_signinBackgroundImageView.image             = [UIImage imageNamed:@"signin_ready_i5.png"];
    }
    else {
        signinBackgroundImageViewframe              = CGRectMake(0, 0, 320.0f, 480.0f);
       self. m_signinBackgroundImageView                   = [[UIImageView alloc] initWithFrame:signinBackgroundImageViewframe];
       self. m_signinBackgroundImageView.image             = [UIImage imageNamed:@"signin_ready_i4.png"];
    }
    [self.m_signinBackgroundView addSubview:self.m_signinBackgroundImageView];
    self.m_signinBackgroundImageView.hidden                = YES;
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.messageButton                  = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 20.0f, 320.0f, 30.0f)];
    }
    else {
        self.messageButton                  = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 70.0f, 320.0f, 30.0f)];
    }
    [self.m_signinBackgroundView addSubview:self.messageButton];
    [self.messageButton addTarget:self action:@selector(registerUser:) forControlEvents:UIControlEventTouchUpInside];
    self.messageButton.titleLabel.font  = [UIFont customFontWithSize:12];
    self.messageButton.titleLabel.textColor = [UIColor darkGrayColor];

    CGRect m_signin_fieldsFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        m_signin_fieldsFrame                          = CGRectMake(11.0f, 144.0f, 300.0f, 130.0f);
    }
    else {
        m_signin_fieldsFrame                          = CGRectMake(11.0f, 122.0f, 300.0f, 110.0f);
    }
    
    self.m_signin_fields                                   = [[UIImageView alloc] initWithFrame:m_signin_fieldsFrame];
    self.m_signin_fields.image                             = [UIImage imageNamed:@"signin_fields.png"];
    [self.m_signinBackgroundView addSubview:self.m_signin_fields];
    
    CGRect emailIDframe;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        emailIDframe                                  = CGRectMake(66.0f, 151.0f, 233.0f, 50.0f);
    }
    else {
        emailIDframe                                  = CGRectMake(65.0f, 128.0f, 233.0f, 42.0f);
    }
    self.m_email_ID                                        = [[UITextField alloc] initWithFrame:emailIDframe];
    self.m_email_ID.font                                   = [UIFont customFontWithSize:15];
    self.m_email_ID.autocorrectionType                     = UITextAutocorrectionTypeNo;
    self.m_email_ID.placeholder = @"Email ID";
    [self.m_signinBackgroundView addSubview:self.m_email_ID];
    self.m_email_ID.hidden                                 = YES;
    
    CGRect passwordframe;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        passwordframe                                 = CGRectMake(66.0f, 213.0f, 233.0f, 50.0f);
    }
    else {
        passwordframe                                 = CGRectMake(65.0f, 180.0f, 233.0f, 42.0f);
    }
    self.m_password                                        = [[UITextField alloc] initWithFrame:passwordframe];
    self.m_password.font                                   = [UIFont customFontWithSize:15];
    self.m_password.placeholder = @"Password";
    [self.m_signinBackgroundView addSubview:self.m_password];
    self.m_password.secureTextEntry = YES;
    self.m_password.hidden                                 = YES;

    CGRect loginButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        loginButtonFrame               = CGRectMake(169.0f, 278.0f, 130.0f, 50.0f);
    }
    else {
        loginButtonFrame               = CGRectMake(169.0f, 230.0f, 130.0f, 50.0f);
    }
    self.m_signInButton                        = [[UIButton alloc] initWithFrame:loginButtonFrame];
    [self.m_signInButton addTarget:self action:@selector(registerUser:) forControlEvents:UIControlEventTouchUpInside];
    self.m_signInButton.hidden                 = YES;
    [self.m_signInButton setBackgroundImage:[UIImage imageNamed:@"login_button.png"] forState:UIControlStateNormal];
    [self.m_signinBackgroundView addSubview:self.m_signInButton];
    
    CGRect registerButtonFrame;
    if([[UIScreen mainScreen] bounds].size.height == 568){
        registerButtonFrame = CGRectMake(25, 278, 130, 50);
    }
    else{
        registerButtonFrame = CGRectMake(25, 230, 130, 50);
    }
    self.m_registerButton = [[UIButton alloc] initWithFrame:registerButtonFrame];
    self.m_registerButton.hidden = YES;
    [self.m_registerButton addTarget:self action:@selector(moveToRegisterViewController:) forControlEvents:UIControlEventTouchUpInside];
    self.m_registerButton.hidden = YES;
    [self.m_registerButton setBackgroundImage:[UIImage imageNamed:@"register.png"] forState:UIControlStateNormal];
    //[m_signinBackgroundView addSubview:m_registerButton];
}

/*
 Set up views
 */
- (void)setUpViews
{
    [self setUpBackgroundMovingImages];
    
    CGRect loginBackgroundImageViewframe;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        loginBackgroundImageViewframe               = CGRectMake(0, 0, 320.0f, 568.0f);
        self.m_loginBackgroundImageView                    = [[UIImageView alloc] initWithFrame:loginBackgroundImageViewframe];
        self.m_loginBackgroundImageView.image              = [UIImage imageNamed:@"login_iPhone5.png"];
    }
    else {
        loginBackgroundImageViewframe               = CGRectMake(0, 0, 320.0f, 480.0f);
        self.m_loginBackgroundImageView                    = [[UIImageView alloc] initWithFrame:loginBackgroundImageViewframe];
        self.m_loginBackgroundImageView.image              = [UIImage imageNamed:@"login_iPhone4.png"];
    }
    [self.view addSubview:self.m_loginBackgroundImageView];
    
    CGRect showSignInButtonframe;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        showSignInButtonframe                           = CGRectMake(220.0f, 510.0f, 50.0f, 30.0f);
    }
    else {
        showSignInButtonframe                           = CGRectMake(220.0f, 410.0f, 50.0f, 30.0f);
    }
    self.m_showSignInViewButton                                  = [[UIButton alloc] initWithFrame:showSignInButtonframe];
    [self.m_showSignInViewButton setTitle:@"Sign In" forState:UIControlStateNormal];
    self.m_showSignInViewButton.titleLabel.font                  = [UIFont customFontWithSize:15];
    self.m_showSignInViewButton.titleLabel.textColor             = [UIColor whiteColor];
    [self.m_showSignInViewButton addTarget:self action:@selector(showSigninView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.m_showSignInViewButton];
    
    CGRect showRegisterButtonFrame;
    if([[UIScreen mainScreen] bounds].size.height == 568){
        showRegisterButtonFrame = CGRectMake(50.0f, 510.0f, 80.0f, 30.0f);
    }
    else{
        showRegisterButtonFrame = CGRectMake(50.0f, 410.0f, 80.0f, 30.0f);
    }
    self.m_registerViewButton = [[UIButton alloc] initWithFrame:showRegisterButtonFrame];
    [self.m_registerViewButton setTitle:@"Get Started" forState:UIControlStateNormal];
    self.m_registerViewButton.titleLabel.font = [UIFont customFontWithSize:15];
    self.m_registerViewButton.titleLabel.textColor = [UIColor whiteColor];
    [self.m_registerViewButton addTarget:self action:@selector(moveToRegisterViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.m_registerViewButton];

    [self setUpSlides];
    
	// Do any additional setup after loading the view.
  //DEBUG
//    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(sessionStateChanged:) name:FBSessionStateChangedNotification object:nil];
//    
    GPPSignIn *signIn                   = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser    = YES;
    signIn.shouldFetchGoogleUserEmail   = YES;
    signIn.shouldFetchGoogleUserID      = YES;
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    signIn.clientID = kClientId;
    signIn.scopes = [NSArray arrayWithObjects:
                     kGTLAuthScopePlusLogin, // defined in GTLPlusConstants.h
                     nil];
    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;
    
    [self.messageButton removeFromSuperview];
    self.messageButton.titleLabel.font          = [UIFont customFontWithSize:13];
    self.messageButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messageButton.titleLabel.numberOfLines = 2;
    self.messageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.messageButton];
    
    [self setUpSignInView];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.userFacebookEmailID        = @"";
        self.userFacebookBirthday       = @"";
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpViews];
//    [self setUpSlides];
    [self showHUD];
    
    
    // Refresh the view
    [self.view setNeedsDisplay];

}

- (void)viewWillAppear:(BOOL)animated
{
    // make it false to enable proper positioning
    objectsMoved                            = FALSE;
    // default of if the calenderviewcontroller or pofileviewcontroller is called are false
    self.m_rootViewControllerAlreadyCalled       = FALSE;
    self.m_profileViewControllerAlreadyCalled    = FALSE;
}

- (void)didReceiveMemoryWarning
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Facebook Delegate Methods

- (void)sessionStateChanged:(NSNotification*)notification {
  //DEBUG
//    if (FBSession.activeSession.isOpen) {
//        // We have a valid session
//        [FBRequestConnection
//         startForMeWithCompletionHandler:^(FBRequestConnection *connection,
//                                           id<FBGraphUser> user,
//                                           NSError *error) {
//             if (!error) {
//                 // Example: typed access (email)
//                 // - no special permissions required
//                 self.userFacebookEmailID          = [NSString stringWithString:[user objectForKey:@"email"]];
//                 // Example: typed access, (birthday)
//                 // - requires user_birthday permission
//                 self.userFacebookBirthday         = [NSString stringWithString:user.birthday];
//                 // When facebook data is retrieved, login using facebook
//                 [self loginUsingFacebook];
//             }
//         }];
//        
//        if (!m_database) {
//            m_database                  = [Database alloc];
//        }
//        if ([[m_database checkUserLogInStatus:userFacebookEmailID] isEqualToString:@"in"]) { // Make sure registration is complete
//            if (!m_userEmailID) {
//                m_userEmailID   = [NSString getUserEmail];
//            }
//            if ([m_database checkEmailIDInBMR:m_userEmailID]) { // Make sure that user has created a BMR detail first
//                // Present the home page
//                if (!m_rootViewControllerAlreadyCalled) { // it has already been called, don't call the method again
//                    [self rootViewController:self];
//                }
//            }
//            else {
//                // Present the profile page
//                if (!m_profileViewControllerAlreadyCalled) { // it has already been called, don't call the method again
//                    [self profileViewController:self];
//                }
//            }
//        }
//    } else {
//        [self displayMessage:@"You are logged out."];
//    }
}

#pragma mark -
#pragma mark Google Plus Methods

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error
{
    if (!self.m_database) {
        self.m_database          = [Database alloc];
    }
    
    if ([[self.m_database checkIfTermsAndConditionsAccepted] isEqualToString:@"Yes"]) { // if terms and conditions is accepted
        if (error) {
            NSLog(@"Received error %@ and auth object %@",error, auth);
            return;
        }
        [self loginWithGooglePlus];
    }
    else {
        self.m_mode_Of_Registration          = @"registerUsingGooglePlus";
        [self createTermsAndConditionsForms];
    }
}

#pragma mark -
#pragma mark Text Field Delegate Methods

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    if  (textField == self.m_email_ID) {
        if(self.view.frame.origin.y >= 0) {
            if (objectsMoved) {
            }
            else { // If they have are not in moved state, objects adjusts their positions
                objectsMoved                        = TRUE;
                [self moveObjectsToProperPositions];
            }
        }
    }
    else if(textField == self.m_password){ // Otherwise adjust the view
        if(self.view.frame.origin.y >= 0) {
            if (objectsMoved) {
                
            }
            else {
                objectsMoved                        = TRUE;
                [self moveObjectsToProperPositions];
            }
        }
    }
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{    
    if(self.view.frame.origin.y < 0) {
        if (objectsMoved) { // We can't know if user moved to "password" field after textFieldDidEndEditing or it is just a return
            objectsMoved                        = FALSE;
            [self moveObjectsToProperPositions];
        }
        else {
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField // Hide keypad if it is password field's return key
{
    if(textField == self.m_email_ID) {
        [textField resignFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark -
#pragma mark UIScrollView Delegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth               = self.featuredScrollView.frame.size.width;
    float fractionalPage            = self.featuredScrollView.contentOffset.x / pageWidth;
    NSInteger page                  = lround(fractionalPage);
    self.pageControl.currentPage    = page;
}

@end
