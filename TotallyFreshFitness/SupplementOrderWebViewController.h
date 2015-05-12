//
//  SupplementOrderWebViewController.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 12/10/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupplementOrderWebViewController : UIViewController<UIWebViewDelegate>

// Singleton SupplementOrderWebViewController object
+ (SupplementOrderWebViewController *)sharedInstance;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (strong, nonatomic) UIButton *bottomBarButton;
@property (strong, nonatomic) UIButton *musicPlayerButton;
@property (strong, nonatomic) UIButton *exercisePlanButton;
@property (strong, nonatomic) UIButton *calendarButton;
@property (strong, nonatomic) UIButton *mealPlanButton;
@property (strong, nonatomic) UIButton *nutritionPlanButton;

@property (strong, nonatomic) UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;
@end
