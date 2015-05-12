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

@property (strong, nonatomic) ProfileViewController *m_profileViewController;

@property (strong, nonatomic) RootViewController *m_rootViewController;

@property (strong, nonatomic) ViewFactory *m_controllerViews;
@property (strong, nonatomic) Database *m_database;
@property (strong, nonatomic) ViewTransitions *m_transition;
@property (strong, nonatomic) TFNGateway *m_serverConnection;

@property (strong, nonatomic) NSMutableArray *m_emailIDsArray;
@property (nonatomic) BOOL m_rootViewControllerAlreadyCalled;
@property (nonatomic) BOOL m_profileViewControllerAlreadyCalled;
@property (strong, nonatomic) NSString *m_userEmailID;
@property (strong, nonatomic) UIImageView *m_terms_And_Conditions_ImageView;

@property (strong, nonatomic) UITextView *m_terms_And_Conditions_TextView;
@property (strong, nonatomic) UIButton *m_click_Terms_And_Conditions;
@property (strong, nonatomic) NSString *m_mode_Of_Registration;
@property (strong, nonatomic) UIImageView *m_loginBackgroundImageView;
@property (strong, nonatomic) UIView *m_signinBackgroundView;
@property (strong, nonatomic) UIImageView *m_signinBackgroundImageView;
@property (strong, nonatomic) UIImageView *m_signin_fields;
@property (strong, nonatomic) UITextField *m_email_ID;
@property (strong, nonatomic) UITextField *m_password;
@property (strong, nonatomic) UIButton *m_registerButton;
@property (strong, nonatomic) UIButton *m_signInButton;
@property (strong, nonatomic) UIButton *m_backButton;
@property (strong, nonatomic) UIImageView *movingImageOneView;
@property (nonatomic) CGRect movingImageTargetOne;
@property (nonatomic) CGRect movingImageTargetOneInitial;
@property (nonatomic) int movingImageTargetOneState;
@property (strong, nonatomic) UIImageView *movingImageTwoView;
@property (nonatomic) CGRect movingImageTargetTwo;
@property (nonatomic) CGRect movingImageTargetTwoInitial;
@property (nonatomic) int movingImageTargetTwoState;
@property (strong, nonatomic) UIImageView *movingImageThreeView;
@property (nonatomic) CGRect movingImageTargetThree;
@property (nonatomic) CGRect movingImageTargetThreeInitial;
@property (nonatomic) int movingImageTargetThreeState;
@property (nonatomic) UIImageView *movingImageFourView;
@property (nonatomic) CGRect movingImageTargetFour;
@property (nonatomic) CGRect movingImageTargetFourInitial;
@property (nonatomic) int movingImageTargetFourState;
@property (strong, nonatomic) UIImageView *movingImageFiveView;
@property (nonatomic) CGRect movingImageTargetFive;
@property (nonatomic) CGRect movingImageTargetFiveInitial;
@property (nonatomic) CGRect m_signinBackgroundViewFrame;
@property (nonatomic) int movingImageTargetFiveState;
@property (nonatomic) CGRect movingImageTargetSix;
@property (nonatomic) CGRect movingImageTargetSixInitial;
@property (nonatomic) int movingImageTargetSixState;
@property (nonatomic) NSArray *movingImageXPositions;
@property (nonatomic) UIImageView *movingImageSixView;
@property (strong, nonatomic) ChimpKit *chimp;

@property (nonatomic) CGRect m_signin_fieldsFrame;
@end

