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

@implementation ViewFactory

// LoginViewController class object
LoginViewController *m_loginViewController;
// RootViewController class object
RootViewController *m_rootViewController;
// ProfileViewController class object
ProfileViewController *m_profileViewController;
// GoalsViewController class object
GoalsViewController *m_goalsViewController;
// CalenderViewController class object
CalenderViewController *m_calenderViewController;
// WorkOutDaysViewController class object
WorkOutDaysViewController *m_workOutDaysViewController;
// ExerciseLevelViewController class object
ExerciseLevelViewController *m_exerciseLevelViewController;
// FoodProfileViewController class object
FoodProfileViewController *m_foodProfileViewController;
// ExerciseProfileViewController class object
ExerciseProfileViewController *m_exerciseProfileViewController;
// MealViewController class object
MealViewController *m_mealViewController;
// ExerciseViewController class object
ExerciseViewController *m_exerciseViewController;
// SupplementPlanViewController class object
SupplementPlanViewController *m_supplementPlanViewController;
// MusicTracksViewController class object
MusicTracksViewController *m_musicTracksViewController;
// ExreciseListViewController class object
ExerciseListViewController *m_exerciseListViewController;
// IntensityViewController class object
IntensityViewController *m_intensityViewController;
// ProgressViewController class object
ProgressViewController *m_progressViewController;
// SwitchPlanItemViewController class object
SwitchPlanItemViewController *m_switchPlanItemViewController;
// SupplementProfileViewController class object
SupplementProfileViewController *m_supplementProfileViewController;
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
    if (!m_loginViewController) {
        m_loginViewController   = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    }
    return m_loginViewController;
}

/*
 Get RootViewController For Window
 */
- (UIViewController *)rootViewControllerForWindow
{
    if (!m_rootViewController) {
        m_rootViewController        = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    }
    return m_rootViewController;
}

/*
 Get CalenderViewController For Window
 */
- (UIViewController *)calenderViewControllerForWindow
{
    if (!m_calenderViewController) {
        m_calenderViewController   = [[CalenderViewController alloc] initWithNibName:@"CalenderViewController" bundle:nil];
    }
    return m_calenderViewController;
}

/*
 Get ProfileViewController For Window
 */
- (UIViewController *)profileViewControllerForWindow
{
    if (!m_profileViewController) {
        m_profileViewController   = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    }
    return m_profileViewController;
}

/*
 Get GoalsViewController For Window
 */
- (UIViewController *)goalsViewControllerForWindow
{
    if (!m_goalsViewController) {
        m_goalsViewController   = [[GoalsViewController alloc] initWithNibName:@"GoalsViewController" bundle:nil];
    }
    return m_goalsViewController;
}

/*
 Get WorkOutDaysViewController For Window
 */
- (UIViewController *)workOutDaysViewControllerForWindow
{
    if (!m_workOutDaysViewController) {
        m_workOutDaysViewController   = [[WorkOutDaysViewController alloc] initWithNibName:@"WorkOutDaysViewController" bundle:nil];
    }
    return m_workOutDaysViewController;
}

/*
 Get ExerciseLevelViewController For Window
 */
- (UIViewController *)exerciseLevelViewControllerForWindow
{
    if (!m_exerciseLevelViewController) {
        m_exerciseLevelViewController   = [[ExerciseLevelViewController alloc] initWithNibName:@"ExerciseLevelViewController" bundle:nil];
    }
    return m_exerciseLevelViewController;
}

/*
 Get IntensityViewController For Window
 */
- (UIViewController *)IntensityViewControllerForWindow
{
    if (!m_intensityViewController) {
        m_intensityViewController       = [[IntensityViewController alloc] initWithNibName:@"IntensityViewController" bundle:nil];
    }
    return m_intensityViewController;
}

/*
 Move to LoginViewController's view
 */
- (UIView *)loginViewControllerView
{
    if (!m_loginViewController) {
        m_loginViewController   = [LoginViewController sharedInstance];
    }
    return m_loginViewController.view;
}

/*
 Move to RootViewController's view
 */
- (UIView *)rootViewControllerView
{
    if (!m_rootViewController) {
        m_rootViewController   = [RootViewController sharedInstance];
    }
    return m_rootViewController.view;
}

/*
 Move to RootViewController's view
 */
