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

// LoginViewController class object
LoginViewController *m_loginViewController;
// ExerciseViewController class object
ExerciseViewController *m_exerciseViewController;
// MealViewContrioller class object
MealViewController *m_mealViewController;
// CalenderViewController class object
CalenderViewController *m_calenderViewController;
// GoalsViewController class object
GoalsViewController *m_goalsViewController;
// MusicTracksViewController class object
MusicTracksViewController *m_musicTracksViewController;
// RootViewController class object
RootViewController *m_rootViewController;
// ViewFactory class object
ViewFactory *m_controllerViews;
// Database class object
Database *m_database;
// ViewTransition class object
ViewTransitions *m_transition;
// GenderViewController class object
GenderViewController *m_genderViewController;
// Done Button
UIButton *m_doneButton;
// Back Button
UIButton *m_backButton;

// Help pop up button
UIButton *m_helpPopUpButtonViewInProfileView;
// NSUserDefault
NSUserDefaults *userDefaults;

// Before the first label Height
CGRect m_beforeFirstHeightFrame;
// First Label Height
CGRect m_firstHeightFrame;
// Second Label Height
CGRect m_secondHeightFrame;
// Third Label Height
CGRect m_thirdHeightFrame;
// After the Third Label Height
CGRect m_afterThirdHeightFrame;
// Before the first label Weight
CGRect m_beforeFirstWeightFrame;
// First Label Weight
CGRect m_firstWeightFrame;
// Second Label Weight
CGRect m_secondWeightFrame;
// Third Label Weight
CGRect m_thirdWeightFrame;
// After Third Label Weight
CGRect m_afterThirdWeightFrame;
// Before the first label Age
CGRect m_beforeFirstAgeFrame;
// First Label Age
CGRect m_firstAgeFrame;
// Second Label Age
CGRect m_secondAgeFrame;
// Third Label Age
CGRect m_thirdAgeFrame;
// After the Third Label Age
CGRect m_afterThirdAgeFrame;

// Feet number track
int m_feet_After_Third_Label;
// Inch number track
int m_inches_After_Third_Label;
// Feet before first label
int m_feet_Before_First_Label;
// Inch before first label
int m_inches_Before_First_Label;
// Exercise mode tag
NSString *m_exercise_Mode;

// User email id from database
NSString *m_userEmailID;

// Value for before first weight label
int m_beforeFirstWeightLabel;
// Check if weight gesture has been used
NSString *weightGestureUsed;
// User status log string
NSString *m_logStatusString;
// Background Imageview
UIImageView *backgroundImageView;

// Weight imageview
UIImageView *weightImageView;

// Weight increment/decrement buttons
UIButton *m_weightPlusButton;
UIButton *m_weightMinusButton;

// Weight Labels
UILabel *beforeFirstWeightLabel;
UILabel *firstWeightLabel;
UILabel *secondWeightLabel;
UILabel *thirdWeightLabel;
UILabel *afterThirdWeightLabel;

// Weight Label Frames
CGRect beforeFirstWeightLabelFrame;
CGRect firstWeightLabelFrame;
CGRect secondWeightLabelFrame;
CGRect thirdWeightLabelFrame;
CGRect afterThirdWeightLabelFrame;

// Age imageview
UIImageView *ageImageView;

// Age increment/decrement buttons
UIButton *m_agePlusButton;
UIButton *m_ageMinusButton;

// Weight Label Frames
CGRect beforeFirstAgeLabelFrame;
CGRect firstAgeLabelFrame;
CGRect secondAgeLabelFrame;
CGRect thirdAgeLabelFrame;
CGRect afterThirdAgeLabelFrame;

// Age Labels
UILabel *beforeFirstAgeLabel;
UILabel *firstAgeLabel;
UILabel *secondAgeLabel;
UILabel *thirdAgeLabel;
UILabel *afterThirdAgeLabel;

// Height ImageView
UIImageView *heightImageView;

// Height Labels
UILabel *beforeFirstHeightLabel;
UILabel *firstHeightLabel;
UILabel *secondHeightLabel;
UILabel *thirdHeightLabel;
UILabel *afterThirdHeightLabel;

