//
//  CalenderViewController.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-04.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

// Tag CalenderViewController view to identify view hierrachy
#define kCalenderViewControllerAtCalender           3;
// Tag LoginViewController view to identify view hierrachy
#define kLoginViewControllerAtCalender              3;

#import <UIKit/UIKit.h>

@interface CalenderViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *monthLabel;
@property (strong, nonatomic) IBOutlet UILabel *firstLabel;
@property (strong, nonatomic) IBOutlet UILabel *secondLabel;
@property (strong, nonatomic) IBOutlet UILabel *thirdLabel;
@property (strong, nonatomic) IBOutlet UILabel *fourthLabel;
@property (strong, nonatomic) IBOutlet UILabel *fifthLabel;
@property (strong, nonatomic) IBOutlet UILabel *sixthLabel;
@property (strong, nonatomic) IBOutlet UILabel *seventhLabel;
@property (strong, nonatomic) IBOutlet UIButton *selectionButton;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *firstLabelTapRecognizer;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *secondLabelTapRecognizer;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *thirdLabelTapRecognizer;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *fourthLabelTapRecognizer;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *fifthLabelTapRecognizer;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *sixthLabelTapRecognizer;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *seventhLabelTapRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *firstLabelRightSwipeRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *firstLabelLeftSwipeRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *secondLabelRightSwipeRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *secondLabelLeftSwipeRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *thirdLabelRightSwipeRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *thirdLabelLeftSwipeRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *fourthLabelRightSwipeRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *fourthLabelLeftSwipeRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *fifthLabelRightSwipeRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *fifthLabelLeftSwipeRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *sixthLabelRightSwipeRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *sixthLabelLeftSwipeRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *seventhLabelRightSwipeRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *seventhLabelLeftSwipeRecognizer;

@property (strong, nonatomic) IBOutlet UIButton *planSectionButton;
@property (strong, nonatomic) IBOutlet UIButton *mealPlanSectionButton;
@property (strong, nonatomic) IBOutlet UIButton *workOutPlanSectionButton;
@property (strong, nonatomic) IBOutlet UITableView *theTableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@property (strong, nonatomic) UIButton *bottomBarButton;
@property (strong, nonatomic) UIButton *musicPlayerButton;
@property (strong, nonatomic) UIButton *exercisePlanButton;
@property (strong, nonatomic) UIButton *calendarButton;
@property (strong, nonatomic) UIButton *mealPlanButton;
@property (strong, nonatomic) UIButton *nutritionPlanButton;

@property (strong, nonatomic) NSString *selectedImage;

@property (strong, nonatomic) IBOutlet UIButton *createPlan;

// Singleton CalenderViewController object
+ (CalenderViewController *)sharedInstance;

- (IBAction)handleTap:(UITapGestureRecognizer *)sender;

- (IBAction)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer;

@end
