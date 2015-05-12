//
//  ExerciseProfileViewController.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-17.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPDConstants.h"
#import "CPDExerciseProgress.h"
#import "CorePlot-CocoaTouch.h"

@interface ExerciseProfileViewController : UIViewController<UIGestureRecognizerDelegate, CPTPlotDataSource>
{
    BOOL objectsMoved;
}

@property (strong, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *bigExerciseBackgroundView;
@property (strong, nonatomic) IBOutlet UIImageView *bigExerciseImageView;
@property (strong, nonatomic) IBOutlet UIImageView *exerciseImageView;
@property (strong, nonatomic) IBOutlet UIImageView *exerciseDetailsImageView;

@property (strong, nonatomic) IBOutlet UITextView *contentsTextView;

@property (strong, nonatomic) IBOutlet UIGestureRecognizer *timeWeightLeftSwipeGesture;
@property (strong, nonatomic) IBOutlet UIGestureRecognizer *timeWeightRightSwipeGesture;
@property (strong, nonatomic) IBOutlet UIGestureRecognizer *difficultyRepLeftSwipeGesture;
@property (strong, nonatomic) IBOutlet UIGestureRecognizer *difficultyRepRightSwipeGesture;

@property (nonatomic) CGRect afterSixthSmallRepBottomNotchFrame;

@property (strong, nonatomic) IBOutlet UIView *graphView;
@property (strong, nonatomic) IBOutlet UILabel *weightBox;
@property (strong, nonatomic) IBOutlet UILabel *repBox;
@property (strong, nonatomic) IBOutlet UILabel *weightLabel;
@property (strong, nonatomic) IBOutlet UILabel *repLabel;
@property (strong, nonatomic) CPTGraphHostingView *hostView;


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) IBOutlet UIButton *messageButton;
@property (strong, nonatomic) UIButton *bottomBarButton;
@property (strong, nonatomic) UIButton *musicPlayerButton;
@property (strong, nonatomic) UIButton *exercisePlanButton;
@property (strong, nonatomic) UIButton *calendarButton;
@property (strong, nonatomic) UIButton *mealPlanButton;
@property (strong, nonatomic) UIButton *nutritionPlanButton;

// Singleton ExerciseProfileViewController object
+ (ExerciseProfileViewController *)sharedInstance;

@end
