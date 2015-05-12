//
//  RegisterViewController.m
//  Total Fitness And Nutrition
//
//  Created by Harveer Parmar on 2014-04-19.
//  Copyright (c) 2014 Total Fitness and Nutrition. All rights reserved.
//

#define kOFFSET_FOR_KEYBOARD 185.0

#import "RegisterViewController.h"
#import "ViewTransitions.h"
#import "ProfileViewController.h"
#import "RootViewController.h"
#import "TFNGateway.h"



@interface RegisterViewController ()

@end

@implementation RegisterViewController
// ProfileViewController class object
ProfileViewController *m_profileViewController;
// RootViewController class object
RootViewController *m_rootViewController;
// ViewFactory class object
ViewFactory *m_controllerViews;
// Database class object
Database *m_database;
// ViewTransition class object
ViewTransitions *m_transition;
// ServerGateway class object
TFNGateway *m_serverConnection;


// All Email Ids
NSMutableArray *m_emailIDsArray;
// move to RootViewController has already been called
bool m_rootViewControllerAlreadyCalled;
// move to ProfileViewController has already been called
bool m_profileViewControllerAlreadyCalled;
// User email id retreived from database
NSString *m_userEmailID;
// Terms and Condition Image View
UIImageView *m_terms_And_Conditions_ImageView;
// Terms and Condition Text View
UITextView *m_terms_And_Conditions_TextView;
// Click Terms and conditions button
UIButton *m_click_Terms_And_Conditions;
// Mode of registration
NSString *m_mode_Of_Registration;

UIImageView *m_loginBackgroundImageView;
UIView *m_signinBackgroundView;
UIImageView *m_signinBackgroundImageView;
UIImageView *m_signin_fields;
UITextField *m_email_ID;
UITextField *m_password;
UIButton *m_registerButton;
UIButton *m_signInButton;
UIButton *m_backButton;

//Moving Images
UIImageView *movingImageOneView;
CGRect movingImageTargetOne;
CGRect movingImageTargetOneInitial;
int movingImageTargetOneState;
UIImageView *movingImageTwoView;
CGRect movingImageTargetTwo;
CGRect movingImageTargetTwoInitial;
int movingImageTargetTwoState;
UIImageView *movingImageThreeView;
CGRect movingImageTargetThree;
CGRect movingImageTargetThreeInitial;
int movingImageTargetThreeState;
UIImageView *movingImageFourView;
CGRect movingImageTargetFour;
CGRect movingImageTargetFourInitial;
int movingImageTargetFourState;
UIImageView *movingImageFiveView;
CGRect movingImageTargetFive;
CGRect movingImageTargetFiveInitial;
int movingImageTargetFiveState;
UIImageView *movingImageSixView;
CGRect movingImageTargetSix;
CGRect movingImageTargetSixInitial;
int movingImageTargetSixState;
NSArray *movingImageXPositions;

ChimpKit *chimp;



ViewTransitions *m_transition;
/*
 Singleton RegisterViewControllerObject
 */
+(RegisterViewController *)sharedInstance{
        static RegisterViewController *globalInstance;
        static dispatch_once_t predicate;
        dispatch_once(&predicate, ^{
            globalInstance = [self alloc];
        });
        return globalInstance;
}
//- (IBAction)moveToPreviousViewController:(id)sender {
//    
//    if(!m_transition){
//        m_transition = [ViewTransitions sharedInstance];
//    }
//    [m_transition performTransitionFromRight:self.view.superview];
//    [self.view removeFromSuperview];
//    
//}

/*
 Check email string
 */
- (BOOL) validateEmail: (NSString *) email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}


-(void)moveToPreviousViewController:(id)sender{
        if(!m_transition){
            m_transition = [ViewTransitions sharedInstance];
        }
        [m_transition performTransitionFromRight:self.view.superview];
        [self.view removeFromSuperview];
}

/*
 Move to RootViewController
 */
