//
//  ProfileViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-10-30.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//
#define kOFFSET_FOR_KEYBOARD            185.0

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "RootViewController.h"
#import "GoalsViewController.h"
#import "ProfileViewController_Profile.h"
#import "UIImageView+Scroll.h"
#import "MealViewController.h"
#import "UILabel+ChangeLabelNumbers.h"
#import <Parse/Parse.h>

@interface ProfileViewController ()

// LoginViewController class object
@property (strong, nonatomic)LoginViewController *m_loginViewController;
// ExerciseViewController class object
@property (strong, nonatomic)ExerciseViewController *m_exerciseViewController;
// MealViewContrioller class object
@property (strong, nonatomic)MealViewController *m_mealViewController;
// CalenderViewController class object
@property (strong, nonatomic)CalenderViewController *m_calenderViewController;
// GoalsViewController class object
@property (strong, nonatomic)GoalsViewController *m_goalsViewController;
// MusicTracksViewController class object
@property (strong, nonatomic)MusicTracksViewController *m_musicTracksViewController;
// RootViewController class object
@property (strong, nonatomic)RootViewController *m_rootViewController;
// ViewFactory class object
@property (strong, nonatomic)ViewFactory *m_controllerViews;
// Database class object
@property (strong, nonatomic)Database *m_database;
// ViewTransition class object
@property (strong, nonatomic)ViewTransitions *m_transition;
// GenderViewController class object
@property (strong, nonatomic)GenderViewController *m_genderViewController;
// Done Button
@property (strong, nonatomic)UIButton *m_doneButton;
// Back Button
@property (strong, nonatomic)UIButton *m_backButton;

// Help pop up button
@property (strong, nonatomic)UIButton *m_helpPopUpButtonViewInProfileView;
// NSUserDefault
@property (strong, nonatomic)NSUserDefaults *userDefaults;

// Before the first label Height
@property (nonatomic)CGRect m_beforeFirstHeightFrame;
// First Label Height
@property (nonatomic)CGRect m_firstHeightFrame;
// Second Label Height
@property (nonatomic)CGRect m_secondHeightFrame;
// Third Label Height
@property (nonatomic)CGRect m_thirdHeightFrame;
// After the Third Label Height
@property (nonatomic)CGRect m_afterThirdHeightFrame;
// Before the first label Weight
@property (nonatomic)CGRect m_beforeFirstWeightFrame;
// First Label Weight
@property (nonatomic)CGRect m_firstWeightFrame;
// Second Label Weight
@property (nonatomic)CGRect m_secondWeightFrame;
// Third Label Weight
@property (nonatomic)CGRect m_thirdWeightFrame;
// After Third Label Weight
@property (nonatomic)CGRect m_afterThirdWeightFrame;
// Before the first label Age
@property (nonatomic)CGRect m_beforeFirstAgeFrame;
// First Label Age
@property (nonatomic)CGRect m_firstAgeFrame;
// Second Label Age
@property (nonatomic)CGRect m_secondAgeFrame;
// Third Label Age
@property (nonatomic)CGRect m_thirdAgeFrame;
// After the Third Label Age
@property (nonatomic)CGRect m_afterThirdAgeFrame;

// Feet number track
@property (nonatomic)int m_feet_After_Third_Label;
// Inch number track
@property (nonatomic)int m_inches_After_Third_Label;
// Feet before first label
@property (nonatomic)int m_feet_Before_First_Label;
// Inch before first label
@property (nonatomic)int m_inches_Before_First_Label;
// Exercise mode tag
@property (strong, nonatomic)NSString *m_exercise_Mode;

// User email id from database
@property (strong, nonatomic)NSString *m_userEmailID;

// Value for before first weight label
@property (nonatomic)int m_beforeFirstWeightLabel;
// Check if weight gesture has been used
@property (strong, nonatomic)NSString *weightGestureUsed;
// User status log string
@property (strong, nonatomic)NSString *m_logStatusString;
// Background Imageview
@property (strong, nonatomic)UIImageView *backgroundImageView;

// Weight imageview
@property (strong, nonatomic)UIImageView *weightImageView;

// Weight increment/decrement buttons
@property (strong, nonatomic)UIButton *m_weightPlusButton;
@property (strong, nonatomic)UIButton *m_weightMinusButton;

// Weight Labels
@property (strong, nonatomic)UILabel *beforeFirstWeightLabel;
@property (strong, nonatomic)UILabel *firstWeightLabel;
@property (strong, nonatomic)UILabel *secondWeightLabel;
@property (strong, nonatomic)UILabel *thirdWeightLabel;
@property (strong, nonatomic)UILabel *afterThirdWeightLabel;

// Weight Label Frames
@property (nonatomic)CGRect beforeFirstWeightLabelFrame;
@property (nonatomic)CGRect firstWeightLabelFrame;
@property (nonatomic)CGRect secondWeightLabelFrame;
@property (nonatomic)CGRect thirdWeightLabelFrame;
@property (nonatomic)CGRect afterThirdWeightLabelFrame;

// Age imageview
@property (strong, nonatomic)UIImageView *ageImageView;

// Age increment/decrement buttons
@property (strong, nonatomic)UIButton *m_agePlusButton;
@property (strong, nonatomic)UIButton *m_ageMinusButton;

// Weight Label Frames
@property (nonatomic)CGRect beforeFirstAgeLabelFrame;
@property (nonatomic)CGRect firstAgeLabelFrame;
@property (nonatomic)CGRect secondAgeLabelFrame;
@property (nonatomic)CGRect thirdAgeLabelFrame;
@property (nonatomic)CGRect afterThirdAgeLabelFrame;

// Age Labels
@property (strong, nonatomic)UILabel *beforeFirstAgeLabel;
@property (strong, nonatomic)UILabel *firstAgeLabel;
@property (strong, nonatomic)UILabel *secondAgeLabel;
@property (strong, nonatomic)UILabel *thirdAgeLabel;
@property (strong, nonatomic)UILabel *afterThirdAgeLabel;

// Height ImageView
@property (strong, nonatomic)UIImageView *heightImageView;

// Height Labels
@property (strong, nonatomic)UILabel *beforeFirstHeightLabel;
@property (strong, nonatomic)UILabel *firstHeightLabel;
@property (strong, nonatomic)UILabel *secondHeightLabel;
@property (strong, nonatomic)UILabel *thirdHeightLabel;
@property (strong, nonatomic)UILabel *afterThirdHeightLabel;

// Height Labels Frames
@property (nonatomic)CGRect beforeFirstHeightLabelFrame;
@property (nonatomic)CGRect firstHeightLabelFrame;
@property (nonatomic)CGRect secondHeightLabelFrame;
@property (nonatomic)CGRect thirdHeightLabelFrame;
@property (nonatomic)CGRect afterThirdHeightLabelFrame;

