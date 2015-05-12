//
//  UIViewController+iPhoneScreenSizes.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-06.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import "UIViewController+iPhoneScreenSizes.h"
#import "ViewFactory.h"

@implementation UIViewController (iPhoneScreenSizes)

// ControllersView class object
ViewFactory *m_controllerView;

// Height of the control buttons at the bottom
static int heightOfControls             = 55;

/*
 Set up subbackground image to take care of difference iphone screen sizes for login view
 */
- (void)subBackgroundImage:(UIButton *)subBackgroundImageButton View:(UIView *)view
{
    subBackgroundImageButton                               = nil;
    // subBackground image
    subBackgroundImageButton                               = [[UIButton alloc] initWithFrame: CGRectMake(view.bounds.origin.x, subBackgroundImageButton.bounds.origin.y, view.bounds.size.width, [UIScreen mainScreen ].bounds.size.height)];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        [subBackgroundImageButton setBackgroundImage:[UIImage imageNamed:@"iphone5signinpanel.png"] forState:UIControlStateNormal];
    }
    else {
        [subBackgroundImageButton setBackgroundImage:[UIImage imageNamed:@"tfn-login.png"] forState:UIControlStateNormal];
    }
    
    [view addSubview:subBackgroundImageButton];
    [view sendSubviewToBack:subBackgroundImageButton];
    subBackgroundImageButton.userInteractionEnabled        = NO;
    subBackgroundImageButton.hidden                        = NO;
}

/*
 Set up background image to take care of difference iphone screen sizes for login view
 */
- (void)backgroundImage:(UIButton *)backgroundButton View:(UIView *)view
{
    backgroundButton                               = nil;
    // Background image
    backgroundButton                               = [[UIButton alloc] initWithFrame: CGRectMake(view.bounds.origin.x, backgroundButton.bounds.origin.y, view.bounds.size.width, [UIScreen mainScreen ].bounds.size.height)];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        [backgroundButton setBackgroundImage:[UIImage imageNamed:@"iphone5background.png"] forState:UIControlStateNormal];
    }
    else {
        [backgroundButton setBackgroundImage:[UIImage imageNamed:@"tfn-interface_background.png"] forState:UIControlStateNormal];
    }
    
    [view addSubview:backgroundButton];
    [view sendSubviewToBack:backgroundButton];
    backgroundButton.userInteractionEnabled        = NO;
    backgroundButton.hidden                        = NO;
}

/*
 Set up the bottom bars controls programmatically to take care of iphone size differences
 */
