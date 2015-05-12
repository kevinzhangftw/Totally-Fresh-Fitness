//
//  MusicListViewController.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 1/22/2014.
//  Copyright (c) 2014 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *musicListTableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property (strong, nonatomic) UIButton *bottomBarButton;
@property (strong, nonatomic) UIButton *musicPlayerButton;
@property (strong, nonatomic) UIButton *exercisePlanButton;
@property (strong, nonatomic) UIButton *calendarButton;
@property (strong, nonatomic) UIButton *mealPlanButton;
@property (strong, nonatomic) UIButton *nutritionPlanButton;
@property (strong, nonatomic) NSString *selectedMusicURL;

// Singleton MusicListViewController object
+ (MusicListViewController *)sharedInstance;

@end