// Move to LoginViewController
- (void)moveToLoginViewController:(id)sender;
// Move to GenderViewController
- (void)moveToGenderViewController:(id)sender;
// Take user to previous view controller
- (void)moveToPreviousViewController:(id)sender;
// Display message to user
- (void)displayMessage:(NSString *)message;
// Go next
- (void)profileDone:(id)sender;
// Increment height before first label
- (void)incrementHeightForBeforeFirstLabel;
// Decrement height for after third label
- (void)decrementHeightForAfterThirdLabel;
// Increment height at after third label for display
- (void)incrementHeightAtAfterThirdLabelForDisplay;
// Decrement height at before first label for display
-(void)decrementHeightAtBeforeFirstLabelForDisplay;
// Increment or Decrement time weight value
- (void)incrementOrDecrement:(NSString *)leftOrRight HeightValue:(UILabel *)label;
// Animate using the five visible labels as well as the two invisible labels
- (void)animateLeftOrRight:(NSString *)leftOrRight HeightLabel:(UILabel *)label;
// Increment or decrement weight label values
- (int)incrementOrDecrement:(NSString *)leftOrRight WeightValue:(UILabel *)label;
// Animate using two visible labels as well as two invisible labels
- (void)animateLeftOrRight:(NSString *)leftOrRight WeightLabel:(UILabel *)label;
// Increment or Decrement age value
- (int)incrementOrDecrement:(NSString *)leftOrRight AgeValue:(UILabel *)label;
// Animate using the three visible labels as well as the two invisible labels
- (void)animateLeftOrRight:(NSString *)leftOrRight AgeLabel:(UILabel *)label;
// In response to left or right swipe gesture, to move the next or previous image.
- (IBAction)handleSwipeforHeight:(UISwipeGestureRecognizer *)swipeRecognizer;
// Swipe for weight
- (IBAction)handleSwipeforWeight:(UISwipeGestureRecognizer *)swipeRecognizer;
// Swipe for age images
- (IBAction)handleSwipeforAge:(UISwipeGestureRecognizer *)swipeRecognizer;

@end

@implementation ProfileViewController



@synthesize messageButton;
@synthesize weight;
@synthesize height;
@synthesize age;
@synthesize heightLeftSwipeGesture;
@synthesize heightRightSwipeGesture;
@synthesize weightLeftSwipeGesture;
@synthesize weightRightSwipeGesture;
@synthesize ageLeftSwipeGesture;
@synthesize ageRightSwipeGesture;

/*
 Singleton ProfileViewController object
 */