- (NSMutableArray *)bottomBar:(UIButton *)bottomBarButton MusicPlayerButton:(UIButton *)musicPlayerButton ExercisePlanButton:(UIButton *)exercisePlanButton Calendar:(UIButton *)calendarButton MealPlan:(UIButton *)mealPlanButton MoreButton:(UIButton *)moreButton InView:(UIView *)view
{
    if (!m_controllerView) {
        m_controllerView                          = [ViewFactory sharedInstance];
    }
    int marginDifference                          = 55.0f;

    // Necessary to return the array of buttons for customizations at each controller's level
    NSMutableArray *controlButtonArrays;
    
    // Take care of iPhone 5 sizes
    bottomBarButton                               = nil;
    // Background image
    CGRect bottomBarFrame                         = CGRectMake(0, ([UIScreen mainScreen ].bounds.size.height - marginDifference), [UIScreen mainScreen ].bounds.size.width,  heightOfControls);
    bottomBarButton                               = [[UIButton alloc] initWithFrame: bottomBarFrame];
    [bottomBarButton setBackgroundImage:[UIImage imageNamed:@"BottomNav_ready.png"] forState:UIControlStateNormal];
    [view addSubview:bottomBarButton];
    bottomBarButton.userInteractionEnabled        = NO;
    bottomBarButton.hidden                        = NO;
    // add bottom button to array
    [controlButtonArrays addObject:bottomBarButton];

    CGRect musicPlayerFrame                       = CGRectMake(0, ([UIScreen mainScreen ].bounds.size.height - marginDifference), 64, heightOfControls);
    musicPlayerButton                             = [[UIButton alloc] initWithFrame:musicPlayerFrame];
    [view addSubview:musicPlayerButton];
    musicPlayerButton.backgroundColor             = [UIColor clearColor];
    musicPlayerButton.hidden                      = NO;
    if (view == [m_controllerView musicTracksViewControllerView]) {
        [bottomBarButton setBackgroundImage:[UIImage imageNamed:@"BottomNav_playlist_active.png"] forState:UIControlStateNormal];
    }
    else {
        [musicPlayerButton addTarget:self action:@selector(moveToMusicTracksViewController:) forControlEvents:UIControlEventTouchUpInside];
    }
    // add music button to array
    [controlButtonArrays addObject:musicPlayerButton];
    
    CGRect exercisePlanFrame                      = CGRectMake(64, ([UIScreen mainScreen ].bounds.size.height - marginDifference), 64, heightOfControls);
    exercisePlanButton                            = [[UIButton alloc] initWithFrame:exercisePlanFrame];
    [view addSubview:exercisePlanButton];
    exercisePlanButton.backgroundColor            = [UIColor clearColor];
    exercisePlanButton.hidden                     = NO;
    if (view  == [m_controllerView exerciseViewControllerView]) {
        [bottomBarButton setBackgroundImage:[UIImage imageNamed:@"BottomNav_workoutactive.png"] forState:UIControlStateNormal];
    }
    else {
        [exercisePlanButton addTarget:self action:@selector(moveToExerciseViewController:) forControlEvents:UIControlEventTouchUpInside];
    }
    // add exercise button to array
    [controlButtonArrays addObject:exercisePlanButton];

    
    CGRect calendarFrame                          = CGRectMake(128, ([UIScreen mainScreen ].bounds.size.height - marginDifference), 64, heightOfControls);
    calendarButton                                = [[UIButton alloc] initWithFrame:calendarFrame];
    [view addSubview:calendarButton];
    calendarButton.backgroundColor                = [UIColor clearColor];
    calendarButton.hidden                         = NO;
    if (view  == [m_controllerView calenderViewControllerView]) {
        [bottomBarButton setBackgroundImage:[UIImage imageNamed:@"BottomNav_cal_active.png"] forState:UIControlStateNormal];
    }
    else {
        [calendarButton addTarget:self action:@selector(moveToCalenderViewController:) forControlEvents:UIControlEventTouchUpInside];
    }
    // add calendar button to array
    [controlButtonArrays addObject:calendarButton];

    
    CGRect mealPlanFrame                          = CGRectMake(192, ([UIScreen mainScreen ].bounds.size.height - marginDifference), 64, heightOfControls);
    mealPlanButton                                = [[UIButton alloc] initWithFrame:mealPlanFrame];
    [view addSubview:mealPlanButton];
    mealPlanButton.backgroundColor                = [UIColor clearColor];
    mealPlanButton.hidden                         = NO;
    
    if (view  == [m_controllerView mealViewControllerView]) {
        [bottomBarButton setBackgroundImage:[UIImage imageNamed:@"BottomNav_meal_active.png"] forState:UIControlStateNormal];
    }
    else {
        [mealPlanButton addTarget:self action:@selector(moveToMealViewController:) forControlEvents:UIControlEventTouchUpInside];
    }
    // add meal button to array
    [controlButtonArrays addObject:mealPlanButton];
    
    
    CGRect moreFrame                              = CGRectMake(256, ([UIScreen mainScreen ].bounds.size.height - marginDifference), 64,heightOfControls);
    moreButton                                    = [[UIButton alloc] initWithFrame:moreFrame];
    [view addSubview:moreButton];
    moreButton.backgroundColor                    = [UIColor clearColor];
    moreButton.hidden                             = NO;
    if (view  == [m_controllerView supplementPlanViewControllerView]) {
        [bottomBarButton setBackgroundImage:[UIImage imageNamed:@"BottomNav_supps_active.png"] forState:UIControlStateNormal];
    }
    else {
        [moreButton addTarget:self action:@selector(moveToSupplementPlanViewController:) forControlEvents:UIControlEventTouchUpInside];
    }
    // add more button to array
    [controlButtonArrays addObject:moreButton];
    
    return controlButtonArrays;
}

/*
 Adjust the height of the views for iphone5 size
 */
- (UIView *)adjustiPhone5HeightOfView:(UIView *)view
{
    CGRect frame;
    // Adjust the height of the view
    frame.size.height                               = 568.0f;
    view.frame                                      = frame;
    return view;
}

// Adjust the height of tableview for iphone5 size
- (UITableView *)adjustiPhone5HeightOfTableView:(UITableView *)tableView ForController:(id)controller
{
    if (!m_controllerView) {
        m_controllerView                          = [ViewFactory alloc];
    }
    CGRect frame;
    frame                                         = tableView.frame;
    if ([controller view] == [m_controllerView musicTracksViewControllerView]) {
        frame.size.height                         = tableView.frame.size.height + 90.0f;
    }
    else {
        frame.size.height                         = tableView.frame.size.height + 75.0f;
    }
    tableView                                     = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain]; // check if this actually works
    tableView.delegate                            = controller;
    tableView.dataSource                          = controller;
    return tableView;
}

//Readd the indicator view to adjust view
- (UIActivityIndicatorView *)reAddActivityIndicatorforiPhone5:(UIActivityIndicatorView *)activityIndicatorView
{
    // Readd activity view controller
    [activityIndicatorView removeFromSuperview];
    return activityIndicatorView;
}
@end
