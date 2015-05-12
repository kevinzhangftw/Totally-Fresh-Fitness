//
//  MusicTracksViewController.h
//  MusicTracksViewController
//
//  Created by John Abeel on 7/15/11.
//  Copyright 2011 Wakefield School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicTracksViewController : UIViewController {
}

@property (strong, nonatomic) IBOutlet UIImageView *topNavigationBar;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UITableView *theTableView;
@property (strong, nonatomic) UIButton *bottomBarButton;
@property (strong, nonatomic) UIButton *musicPlayerButton;
@property (strong, nonatomic) UIButton *exercisePlanButton;
@property (strong, nonatomic) UIButton *calendarButton;
@property (strong, nonatomic) UIButton *mealPlanButton;
@property (strong, nonatomic) UIButton *nutritionPlanButton;
@property (strong, nonatomic) NSString *selectedMusicURL;

// Singleton MusicTracksViewController object
+ (MusicTracksViewController *)sharedInstance;

@end