+ (ProfileViewController *)sharedInstance {
	static ProfileViewController *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 Move to the previous view
 */
- (void)moveToPreviousViewController:(id)sender
{
    if (!self.m_loginViewController) {
        self.m_loginViewController        = [LoginViewController sharedInstance];
    }

    if (!self.m_rootViewController) {
        self.m_rootViewController         = [RootViewController sharedInstance];
    }
    if (self.m_loginViewController.view.tag == 1) {
        id instanceObject                = self.m_loginViewController;
        [self moveToView:self.m_loginViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    }
    else if(self.m_rootViewController.view.tag == 1){
        id instanceObject                = self.m_rootViewController;
        [self moveToView:self.m_rootViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    }
}

/*
 Move to LoginViewController
 */
- (void)moveToLoginViewController:(id)sender
{
    if (!self.m_loginViewController) {
        self.m_loginViewController        = [LoginViewController sharedInstance];
    }
    id instanceObject                = self.m_loginViewController;
    [self moveToView:self.m_loginViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
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
 Move to GenderViewController
 */
- (void)moveToGenderViewController:(id)sender
{
    if (!self.m_genderViewController) {
        self.m_genderViewController       = [GenderViewController sharedInstance];
    }
    id instanceObject               = self.m_genderViewController;
    [self moveToView:self.m_genderViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to MusicTracksViewController
 */
- (IBAction)moveToRootViewController:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

/*
 Get User ID
 */
- (NSString *)getUserId
{
    if (!self.m_database) {
        self.m_database        = [[Database alloc] init];
    }
    if (!self.m_userEmailID) {
        self.m_userEmailID     = [NSString getUserEmail];
        
    }
    return self.m_userEmailID;
}

/*
 Log out from facebook
 */
-(void)logOutFromFacebook
{
    // If the user is logged into facebook, logout the user from facebook.
  //DEBUG
//    if (FBSession.activeSession.isOpen) {
//        [FBSession.activeSession closeAndClearTokenInformation];
//    }
}

/*
 Log out from database
 */
- (void)logoutUserFromDatabase:(NSString *)user_Id
{
    if (!self.m_database) {
        self.m_database      = [[Database alloc] init];
    }
    [self.m_database logOutUser:user_Id];
}

/*
 Log out user from the App
 */
- (void)logOutUser
{
    if (!self.m_database) {
        self.m_database      = [Database alloc];
    }
    
    [self logOutFromFacebook];
    
    // Logout from both facebook and database
    [self logoutUserFromDatabase:[self getUserId]];
}

// Logout of App
- (void)logOutOfApp
{
    if (!self.m_controllerViews) {
        self.m_controllerViews           = [ViewFactory sharedInstance];
    }
    [self logOutUser];
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
 I am ready
 */
- (void)profileDone:(id)sender
{
    // Check all the selections and insert and take to the next page
    if ((self.weight != 0) && ([self.height length] != 0)  && (self.height != NULL) && (self.age != 0)) {
        // Take user to IntensityViewController
    
        
        [self moveToGenderViewController:sender];
    }
    else { // Unable to save profile
        [self displayMessage:@"Profile not saved, please try again."];
    }
}

/*
 Increment height before first label
 */
- (void)incrementHeightForBeforeFirstLabel
{
    // need to simultaneously keep the count
    if (self.m_inches_Before_First_Label < 11) {
        self.m_inches_Before_First_Label++;
    }
    else if(self.m_inches_Before_First_Label == 11){
        self.m_feet_Before_First_Label++;
        self.m_inches_Before_First_Label     = 0;
    }
}

/*
 Decrement height for after fifth label
 */
- (void)decrementHeightForAfterThirdLabel
{
    // Need to simultanouesly keep the count
    if (self.m_inches_After_Third_Label == 0) {
        self.m_feet_After_Third_Label--;
        self.m_inches_After_Third_Label     = 11;
    }
    else if(self.m_inches_After_Third_Label > 0 ){
        self.m_inches_After_Third_Label--;
    }
}

/*
 Increment height at after third label for display
 */
- (void)incrementHeightAtAfterThirdLabelForDisplay
{
    if (self.m_inches_After_Third_Label < 11) { // if m_inches than 12 inches
        // make inches to zero
        self.m_inches_After_Third_Label++;
    }
    else if(self.m_inches_After_Third_Label == 11){ // if more than 11 inches, make inch 0 and increment feet
        // increment the feet
        self.m_feet_After_Third_Label++;
        self.m_inches_After_Third_Label      = 0;
    }
}

/*
 Decrement height at before first label for display
 */
-(void)decrementHeightAtBeforeFirstLabelForDisplay
{
    if (self.m_inches_Before_First_Label == 0) { // if inche is more than 11
        self.m_feet_Before_First_Label--;
        self.m_inches_Before_First_Label    = 11;
    }
    else if(self.m_inches_Before_First_Label > 0){
        // make inches to zero
        self.m_inches_Before_First_Label--;
    }
}

/*
 Increment or Decrement time weight value
 */
- (void)incrementOrDecrement:(NSString *)leftOrRight HeightValue:(UILabel *)label
{
    if ([leftOrRight isEqualToString:@"Left"]) {
        if (label.frame.origin.x == self.m_afterThirdHeightFrame.origin.x) {
            // Increment before first label to keep track of changing height values
            [self incrementHeightForBeforeFirstLabel];
            
            // Increment height for display
            [self incrementHeightAtAfterThirdLabelForDisplay];
        }
    }
    else if([leftOrRight isEqualToString:@"Right"]) {
        if (label.frame.origin.x == self.m_beforeFirstHeightFrame.origin.x) {
            // Decrement after fifth label keep track of the changing height values
            [self decrementHeightForAfterThirdLabel];
            
            // Decrement height for display
            [self decrementHeightAtBeforeFirstLabelForDisplay];
        }
    }

    // Get the selected height
    if (label.frame.origin.x == self.m_thirdHeightFrame.origin.x) {
        self.height                      = label.text;
    }
}

/*
 Animate using the five visible labels as well as the two invisible labels
 */
- (void)animateLeftOrRight:(NSString *)leftOrRight HeightLabel:(UILabel *)label
{    
    if ([leftOrRight isEqualToString:@"Left"]) {

        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration: 0.25];

        if (label.frame.origin.x == self.m_beforeFirstHeightFrame.origin.x) {
            label.frame            = self.m_afterThirdHeightFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
            // display height
            label.text             = [NSString stringWithFormat:@"%d’ %d”",self.m_feet_After_Third_Label, self.m_inches_After_Third_Label];
        }
        else if(label.frame.origin.x == self.m_firstHeightFrame.origin.x) {
            label.frame            = self.m_beforeFirstHeightFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == self.m_secondHeightFrame.origin.x) {
            label.frame            = self.m_firstHeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == self.m_thirdHeightFrame.origin.x) {
            label.frame            = self.m_secondHeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor redColor];
        }
        else if(label.frame.origin.x == self.m_afterThirdHeightFrame.origin.x) {
            label.frame            = self.m_thirdHeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        [UIView commitAnimations];
        // Change the before first value
        [self incrementOrDecrement:@"Left" HeightValue:label];
    }
    else if ([leftOrRight isEqualToString:@"Right"]) {

        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration: 0.25];

        if(label.frame.origin.x == self.m_beforeFirstHeightFrame.origin.x) {
            label.frame            = self.m_firstHeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        else if (label.frame.origin.x == self.m_afterThirdHeightFrame.origin.x) {
            label.frame            = self.m_beforeFirstHeightFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
            // display height
            label.text             = [NSString stringWithFormat:@"%d’ %d”",self.m_feet_Before_First_Label, self.m_inches_Before_First_Label];
        }
        else if(label.frame.origin.x == self.m_thirdHeightFrame.origin.x) {
            label.frame            = self.m_afterThirdHeightFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == self.m_secondHeightFrame.origin.x) {
            label.frame            = self.m_thirdHeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == self.m_firstHeightFrame.origin.x) {
            label.frame            = self.m_secondHeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor redColor];
        }
        [UIView commitAnimations];
        // Change the before first value
        [self incrementOrDecrement:@"Right" HeightValue:label];
    }
}

/*
 Increment or decrement weight label values
 */
- (int)incrementOrDecrement:(NSString *)leftOrRight WeightValue:(UILabel *)label
{
    int value                               = [label.text intValue];
    
    if ([leftOrRight isEqualToString:@"Left"]) {
        if (label.frame.origin.x == self.m_afterThirdWeightFrame.origin.x) {
            value                           = value + 5;
        }
        else if (label.frame.origin.x == self.m_beforeFirstWeightFrame.origin.x) {
            self.m_beforeFirstWeightLabel        = value;
        }
    }
    else if([leftOrRight isEqualToString:@"Right"]) {
        if (label.frame.origin.x == self.m_beforeFirstWeightFrame.origin.x) {
            value                           = value - 5;
            self.m_beforeFirstWeightLabel        = value;
        }
    }
    
    // Get the selected Weight or Time
    if (label.frame.origin.x == self.m_secondWeightFrame.origin.x) {
        self.weight                        = [label.text intValue];
    }
    
    return value;
}

/*
 Animate using two visible labels as well as two invisible labels
 */
- (void)animateLeftOrRight:(NSString *)leftOrRight WeightLabel:(UILabel *)label
{
    if ([leftOrRight isEqualToString:@"Left"]) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration: 0.25];

        if (label.frame.origin.x == self.m_beforeFirstWeightFrame.origin.x) {
            label.frame            = self.m_afterThirdWeightFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == self.m_firstWeightFrame.origin.x) {
            label.frame            = self.m_beforeFirstWeightFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == self.m_secondWeightFrame.origin.x) {
            label.frame            = self.m_firstWeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == self.m_thirdWeightFrame.origin.x) {
            label.frame            = self.m_secondWeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor redColor];
        }
        else if(label.frame.origin.x == self.m_afterThirdWeightFrame.origin.x) {
            label.frame            = self.m_thirdWeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        [UIView commitAnimations];
        
        // Change the before first value
        label.text                 = [NSString stringWithFormat:@"%d", [self incrementOrDecrement:@"Left" WeightValue:label]];
    }
    else if ([leftOrRight isEqualToString:@"Right"]) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration: 0.25];

        if(label.frame.origin.x == self.m_beforeFirstWeightFrame.origin.x) {
            label.frame            = self.m_firstWeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == self.m_firstWeightFrame.origin.x) {
            label.frame            = self.m_secondWeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor redColor];
        }
        else if(label.frame.origin.x == self.m_secondWeightFrame.origin.x) {
            label.frame            = self.m_thirdWeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        else if (label.frame.origin.x == self.m_thirdWeightFrame.origin.x) {
            label.frame            = self.m_afterThirdWeightFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
        }
        else if (label.frame.origin.x == self.m_afterThirdWeightFrame.origin.x) {
            label.frame            = self.m_beforeFirstWeightFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
        }
        [UIView commitAnimations];
        
        // Change the before first value
        label.text                 = [NSString stringWithFormat:@"%d", [self incrementOrDecrement:@"Right" WeightValue:label]];
    }
}

/*
 Increment or Decrement age value
 */
- (int)incrementOrDecrement:(NSString *)leftOrRight AgeValue:(UILabel *)label
{
    int value                               = [label.text intValue];
    
    if ([leftOrRight isEqualToString:@"Left"]) {
        if (label.frame.origin.x == self.m_afterThirdAgeFrame.origin.x) {
            value                           = value + 5;
        }
    }
    else if([leftOrRight isEqualToString:@"Right"]) {
        if (label.frame.origin.x == self.m_beforeFirstAgeFrame.origin.x) {
            value                           = value - 5;
        }
    }
    
    // Get the selected Weight or Time
    if (label.frame.origin.x == self.m_secondAgeFrame.origin.x) {
        self.age                            = [label.text intValue];
    }
    
    return value;
}

/*
 Animate using the three visible labels as well as the two invisible labels
 */
- (void)animateLeftOrRight:(NSString *)leftOrRight AgeLabel:(UILabel *)label
{    
    if ([leftOrRight isEqualToString:@"Left"]) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration: 0.25];

        if (label.frame.origin.x == self.m_beforeFirstAgeFrame.origin.x) {
            label.frame            = self.m_afterThirdAgeFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == self.m_firstAgeFrame.origin.x) {
            label.frame            = self.m_beforeFirstAgeFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == self.m_secondAgeFrame.origin.x) {
            label.frame            = self.m_firstAgeFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == self.m_thirdAgeFrame.origin.x) {
            label.frame            = self.m_secondAgeFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor redColor];
        }
        else if(label.frame.origin.x == self.m_afterThirdAgeFrame.origin.x) {
            label.frame            = self.m_thirdAgeFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        [UIView commitAnimations];
        
        // Change the before first value
        label.text                 = [NSString stringWithFormat:@"%d", [self incrementOrDecrement:@"Left" AgeValue:label]];
    }
    else if ([leftOrRight isEqualToString:@"Right"]) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration: 0.25];

        if(label.frame.origin.x == self.m_beforeFirstAgeFrame.origin.x) {
            label.frame            = self.m_firstAgeFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        else if (label.frame.origin.x == self.m_afterThirdAgeFrame.origin.x) {
            label.frame            = self.m_beforeFirstAgeFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == self.m_thirdAgeFrame.origin.x) {
            label.frame            = self.m_afterThirdAgeFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == self.m_secondAgeFrame.origin.x) {
            label.frame            = self.m_thirdAgeFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == self.m_firstAgeFrame.origin.x) {
            label.frame            = self.m_secondAgeFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor redColor];
        }
        [UIView commitAnimations];
        
        // Change the before first value
        label.text                 = [NSString stringWithFormat:@"%d", [self incrementOrDecrement:@"Right" AgeValue:label]];
    }
}