@implementation RegisterViewController


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
        if(!self.m_transition){
            self.m_transition = [ViewTransitions sharedInstance];
        }
        [self.m_transition performTransitionFromRight:self.view.superview];
        [self.view removeFromSuperview];
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
    if (!self.m_transition) {
        self.m_transition    = [ViewTransitions sharedInstance];
    }
    
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
        self.m_terms_And_Conditions_ImageView                = [[UIImageView alloc] initWithFrame:termsAndConditionsImageViewFrame];
        self.m_terms_And_Conditions_ImageView.image          = [UIImage imageNamed:@"terms_condition_iPhone4.png"];
        termsAndConditionsTextViewFrame                 = CGRectMake(35.0f, 130.0f, 260.0f, 260.0f);
        termsAndConditionsClickButtonFrame              = CGRectMake(69.0f, 420.0f, 182.0f, 50.0f);
    }
    
    [self.view addSubview:self.m_terms_And_Conditions_ImageView];
    [self.m_transition performTransitionAppear:self.m_terms_And_Conditions_ImageView];
    self.m_terms_And_Conditions_TextView                 = [[UITextView alloc] initWithFrame:termsAndConditionsTextViewFrame];
    [self.view addSubview:self.m_terms_And_Conditions_TextView];
    self.m_terms_And_Conditions_TextView.backgroundColor = [UIColor clearColor];
    self.m_terms_And_Conditions_TextView.text            = self.termsAndConditionTextView.text;
    self.m_terms_And_Conditions_TextView.textColor       = [UIColor whiteColor];
    self.m_terms_And_Conditions_TextView.editable        = NO;
    self.self.m_terms_And_Conditions_TextView.scrollEnabled   = YES;
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
    if (((self.m_email_ID.text == NULL) || ([self.m_email_ID.text length] == 0)) || (self.m_password.text == NULL || ([self.m_password.text length] == 0))) {
        //[self displayMessage:@"User Id field or Password field cannot be empty."];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty Fields" message:@"User ID field or Password field cannot be empty" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
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
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.m_signinBackgroundViewFrame                   = CGRectMake(0.0f, 0.0f, 320.0f, 568.0f);
    }
    else {
        self.m_signinBackgroundViewFrame                   = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
    }
    self.m_signinBackgroundView                            = [[UIView alloc] initWithFrame:self.m_signinBackgroundViewFrame];
    [self.view addSubview:self.m_signinBackgroundView];
    self.m_signinBackgroundView.hidden                   = NO;
    //    self.m_signinBackgroundView.backgroundColor            = [UIColor whiteColor];
    
    CGRect signinBackgroundImageViewframe;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        signinBackgroundImageViewframe              = CGRectMake(0, 0, 320.0f, 568.0f);
        self.m_signinBackgroundImageView                   = [[UIImageView alloc] initWithFrame:signinBackgroundImageViewframe];
        self.m_signinBackgroundImageView.image             = [UIImage imageNamed:@"signin_ready_i5.png"];
    }
    else {
        signinBackgroundImageViewframe              = CGRectMake(0, 0, 320.0f, 480.0f);
        self.m_signinBackgroundImageView                   = [[UIImageView alloc] initWithFrame:signinBackgroundImageViewframe];
        self.m_signinBackgroundImageView.image             = [UIImage imageNamed:@"signin_ready_i4.png"];
    }
    [self.m_signinBackgroundView addSubview:self.m_signinBackgroundImageView];
    self.m_signinBackgroundImageView.hidden                = NO;
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.m_signin_fieldsFrame                          = CGRectMake(11.0f, 144.0f, 300.0f, 130.0f);
    }
    else {
        self.m_signin_fieldsFrame                          = CGRectMake(11.0f, 122.0f, 300.0f, 110.0f);
    }
    
    self.m_signin_fields                                   = [[UIImageView alloc] initWithFrame:self.m_signin_fieldsFrame];
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
    self.m_email_ID.hidden                                 = NO;
    
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
    self.m_password.hidden                                 = NO;
    

    CGRect registerButtonFrame;
    if([[UIScreen mainScreen] bounds].size.height == 568){
        registerButtonFrame = CGRectMake(25, 278, 130, 50);
    }
    else{
        registerButtonFrame = CGRectMake(25, 230, 130, 50);
    }
    self.m_registerButton = [[UIButton alloc] initWithFrame:registerButtonFrame];
    self.m_registerButton.hidden = NO;
    [self.m_registerButton addTarget:self action:@selector(registerUser:) forControlEvents:UIControlEventTouchUpInside];
    self.m_registerButton.hidden = NO;
    [self.m_registerButton setBackgroundImage:[UIImage imageNamed:@"register.png"] forState:UIControlStateNormal];
    [self.m_signinBackgroundView addSubview:self.m_registerButton];
    
    CGRect backButton;
    if([[UIScreen mainScreen]bounds].size.height == 568){
        backButton = CGRectMake(20, 20, 44, 36);
    }
    self.m_backButton = [[UIButton alloc] initWithFrame:backButton];
    self.m_backButton.hidden = NO;
    [self.m_backButton addTarget:self action:@selector(moveToPreviousViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.m_backButton setBackgroundImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateNormal];
    [self.m_signinBackgroundView addSubview:self.m_backButton];

}

