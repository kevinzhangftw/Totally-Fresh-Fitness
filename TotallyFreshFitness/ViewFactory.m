//
//  ViewFactory.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-02.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import "ViewFactory.h"
#import "LoginViewController.h"
#import "RootViewController.h"
#import "ProfileViewController.h"
#import "GoalsViewController.h"
#import "WorkOutDaysViewController.h"
#import "ExerciseLevelViewController.h"
#import "FoodProfileViewController.h"
#import "ExerciseProfileViewController.h"
#import "ExerciseListViewController.h"
#import "IntensityViewController.h"
#import "ProgressViewController.h"
#import "SwitchPlanItemViewController.h"
#import "SupplementProfileViewController.h"

@interface ViewFactory()
// LoginViewController class object
@property (strong, nonatomic)LoginViewController *m_loginViewController;
// RootViewController class object
@property (strong, nonatomic)RootViewController *m_rootViewController;
// ProfileViewController class object
@property (strong, nonatomic)ProfileViewController *m_profileViewController;
// GoalsViewController class object
@property (strong, nonatomic)GoalsViewController *m_goalsViewController;
// CalenderViewController class object
@property (strong, nonatomic)CalenderViewController *m_calenderViewController;
// WorkOutDaysViewController class object
@property (strong, nonatomic)WorkOutDaysViewController *m_workOutDaysViewController;
// ExerciseLevelViewController class object
@property (strong, nonatomic)ExerciseLevelViewController *m_exerciseLevelViewController;
// FoodProfileViewController class object
@property (strong, nonatomic)FoodProfileViewController *m_foodProfileViewController;
// ExerciseProfileViewController class object
@property (strong, nonatomic)ExerciseProfileViewController *m_exerciseProfileViewController;
// MealViewController class object
@property (strong, nonatomic)MealViewController *m_mealViewController;
// ExerciseViewController class object
@property (strong, nonatomic)ExerciseViewController *m_exerciseViewController;
// SupplementPlanViewController class object
@property (strong, nonatomic)SupplementPlanViewController *m_supplementPlanViewController;
// MusicTracksViewController class object
@property (strong, nonatomic)MusicTracksViewController *m_musicTracksViewController;
// ExreciseListViewController class object
@property (strong, nonatomic)ExerciseListViewController *m_exerciseListViewController;
// IntensityViewController class object
@property (strong, nonatomic)IntensityViewController *m_intensityViewController;
// ProgressViewController class object
@property (strong, nonatomic)ProgressViewController *m_progressViewController;
// SwitchPlanItemViewController class object
@property (strong, nonatomic)SwitchPlanItemViewController *m_switchPlanItemViewController;
// SupplementProfileViewController class object
@property (strong, nonatomic)SupplementProfileViewController *m_supplementProfileViewController;

@end

@implementation ViewFactory

/*
 Singleton ViewFactory object
 */