/*
 In response to left or right swipe gesture, to move the next or previous image.
 */
- (IBAction)handleSwipeforHeight:(UISwipeGestureRecognizer *)swipeRecognizer
{        
    if (swipeRecognizer == self.heightLeftSwipeGesture) {
        // Add to inches
        // Animate the first label
        [self animateLeftOrRight:@"Left" HeightLabel:self.firstHeightLabel];
        // Animate the second label
        [self animateLeftOrRight:@"Left" HeightLabel:self.secondHeightLabel];
        // Animate the third label
        [self animateLeftOrRight:@"Left" HeightLabel:self.thirdHeightLabel];
        // Animate the fourth label
        [self animateLeftOrRight:@"Left" HeightLabel:self.afterThirdHeightLabel];
        // Animate before first label, do this last to get the value from the label to be used to check if it is zero
        [self animateLeftOrRight:@"Left" HeightLabel:self.beforeFirstHeightLabel];

    }
    else if (swipeRecognizer == self.heightRightSwipeGesture) {
        // Animate first label
        [self animateLeftOrRight:@"Right" HeightLabel:self.firstHeightLabel];
        // Animate second label
        [self animateLeftOrRight:@"Right" HeightLabel:self.secondHeightLabel];
        // Animate third label
        [self animateLeftOrRight:@"Right" HeightLabel:self.thirdHeightLabel];
        // Animate fourth label
        [self animateLeftOrRight:@"Right" HeightLabel:self.afterThirdHeightLabel];
        // Animate before first label, do this last to get the value from the label to be used to check if it is zero
        [self animateLeftOrRight:@"Right" HeightLabel:self.beforeFirstHeightLabel];

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
 Increment Age labels by 10
 */
- (void)plusAgeby10:(id)sender
{
    [UILabel incrementBy10OnLabelOne:self.beforeFirstAgeLabel LabelTwo:self.firstAgeLabel  LabelThree:self.secondAgeLabel LabelFour:self.thirdAgeLabel LabelFive:self.afterThirdAgeLabel];
}

/*
 Decrement Age labels by 10
 */
- (void)minusAgeby10:(id)sender
{
    if ([self.secondAgeLabel.text intValue] > 10) {
        [UILabel decrementBy10OnLabelOne:self.beforeFirstAgeLabel LabelTwo:self.firstAgeLabel  LabelThree:self.secondAgeLabel LabelFour:self.thirdAgeLabel LabelFive:self.afterThirdAgeLabel];
    }
}


/*
 Animate weight labels to left
 */
- (void)animateWeightLabelsToLeft
{
    // animate before second label
    [self animateLeftOrRight:@"Left" WeightLabel:self.firstWeightLabel];
    // animate before third label
    [self animateLeftOrRight:@"Left" WeightLabel:self.secondWeightLabel];
    // animate before third label
    [self animateLeftOrRight:@"Left" WeightLabel:self.thirdWeightLabel];
    // animate before fourth label
    [self animateLeftOrRight:@"Left" WeightLabel:self.afterThirdWeightLabel];
    
    // Animate before first label, do this last to get the value from the label to be used to check if it is zero
    [self animateLeftOrRight:@"Left" WeightLabel:self.beforeFirstWeightLabel];
}

/*
 Animate weight labels to right
 */
- (void)animateWeightLabelsToRight
{
    // animate before second label
    [self animateLeftOrRight:@"Right" WeightLabel:self.firstWeightLabel];
    // animate before third label
    [self animateLeftOrRight:@"Right" WeightLabel:self.secondWeightLabel];
    // animate before third label
    [self animateLeftOrRight:@"Right" WeightLabel:self.thirdWeightLabel];
    // animate before fourth label
    [self animateLeftOrRight:@"Right" WeightLabel:self.afterThirdWeightLabel];
    
    // Animate before first label, do this last to get the value from the label to be used to check if it is zero
    [self animateLeftOrRight:@"Right" WeightLabel:self.beforeFirstWeightLabel];
}

/*
 Swipe for weight
 */
- (IBAction)handleSwipeforWeight:(UISwipeGestureRecognizer *)swipeRecognizer
{
    if (swipeRecognizer == self.weightLeftSwipeGesture) {
        [self animateWeightLabelsToLeft];
    }
    else if (swipeRecognizer == self.weightRightSwipeGesture) {
        [self animateWeightLabelsToRight];
    }
}

/*
 Animate age labels to left
 */
- (void)animateAgeLabelsToLeft
{
    // Animate the first label
    [self animateLeftOrRight:@"Left" AgeLabel:self.firstAgeLabel];
    // Animate the second label
    [self animateLeftOrRight:@"Left" AgeLabel:self.secondAgeLabel];
    // Animate the third label
    [self animateLeftOrRight:@"Left" AgeLabel:self.thirdAgeLabel];
    // Animate after third label
    [self animateLeftOrRight:@"Left" AgeLabel:self.afterThirdAgeLabel];
    // Animate before first label, do this last to get the value from the label to be used to check if it is zero
    [self animateLeftOrRight:@"Left" AgeLabel:self.beforeFirstAgeLabel];
}

/*
 Animate age labels to right
 */
- (void)animateAgeLabelsToRight
{
    // Animate the first label
    [self animateLeftOrRight:@"Right" AgeLabel:self.firstAgeLabel];
    // Animate the second label
    [self animateLeftOrRight:@"Right" AgeLabel:self.secondAgeLabel];
    // Animate the third label
    [self animateLeftOrRight:@"Right" AgeLabel:self.thirdAgeLabel];
    // Animate after third label
    [self animateLeftOrRight:@"Right" AgeLabel:self.afterThirdAgeLabel];
    // Animate before first label, do this last to get the value from the label to be used to check if it is zero
    [self animateLeftOrRight:@"Right" AgeLabel:self.beforeFirstAgeLabel];
}

/*
 Swipe for age images
 */
- (IBAction)handleSwipeforAge:(UISwipeGestureRecognizer *)swipeRecognizer
{
    if (swipeRecognizer == self.ageLeftSwipeGesture) {
        [self animateAgeLabelsToLeft];
    }
    else if (swipeRecognizer == self.ageRightSwipeGesture) {
        [self animateAgeLabelsToRight];
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

/*
 Add height labels and images
 */
- (void)addHeightImageAndLabels
{
    // Add height labels
    // Add invisible weight image view
    CGRect weightImageViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        weightImageViewFrame                         = CGRectMake(50.0f, 401.0f, 225.0f, 57.0f);
    }
    else {
        weightImageViewFrame                         = CGRectMake(50.0f, 339.0f, 225.0f, 57.0f);
    }
    self.heightImageView                                     = [[UIImageView alloc] initWithFrame:weightImageViewFrame];
    [self.view addSubview:self.heightImageView];
    [self.heightImageView addGestureRecognizer:self.heightLeftSwipeGesture];
    [self.heightImageView addGestureRecognizer:self.heightRightSwipeGesture];
    self.heightImageView.userInteractionEnabled              = YES;
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.beforeFirstHeightLabelFrame                  = CGRectMake(30.0f, 414.0f, 50.0f, 35.0f);
    }
    else {
        self.beforeFirstHeightLabelFrame                  = CGRectMake(30.0f, 352.0f, 50.0f, 35.0f);
    }
    self.beforeFirstHeightLabel                              = [[UILabel alloc] initWithFrame:self.beforeFirstHeightLabelFrame];
    self.beforeFirstHeightLabel.backgroundColor              = [UIColor clearColor];
    self.beforeFirstHeightLabel.text                         = @"5' 4”";
    self.beforeFirstWeightLabel.font                         = [UIFont customFontWithSize:19];
    self.beforeFirstHeightLabel.textColor                    = [UIColor blackColor];
    [self.view addSubview:self.beforeFirstHeightLabel];
    self.beforeFirstHeightLabel.hidden                       = YES;

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.firstHeightLabelFrame                        = CGRectMake(85.0f, 414.0f, 50.0f, 35.0f);
    }
    else{
        self.firstHeightLabelFrame                        = CGRectMake(85.0f, 352.0f, 50.0f, 35.0f);
    }
    self.firstHeightLabel                                    = [[UILabel alloc] initWithFrame:self.firstHeightLabelFrame];
    self.firstHeightLabel.backgroundColor                    = [UIColor clearColor];
    self.firstHeightLabel.text                               = @"5' 5”";
    self.firstHeightLabel.font                               = [UIFont customFontWithSize:19];
    self.firstHeightLabel.textColor                          = [UIColor blackColor];
    [self.view addSubview:self.firstHeightLabel];

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.secondHeightLabelFrame                       = CGRectMake(145.0f, 414.0f, 50.0f, 35.0f);
    }
    else {
        self.secondHeightLabelFrame                       = CGRectMake(145.0f, 352.0f, 50.0f, 35.0f);
    }
    self.secondHeightLabel                                   = [[UILabel alloc] initWithFrame:self.secondHeightLabelFrame];
    self.secondHeightLabel.backgroundColor                   = [UIColor clearColor];
    self.secondHeightLabel.text                              = @"5' 6”";
    self.secondHeightLabel.font                              = [UIFont customFontWithSize:19];
    self.secondHeightLabel.textColor                         = [UIColor redColor];
    [self.view addSubview:self.secondHeightLabel];

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.thirdHeightLabelFrame                        = CGRectMake(205.0f, 414.0f, 50.0f, 35.0f);
    }
    else {
        self.thirdHeightLabelFrame                        = CGRectMake(205.0f, 352.0f, 50.0f, 35.0f);
    }
    self.thirdHeightLabel                                    = [[UILabel alloc] initWithFrame:self.thirdHeightLabelFrame];
    self.thirdHeightLabel.backgroundColor                    = [UIColor clearColor];
    self.thirdHeightLabel.text                               = @"5' 7”";
    self.thirdHeightLabel.font                               = [UIFont customFontWithSize:19];
    self.thirdHeightLabel.textColor                          = [UIColor blackColor];
    [self.view addSubview:self.thirdHeightLabel];

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.afterThirdHeightLabelFrame                   = CGRectMake(264.0f, 414.0f, 50.0f, 35.0f);
    }
    else {
        self.afterThirdHeightLabelFrame                   = CGRectMake(264.0f, 352.0f, 50.0f, 35.0f);
    }
    self.afterThirdHeightLabel                               = [[UILabel alloc] initWithFrame:self.afterThirdHeightLabelFrame];
    self.afterThirdHeightLabel.backgroundColor               = [UIColor clearColor];
    self.afterThirdHeightLabel.text                          = @"5' 8”";
    self.afterThirdHeightLabel.font                          = [UIFont customFontWithSize:19];
    self.afterThirdHeightLabel.textColor                     = [UIColor blackColor];
    [self.view addSubview:self.afterThirdHeightLabel];
    self.afterThirdHeightLabel.hidden                        = YES;
}