// Height Labels Frames
CGRect beforeFirstHeightLabelFrame;
CGRect firstHeightLabelFrame;
CGRect secondHeightLabelFrame;
CGRect thirdHeightLabelFrame;
CGRect afterThirdHeightLabelFrame;

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
    if (!m_loginViewController) {
        m_loginViewController        = [LoginViewController sharedInstance];
    }

    if (!m_rootViewController) {
        m_rootViewController         = [RootViewController sharedInstance];
    }
    if (m_loginViewController.view.tag == 1) {
        id instanceObject                = m_loginViewController;
        [self moveToView:m_loginViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    }
    else if(m_rootViewController.view.tag == 1){
        id instanceObject                = m_rootViewController;
        [self moveToView:m_rootViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    }
}

/*
 Move to LoginViewController
 */
- (void)moveToLoginViewController:(id)sender
{
    if (!m_loginViewController) {
        m_loginViewController        = [LoginViewController sharedInstance];
    }
    id instanceObject                = m_loginViewController;
    [self moveToView:m_loginViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
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
    if (!m_genderViewController) {
        m_genderViewController       = [GenderViewController sharedInstance];
    }
    id instanceObject               = m_genderViewController;
    [self moveToView:m_genderViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to MusicTracksViewController
 */
- (IBAction)moveToRootViewController:(id)sender
{
    if (!m_rootViewController) {
        m_rootViewController                = [RootViewController sharedInstance];
    }
    
    id instanceObject               = m_rootViewController;
    [self moveToView:m_rootViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Get User ID
 */
- (NSString *)getUserId
{
    if (!m_database) {
        m_database        = [[Database alloc] init];
    }
    if (!m_userEmailID) {
        m_userEmailID     = [NSString getUserEmail];
        
    }
    return m_userEmailID;
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
    if (!m_database) {
        m_database      = [[Database alloc] init];
    }
    [m_database logOutUser:user_Id];
}

/*
 Log out user from the App
 */
- (void)logOutUser
{
    if (!m_database) {
        m_database      = [Database alloc];
    }
    
    [self logOutFromFacebook];
    
    // Logout from both facebook and database
    [self logoutUserFromDatabase:[self getUserId]];
}

// Logout of App
- (void)logOutOfApp
{
    if (!m_controllerViews) {
        m_controllerViews           = [ViewFactory sharedInstance];
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
    
    if (!m_transition) {
        m_transition    = [ViewTransitions sharedInstance];
    }
    [m_transition performTransitionFromBottom:self.messageButton];
    
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
    if (m_inches_Before_First_Label < 11) {
        m_inches_Before_First_Label++;
    }
    else if(m_inches_Before_First_Label == 11){
        m_feet_Before_First_Label++;
        m_inches_Before_First_Label     = 0;
    }
}

/*
 Decrement height for after fifth label
 */
- (void)decrementHeightForAfterThirdLabel
{
    // Need to simultanouesly keep the count
    if (m_inches_After_Third_Label == 0) {
        m_feet_After_Third_Label--;
        m_inches_After_Third_Label     = 11;
    }
    else if(m_inches_After_Third_Label > 0 ){
        m_inches_After_Third_Label--;
    }
}

/*
 Increment height at after third label for display
 */
- (void)incrementHeightAtAfterThirdLabelForDisplay
{
    if (m_inches_After_Third_Label < 11) { // if m_inches than 12 inches
        // make inches to zero
        m_inches_After_Third_Label++;
    }
    else if(m_inches_After_Third_Label == 11){ // if more than 11 inches, make inch 0 and increment feet
        // increment the feet
        m_feet_After_Third_Label++;
        m_inches_After_Third_Label      = 0;
    }
}

/*
 Decrement height at before first label for display
 */
-(void)decrementHeightAtBeforeFirstLabelForDisplay
{
    if (m_inches_Before_First_Label == 0) { // if inche is more than 11        
        m_feet_Before_First_Label--;
        m_inches_Before_First_Label    = 11;
    }
    else if(m_inches_Before_First_Label > 0){
        // make inches to zero
        m_inches_Before_First_Label--;
    }
}

/*
 Increment or Decrement time weight value
 */
- (void)incrementOrDecrement:(NSString *)leftOrRight HeightValue:(UILabel *)label
{
    if ([leftOrRight isEqualToString:@"Left"]) {
        if (label.frame.origin.x == m_afterThirdHeightFrame.origin.x) {
            // Increment before first label to keep track of changing height values
            [self incrementHeightForBeforeFirstLabel];
            
            // Increment height for display
            [self incrementHeightAtAfterThirdLabelForDisplay];
        }
    }
    else if([leftOrRight isEqualToString:@"Right"]) {
        if (label.frame.origin.x == m_beforeFirstHeightFrame.origin.x) {           
            // Decrement after fifth label keep track of the changing height values
            [self decrementHeightForAfterThirdLabel];
            
            // Decrement height for display
            [self decrementHeightAtBeforeFirstLabelForDisplay];
        }
    }

    // Get the selected height
    if (label.frame.origin.x == m_thirdHeightFrame.origin.x) {
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

        if (label.frame.origin.x == m_beforeFirstHeightFrame.origin.x) {
            label.frame            = m_afterThirdHeightFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
            // display height
            label.text             = [NSString stringWithFormat:@"%d’ %d”",m_feet_After_Third_Label, m_inches_After_Third_Label];
        }
        else if(label.frame.origin.x == m_firstHeightFrame.origin.x) {
            label.frame            = m_beforeFirstHeightFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == m_secondHeightFrame.origin.x) {
            label.frame            = m_firstHeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == m_thirdHeightFrame.origin.x) {
            label.frame            = m_secondHeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor redColor];
        }
        else if(label.frame.origin.x == m_afterThirdHeightFrame.origin.x) {
            label.frame            = m_thirdHeightFrame;
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

        if(label.frame.origin.x == m_beforeFirstHeightFrame.origin.x) {
            label.frame            = m_firstHeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        else if (label.frame.origin.x == m_afterThirdHeightFrame.origin.x) {
            label.frame            = m_beforeFirstHeightFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
            // display height
            label.text             = [NSString stringWithFormat:@"%d’ %d”",m_feet_Before_First_Label, m_inches_Before_First_Label];
        }
        else if(label.frame.origin.x == m_thirdHeightFrame.origin.x) {
            label.frame            = m_afterThirdHeightFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == m_secondHeightFrame.origin.x) {
            label.frame            = m_thirdHeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == m_firstHeightFrame.origin.x) {
            label.frame            = m_secondHeightFrame;
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
        if (label.frame.origin.x == m_afterThirdWeightFrame.origin.x) {
            value                           = value + 5;
        }
        else if (label.frame.origin.x == m_beforeFirstWeightFrame.origin.x) {
            m_beforeFirstWeightLabel        = value;
        }
    }
    else if([leftOrRight isEqualToString:@"Right"]) {
        if (label.frame.origin.x == m_beforeFirstWeightFrame.origin.x) {
            value                           = value - 5;
            m_beforeFirstWeightLabel        = value;
        }
    }
    
    // Get the selected Weight or Time
    if (label.frame.origin.x == m_secondWeightFrame.origin.x) {
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

        if (label.frame.origin.x == m_beforeFirstWeightFrame.origin.x) {
            label.frame            = m_afterThirdWeightFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == m_firstWeightFrame.origin.x) {
            label.frame            = m_beforeFirstWeightFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == m_secondWeightFrame.origin.x) {
            label.frame            = m_firstWeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == m_thirdWeightFrame.origin.x) {
            label.frame            = m_secondWeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor redColor];
        }
        else if(label.frame.origin.x == m_afterThirdWeightFrame.origin.x) {
            label.frame            = m_thirdWeightFrame;
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

        if(label.frame.origin.x == m_beforeFirstWeightFrame.origin.x) {
            label.frame            = m_firstWeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == m_firstWeightFrame.origin.x) {
            label.frame            = m_secondWeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor redColor];
        }
        else if(label.frame.origin.x == m_secondWeightFrame.origin.x) {
            label.frame            = m_thirdWeightFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        else if (label.frame.origin.x == m_thirdWeightFrame.origin.x) {
            label.frame            = m_afterThirdWeightFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
        }
        else if (label.frame.origin.x == m_afterThirdWeightFrame.origin.x) {
            label.frame            = m_beforeFirstWeightFrame;
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
        if (label.frame.origin.x == m_afterThirdAgeFrame.origin.x) {
            value                           = value + 5;
        }
    }
    else if([leftOrRight isEqualToString:@"Right"]) {
        if (label.frame.origin.x == m_beforeFirstAgeFrame.origin.x) {
            value                           = value - 5;
        }
    }
    
    // Get the selected Weight or Time
    if (label.frame.origin.x == m_secondAgeFrame.origin.x) {
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

        if (label.frame.origin.x == m_beforeFirstAgeFrame.origin.x) {
            label.frame            = m_afterThirdAgeFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == m_firstAgeFrame.origin.x) {
            label.frame            = m_beforeFirstAgeFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == m_secondAgeFrame.origin.x) {
            label.frame            = m_firstAgeFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == m_thirdAgeFrame.origin.x) {
            label.frame            = m_secondAgeFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor redColor];
        }
        else if(label.frame.origin.x == m_afterThirdAgeFrame.origin.x) {
            label.frame            = m_thirdAgeFrame;
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

        if(label.frame.origin.x == m_beforeFirstAgeFrame.origin.x) {
            label.frame            = m_firstAgeFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        else if (label.frame.origin.x == m_afterThirdAgeFrame.origin.x) {
            label.frame            = m_beforeFirstAgeFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == m_thirdAgeFrame.origin.x) {
            label.frame            = m_afterThirdAgeFrame;
            label.hidden           = YES;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == m_secondAgeFrame.origin.x) {
            label.frame            = m_thirdAgeFrame;
            label.hidden           = NO;
            label.textColor        = [UIColor blackColor];
        }
        else if(label.frame.origin.x == m_firstAgeFrame.origin.x) {
            label.frame            = m_secondAgeFrame;
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
        [self animateLeftOrRight:@"Left" HeightLabel:firstHeightLabel];
        // Animate the second label
        [self animateLeftOrRight:@"Left" HeightLabel:secondHeightLabel];
        // Animate the third label
        [self animateLeftOrRight:@"Left" HeightLabel:thirdHeightLabel];
        // Animate the fourth label
        [self animateLeftOrRight:@"Left" HeightLabel:afterThirdHeightLabel];
        // Animate before first label, do this last to get the value from the label to be used to check if it is zero
        [self animateLeftOrRight:@"Left" HeightLabel:beforeFirstHeightLabel];

    }
    else if (swipeRecognizer == self.heightRightSwipeGesture) {
        // Animate first label
        [self animateLeftOrRight:@"Right" HeightLabel:firstHeightLabel];
        // Animate second label
        [self animateLeftOrRight:@"Right" HeightLabel:secondHeightLabel];
        // Animate third label
        [self animateLeftOrRight:@"Right" HeightLabel:thirdHeightLabel];
        // Animate fourth label
        [self animateLeftOrRight:@"Right" HeightLabel:afterThirdHeightLabel];
        // Animate before first label, do this last to get the value from the label to be used to check if it is zero
        [self animateLeftOrRight:@"Right" HeightLabel:beforeFirstHeightLabel];

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
 Increment Age labels by 10
 */
- (void)plusAgeby10:(id)sender
{
    [UILabel incrementBy10OnLabelOne:beforeFirstAgeLabel LabelTwo:firstAgeLabel  LabelThree:secondAgeLabel LabelFour:thirdAgeLabel LabelFive:afterThirdAgeLabel];
}

/*
 Decrement Age labels by 10
 */
- (void)minusAgeby10:(id)sender
{
    if ([secondAgeLabel.text intValue] > 10) {
        [UILabel decrementBy10OnLabelOne:beforeFirstAgeLabel LabelTwo:firstAgeLabel  LabelThree:secondAgeLabel LabelFour:thirdAgeLabel LabelFive:afterThirdAgeLabel];
    }
}


/*
 Animate weight labels to left
 */
- (void)animateWeightLabelsToLeft
{
    // animate before second label
    [self animateLeftOrRight:@"Left" WeightLabel:firstWeightLabel];
    // animate before third label
    [self animateLeftOrRight:@"Left" WeightLabel:secondWeightLabel];
    // animate before third label
    [self animateLeftOrRight:@"Left" WeightLabel:thirdWeightLabel];
    // animate before fourth label
    [self animateLeftOrRight:@"Left" WeightLabel:afterThirdWeightLabel];
    
    // Animate before first label, do this last to get the value from the label to be used to check if it is zero
    [self animateLeftOrRight:@"Left" WeightLabel:beforeFirstWeightLabel];
}

/*
 Animate weight labels to right
 */
- (void)animateWeightLabelsToRight
{
    // animate before second label
    [self animateLeftOrRight:@"Right" WeightLabel:firstWeightLabel];
    // animate before third label
    [self animateLeftOrRight:@"Right" WeightLabel:secondWeightLabel];
    // animate before third label
    [self animateLeftOrRight:@"Right" WeightLabel:thirdWeightLabel];
    // animate before fourth label
    [self animateLeftOrRight:@"Right" WeightLabel:afterThirdWeightLabel];
    
    // Animate before first label, do this last to get the value from the label to be used to check if it is zero
    [self animateLeftOrRight:@"Right" WeightLabel:beforeFirstWeightLabel];
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
    [self animateLeftOrRight:@"Left" AgeLabel:firstAgeLabel];
    // Animate the second label
    [self animateLeftOrRight:@"Left" AgeLabel:secondAgeLabel];
    // Animate the third label
    [self animateLeftOrRight:@"Left" AgeLabel:thirdAgeLabel];
    // Animate after third label
    [self animateLeftOrRight:@"Left" AgeLabel:afterThirdAgeLabel];
    // Animate before first label, do this last to get the value from the label to be used to check if it is zero
    [self animateLeftOrRight:@"Left" AgeLabel:beforeFirstAgeLabel];
}

/*
 Animate age labels to right
 */
- (void)animateAgeLabelsToRight
{
    // Animate the first label
    [self animateLeftOrRight:@"Right" AgeLabel:firstAgeLabel];
    // Animate the second label
    [self animateLeftOrRight:@"Right" AgeLabel:secondAgeLabel];
    // Animate the third label
    [self animateLeftOrRight:@"Right" AgeLabel:thirdAgeLabel];
    // Animate after third label
    [self animateLeftOrRight:@"Right" AgeLabel:afterThirdAgeLabel];
    // Animate before first label, do this last to get the value from the label to be used to check if it is zero
    [self animateLeftOrRight:@"Right" AgeLabel:beforeFirstAgeLabel];
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
    heightImageView                                     = [[UIImageView alloc] initWithFrame:weightImageViewFrame];
    [self.view addSubview:heightImageView];
    [heightImageView addGestureRecognizer:self.heightLeftSwipeGesture];
    [heightImageView addGestureRecognizer:self.heightRightSwipeGesture];
    heightImageView.userInteractionEnabled              = YES;
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        beforeFirstHeightLabelFrame                  = CGRectMake(30.0f, 414.0f, 50.0f, 35.0f);
    }
    else {
        beforeFirstHeightLabelFrame                  = CGRectMake(30.0f, 352.0f, 50.0f, 35.0f);
    }
    beforeFirstHeightLabel                              = [[UILabel alloc] initWithFrame:beforeFirstHeightLabelFrame];
    beforeFirstHeightLabel.backgroundColor              = [UIColor clearColor];
    beforeFirstHeightLabel.text                         = @"5' 4”";
    beforeFirstWeightLabel.font                         = [UIFont customFontWithSize:19];
    beforeFirstHeightLabel.textColor                    = [UIColor blackColor];
    [self.view addSubview:beforeFirstHeightLabel];
    beforeFirstHeightLabel.hidden                       = YES;

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        firstHeightLabelFrame                        = CGRectMake(85.0f, 414.0f, 50.0f, 35.0f);
    }
    else{
        firstHeightLabelFrame                        = CGRectMake(85.0f, 352.0f, 50.0f, 35.0f);
    }
    firstHeightLabel                                    = [[UILabel alloc] initWithFrame:firstHeightLabelFrame];
    firstHeightLabel.backgroundColor                    = [UIColor clearColor];
    firstHeightLabel.text                               = @"5' 5”";
    firstHeightLabel.font                               = [UIFont customFontWithSize:19];
    firstHeightLabel.textColor                          = [UIColor blackColor];
    [self.view addSubview:firstHeightLabel];

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        secondHeightLabelFrame                       = CGRectMake(145.0f, 414.0f, 50.0f, 35.0f);
    }
    else {
        secondHeightLabelFrame                       = CGRectMake(145.0f, 352.0f, 50.0f, 35.0f);
    }
    secondHeightLabel                                   = [[UILabel alloc] initWithFrame:secondHeightLabelFrame];
    secondHeightLabel.backgroundColor                   = [UIColor clearColor];
    secondHeightLabel.text                              = @"5' 6”";
    secondHeightLabel.font                              = [UIFont customFontWithSize:19];
    secondHeightLabel.textColor                         = [UIColor redColor];
    [self.view addSubview:secondHeightLabel];

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        thirdHeightLabelFrame                        = CGRectMake(205.0f, 414.0f, 50.0f, 35.0f);
    }
    else {
        thirdHeightLabelFrame                        = CGRectMake(205.0f, 352.0f, 50.0f, 35.0f);
    }
    thirdHeightLabel                                    = [[UILabel alloc] initWithFrame:thirdHeightLabelFrame];
    thirdHeightLabel.backgroundColor                    = [UIColor clearColor];
    thirdHeightLabel.text                               = @"5' 7”";
    thirdHeightLabel.font                               = [UIFont customFontWithSize:19];
    thirdHeightLabel.textColor                          = [UIColor blackColor];
    [self.view addSubview:thirdHeightLabel];

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        afterThirdHeightLabelFrame                   = CGRectMake(264.0f, 414.0f, 50.0f, 35.0f);
    }
    else {
        afterThirdHeightLabelFrame                   = CGRectMake(264.0f, 352.0f, 50.0f, 35.0f);
    }
    afterThirdHeightLabel                               = [[UILabel alloc] initWithFrame:afterThirdHeightLabelFrame];
    afterThirdHeightLabel.backgroundColor               = [UIColor clearColor];
    afterThirdHeightLabel.text                          = @"5' 8”";
    afterThirdHeightLabel.font                          = [UIFont customFontWithSize:19];
    afterThirdHeightLabel.textColor                     = [UIColor blackColor];
    [self.view addSubview:afterThirdHeightLabel];
    afterThirdHeightLabel.hidden                        = YES;
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
    weightImageView                     = [[UIImageView alloc] initWithFrame:weightImageViewFrame];
    [self.view addSubview:weightImageView];
    [weightImageView addGestureRecognizer:self.weightLeftSwipeGesture];
    [weightImageView addGestureRecognizer:self.weightRightSwipeGesture];
    weightImageView.userInteractionEnabled  = YES;

    CGRect weightMinusButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        weightMinusButtonFrame            = CGRectMake(0.0f, 120.0f, 33.0f, 57.0f);
    }
    else {
        weightMinusButtonFrame            = CGRectMake(0.0f, 116.0f, 33.0f, 57.0f);
    }
    m_weightMinusButton                 = [[UIButton alloc] initWithFrame:weightMinusButtonFrame];
    [self.view addSubview:m_weightMinusButton];
    [m_weightMinusButton addTarget:self action:@selector(minusWeightby10:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect weightPlusButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        weightPlusButtonFrame            = CGRectMake(285.0f, 120.0f, 33.0f, 57.0f);
    }
    else {
        weightPlusButtonFrame            = CGRectMake(285.0f, 116.0f, 33.0f, 57.0f);
    }
    m_weightPlusButton                 = [[UIButton alloc] initWithFrame:weightPlusButtonFrame];
    [self.view addSubview:m_weightPlusButton];
    [m_weightPlusButton addTarget:self action:@selector(plusWeightby10:) forControlEvents:UIControlEventTouchUpInside];
    
    // Add weight labels
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        beforeFirstWeightLabelFrame         = CGRectMake(23.0f, 135.0f, 50.0f, 30.0f);
    }
    else {
        beforeFirstWeightLabelFrame         = CGRectMake(23.0f, 129.0f, 50.0f, 30.0f);
    }
    beforeFirstWeightLabel              = [[UILabel alloc] initWithFrame:beforeFirstWeightLabelFrame];
    beforeFirstWeightLabel.text         = @"123";
    beforeFirstHeightLabel.textAlignment    = NSTextAlignmentCenter;
    beforeFirstWeightLabel.font         = [UIFont customFontWithSize:20];
    beforeFirstWeightLabel.backgroundColor    = [UIColor clearColor];
    [self.view addSubview:beforeFirstWeightLabel];
    beforeFirstWeightLabel.hidden       = YES;

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        firstWeightLabelFrame               = CGRectMake(60.0f, 135.0f, 50.0f, 30.0f);
    }
    else {
        firstWeightLabelFrame               = CGRectMake(60.0f, 129.0f, 50.0f, 30.0f);
    }
    firstWeightLabel                    = [[UILabel alloc] initWithFrame:firstWeightLabelFrame];
    firstWeightLabel.text               = @"124";
    firstWeightLabel.textAlignment      = NSTextAlignmentCenter;
    firstWeightLabel.font               = [UIFont customFontWithSize:20];
    firstWeightLabel.backgroundColor    = [UIColor clearColor];
    [self.view addSubview:firstWeightLabel];

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        secondWeightLabelFrame              = CGRectMake(135.0f, 135.0f, 50.0f, 30.0f);
    }
    else {
        secondWeightLabelFrame              = CGRectMake(135.0f, 129.0f, 50.0f, 30.0f);
    }
    secondWeightLabel                   = [[UILabel alloc] initWithFrame:secondWeightLabelFrame];
    secondWeightLabel.text              = @"125";
    secondWeightLabel.textAlignment     = NSTextAlignmentCenter;
    secondWeightLabel.textColor         = [UIColor redColor];
    secondWeightLabel.font              = [UIFont customFontWithSize:20];
    secondWeightLabel.backgroundColor   = [UIColor clearColor];
    [self.view addSubview:secondWeightLabel];

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        thirdWeightLabelFrame               = CGRectMake(213.0f, 135.0f, 50.0f, 30.0f);
    }
    else {
        thirdWeightLabelFrame               = CGRectMake(213.0f, 129.0f, 50.0f, 30.0f);
    }
    thirdWeightLabel                    = [[UILabel alloc] initWithFrame:thirdWeightLabelFrame];
    thirdWeightLabel.text               = @"126";
    thirdWeightLabel.textAlignment      = NSTextAlignmentCenter;
    thirdWeightLabel.font               = [UIFont customFontWithSize:20];
    thirdWeightLabel.backgroundColor    = [UIColor clearColor];
    [self.view addSubview:thirdWeightLabel];

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        afterThirdWeightLabelFrame   = CGRectMake(248.0f, 135.0f, 50.0f, 30.0f);
    }
    else {
        afterThirdWeightLabelFrame   = CGRectMake(248.0f, 129.0f, 50.0f, 30.0f);
    }
    afterThirdWeightLabel              	= [[UILabel alloc] initWithFrame:afterThirdWeightLabelFrame];
    afterThirdWeightLabel.text          = @"127";
    afterThirdWeightLabel.textAlignment = NSTextAlignmentCenter;
    afterThirdWeightLabel.font          = [UIFont customFontWithSize:20];
    afterThirdWeightLabel.backgroundColor   = [UIColor clearColor];
    [self.view addSubview:afterThirdWeightLabel];
    afterThirdWeightLabel.hidden        = YES;
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
    ageImageView                     = [[UIImageView alloc] initWithFrame:ageImageViewFrame];
    [self.view addSubview:ageImageView];
    [ageImageView addGestureRecognizer:self.ageLeftSwipeGesture];
    [ageImageView addGestureRecognizer:self.ageRightSwipeGesture];
    ageImageView.userInteractionEnabled  = YES;

    CGRect ageMinusButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        ageMinusButtonFrame         = CGRectMake(0.0f, 265.0f, 33.0f, 57.0f);
    }
    else {
        ageMinusButtonFrame         = CGRectMake(0.0f, 229.0f, 33.0f, 57.0f);
    }
    m_ageMinusButton                 = [[UIButton alloc] initWithFrame:ageMinusButtonFrame];
    [self.view addSubview:m_ageMinusButton];
    [m_ageMinusButton addTarget:self action:@selector(minusAgeby10:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect agePlusButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        agePlusButtonFrame            = CGRectMake(287.0f, 265.0f, 33.0f, 57.0f);
    }
    else {
        agePlusButtonFrame            = CGRectMake(287.0f, 229.0f, 33.0f, 57.0f);
    }
    m_agePlusButton                 = [[UIButton alloc] initWithFrame:agePlusButtonFrame];
    [self.view addSubview:m_agePlusButton];
    [m_agePlusButton addTarget:self action:@selector(plusAgeby10:) forControlEvents:UIControlEventTouchUpInside];

    // Add weight labels
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        beforeFirstAgeLabelFrame         = CGRectMake(18.0f, 280.0f, 50.0f, 30.0f);
    }
    else {
        beforeFirstAgeLabelFrame         = CGRectMake(18.0f, 245.0f, 50.0f, 30.0f);
    }
    beforeFirstAgeLabel              = [[UILabel alloc] initWithFrame:beforeFirstAgeLabelFrame];
    beforeFirstAgeLabel.text         = @"25";
    beforeFirstAgeLabel.textAlignment = NSTextAlignmentCenter;
    beforeFirstAgeLabel.font         = [UIFont customFontWithSize:20];
    beforeFirstAgeLabel.backgroundColor   = [UIColor clearColor];
    [self.view addSubview:beforeFirstAgeLabel];
    beforeFirstAgeLabel.hidden       = YES;
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        firstAgeLabelFrame               = CGRectMake(68.0f, 280.0f, 50.0f, 30.0f);
    }
    else {
        firstAgeLabelFrame               = CGRectMake(68.0f, 245.0f, 50.0f, 30.0f);
    }
    firstAgeLabel                    = [[UILabel alloc] initWithFrame:firstAgeLabelFrame];
    firstAgeLabel.text               = @"26";
    firstAgeLabel.textAlignment = NSTextAlignmentCenter;
    firstAgeLabel.font               = [UIFont customFontWithSize:20];
    firstAgeLabel.backgroundColor    = [UIColor clearColor];
    [self.view addSubview:firstAgeLabel];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        secondAgeLabelFrame              = CGRectMake(135.0f, 280.0f, 50.0f, 30.0f);
    }
    else {
        secondAgeLabelFrame              = CGRectMake(135.0f, 245.0f, 50.0f, 30.0f);
    }
    secondAgeLabel                   = [[UILabel alloc] initWithFrame:secondAgeLabelFrame];
    secondAgeLabel.text              = @"27";
    secondAgeLabel.textAlignment = NSTextAlignmentCenter;
    secondAgeLabel.textColor         = [UIColor redColor];
    secondAgeLabel.font              = [UIFont customFontWithSize:20];
    secondAgeLabel.backgroundColor   = [UIColor clearColor];
    [self.view addSubview:secondAgeLabel];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        thirdAgeLabelFrame               = CGRectMake(203.0f, 280.0f, 50.0f, 30.0f);
    }
    else {
        thirdAgeLabelFrame               = CGRectMake(203.0f, 245.0f, 50.0f, 30.0f);
    }
    thirdAgeLabel                    = [[UILabel alloc] initWithFrame:thirdAgeLabelFrame];
    thirdAgeLabel.text               = @"28";
    thirdAgeLabel.textAlignment = NSTextAlignmentCenter;
    thirdAgeLabel.font               = [UIFont customFontWithSize:20];
    thirdAgeLabel.backgroundColor    = [UIColor clearColor];
    [self.view addSubview:thirdAgeLabel];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        afterThirdAgeLabelFrame   = CGRectMake(253.0f, 280.0f, 50.0f, 30.0f);
    }
    else {
        afterThirdAgeLabelFrame   = CGRectMake(253.0f, 245.0f, 50.0f, 30.0f);
    }
    afterThirdAgeLabel              	= [[UILabel alloc] initWithFrame:afterThirdAgeLabelFrame];
    afterThirdAgeLabel.text          = @"29";
    afterThirdAgeLabel.textAlignment = NSTextAlignmentCenter;
    afterThirdAgeLabel.font          = [UIFont customFontWithSize:20];
    afterThirdAgeLabel.backgroundColor  = [UIColor clearColor];
    [self.view addSubview:afterThirdAgeLabel];
    afterThirdAgeLabel.hidden        = YES;
}

