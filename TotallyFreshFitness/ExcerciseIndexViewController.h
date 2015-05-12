//
//  ExcerciseIndexViewController.h
//  Total Fitness And Nutrition
//
//  Created by Harveer Parmar on 2014-10-22.
//  Copyright (c) 2014 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExcerciseIndexViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

- (IBAction)previousViewController:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *exerciseIndexTableView;


@property (strong, nonatomic) NSString *selectedImage;


// Singleton SwitchPlanItemViewController object
+ (ExcerciseIndexViewController *)sharedInstance;

@end
