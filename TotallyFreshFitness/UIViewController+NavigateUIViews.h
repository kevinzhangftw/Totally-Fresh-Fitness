//
//  UIViewController+NavigateUIViews.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-18.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavigateUIViews)

// Move to destination view from current view
- (void)moveToView:(UIView *)destinationView FromCurrentView:(UIView *)currentView ByRefreshing:(id)instanceObject;

@end