- (void)rootViewController:(id)sender
{
    // Hide keypad
    [m_email_ID resignFirstResponder];
    [m_password resignFirstResponder];
    
    if (!m_rootViewController) {
        m_rootViewController                    = [RootViewController sharedInstance];
    }
    
    id instanceObject                               = m_rootViewController;
    [self moveToView:m_rootViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    m_rootViewController.view.tag               = 20;
    // The method is now called, now don't call when facebook session changes
    m_rootViewControllerAlreadyCalled           = TRUE;
}

/*
 Move to ProfileViewController
 */
- (void)profileViewController:(id)sender
{
    // Hide keypad
    [m_email_ID resignFirstResponder];
    [m_password resignFirstResponder];
    
    if (!m_profileViewController) {
        m_profileViewController             = [ProfileViewController sharedInstance];
    }
    id instanceObject                       = m_profileViewController;
    m_profileViewController.view.tag        = 2;
    [self moveToView:m_profileViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    // The method is now called, now don't call when facebook session changes
    m_profileViewControllerAlreadyCalled    = TRUE;
}

// Move to RootViewController or ProfileViewController
- (void)moveToRootOrProfileViewController: (NSString *)userStatus
{
    if ([userStatus isEqualToString:@"New User"]) { // If new user present the profile page
        // Present the profile page
        [self profileViewController:self];
    }
    else {
        if (!m_database) {
            m_database      = [Database alloc];
        }
        if (!m_userEmailID) {
            m_userEmailID   = [NSString getUserEmail];
            
        }
        if ([m_database checkEmailIDInBMR:m_userEmailID]) { // Make sure that user has created a BMR detail first
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
    
    if (!m_database) {
        m_database          = [Database alloc];
    }
    status                  = [m_database insertIntoTermsAndConditionsToAccept:@"Yes"];
    if ([status isEqualToString:@"inserted"]) {
        if ([m_mode_Of_Registration isEqualToString:@"registerUser"]) {
            [self insertUserIntoDatabase];
        }
        // remove terms and conditions form
        [self removeTermsAndConditionsForm];
    }
    else { // failed to accept
        //[self displayMessage:@"Please accept the Terms & Conditions to proceed"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Terms and Conditions" message:@"Please accept the Terms & Conditions to proceed" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }

}

/*
 Create terms and conditions if not signed
 */
- (void)createTermsAndConditionsForms
{
    if (!m_transition) {
        m_transition    = [ViewTransitions sharedInstance];
    }
    
    // Terms and Conditions frames
    CGRect termsAndConditionsImageViewFrame;
    CGRect termsAndConditionsTextViewFrame;
    CGRect termsAndConditionsClickButtonFrame;
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        termsAndConditionsImageViewFrame                = CGRectMake(0.0f, 0.0f, 320.0f, 568.0f);
        m_terms_And_Conditions_ImageView                = [[UIImageView alloc] initWithFrame:termsAndConditionsImageViewFrame];
        m_terms_And_Conditions_ImageView.image          = [UIImage imageNamed:@"terms_condition_iPhone5.png"];
        termsAndConditionsTextViewFrame                 = CGRectMake(35.0f, 185.0f, 260.0f, 265.0f);
        termsAndConditionsClickButtonFrame              = CGRectMake(69.0f, 480.0f, 182.0f, 50.0f);
    }
    else { // if iphones other than iphone 5
        termsAndConditionsImageViewFrame                = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
        m_terms_And_Conditions_ImageView                = [[UIImageView alloc] initWithFrame:termsAndConditionsImageViewFrame];
        m_terms_And_Conditions_ImageView.image          = [UIImage imageNamed:@"terms_condition_iPhone4.png"];
        termsAndConditionsTextViewFrame                 = CGRectMake(35.0f, 130.0f, 260.0f, 260.0f);
        termsAndConditionsClickButtonFrame              = CGRectMake(69.0f, 420.0f, 182.0f, 50.0f);
    }
    
    [self.view addSubview:m_terms_And_Conditions_ImageView];
    [m_transition performTransitionAppear:m_terms_And_Conditions_ImageView];
    m_terms_And_Conditions_TextView                 = [[UITextView alloc] initWithFrame:termsAndConditionsTextViewFrame];
    [self.view addSubview:m_terms_And_Conditions_TextView];
    m_terms_And_Conditions_TextView.backgroundColor = [UIColor clearColor];
    m_terms_And_Conditions_TextView.text            = self.termsAndConditionTextView.text;
    m_terms_And_Conditions_TextView.textColor       = [UIColor whiteColor];
    m_terms_And_Conditions_TextView.editable        = NO;
    m_terms_And_Conditions_TextView.scrollEnabled   = YES;
    [m_transition performTransitionAppear:m_terms_And_Conditions_TextView];
    
    m_click_Terms_And_Conditions                    = [[UIButton alloc] initWithFrame:termsAndConditionsClickButtonFrame];
    [self.view addSubview:m_click_Terms_And_Conditions];
    [m_click_Terms_And_Conditions addTarget:self action:@selector(acceptTermsAndConditions:) forControlEvents:UIControlEventTouchUpInside];
    [m_transition performTransitionAppear:m_click_Terms_And_Conditions];
    
}

/*
 Remove terms and conditions
 */
- (void)removeTermsAndConditionsForm
{
    if (!m_transition) {
        m_transition                = [ViewTransitions sharedInstance];
    }
    
    [m_transition performTransitionAppear:m_loginBackgroundImageView];
    // Show the background login image view
    m_loginBackgroundImageView.hidden                     = NO;
    m_signinBackgroundView.hidden                         = YES;
    m_signinBackgroundImageView.hidden                    = YES;
    [m_click_Terms_And_Conditions removeFromSuperview];
    [m_terms_And_Conditions_ImageView removeFromSuperview];
    [m_terms_And_Conditions_TextView removeFromSuperview];
}

/*
 Insert user into database
 */
- (void)insertUserIntoDatabase
{
    if ([self validateEmail:m_email_ID.text]) { // Validate to be an Email Id
        [self registerUserWithUsername:m_email_ID.text AndPassword:m_password.text];
        
    }
    else {
        //[self displayMessage:@"Please enter a valid email id."];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Email" message:@"Please enter a valid email ID." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
    }
}

/*
 Register user with username and password
 */
- (void)registerUserWithUsername:(NSString *)usernameInput AndPassword:(NSString *)passwordInput
{
    NSString *userStatus;
    if ( !m_database ) {
        m_database      = [ Database alloc ];
    }
    // if the string is not null or empty or nil or false
    if ((usernameInput != NULL && passwordInput != NULL) || (([usernameInput length] != 0) && [passwordInput length] != 0)) {// If the data has been retrieved
        userStatus          = [[NSString alloc] initWithFormat:@"%@", [m_database insertIntoUserEmail_Id:usernameInput Password:passwordInput Log:@"in"]];
        
        if ([userStatus length] != 0) { // if inserted into database or check if already existing
            // move to root or profile view controller
            [self moveToRootOrProfileViewController:userStatus];

            PFObject *object = [PFObject objectWithClassName:@"RegisteredUsers"];
            object[@"email"] = usernameInput;
            [object saveInBackground];
            
        }
        else {
            //[self displayMessage:@"Login failed, please try again"];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Login failed. Please try again" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
            [alert show];
        }
    }
    else {// if not
        userStatus          = @"";
    }
}

- (void)showSubscribeError {
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Subscription Failed"
                                                             message:@"We couldn't subscribe you to the list.  Please check your email address and try again."
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
    [errorAlertView show];
}


/*
 Register and login, if already registered, just login
 */
- (void)registerUser:(id)sender
{
    NSString *userStatus;
    if (((m_email_ID.text == NULL) || ([m_email_ID.text length] == 0)) || (m_password.text == NULL || ([m_password.text length] == 0))) {
        //[self displayMessage:@"User Id field or Password field cannot be empty."];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty Fields" message:@"User ID field or Password field cannot be empty" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
    }
    else { // Textfields not empty
        m_mode_Of_Registration              = @"registerUser";
        
        if (!m_database) {
            m_database          = [Database alloc];
        }
        
        if ([[m_database checkIfTermsAndConditionsAccepted] isEqualToString:@"Yes"]) { // if terms and conditions is accepted
            
            // register into database
            [self insertUserIntoDatabase];
        }
        else {
            [self createTermsAndConditionsForms];
        }
        if (userStatus == NULL || [userStatus length] == 0) {
            // Hide the keypad
            [m_email_ID resignFirstResponder];
            [m_password resignFirstResponder];
        }
    }
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
    [self setUpBackgroundMovingImages];
    [super viewDidLoad];
    CGRect m_signinBackgroundViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        m_signinBackgroundViewFrame                   = CGRectMake(0.0f, 0.0f, 320.0f, 568.0f);
    }
    else {
        m_signinBackgroundViewFrame                   = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
    }
    m_signinBackgroundView                            = [[UIView alloc] initWithFrame:m_signinBackgroundViewFrame];
    [self.view addSubview:m_signinBackgroundView];
    m_signinBackgroundView.hidden                   = NO;
    //    m_signinBackgroundView.backgroundColor            = [UIColor whiteColor];
    
    CGRect signinBackgroundImageViewframe;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        signinBackgroundImageViewframe              = CGRectMake(0, 0, 320.0f, 568.0f);
        m_signinBackgroundImageView                   = [[UIImageView alloc] initWithFrame:signinBackgroundImageViewframe];
        m_signinBackgroundImageView.image             = [UIImage imageNamed:@"signin_ready_i5.png"];
    }
    else {
        signinBackgroundImageViewframe              = CGRectMake(0, 0, 320.0f, 480.0f);
        m_signinBackgroundImageView                   = [[UIImageView alloc] initWithFrame:signinBackgroundImageViewframe];
        m_signinBackgroundImageView.image             = [UIImage imageNamed:@"signin_ready_i4.png"];
    }
    [m_signinBackgroundView addSubview:m_signinBackgroundImageView];
    m_signinBackgroundImageView.hidden                = NO;
    
    CGRect m_signin_fieldsFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        m_signin_fieldsFrame                          = CGRectMake(11.0f, 144.0f, 300.0f, 130.0f);
    }
    else {
        m_signin_fieldsFrame                          = CGRectMake(11.0f, 122.0f, 300.0f, 110.0f);
    }
    
    m_signin_fields                                   = [[UIImageView alloc] initWithFrame:m_signin_fieldsFrame];
    m_signin_fields.image                             = [UIImage imageNamed:@"signin_fields.png"];
    [m_signinBackgroundView addSubview:m_signin_fields];
    
    CGRect emailIDframe;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        emailIDframe                                  = CGRectMake(66.0f, 151.0f, 233.0f, 50.0f);
    }
    else {
        emailIDframe                                  = CGRectMake(65.0f, 128.0f, 233.0f, 42.0f);
    }
    m_email_ID                                        = [[UITextField alloc] initWithFrame:emailIDframe];
    m_email_ID.font                                   = [UIFont customFontWithSize:15];
    m_email_ID.autocorrectionType                     = UITextAutocorrectionTypeNo;
    m_email_ID.placeholder = @"Email ID";
    [m_signinBackgroundView addSubview:m_email_ID];
    m_email_ID.hidden                                 = NO;
    
    CGRect passwordframe;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        passwordframe                                 = CGRectMake(66.0f, 213.0f, 233.0f, 50.0f);
    }
    else {
        passwordframe                                 = CGRectMake(65.0f, 180.0f, 233.0f, 42.0f);
    }
    m_password                                        = [[UITextField alloc] initWithFrame:passwordframe];
    m_password.font                                   = [UIFont customFontWithSize:15];
    m_password.placeholder = @"Password";
    [m_signinBackgroundView addSubview:m_password];
    m_password.secureTextEntry = YES;
    m_password.hidden                                 = NO;
    

    CGRect registerButtonFrame;
    if([[UIScreen mainScreen] bounds].size.height == 568){
        registerButtonFrame = CGRectMake(25, 278, 130, 50);
    }
    else{
        registerButtonFrame = CGRectMake(25, 230, 130, 50);
    }
    m_registerButton = [[UIButton alloc] initWithFrame:registerButtonFrame];
    m_registerButton.hidden = NO;
    [m_registerButton addTarget:self action:@selector(registerUser:) forControlEvents:UIControlEventTouchUpInside];
    m_registerButton.hidden = NO;
    [m_registerButton setBackgroundImage:[UIImage imageNamed:@"register.png"] forState:UIControlStateNormal];
    [m_signinBackgroundView addSubview:m_registerButton];
    
    CGRect backButton;
    if([[UIScreen mainScreen]bounds].size.height == 568){
        backButton = CGRectMake(20, 20, 44, 36);
    }
    m_backButton = [[UIButton alloc] initWithFrame:backButton];
    m_backButton.hidden = NO;
    [m_backButton addTarget:self action:@selector(moveToPreviousViewController:) forControlEvents:UIControlEventTouchUpInside];
    [m_backButton setBackgroundImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateNormal];
    [m_signinBackgroundView addSubview:m_backButton];

}

