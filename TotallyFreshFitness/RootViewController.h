//
//  RootViewController.h
//  Total Fitness & Nutrition
//
//  Created by Namgyal Damdul on 2012-10-26.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

// Tag RootViewController view to identify view hierrachy
#define kRootViewControllerAtRoot           3;
// Tag LoginViewController view to identify view hierrachy
#define kLoginViewControllerAtRoot          3;

#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <AVFoundation/AVFoundation.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
@interface RootViewController : UIViewController<MFMessageComposeViewControllerDelegate, UIScrollViewDelegate,AVAudioPlayerDelegate, MBProgressHUDDelegate, UITableViewDataSource, UITableViewDelegate>

// Singleton RootViewController object
+ (RootViewController *)sharedInstance;
// Display message to user with animation
- (void)displayMessage:(NSString *)message;

@property (strong, nonatomic) UIPageControl *featuredPageControl;
@property (strong, nonatomic) UIScrollView *featuredScrollView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *messageButton;
@property (strong, nonatomic) IBOutlet UIImageView *controlsImageView;
@property (strong, nonatomic) IBOutlet UIButton *showProgressReportButton;
@property (strong, nonatomic) IBOutlet UIButton *showDifficultyLevelButton;
@property (strong, nonatomic) IBOutlet UIButton *createPersonalizedMealPlanButton;
@property (strong, nonatomic) IBOutlet UIButton *showSupplementOrderButton;

@property (strong, nonatomic) IBOutlet UIButton *refreshImages;
- (IBAction)refreshImages:(id)sender;

@property (strong, nonatomic) NSMutableArray *linkArray;

@property (strong, nonatomic) UIButton *bottomBarButton;
@property (strong, nonatomic) UIButton *musicPlayerButton;
@property (strong, nonatomic) UIButton *exercisePlanButton;
@property (strong, nonatomic) UIButton *calendarButton;
@property (strong, nonatomic) UIButton *mealPlanButton;
@property (strong, nonatomic) UIButton *nutritionPlanButton;

@property (strong, nonatomic) NSArray *titleLabels;

@property (nonatomic, strong) NSDictionary *photos;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
