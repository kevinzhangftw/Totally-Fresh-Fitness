//
//  NutritionPlanViewController.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/16/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupplementPlanViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) IBOutlet UIButton *homeButton;
@property (strong, nonatomic) IBOutlet UIImageView *controlsImageView;
@property (strong, nonatomic) IBOutlet UIButton *supplementPlanSectionButton;
@property (strong, nonatomic) IBOutlet UIButton *supplementOrderSectionButton;
@property (strong, nonatomic) IBOutlet UITableView *supplementPlanTableView;
@property (strong, nonatomic) IBOutlet UIWebView *supplementOrderWebPlanView;
//@property (strong, nonatomic) IBOutlet UITableView *supplementOrderTableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@property (strong, nonatomic) UIButton *messageButton;
@property (strong, nonatomic) UIButton *bottomBarButton;
@property (strong, nonatomic) UIButton *musicPlayerButton;
@property (strong, nonatomic) UIButton *exercisePlanButton;
@property (strong, nonatomic) UIButton *calendarButton;
@property (strong, nonatomic) UIButton *mealPlanButton;
@property (strong, nonatomic) UIButton *nutritionPlanButton;
@property (strong, nonatomic) NSString *selectedImage;
@property (nonatomic) int selectedSection;

// Singleton SupplementPlanViewController object
+ (SupplementPlanViewController *)sharedInstance;


@end
