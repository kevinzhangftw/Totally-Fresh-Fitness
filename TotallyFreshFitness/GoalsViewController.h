//
//  GoalsViewController.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-01.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoalsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIButton *messageButton;
@property (strong, nonatomic) IBOutlet UIButton *shredFatButton;
@property (strong, nonatomic) IBOutlet UIButton *getTonedButton;
@property (strong, nonatomic) IBOutlet UIButton *buildMuscleMassButton;
@property (strong, nonatomic) IBOutlet UIButton *buildMuscleIsolationButton;

// Singleton GoalsViewController object
+ (GoalsViewController *)sharedInstance;

@end
