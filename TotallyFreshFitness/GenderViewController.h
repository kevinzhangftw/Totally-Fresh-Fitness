//
//  GenderViewController.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 10/27/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GenderViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *maleButton;
@property (strong, nonatomic) IBOutlet UIButton *femaleButton;

@property (strong, nonatomic) NSString *sex;

// Singleton GenderViewController object
+ (GenderViewController *)sharedInstance;

@end
