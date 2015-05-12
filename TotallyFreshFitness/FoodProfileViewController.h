//
//  FoodProfileViewController.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-11.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodProfileViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *createNewButton;



@property (strong, nonatomic) UIButton *messageButton;
@property (strong, nonatomic) UIButton *bottomBarButton;
@property (strong, nonatomic) UIButton *musicPlayerButton;
@property (strong, nonatomic) UIButton *exercisePlanButton;
@property (strong, nonatomic) UIButton *calendarButton;
@property (strong, nonatomic) UIButton *mealPlanButton;
@property (strong, nonatomic) UIButton *nutritionPlanButton;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) NSMutableArray *recipesArray;

// Singleton FoodProfileViewController object
+ (FoodProfileViewController *)sharedInstance;

@end