- (UIView *)profileViewControllerView
{
    if (!m_profileViewController) {
        m_profileViewController   = [ProfileViewController sharedInstance];
    }
    return m_profileViewController.view;
}

/*
 Move to GoalsViewController's view
 */
- (UIView *)goalsViewControllerView
{
    if (!m_goalsViewController) {
        m_goalsViewController   = [GoalsViewController sharedInstance];
    }
    return m_goalsViewController.view;
}

/*
 Move to CalenderViewController view
 */
- (UIView *)calenderViewControllerView
{
    if (!m_calenderViewController) {
        m_calenderViewController   = [CalenderViewController sharedInstance];
    }
    return m_calenderViewController.view;
}

/*
 Move to WorkOutDaysViewController view
 */
- (UIView *)workOutDaysViewControllerView
{
    if (!m_workOutDaysViewController) {
        m_workOutDaysViewController   = [WorkOutDaysViewController sharedInstance];
    }
    return m_workOutDaysViewController.view;
}

/*
 Move to ExerciseLevelViewController view
 */
- (UIView *)exerciseLevelViewControllerView
{
    if (!m_exerciseLevelViewController) {
        m_exerciseLevelViewController   = [ExerciseLevelViewController sharedInstance];
    }
    return m_exerciseLevelViewController.view;
}

/*
 Move to SupplementPlanViewController view
 */
- (UIView *)supplementPlanViewControllerView
{
    if (!m_supplementPlanViewController) {
        m_supplementPlanViewController   = [SupplementPlanViewController sharedInstance];
    }
    return m_supplementPlanViewController.view;
}

/*
 Get FoodProfileViewController's view
 */
- (UIView *)foodProfileViewControllerView
{
    if (!m_foodProfileViewController) {
        m_foodProfileViewController   = [FoodProfileViewController sharedInstance];
    }
    return m_foodProfileViewController.view;
}

/*
 Get ExerciseProfileViewController's view
 */
- (UIView *)exerciseProfileViewControllerView
{
    if (!m_exerciseProfileViewController) {
        m_exerciseProfileViewController   = [ExerciseProfileViewController sharedInstance];
    }
    return m_exerciseProfileViewController.view;
}

/*
 Get MealViewController's view
 */
- (UIView *)mealViewControllerView
{
    if (!m_mealViewController) {
        m_mealViewController        = [MealViewController sharedInstance];
    }
    return m_mealViewController.view;
}

/*
 Get ExerciseViewController's view
 */
- (UIView *)exerciseViewControllerView
{
    if (!m_exerciseViewController) {
        m_exerciseViewController    = [ExerciseViewController sharedInstance];
    }
    return m_exerciseViewController.view;
}

/*
 Get MusicTracksViewController view
 */
- (UIView *)musicTracksViewControllerView
{
    if (!m_musicTracksViewController) {
        m_musicTracksViewController           = [MusicTracksViewController sharedInstance];
    }
    return m_musicTracksViewController.view;
}

/*
 Get SupplementProfileViewController's view
 */
- (UIView *)supplementProfileViewControllerView
{
    if (!m_supplementProfileViewController) {
        m_supplementProfileViewController    = [SupplementProfileViewController sharedInstance];
    }
    return m_supplementProfileViewController.view;
}

/*
 Get ExerciseListViewController view
 */
- (UIView *)moveToexerciseListViewController
{
    if (!m_exerciseListViewController) {
        m_exerciseListViewController          = [ExerciseListViewController sharedInstance];
    }
    return m_exerciseListViewController.view;
}

/*
 Get IntensityViewController view
 */
- (UIView *)moveToIntensityViewControllerViewController
{
    if (!m_intensityViewController) {
        m_intensityViewController            = [IntensityViewController sharedInstance];
    }
    return m_intensityViewController.view;
}

/*
 Get ProgressViewController view
 */
- (UIView *)progresViewControllerView
{
    if (!m_progressViewController) {
        m_progressViewController            = [ProgressViewController alloc];
    }
    return m_progressViewController.view;
}

/*
 Get EditPlanViewController view
 */
- (UIView *)switchPlanItemViewController
{
    if (!m_switchPlanItemViewController) {
        m_switchPlanItemViewController            = [SwitchPlanItemViewController alloc];
    }
    return m_switchPlanItemViewController.view;
}

@end
