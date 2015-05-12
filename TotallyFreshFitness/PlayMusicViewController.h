//
//  PlayMusicViewController.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-06-08.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayMusicViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *topNavigationBar;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) UIButton *bottomBarButton;
@property (strong, nonatomic) UIButton *musicPlayerButton;
@property (strong, nonatomic) UIButton *exercisePlanButton;
@property (strong, nonatomic) UIButton *calendarButton;
@property (strong, nonatomic) UIButton *mealPlanButton;
@property (strong, nonatomic) UIButton *nutritionPlanButton;

// Singleton PlayMusicViewController object
+ (PlayMusicViewController *)sharedInstance;

@end