/*
 Assign frames for height labels
 */
- (void)assignHeightLabelFrames
{
    // Before the first label Height
    m_beforeFirstHeightFrame          = beforeFirstHeightLabel.frame;
    // First Label Height
    m_firstHeightFrame                = firstHeightLabel.frame;
    // Second Label Height
    m_secondHeightFrame               = secondHeightLabel.frame;
    // Third Label Height
    m_thirdHeightFrame                = thirdHeightLabel.frame;
    // Fourth Label Height
    m_afterThirdHeightFrame           = afterThirdHeightLabel.frame;
}

/*
 Assign frames for weight labels
 */
- (void)assignWeightLabelFrames
{
    // Before the first label Weight
    m_beforeFirstWeightFrame          = beforeFirstWeightLabel.frame;
    // First Label Weight
    m_firstWeightFrame                = firstWeightLabel.frame;
    // Second Label Weight
    m_secondWeightFrame               = secondWeightLabel.frame;
    // Third label weight
    m_thirdWeightFrame                = thirdWeightLabel.frame;
    // Third Label Weight
    m_afterThirdWeightFrame           = afterThirdWeightLabel.frame;
}


/*
 Assign initial height values
 */
- (void)assignInitialHeightValues
{
    // Default feet is 5 after fifth label
    m_feet_After_Third_Label                      = 5;
    // Defautl feet is 5 before first label
    m_feet_Before_First_Label                     = 5;
    // Default inches is 9 after fifth label
    m_inches_After_Third_Label                    = 9;
    // Default inches is 3 before first label
    m_inches_Before_First_Label                   = 3;
}

