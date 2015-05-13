//
//  AppDelegate.m
//  TotallyFreshFitness
//
//  Created by Kevin Zhang on 2015-05-11.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ViewFactory.h"
#import "RootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  if (self.window == nil) {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  }
  ViewFactory *viewFactory = [ViewFactory sharedInstance];
  UIViewController *viewController = [RootViewController new];
  UINavigationController *navController = [UINavigationController new];
  navController.navigationBarHidden = YES;
  [navController setViewControllers:@[viewController]];
  self.window.rootViewController = navController;
  //self.window.rootViewController = [RootViewController new];
  [self.window makeKeyAndVisible];
  return YES;
}

@end
