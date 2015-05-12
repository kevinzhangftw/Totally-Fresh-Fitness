//
//  UIViewController+iPhoneScreenSizes.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-06.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (iPhoneScreenSizes)

// Set up background image to take care of difference iphone screen sizes for login view
- (void)backgroundImage:(UIButton *)backgroundImageButton View:(UIView *)view;

// Set up subbackground image to take care of difference iphone screen sizes for login view
- (void)subBackgroundImage:(UIButton *)subBackgroundImageButton View:(UIView *)view;

// Set up the bottom bars controls programmatically to take care of iphone screen size differences
- (NSMutableArray *)bottomBar:(UIButton *)buttonBar MusicPlayerButton:(UIButton *)musicPlayerButton ExercisePlanButton:(UIButton *)exercisePlanButton Calendar:(UIButton *)calender MealPlan:(UIButton *)mealPlanButton MoreButton:(UIButton *)moreButton InView:(UIView *)view;

// Adjust the height of the views for iphone5 size
- (UIView *)adjustiPhone5HeightOfView:(UIView *)view;

// Adjust the height of tableview for iphone5 size
- (UITableView *)adjustiPhone5HeightOfTableView:(UITableView *)tableView ForController:(id)controller;

//Readd the indicator view to adjust view
- (UIActivityIndicatorView *)reAddActivityIndicatorforiPhone5:(UIActivityIndicatorView *)activityIndicatorView;

@end