/*
 Assign frames for age labels
 */
- (void)assignAgeLabelFrames
{
    // before first age label
    m_beforeFirstAgeFrame                 = beforeFirstAgeLabel.frame;
    // first age label
    m_firstAgeFrame                       = firstAgeLabel.frame;
    // second age label
    m_secondAgeFrame                      = secondAgeLabel.frame;
    // third age label
    m_thirdAgeFrame                       = thirdAgeLabel.frame;
    // after third age label
    m_afterThirdAgeFrame                  = afterThirdAgeLabel.frame;
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
    userDefaults        = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:1 forKey:@"BMR_Help"];
    [userDefaults synchronize];
    
    [m_helpPopUpButtonViewInProfileView removeFromSuperview];
    self.homeButton.userInteractionEnabled      = YES;
}

- (void)createHelpPopUp
{
    CGRect helpPopUpButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        helpPopUpButtonFrame     = CGRectMake(0.0f, 0.0f, 320.0f, 568.0f);
        m_helpPopUpButtonViewInProfileView       = [[UIButton alloc] initWithFrame:helpPopUpButtonFrame];
        [m_helpPopUpButtonViewInProfileView setBackgroundImage:[UIImage imageNamed:@"bmr_instruction_i5.png"] forState:UIControlStateNormal];
    }
    else {
        helpPopUpButtonFrame     = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
        m_helpPopUpButtonViewInProfileView       = [[UIButton alloc] initWithFrame:helpPopUpButtonFrame];
        [m_helpPopUpButtonViewInProfileView setBackgroundImage:[UIImage imageNamed:@"bmr_instruction.png"] forState:UIControlStateNormal];
    }
    [self.view addSubview:m_helpPopUpButtonViewInProfileView];
    [m_helpPopUpButtonViewInProfileView addTarget:self action:@selector(helpButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    backgroundImageView                   = [[UIImageView alloc] initWithFrame:backgroundImageViewFrame];

    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        backgroundImageView.image         = [UIImage imageNamed:@"createnew.png"];
    }
    else {
        backgroundImageView.image         = [UIImage imageNamed:@"createnew_iphone4.png"];
    }
    backgroundImageView.userInteractionEnabled  = NO;

    [self.view addSubview:backgroundImageView];
    
    m_doneButton                          = [[UIButton alloc] initWithFrame:doneButtonFrame];
    [m_doneButton addTarget:self action:@selector(profileDone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:m_doneButton];
    
    m_backButton                          = [[UIButton alloc] initWithFrame:backButtonFrame];
    [m_backButton addTarget:self action:@selector(moveToPreviousViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:m_backButton];

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
    
    userDefaults        = [NSUserDefaults standardUserDefaults];
    if (![userDefaults integerForKey:@"BMR_Help"]) {
        // Add Help Pop Up
        [self createHelpPopUp];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    // Create new active is the default top nav image
//    [self.topNavigationBar setBackgroundImage:[UIImage imageNamed:@"topnav.png"] forState:UIControlStateNormal];

    if (!m_database) {
        m_database           = [Database alloc];
    }
    m_userEmailID            = [NSString getUserEmail];

//    // Default sex selection is none
//    self.sex                 = @"";
    // Default exercise mode is none
    m_exercise_Mode          = @"";
    
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
    
    if (!m_loginViewController) {
        m_loginViewController        = [LoginViewController sharedInstance];
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