#pragma Text Field Delegate Methods

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if  (textField == m_email_ID) {
        if(self.view.frame.origin.y >= 0) {
            if (objectsMoved) {
            }
            else { // If they have are not in moved state, objects adjusts their positions
                objectsMoved                        = TRUE;
                [self moveObjectsToProperPositions];
            }
        }
    }
    else if(textField == m_password){ // Otherwise adjust the view
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
    if(textField == m_email_ID) {
        [textField resignFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 Animate moving image one
 */
- (void)animateMovingImageOne
{
    __block int movingImageTargetOneStateBlock  = movingImageTargetOneState;
    [UIView animateWithDuration:25.0
                          delay:1.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (movingImageTargetOneStateBlock == 0) {
                             movingImageTargetOneStateBlock = 1;
                             movingImageOneView.frame   = movingImageTargetOne;
                         }
                         else {
                             movingImageTargetOneStateBlock = 0;
                             movingImageOneView.frame    = movingImageTargetOneInitial;
                         }
                     }
                     completion:^(BOOL finished){
                         movingImageTargetOneState           = movingImageTargetOneStateBlock;
                         [self animateMovingImageOne];
                     }];
}

/*
 Animate moving image two
 */
- (void)animateMovingImageTwo
{
    __block int movingImageTargetTwoStateBlock  = movingImageTargetTwoState;
    [UIView animateWithDuration:25.0
                          delay:1.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (movingImageTargetTwoStateBlock == 0) {
                             movingImageTargetTwoStateBlock = 1;
                             movingImageTwoView.frame   = movingImageTargetTwo;
                         }
                         else {
                             movingImageTargetTwoStateBlock = 0;
                             movingImageTwoView.frame   = movingImageTargetTwoInitial;
                         }
                     }
                     completion:^(BOOL finished){
                         movingImageTargetTwoState           = movingImageTargetTwoStateBlock;
                         [self animateMovingImageTwo];
                     }];
}

/*
 Animate moving image three
 */
- (void)animateMovingImageThree
{
    __block int movingImageTargetThreeStateBlock  = movingImageTargetThreeState;
    [UIView animateWithDuration:25.0
                          delay:1.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (movingImageTargetThreeStateBlock == 0) {
                             movingImageTargetThreeStateBlock = 1;
                             movingImageThreeView.frame   = movingImageTargetThree;
                         }
                         else {
                             movingImageTargetThreeStateBlock = 0;
                             movingImageThreeView.frame   = movingImageTargetThreeInitial;
                         }
                     }
                     completion:^(BOOL finished){
                         movingImageTargetThreeState           = movingImageTargetThreeStateBlock;
                         [self animateMovingImageThree];
                     }];
}