+ (ViewFactory *)sharedInstance {
	static ViewFactory *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 Get LoginViewController For Window
 */
- (UIViewController *)loginViewControllerForWindow
{
    return [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
}

/*
 Get RootViewController For Window
 */
- (UIViewController *)rootViewControllerForWindow
{
    return [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
}

/*
 Get CalenderViewController For Window
 */
- (UIViewController *)calenderViewControllerForWindow
{
    return [[CalenderViewController alloc] initWithNibName:@"CalenderViewController" bundle:nil];
}

/*
 Get ProfileViewController For Window
 */
- (UIViewController *)profileViewControllerForWindow
{
    return [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
}

/*
 Get GoalsViewController For Window
 */
- (UIViewController *)goalsViewControllerForWindow
{
    return [[GoalsViewController alloc] initWithNibName:@"GoalsViewController" bundle:nil];
}

/*
 Get WorkOutDaysViewController For Window
 */
- (UIViewController *)workOutDaysViewControllerForWindow
{
  
    return [[WorkOutDaysViewController alloc] initWithNibName:@"WorkOutDaysViewController" bundle:nil];
}

/*
 Get ExerciseLevelViewController For Window
 */
- (UIViewController *)exerciseLevelViewControllerForWindow
{
    return [[ExerciseLevelViewController alloc] initWithNibName:@"ExerciseLevelViewController" bundle:nil];
}

/*
 Get IntensityViewController For Window
 */
- (UIViewController *)IntensityViewControllerForWindow
{

    return [[IntensityViewController alloc] initWithNibName:@"IntensityViewController" bundle:nil];}

/*
 Move to LoginViewController's view
 */
- (UIView *)loginViewControllerView
{
    if (!self.m_loginViewController) {
        self.m_loginViewController   = [LoginViewController sharedInstance];
    }
    return self.m_loginViewController.view;
}

/*
 Move to RootViewController's view
 */
- (UIView *)rootViewControllerView
{
    if (!self.m_rootViewController) {
        self.m_rootViewController   = [RootViewController sharedInstance];
    }
    return self.m_rootViewController.view;
}

/*
 Move to RootViewController's view
 */
- (UIView *)profileViewControllerView
{
    if (!self.m_profileViewController) {
        self.m_profileViewController   = [ProfileViewController sharedInstance];
    }
    return self.m_profileViewController.view;
}

/*
 Move to GoalsViewController's view
 */
- (UIView *)goalsViewControllerView
{
    if (!self.m_goalsViewController) {
        self.m_goalsViewController   = [GoalsViewController sharedInstance];
    }
    return self.m_goalsViewController.view;
}

/*
 Move to CalenderViewController view
 */
- (UIView *)calenderViewControllerView
{
    if (!self.m_calenderViewController) {
        self.m_calenderViewController   = [CalenderViewController sharedInstance];
    }
    return self.m_calenderViewController.view;
}

/*
 Move to WorkOutDaysViewController view
 */
- (UIView *)workOutDaysViewControllerView
{
    if (!self.m_workOutDaysViewController) {
        self.m_workOutDaysViewController   = [WorkOutDaysViewController sharedInstance];
    }
    return self.m_workOutDaysViewController.view;
}

/*
 Move to ExerciseLevelViewController view
 */
- (UIView *)exerciseLevelViewControllerView
{
    if (!self.m_exerciseLevelViewController) {
        self.m_exerciseLevelViewController   = [ExerciseLevelViewController sharedInstance];
    }
    return self.m_exerciseLevelViewController.view;
}

/*
 Move to SupplementPlanViewController view
 */
- (UIView *)supplementPlanViewControllerView
{
    if (!self.m_supplementPlanViewController) {
        self.m_supplementPlanViewController   = [SupplementPlanViewController sharedInstance];
    }
    return self.m_supplementPlanViewController.view;
}

/*
 Get FoodProfileViewController's view
 */
- (UIView *)foodProfileViewControllerView
{
    if (!self.m_foodProfileViewController) {
        self.m_foodProfileViewController   = [FoodProfileViewController sharedInstance];
    }
    return self.m_foodProfileViewController.view;
}

/*
 Get ExerciseProfileViewController's view
 */
- (UIView *)exerciseProfileViewControllerView
{
    if (!self.m_exerciseProfileViewController) {
        self.m_exerciseProfileViewController   = [ExerciseProfileViewController sharedInstance];
    }
    return self.m_exerciseProfileViewController.view;
}

/*
 Get MealViewController's view
 */
- (UIView *)mealViewControllerView
{
    if (!self.m_mealViewController) {
        self.m_mealViewController        = [MealViewController sharedInstance];
    }
    return self.m_mealViewController.view;
}

/*
 Get ExerciseViewController's view
 */
- (UIView *)exerciseViewControllerView
{
    if (!self.m_exerciseViewController) {
        self.m_exerciseViewController    = [ExerciseViewController sharedInstance];
    }
    return self.m_exerciseViewController.view;
}

/*
 Get MusicTracksViewController view
 */
- (UIView *)musicTracksViewControllerView
{
    if (!self.m_musicTracksViewController) {
        self.m_musicTracksViewController           = [MusicTracksViewController sharedInstance];
    }
    return self.m_musicTracksViewController.view;
}

/*
 Get SupplementProfileViewController's view
 */
- (UIView *)supplementProfileViewControllerView
{
    if (!self.m_supplementProfileViewController) {
        self.m_supplementProfileViewController    = [SupplementProfileViewController sharedInstance];
    }
    return self.m_supplementProfileViewController.view;
}

/*
 Get ExerciseListViewController view
 */
- (UIView *)moveToexerciseListViewController
{
    if (!self.m_exerciseListViewController) {
        self.m_exerciseListViewController          = [ExerciseListViewController sharedInstance];
    }
    return self.m_exerciseListViewController.view;
}

/*
 Get IntensityViewController view
 */
- (UIView *)moveToIntensityViewControllerViewController
{
    if (!self.m_intensityViewController) {
        self.m_intensityViewController            = [IntensityViewController sharedInstance];
    }
    return self.m_intensityViewController.view;
}

/*
 Get ProgressViewController view
 */
- (UIView *)progresViewControllerView
{
    if (!self.m_progressViewController) {
        self.m_progressViewController            = [ProgressViewController alloc];
    }
    return self.m_progressViewController.view;
}

/*
 Get EditPlanViewController view
 */
- (UIView *)switchPlanItemViewController
{
    if (!self.m_switchPlanItemViewController) {
        self.m_switchPlanItemViewController            = [SwitchPlanItemViewController alloc];
    }
    return self.m_switchPlanItemViewController.view;
}

@end