/*
 Add weight notches, weight labels and age labels
 */
- (void)addWeightLabels
{
    // Add invisible weight image view
    CGRect weightImageViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        weightImageViewFrame            = CGRectMake(2.0f, 120.0f, 320.0f, 57.0f);
    }
    else {
        weightImageViewFrame            = CGRectMake(0.0f, 116.0f, 320.0f, 57.0f);
    }
    self.weightImageView                     = [[UIImageView alloc] initWithFrame:weightImageViewFrame];
    [self.view addSubview:self.weightImageView];
    [self.weightImageView addGestureRecognizer:self.weightLeftSwipeGesture];
    [self.weightImageView addGestureRecognizer:self.weightRightSwipeGesture];
    self.weightImageView.userInteractionEnabled  = YES;

    CGRect weightMinusButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        weightMinusButtonFrame            = CGRectMake(0.0f, 120.0f, 33.0f, 57.0f);
    }
    else {
        weightMinusButtonFrame            = CGRectMake(0.0f, 116.0f, 33.0f, 57.0f);
    }
    self.m_weightMinusButton                 = [[UIButton alloc] initWithFrame:weightMinusButtonFrame];
    [self.view addSubview:self.m_weightMinusButton];
    [self.m_weightMinusButton addTarget:self action:@selector(minusWeightby10:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect weightPlusButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        weightPlusButtonFrame            = CGRectMake(285.0f, 120.0f, 33.0f, 57.0f);
    }
    else {
        weightPlusButtonFrame            = CGRectMake(285.0f, 116.0f, 33.0f, 57.0f);
    }
    self.m_weightPlusButton                 = [[UIButton alloc] initWithFrame:weightPlusButtonFrame];
    [self.view addSubview:self.m_weightPlusButton];
    [self.m_weightPlusButton addTarget:self action:@selector(plusWeightby10:) forControlEvents:UIControlEventTouchUpInside];
    
    // Add weight labels
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.beforeFirstWeightLabelFrame         = CGRectMake(23.0f, 135.0f, 50.0f, 30.0f);
    }
    else {
        self.beforeFirstWeightLabelFrame         = CGRectMake(23.0f, 129.0f, 50.0f, 30.0f);
    }
    self.beforeFirstWeightLabel              = [[UILabel alloc] initWithFrame:self.beforeFirstWeightLabelFrame];
    self.beforeFirstWeightLabel.text         = @"123";
    self.beforeFirstHeightLabel.textAlignment    = NSTextAlignmentCenter;
    self.beforeFirstWeightLabel.font         = [UIFont customFontWithSize:20];
    self.beforeFirstWeightLabel.backgroundColor    = [UIColor clearColor];
    [self.view addSubview:self.beforeFirstWeightLabel];
    self.beforeFirstWeightLabel.hidden       = YES;

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.firstWeightLabelFrame               = CGRectMake(60.0f, 135.0f, 50.0f, 30.0f);
    }
    else {
        self.firstWeightLabelFrame               = CGRectMake(60.0f, 129.0f, 50.0f, 30.0f);
    }
    self.firstWeightLabel                    = [[UILabel alloc] initWithFrame:self.firstWeightLabelFrame];
    self.firstWeightLabel.text               = @"124";
    self.firstWeightLabel.textAlignment      = NSTextAlignmentCenter;
    self.firstWeightLabel.font               = [UIFont customFontWithSize:20];
    self.firstWeightLabel.backgroundColor    = [UIColor clearColor];
    [self.view addSubview:self.firstWeightLabel];

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.secondWeightLabelFrame              = CGRectMake(135.0f, 135.0f, 50.0f, 30.0f);
    }
    else {
        self.secondWeightLabelFrame              = CGRectMake(135.0f, 129.0f, 50.0f, 30.0f);
    }
    self.secondWeightLabel                   = [[UILabel alloc] initWithFrame:self.secondWeightLabelFrame];
    self.secondWeightLabel.text              = @"125";
    self.secondWeightLabel.textAlignment     = NSTextAlignmentCenter;
    self.secondWeightLabel.textColor         = [UIColor redColor];
    self.secondWeightLabel.font              = [UIFont customFontWithSize:20];
    self.secondWeightLabel.backgroundColor   = [UIColor clearColor];
    [self.view addSubview:self.secondWeightLabel];

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.thirdWeightLabelFrame               = CGRectMake(213.0f, 135.0f, 50.0f, 30.0f);
    }
    else {
        self.thirdWeightLabelFrame               = CGRectMake(213.0f, 129.0f, 50.0f, 30.0f);
    }
    self.thirdWeightLabel                    = [[UILabel alloc] initWithFrame:self.thirdWeightLabelFrame];
    self.thirdWeightLabel.text               = @"126";
    self.thirdWeightLabel.textAlignment      = NSTextAlignmentCenter;
    self.thirdWeightLabel.font               = [UIFont customFontWithSize:20];
    self.thirdWeightLabel.backgroundColor    = [UIColor clearColor];
    [self.view addSubview:self.thirdWeightLabel];

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.afterThirdWeightLabelFrame   = CGRectMake(248.0f, 135.0f, 50.0f, 30.0f);
    }
    else {
        self.afterThirdWeightLabelFrame   = CGRectMake(248.0f, 129.0f, 50.0f, 30.0f);
    }
    self.afterThirdWeightLabel              	= [[UILabel alloc] initWithFrame:self.afterThirdWeightLabelFrame];
    self.afterThirdWeightLabel.text          = @"127";
    self.afterThirdWeightLabel.textAlignment = NSTextAlignmentCenter;
    self.afterThirdWeightLabel.font          = [UIFont customFontWithSize:20];
    self.afterThirdWeightLabel.backgroundColor   = [UIColor clearColor];
    [self.view addSubview:self.afterThirdWeightLabel];
    self.afterThirdWeightLabel.hidden        = YES;
}
/*
 Add age labels
 */
