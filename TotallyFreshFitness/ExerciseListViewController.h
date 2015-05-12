//
//  ExerciseListViewController.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-12-07.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *topNavigationBar;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *createNewButton;

@property (strong, nonatomic) IBOutlet UITableView *theTableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (strong, nonatomic) NSString *selectedImage;

@property (strong, nonatomic) UIButton *messageButton;
@property (strong, nonatomic) UIButton *bottomBarButton;
@property (strong, nonatomic) UIButton *musicPlayerButton;
@property (strong, nonatomic) UIButton *exercisePlanButton;
@property (strong, nonatomic) UIButton *calendarButton;
@property (strong, nonatomic) UIButton *mealPlanButton;
@property (strong, nonatomic) UIButton *nutritionPlanButton;

// Singleton ExerciseListViewController object
+ (ExerciseListViewController *)sharedInstance;

@end