/*
 Animate moving image four
 */
- (void)animateMovingImageFour
{
    __block int movingImageTargetFourStateBlock  = movingImageTargetFourState;
    [UIView animateWithDuration:25.0
                          delay:1.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (movingImageTargetFourStateBlock == 0) {
                             movingImageTargetFourStateBlock = 1;
                             movingImageFourView.frame   = movingImageTargetFour;
                         }
                         else {
                             movingImageTargetFourStateBlock = 0;
                             movingImageFourView.frame   = movingImageTargetFourInitial;
                         }
                     }
                     completion:^(BOOL finished){
                         movingImageTargetFourState           = movingImageTargetFourStateBlock;
                         [self animateMovingImageFour];
                     }];
}

/*
 Animate moving image five
 */
- (void)animateMovingImageFive
{
    __block int movingImageTargetFiveStateBlock  = movingImageTargetFiveState;
    [UIView animateWithDuration:25.0
                          delay:1.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (movingImageTargetFiveStateBlock == 0) {
                             movingImageTargetFiveStateBlock = 1;
                             movingImageFiveView.frame   = movingImageTargetFive;
                         }
                         else {
                             movingImageTargetFiveStateBlock = 0;
                             movingImageFiveView.frame   = movingImageTargetFiveInitial;
                         }
                     }
                     completion:^(BOOL finished){
                         movingImageTargetFiveState           = movingImageTargetFiveStateBlock;
                         [self animateMovingImageFive];
                     }];
}