- (void)addAgeLabels
{
    // Add invisible age image view
    CGRect ageImageViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        ageImageViewFrame         = CGRectMake(0.0f, 265.0f, 320.0f, 57.0f);
    }
    else {
        ageImageViewFrame         = CGRectMake(0.0f, 229.0f, 320.0f, 57.0f);
    }
    self.ageImageView                     = [[UIImageView alloc] initWithFrame:ageImageViewFrame];
    [self.view addSubview:self.ageImageView];
    [self.ageImageView addGestureRecognizer:self.ageLeftSwipeGesture];
    [self.ageImageView addGestureRecognizer:self.ageRightSwipeGesture];
    self.ageImageView.userInteractionEnabled  = YES;

    CGRect ageMinusButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        ageMinusButtonFrame         = CGRectMake(0.0f, 265.0f, 33.0f, 57.0f);
    }
    else {
        ageMinusButtonFrame         = CGRectMake(0.0f, 229.0f, 33.0f, 57.0f);
    }
    self.m_ageMinusButton                 = [[UIButton alloc] initWithFrame:ageMinusButtonFrame];
    [self.view addSubview:self.m_ageMinusButton];
    [self.m_ageMinusButton addTarget:self action:@selector(minusAgeby10:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect agePlusButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        agePlusButtonFrame            = CGRectMake(287.0f, 265.0f, 33.0f, 57.0f);
    }
    else {
        agePlusButtonFrame            = CGRectMake(287.0f, 229.0f, 33.0f, 57.0f);
    }
    self.m_agePlusButton                 = [[UIButton alloc] initWithFrame:agePlusButtonFrame];
    [self.view addSubview:self.m_agePlusButton];
    [self.m_agePlusButton addTarget:self action:@selector(plusAgeby10:) forControlEvents:UIControlEventTouchUpInside];

    // Add weight labels
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.beforeFirstAgeLabelFrame         = CGRectMake(18.0f, 280.0f, 50.0f, 30.0f);
    }
    else {
        self.beforeFirstAgeLabelFrame         = CGRectMake(18.0f, 245.0f, 50.0f, 30.0f);
    }
    self.beforeFirstAgeLabel              = [[UILabel alloc] initWithFrame:self.beforeFirstAgeLabelFrame];
    self.beforeFirstAgeLabel.text         = @"25";
    self.beforeFirstAgeLabel.textAlignment = NSTextAlignmentCenter;
    self.beforeFirstAgeLabel.font         = [UIFont customFontWithSize:20];
    self.beforeFirstAgeLabel.backgroundColor   = [UIColor clearColor];
    [self.view addSubview:self.beforeFirstAgeLabel];
    self.beforeFirstAgeLabel.hidden       = YES;
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.firstAgeLabelFrame               = CGRectMake(68.0f, 280.0f, 50.0f, 30.0f);
    }
    else {
        self.firstAgeLabelFrame               = CGRectMake(68.0f, 245.0f, 50.0f, 30.0f);
    }
    self.firstAgeLabel                    = [[UILabel alloc] initWithFrame:self.firstAgeLabelFrame];
    self.firstAgeLabel.text               = @"26";
    self.firstAgeLabel.textAlignment = NSTextAlignmentCenter;
    self.firstAgeLabel.font               = [UIFont customFontWithSize:20];
    self.firstAgeLabel.backgroundColor    = [UIColor clearColor];
    [self.view addSubview:self.firstAgeLabel];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.secondAgeLabelFrame              = CGRectMake(135.0f, 280.0f, 50.0f, 30.0f);
    }
    else {
        self.secondAgeLabelFrame              = CGRectMake(135.0f, 245.0f, 50.0f, 30.0f);
    }
    self.secondAgeLabel                   = [[UILabel alloc] initWithFrame:self.secondAgeLabelFrame];
    self.secondAgeLabel.text              = @"27";
    self.secondAgeLabel.textAlignment = NSTextAlignmentCenter;
    self.secondAgeLabel.textColor         = [UIColor redColor];
    self.secondAgeLabel.font              = [UIFont customFontWithSize:20];
    self.secondAgeLabel.backgroundColor   = [UIColor clearColor];
    [self.view addSubview:self.secondAgeLabel];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.thirdAgeLabelFrame               = CGRectMake(203.0f, 280.0f, 50.0f, 30.0f);
    }
    else {
        self.thirdAgeLabelFrame               = CGRectMake(203.0f, 245.0f, 50.0f, 30.0f);
    }
    self.thirdAgeLabel                    = [[UILabel alloc] initWithFrame:self.thirdAgeLabelFrame];
    self.thirdAgeLabel.text               = @"28";
    self.thirdAgeLabel.textAlignment = NSTextAlignmentCenter;
    self.thirdAgeLabel.font               = [UIFont customFontWithSize:20];
    self.thirdAgeLabel.backgroundColor    = [UIColor clearColor];
    [self.view addSubview:self.thirdAgeLabel];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.afterThirdAgeLabelFrame   = CGRectMake(253.0f, 280.0f, 50.0f, 30.0f);
    }
    else {
        self.afterThirdAgeLabelFrame   = CGRectMake(253.0f, 245.0f, 50.0f, 30.0f);
    }
    self.afterThirdAgeLabel              	= [[UILabel alloc] initWithFrame:self.afterThirdAgeLabelFrame];
    self.afterThirdAgeLabel.text          = @"29";
    self.afterThirdAgeLabel.textAlignment = NSTextAlignmentCenter;
    self.afterThirdAgeLabel.font          = [UIFont customFontWithSize:20];
    self.afterThirdAgeLabel.backgroundColor  = [UIColor clearColor];
    [self.view addSubview:self.afterThirdAgeLabel];
    self.afterThirdAgeLabel.hidden        = YES;
}

