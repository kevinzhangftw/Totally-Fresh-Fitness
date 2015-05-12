//
//  MealViewController.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-14.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHCToDoItem.h"


@interface MealViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *controlsImageView;
@property (strong, nonatomic) IBOutlet UIButton *mealPlanSectionButton;
@property (strong, nonatomic) IBOutlet UIButton *groceryListSectionButton;

@property (strong, nonatomic) IBOutlet UITableView *mealTableView;
@property (strong, nonatomic) IBOutlet UITableView *groceryTableView;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@property (strong, nonatomic) UIButton *messageButton;
@property (strong, nonatomic) UIButton *bottomBarButton;
@property (strong, nonatomic) UIButton *musicPlayerButton;
@property (strong, nonatomic) UIButton *exercisePlanButton;
@property (strong, nonatomic) UIButton *calendarButton;
@property (strong, nonatomic) UIButton *mealPlanButton;
@property (strong, nonatomic) UIButton *nutritionPlanButton;
@property (strong, nonatomic) NSString *selectedImage;
@property (strong, nonatomic) NSString *foodSelectedToEdit;
@property (nonatomic) NSUInteger selectedSection;

@property (nonatomic) SHCToDoItem *toDoItem;

// Singleton MealViewController object
+ (MealViewController *)sharedInstance;

@end
