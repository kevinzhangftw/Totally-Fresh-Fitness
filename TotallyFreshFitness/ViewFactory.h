//
//  ViewFactory.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-02.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewFactory : NSObject

// Get LoginViewController For Window
- (UIViewController *)loginViewControllerForWindow;
// Get RootViewController For Window
- (UIViewController *)rootViewControllerForWindow;
// Get CalenderViewController For Window
- (UIViewController *)calenderViewControllerForWindow;
// Get ProfileViewController For Window
- (UIViewController *)profileViewControllerForWindow;
// Get GoalsViewController For Window
- (UIViewController *)goalsViewControllerForWindow;
// Get WorkOutDaysViewController For Window
- (UIViewController *)workOutDaysViewControllerForWindow;
// Get ExerciseLevelViewController For Window
- (UIViewController *)exerciseLevelViewControllerForWindow;
// Get IntensityViewController For Window
- (UIViewController *)IntensityViewControllerForWindow;
// Get LoginViewController's view
- (UIView *)loginViewControllerView;
// Get RootViewController's view
- (UIView *)rootViewControllerView;
// Get ProfileViewController's view
- (UIView *)profileViewControllerView;
// Get GoalsViewController's view
- (UIView *)goalsViewControllerView;
// Get CalenderViewController's view
- (UIView *)calenderViewControllerView;
// Get WorkOutDaysViewController's view
- (UIView *)workOutDaysViewControllerView;
// Get ExerciseLevelViewController's view
- (UIView *)exerciseLevelViewControllerView;
// Get FoodProfileViewController's view
- (UIView *)foodProfileViewControllerView;
// Get ExerciseProfileViewController's view
- (UIView *)exerciseProfileViewControllerView;
// Get MealViewController's view
- (UIView *)mealViewControllerView;
// Get ExerciseViewController's view
- (UIView *)exerciseViewControllerView;
// Get MusicTracksViewController view
- (UIView *)musicTracksViewControllerView;
// Get SupplementPlanViewController's view
- (UIView *)supplementPlanViewControllerView;
// Get SupplementProfileViewController's view
- (UIView *)supplementProfileViewControllerView;
// Get ExerciseListViewController view
- (UIView *)moveToexerciseListViewController;
// Get IntensityViewController view
- (UIView *)moveToIntensityViewControllerViewController;
// Get ProgressViewController view
- (UIView *)progresViewControllerView;
// Get SwitchPlanItemViewController view
- (UIView *)switchPlanItemViewController;

// Singleton ViewFactory object
+ (ViewFactory *)sharedInstance;

@end