/*
 Assign frames for height labels
 */
- (void)assignHeightLabelFrames
{
    // Before the first label Height
    self.m_beforeFirstHeightFrame          = self.beforeFirstHeightLabel.frame;
    // First Label Height
    self.m_firstHeightFrame                = self.firstHeightLabel.frame;
    // Second Label Height
    self.m_secondHeightFrame               = self.secondHeightLabel.frame;
    // Third Label Height
    self.m_thirdHeightFrame                = self.thirdHeightLabel.frame;
    // Fourth Label Height
    self.m_afterThirdHeightFrame           = self.afterThirdHeightLabel.frame;
}

/*
 Assign frames for weight labels
 */
- (void)assignWeightLabelFrames
{
    // Before the first label Weight
    self.m_beforeFirstWeightFrame          = self.beforeFirstWeightLabel.frame;
    // First Label Weight
    self.m_firstWeightFrame                = self.firstWeightLabel.frame;
    // Second Label Weight
    self.m_secondWeightFrame               = self.secondWeightLabel.frame;
    // Third label weight
    self.m_thirdWeightFrame                = self.thirdWeightLabel.frame;
    // Third Label Weight
    self.m_afterThirdWeightFrame           = self.afterThirdWeightLabel.frame;
}


/*
 Assign initial height values
 */
- (void)assignInitialHeightValues
{
    // Default feet is 5 after fifth label
    self.m_feet_After_Third_Label                      = 5;
    // Defautl feet is 5 before first label
    self.m_feet_Before_First_Label                     = 5;
    // Default inches is 9 after fifth label
    self.m_inches_After_Third_Label                    = 9;
    // Default inches is 3 before first label
    self.m_inches_Before_First_Label                   = 3;
}

/*
 Assign frames for age labels
 */
- (void)assignAgeLabelFrames
{
    // before first age label
    self.m_beforeFirstAgeFrame                 = self.beforeFirstAgeLabel.frame;
    // first age label
    self.m_firstAgeFrame                       = self.firstAgeLabel.frame;
    // second age label
    self.m_secondAgeFrame                      = self.secondAgeLabel.frame;
    // third age label
    self.m_thirdAgeFrame                       = self.thirdAgeLabel.frame;
    // after third age label
    self.m_afterThirdAgeFrame                  = self.afterThirdAgeLabel.frame;
}

