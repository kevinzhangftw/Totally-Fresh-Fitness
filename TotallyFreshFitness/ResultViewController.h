//
//  ResultViewController.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-10-15.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController

// Singleton ResultViewController object
+ (ResultViewController *)sharedInstance;

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIButton *messageButton;
@property (strong, nonatomic) IBOutlet UIButton *backButton;

@end
