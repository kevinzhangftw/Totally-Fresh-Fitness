//
//  ExerciseViewController.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-17.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *controlsImageView;
@property (strong, nonatomic) IBOutlet UIButton *workoutPlanSectionButton;
@property (strong, nonatomic) IBOutlet UIButton *exerciseIndexSectionButton;

@property (strong, nonatomic) IBOutlet UITableView *workoutTableView;
@property (strong, nonatomic) IBOutlet UITableView *exerciseIndexTableView;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@property (strong, nonatomic) UIButton *messageButton;
@property (strong, nonatomic) UIButton *bottomBarButton;
@property (strong, nonatomic) UIButton *musicPlayerButton;
@property (strong, nonatomic) UIButton *exercisePlanButton;
@property (strong, nonatomic) UIButton *calendarButton;
@property (strong, nonatomic) UIButton *mealPlanButton;
@property (strong, nonatomic) UIButton *nutritionPlanButton;
@property (strong, nonatomic) NSString *selectedImage;
@property (strong, nonatomic) NSString *workoutSelectedToEdit;
@property (nonatomic) NSUInteger selectedSection;
- (IBAction)exerciseIndex:(id)sender;

// Singleton ExerciseViewController object
+ (ExerciseViewController *)sharedInstance;

@end