/*
 Animate moving image six
 */
- (void)animateMovingImageSix
{
    __block int movingImageTargetSixStateBlock  = movingImageTargetSixState;
    [UIView animateWithDuration:25.0
                          delay:1.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (movingImageTargetSixStateBlock == 0) {
                             movingImageTargetSixStateBlock = 1;
                             movingImageSixView.frame   = movingImageTargetSix;
                         }
                         else {
                             movingImageTargetSixStateBlock = 0;
                             movingImageSixView.frame   = movingImageTargetSixInitial;
                         }
                     }
                     completion:^(BOOL finished){
                         movingImageTargetSixState           = movingImageTargetSixStateBlock;
                         [self animateMovingImageSix];
                     }];
}

/*
 Set up background moving images
 */
- (void)setUpBackgroundMovingImages
{
    movingImageTargetOne                             = CGRectMake(-490.0f, 20.0f, 852.0f, 105.0f);
    UIImage *movingImageOne                          = [UIImage imageNamed:@"moving image 1.png"];
    movingImageOneView                               = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, 852.0f, 105.0f)];
    movingImageOneView.image                         = movingImageOne;
    movingImageTargetOneInitial                      = movingImageOneView.frame;
    [self.view addSubview:movingImageOneView];
    if (!m_transition) {
        m_transition            = [ViewTransitions sharedInstance];
    }
    [m_transition performTransitionAppearForMovingImages:movingImageOneView];
    //[self animateMovingImageOne];
    
    movingImageTargetTwo                             = CGRectMake(-50.0f, 127.0f, 852.0f, 105.0f);
    UIImage *movingImageTwo                          = [UIImage imageNamed:@"moving image 2.png"];
    movingImageTwoView                               = [[UIImageView alloc] initWithFrame:CGRectMake(-490.0f, 127.0f, 852.0f, 105.0f)];
    movingImageTwoView.image                         = movingImageTwo;
    movingImageTargetTwoInitial                      = movingImageTwoView.frame;
    [self.view addSubview:movingImageTwoView];
    [m_transition performTransitionAppearForMovingImages:movingImageTwoView];
    //[self animateMovingImageTwo];
    
    movingImageTargetThree                             = CGRectMake(-490.0f, 234.0f, 812.0f, 105.0f);
    UIImage *movingImageThree                          = [UIImage imageNamed:@"moving image 3.png"];
    movingImageThreeView                               = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 234.0f, 852.0f, 105.0f)];
    movingImageThreeView.image                         = movingImageThree;
    movingImageTargetThreeInitial                      = movingImageThreeView.frame;
    [self.view addSubview:movingImageThreeView];
    [m_transition performTransitionAppearForMovingImages:movingImageThreeView];
    //[self animateMovingImageThree];
    
    movingImageTargetFour                             = CGRectMake(-50.0f, 341.0f, 852.0f, 105.0f);
    UIImage *movingImageFour                          = [UIImage imageNamed:@"moving image 1.png"];
    movingImageFourView                               = [[UIImageView alloc] initWithFrame:CGRectMake(-490.0f, 341.0f, 852.0f, 105.0f)];
    movingImageFourView.image                         = movingImageFour;
    movingImageTargetFourInitial                      = movingImageFourView.frame;
    [self.view addSubview:movingImageFourView];
    [m_transition performTransitionAppearForMovingImages:movingImageFourView];
    //[self animateMovingImageFour];
    
    movingImageTargetFive                             = CGRectMake(-490.0f, 448.0f, 852.0f, 105.0f);
    UIImage *movingImageFive                          = [UIImage imageNamed:@"moving image 2.png"];
    movingImageFiveView                               = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 448.0f, 852.0f, 105.0f)];
    movingImageFiveView.image                         = movingImageFive;
    movingImageTargetFiveInitial                      = movingImageFiveView.frame;
    [self.view addSubview:movingImageFiveView];
    [m_transition performTransitionAppearForMovingImages:movingImageFiveView];
    //[self animateMovingImageFive];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        movingImageTargetSix                             = CGRectMake(0.0f, 555.0f, 852.0f, 105.0f);
        UIImage *movingImageSix                          = [UIImage imageNamed:@"moving image 3.png"];
        movingImageSixView                               = [[UIImageView alloc] initWithFrame:CGRectMake(-490.0f, 555.0f, 852.0f, 105.0f)];
        movingImageSixView.image                         = movingImageSix;
        movingImageTargetSixInitial                      = movingImageSixView.frame;
        [self.view addSubview:movingImageSixView];
        [m_transition performTransitionAppearForMovingImages:movingImageSixView];
        //[self animateMovingImageSix];
    }
}

@end
