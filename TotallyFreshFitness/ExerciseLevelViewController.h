//
//  ExerciseLevelViewController.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-06.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseLevelViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *messageButton;
@property (strong, nonatomic) IBOutlet UITableView *theTableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

// Singleton ExerciseLevelViewController object
+ (ExerciseLevelViewController *)sharedInstance;

@end