#pragma Text Field Delegate Methods

-(void)textFieldDidBeginEditing:(UITextField *)textField{
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
    if(textField == self.m_email_ID) {
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

/*
 Set up background moving images
 */
- (void)setUpBackgroundMovingImages
{
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
    //[self animateMovingImageOne];
    
    self.movingImageTargetTwo                             = CGRectMake(-50.0f, 127.0f, 852.0f, 105.0f);
    UIImage *movingImageTwo                          = [UIImage imageNamed:@"moving image 2.png"];
    self.movingImageTwoView                               = [[UIImageView alloc] initWithFrame:CGRectMake(-490.0f, 127.0f, 852.0f, 105.0f)];
    self.movingImageTwoView.image                         = movingImageTwo;
    self.movingImageTargetTwoInitial                      = self.movingImageTwoView.frame;
    [self.view addSubview:self.movingImageTwoView];
    [self.m_transition performTransitionAppearForMovingImages:self.movingImageTwoView];
    //[self animateMovingImageTwo];
    
    self.movingImageTargetThree                             = CGRectMake(-490.0f, 234.0f, 812.0f, 105.0f);
    UIImage *movingImageThree                          = [UIImage imageNamed:@"moving image 3.png"];
    self.movingImageThreeView                               = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 234.0f, 852.0f, 105.0f)];
    self.movingImageThreeView.image                         = movingImageThree;
    self.movingImageTargetThreeInitial                      = self.movingImageThreeView.frame;
    [self.view addSubview:self.movingImageThreeView];
    [self.m_transition performTransitionAppearForMovingImages:self.movingImageThreeView];
    //[self animateMovingImageThree];
    
    self.movingImageTargetFour                             = CGRectMake(-50.0f, 341.0f, 852.0f, 105.0f);
    UIImage *movingImageFour                          = [UIImage imageNamed:@"moving image 1.png"];
    self.movingImageFourView                               = [[UIImageView alloc] initWithFrame:CGRectMake(-490.0f, 341.0f, 852.0f, 105.0f)];
    self.movingImageFourView.image                         = movingImageFour;
    self.movingImageTargetFourInitial                      = self.movingImageFourView.frame;
    [self.view addSubview:self.movingImageFourView];
    [self.m_transition performTransitionAppearForMovingImages:self.movingImageFourView];
    //[self animateMovingImageFour];
    
    self.movingImageTargetFive                             = CGRectMake(-490.0f, 448.0f, 852.0f, 105.0f);
    UIImage *movingImageFive                          = [UIImage imageNamed:@"moving image 2.png"];
    self.movingImageFiveView                               = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 448.0f, 852.0f, 105.0f)];
    self.movingImageFiveView.image                         = movingImageFive;
    self.movingImageTargetFiveInitial                      = self.movingImageFiveView.frame;
    [self.view addSubview:self.movingImageFiveView];
    [self.m_transition performTransitionAppearForMovingImages:self.movingImageFiveView];
    //[self animateMovingImageFive];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.movingImageTargetSix                             = CGRectMake(0.0f, 555.0f, 852.0f, 105.0f);
        UIImage *movingImageSix                          = [UIImage imageNamed:@"moving image 3.png"];
        self.movingImageSixView                               = [[UIImageView alloc] initWithFrame:CGRectMake(-490.0f, 555.0f, 852.0f, 105.0f)];
        self.movingImageSixView.image                         = movingImageSix;
        self.movingImageTargetSixInitial                      = self.movingImageSixView.frame;
        [self.view addSubview:self.movingImageSixView];
        [self.m_transition performTransitionAppearForMovingImages:self.movingImageSixView];
        //[self animateMovingImageSix];
    }
}

@end
