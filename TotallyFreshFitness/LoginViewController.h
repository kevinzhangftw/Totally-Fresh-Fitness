//
//  LoginViewController.h
//  Total Fitness & Nutrition
//
//  Created by Namgyal Damdul on 2012-10-26.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

// Tag RootViewController view to identify view hierrachy
#define kRootViewControllerAtLogin           2;
// Tag LoginViewController view to identify view hierrachy
#define kLoginViewControllerAtLogin          2;
// Tag ProfileViewController view to identify view hierrachy
#define kProfileViewControllerAtLogin        2;

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <GooglePlus/GooglePlus.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@class GPPSignInButton;

@interface LoginViewController : UIViewController<UITextFieldDelegate, MFMailComposeViewControllerDelegate, GPPSignInDelegate, UIScrollViewDelegate, MBProgressHUDDelegate>
{
    // If objects moved
    BOOL objectsMoved;

    // if facebookloginbutton moved
    bool facebookLoginButtonPositionMoved;

    // If button moved
    BOOL emailIDTextFieldMoved;

    // Retrieve facebook user name
    NSString *userFacebookEmailID;
    // Retrive facebook user location
    NSString *userFacebookBirthday;
    // The facebook details check
    NSString *userFacebookDetailsCheck;
}

// Message button
@property (strong,  nonatomic) IBOutlet UIButton *messageButton;
@property (strong, nonatomic) NSString *userFacebookEmailID;
@property (strong, nonatomic) NSString *userFacebookBirthday;
@property (strong, nonatomic) NSString *userFacebookDetailsCheck;
@property (retain, nonatomic) IBOutlet GPPSignInButton *googlePlusLoginButtonOne;
@property (retain, nonatomic) IBOutlet GPPSignInButton *googlePlusLoginButtonTwo;
@property (retain, nonatomic) IBOutlet UIButton *m_facebookLoginButton;
@property (retain, nonatomic) IBOutlet UIButton *m_twitterLoginButton;
@property (strong, nonatomic) IBOutlet UITextView *termsAndConditionTextView;
@property (strong, nonatomic) UIScrollView *featuredScrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

// Singleton LoginViewController object
+ (LoginViewController *)sharedInstance;
// Display message to user with animation
- (void)displayMessage:(NSString *)message;
- (void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verfier;

@end
