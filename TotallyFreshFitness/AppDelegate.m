//
//  AppDelegate.m
//  TotallyFreshFitness
//
//  Created by Kevin Zhang on 2015-05-11.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  if (self.window == nil) {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  }
  ViewController *viewController = [ViewController new];
  self.window.rootViewController = viewController;
  [self.window makeKeyAndVisible];
  return YES;
}

@end
