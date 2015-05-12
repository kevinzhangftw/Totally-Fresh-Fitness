//
//  WorkOutDaysViewController.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-06.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkOutDaysViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *messageButton;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIButton *backButton;

// Singleton WorkOutDaysViewController object
+ (WorkOutDaysViewController *)sharedInstance;

@end
