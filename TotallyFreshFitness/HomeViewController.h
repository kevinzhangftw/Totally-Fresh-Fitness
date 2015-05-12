//
//  HomeViewController.h
//  Total Fitness And Nutrition
//
//  Created by Harveer Parmar on 2014-10-27.
//  Copyright (c) 2014 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface HomeViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSArray *titleLabels;


// Singleton SwitchPlanItemViewController object
+ (HomeViewController *)sharedInstance;

@end
