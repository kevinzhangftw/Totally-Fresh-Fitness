//
//  ProgressViewController.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-02-03.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPDConstants.h"
#import "CPDWeightProgress.h"

@interface ProgressViewController : UIViewController<UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIView *graphView;

@property (strong, nonatomic) IBOutlet UIView *saveReportView;

@property (strong, nonatomic) IBOutlet UIGestureRecognizer *weightLeftSwipeGesture;
@property (strong, nonatomic) IBOutlet UIGestureRecognizer *weightRightSwipeGesture;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) IBOutlet UIButton *messageButton;

@property (strong, nonatomic) UIButton *bottomBarButton;
@property (strong, nonatomic) UIButton *musicPlayerButton;
@property (strong, nonatomic) UIButton *exercisePlanButton;
@property (strong, nonatomic) UIButton *calendarButton;
@property (strong, nonatomic) UIButton *mealPlanButton;
@property (strong, nonatomic) UIButton *nutritionPlanButton;

// Singleton ProgressViewController object
+ (ProgressViewController *)sharedInstance;

@end
