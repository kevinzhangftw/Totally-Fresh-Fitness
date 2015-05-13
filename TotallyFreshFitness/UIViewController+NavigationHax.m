//
//  UIViewController+NavigationHax.m
//  TotallyFreshFitness
//
//  Created by Kevin Zhang on 2015-05-12.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "UIViewController+NavigationHax.h"
#import "WorkOutDaysViewController.h"
#import "GoalsViewController.h"
#import "ExerciseLevelViewController.h"

@implementation UIViewController (NavigationHax)

-(void)moveToVC:(UIViewController*) vc{
  if ([self.navigationController.viewControllers containsObject:vc]) {
    [self.navigationController popToViewController:vc animated:NO];
  } else {
    [self.navigationController pushViewController:vc animated:NO];
  }
}

- (void)moveToProfileViewController:(id)sender{
  [self moveToVC:[ProfileViewController sharedInstance]];
}
- (void)moveToExerciseViewController:(id)sender{
  [self moveToVC:[ExerciseViewController sharedInstance]];
}
- (void)moveToMealViewController:(id)sender{
  [self moveToVC:[MealViewController sharedInstance]];
}
- (void)moveToCalenderViewController:(id)sender{
  [self moveToVC:[CalenderViewController sharedInstance]];
}
- (void)moveToMusicTracksViewController:(id)sender{
  [self moveToVC:[MusicTracksViewController sharedInstance]];
}
-(void)moveToSupplementPlanViewController:(id)sender{ //TODO: remove supplement vc.
  [self moveToVC:[SupplementPlanViewController sharedInstance]];
}
- (void)moveToWorkOutDaysViewController{
  [self moveToVC:[WorkOutDaysViewController sharedInstance]];
}
- (void)moveToGoalsViewController{
  [self moveToVC:[GoalsViewController sharedInstance]];
}
- (void)moveToExerciseLevelViewController{
  [self moveToVC:[ExerciseLevelViewController sharedInstance]];
}

@end