//- (void)setWeightForSex:(NSString *)SEX
//{
//    if (![weightGestureUsed isEqualToString:@"YES"]) {
//        // Weights values
//        NSString *beforeFirstLabelWeight;
//        NSString *firstLabelWeight;
//        NSString *secondLabelWeight;
//        NSString *thirdLabelWeight;
//        NSString *afterThirdLabelWeight;
//        
//        if([SEX isEqualToString:@"Female"]) { // if female
//            beforeFirstLabelWeight                   = @"123";
//            firstLabelWeight                         = @"124";
//            secondLabelWeight                        = @"125";
//            thirdLabelWeight                         = @"126";
//            afterThirdLabelWeight                    = @"127";
//        }
//        else { // Default should be male
//            beforeFirstLabelWeight                   = @"183";
//            firstLabelWeight                         = @"184";
//            secondLabelWeight                        = @"185";
//            thirdLabelWeight                         = @"186";
//            afterThirdLabelWeight                    = @"187";
//        }
//        
//        // Default weight
//        self.weight                                 = [secondLabelWeight intValue];
//        
//        // Before the first label Weight
//        self.beforeFirstWeightLabel.text            = beforeFirstLabelWeight;
//        // First Label Weight
//        self.firstWeightLabel.text                  = firstLabelWeight;
//        // Second Label Weight
//        self.secondWeightLabel.text                 = secondLabelWeight;
//        // Third label weight
//        self.thirdWeightLabel.text                  = thirdLabelWeight;
//        // Third Label Weight
//        self.afterThirdWeightLabel.text             = afterThirdLabelWeight;
//    }
//}

- (void)helpButtonClicked
{
    self.userDefaults        = [NSUserDefaults standardUserDefaults];
    [self.userDefaults setInteger:1 forKey:@"BMR_Help"];
    [self.userDefaults synchronize];
    
    [self.m_helpPopUpButtonViewInProfileView removeFromSuperview];
    self.homeButton.userInteractionEnabled      = YES;
}

- (void)createHelpPopUp
{
    CGRect helpPopUpButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        helpPopUpButtonFrame     = CGRectMake(0.0f, 0.0f, 320.0f, 568.0f);
        self.m_helpPopUpButtonViewInProfileView       = [[UIButton alloc] initWithFrame:helpPopUpButtonFrame];
        [self.m_helpPopUpButtonViewInProfileView setBackgroundImage:[UIImage imageNamed:@"bmr_instruction_i5.png"] forState:UIControlStateNormal];
    }
    else {
        helpPopUpButtonFrame     = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
        self.m_helpPopUpButtonViewInProfileView       = [[UIButton alloc] initWithFrame:helpPopUpButtonFrame];
        [self.m_helpPopUpButtonViewInProfileView setBackgroundImage:[UIImage imageNamed:@"bmr_instruction.png"] forState:UIControlStateNormal];
    }
    [self.view addSubview:self.m_helpPopUpButtonViewInProfileView];
    [self.m_helpPopUpButtonViewInProfileView addTarget:self action:@selector(helpButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.homeButton.userInteractionEnabled      = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect backgroundImageViewFrame;
    CGRect doneButtonFrame;
    CGRect backButtonFrame;
    // if iPhone 5 adjust view size
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        backgroundImageViewFrame          = CGRectMake(0.0f, 60.0f, 320.0f, 520.0f);
        doneButtonFrame                   = CGRectMake(250.0f, 568 - 55, 60.0f, 55.0f);
        backButtonFrame                   = CGRectMake(15.0f, 568 - 55, 60.0f, 55.0f);
    }
    else {
        backgroundImageViewFrame          = CGRectMake(0.0f, 62.0f, 320.0f, 420.0f);
        doneButtonFrame                   = CGRectMake(250.0f, 425.0f, 60.0f, 40.0f);
        backButtonFrame                   = CGRectMake(15.0f, 425.0f, 60.0f, 40.0f);
    }
    
    self.backgroundImageView                   = [[UIImageView alloc] initWithFrame:backgroundImageViewFrame];

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.backgroundImageView.image         = [UIImage imageNamed:@"createnew.png"];
    }
    else {
        self.backgroundImageView.image         = [UIImage imageNamed:@"createnew_iphone4.png"];
    }
    self.backgroundImageView.userInteractionEnabled  = NO;

    [self.view addSubview:self.backgroundImageView];
    
    self.m_doneButton                          = [[UIButton alloc] initWithFrame:doneButtonFrame];
    [self.m_doneButton addTarget:self action:@selector(profileDone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.m_doneButton];
    
    self.m_backButton                          = [[UIButton alloc] initWithFrame:backButtonFrame];
    [self.m_backButton addTarget:self action:@selector(moveToPreviousViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.m_backButton];

    [self.messageButton removeFromSuperview];
    self.messageButton.titleLabel.font          = [UIFont customFontWithSize:13];
    self.messageButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messageButton.titleLabel.numberOfLines = 2;
    self.messageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.messageButton];
    
    // Add weight, age labels
    [self addWeightLabels];
    [self addAgeLabels];
    // Add height image and label
    [self addHeightImageAndLabels];
    
    // Assign height frames for animation
    [self assignHeightLabelFrames];
    // Assign weight frames for animation
    [self assignWeightLabelFrames];
    // Assign initial height values
    [self assignInitialHeightValues];
    // Assign age frames for animation
    [self assignAgeLabelFrames];
    
    self.userDefaults        = [NSUserDefaults standardUserDefaults];
    if (![self.userDefaults integerForKey:@"BMR_Help"]) {
        // Add Help Pop Up
        [self createHelpPopUp];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    // Create new active is the default top nav image
//    [self.topNavigationBar setBackgroundImage:[UIImage imageNamed:@"topnav.png"] forState:UIControlStateNormal];

    if (!self.m_database) {
        self.m_database           = [Database alloc];
    }
    self.m_userEmailID            = [NSString getUserEmail];

//    // Default sex selection is none
//    self.sex                 = @"";
    // Default exercise mode is none
    self.m_exercise_Mode          = @"";
    
//    // If the user email is already registered and registered under with one sex gender
//    if (([[self sexOfAnExistingUser] length] != 0) && ([self sexOfAnExistingUser] != NULL) {
//        if ([[self sexOfAnExistingUser] isEqualToString:@"Male"]) {
//            self.sex         = @"Male";
//            [self.maleFemaleReadyButton setBackgroundImage:[UIImage imageNamed:@"male_active.png"] forState:UIControlStateNormal];
//        }
//        else if([[self sexOfAnExistingUser] isEqualToString:@"Female"]) {
//            self.sex         = @"Female";
//            [self.maleFemaleReadyButton setBackgroundImage:[UIImage imageNamed:@"female_active.png"] forState:UIControlStateNormal];
//        }
//        // Disable both buttons
//       /* self.maleReadyButton.enabled                        = NO;
//        self.femaleReadyButton.enabled                      = NO;
//        self.maleReadyButton.userInteractionEnabled         = NO;
//        self.femaleReadyButton.userInteractionEnabled       = NO; */
//    }
    self.weight       = 122;
    // Default age is 27
    self.age           = 27;
    // Default height is 5' 7”
    self.height        = @"5' 7”";
    
    if (!self.m_loginViewController) {
        self.m_loginViewController        = [LoginViewController sharedInstance];
    }
    if ((super.view.tag == 1) || (super.view.tag == 2)) {
        self.homeButton.hidden      = YES;
//        [self.homeButton removeFromSuperview];
    }
    else {
        self.homeButton.hidden      = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
