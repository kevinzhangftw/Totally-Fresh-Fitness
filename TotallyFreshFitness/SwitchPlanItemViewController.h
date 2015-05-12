//
//  SwitchPlanItemViewController.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-03-09.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchPlanItemViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *theTableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *switchPlanItemButton;
@property (strong, nonatomic) IBOutlet UIButton *messageButton;
@property (strong, nonatomic) UIButton *bottomBarButton;
@property (strong, nonatomic) UIButton *musicPlayerButton;
@property (strong, nonatomic) UIButton *exercisePlanButton;
@property (strong, nonatomic) UIButton *calendarButton;
@property (strong, nonatomic) UIButton *mealPlanButton;
@property (strong, nonatomic) UIButton *nutritionPlanButton;

@property (nonatomic, retain) NSIndexPath* checkedIndexPath;

// Singleton SwitchPlanItemViewController object
+ (SwitchPlanItemViewController *)sharedInstance;

@end
