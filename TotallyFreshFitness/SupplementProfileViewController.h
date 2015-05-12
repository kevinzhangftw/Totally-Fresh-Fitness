//
//  SupplementProfileViewController.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/16/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupplementProfileViewController : UIViewController

// Singleton SupplementProfileViewController object
+ (SupplementProfileViewController *)sharedInstance;

@property (strong, nonatomic) UIButton *messageButton;
@property (strong, nonatomic) UIButton *bottomBarButton;
@property (strong, nonatomic) UIButton *musicPlayerButton;
@property (strong, nonatomic) UIButton *exercisePlanButton;
@property (strong, nonatomic) UIButton *calendarButton;
@property (strong, nonatomic) UIButton *mealPlanButton;
@property (strong, nonatomic) UIButton *nutritionPlanButton;

@end
