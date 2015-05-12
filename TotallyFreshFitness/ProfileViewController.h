//
//  ProfileViewController.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-10-30.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
{
    // Ready/Done button
    IBOutlet UIButton *messageButton;
}
@property (strong, nonatomic) IBOutlet UIButton *homeButton;
@property (strong, nonatomic) IBOutlet UIButton *messageButton;
@property (strong, nonatomic, readonly) NSString *height;
@property (nonatomic, readonly) int weight;
@property (nonatomic, readonly) int age;

@property (strong, nonatomic) IBOutlet UIGestureRecognizer *weightLeftSwipeGesture;
@property (strong, nonatomic) IBOutlet UIGestureRecognizer *weightRightSwipeGesture;
@property (strong, nonatomic) IBOutlet UIGestureRecognizer *heightLeftSwipeGesture;
@property (strong, nonatomic) IBOutlet UIGestureRecognizer *heightRightSwipeGesture;
@property (strong, nonatomic) IBOutlet UIGestureRecognizer *ageLeftSwipeGesture;
@property (strong, nonatomic) IBOutlet UIGestureRecognizer *ageRightSwipeGesture;

// Singleton ProfileViewController object
+ (ProfileViewController *)sharedInstance;

@end
