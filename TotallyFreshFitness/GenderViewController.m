//
//  GenderViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 10/27/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "GenderViewController.h"
#import "WorkOutDaysViewController.h"
#import "IntensityViewController.h"
#import "GoalsViewController.h"
#import "ViewTransitions.h"
#import <Parse/Parse.h>

@interface GenderViewController ()
// IntensityViewController class object
@property (strong, nonatomic)IntensityViewController *m_intensityViewController;
// Selected Gender
@property (strong, nonatomic)NSString *gender;
@property (strong, nonatomic)ViewTransitions *m_transition;
// Move to IntensityViewController
- (void)moveToIntensityViewController:(id)sender;
@end

@implementation GenderViewController


@synthesize maleButton;
@synthesize femaleButton;
@synthesize sex;

/*
 Singleton GenderViewController object
 */
+ (GenderViewController *)sharedInstance {
	static GenderViewController *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 Move to the previous view
 */
- (IBAction)moveToPreviousViewController:(id)sender
{
    if (!self.m_transition) {
        self.m_transition                    = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionFromRight:self.view.superview];
    [self.view removeFromSuperview];

}

/*
 Take user to intensity view controller
 */
- (void)moveToIntensityViewController:(id)sender
{
    if (!self.m_intensityViewController) {
        self.m_intensityViewController          = [IntensityViewController sharedInstance];
    }
    id instanceObject               = self.m_intensityViewController;
    [self moveToView:self.m_intensityViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}
- (IBAction)nextView:(id)sender {
    
    if(![self.sex isEqualToString:@""]){
        [self moveToIntensityViewController:self];
    }
}

/*
 Update gender button
 */
- (void)updateGenderButton:(id)sender
{

        
    if (sender == self.maleButton) {
        if (self.maleButton.tag == 0) {
            // assign the mode
            self.maleButton.tag               = 1;
            self.femaleButton.tag             = 0;
            // set light intensity image
            [self.maleButton setBackgroundImage:[UIImage imageNamed:@"male_active.png"] forState:UIControlStateNormal];
            [self.femaleButton setBackgroundImage:[UIImage imageNamed:@"female.png"] forState:UIControlStateNormal];
            
            self.gender                            = @"Male";
            self.sex                        = self.gender;
            if (![self.sex isEqualToString:@""]) {
                PFObject *sexObject = [PFObject objectWithClassName:@"User"];
                [sexObject setObject:self.gender forKey:@"sex"];
                [self moveToIntensityViewController:self];
            }

        }
        else {
            // assign the mode
            self.maleButton.tag               = 0;
            // set light intensity image
            [self.maleButton setBackgroundImage:[UIImage imageNamed:@"male.png"] forState:UIControlStateNormal];
        }
    }
    else if (sender == self.femaleButton) {
        if (self.femaleButton.tag == 0) {
            // assign the mode
            self.maleButton.tag               = 0;
            self.femaleButton.tag             = 1;
            // set light intensity image
            [self.maleButton setBackgroundImage:[UIImage imageNamed:@"male.png"] forState:UIControlStateNormal];
            [self.femaleButton setBackgroundImage:[UIImage imageNamed:@"female_active.png"] forState:UIControlStateNormal];
            self.gender                            = @"Female";
            self.sex                        = self.gender;
            if (![self.sex isEqualToString:@""]) {
                PFObject *sexObject = [PFObject objectWithClassName:@"User"];
                [sexObject setObject:self.gender forKey:@"sex"];
                [self moveToIntensityViewController:self];
            }

        }
        else {
            // assign the mode
            self.femaleButton.tag             = 0;
            // set light intensity image
            [self.femaleButton setBackgroundImage:[UIImage imageNamed:@"female.png"] forState:UIControlStateNormal];
        }
    }
}

/*
 User selects one gaol
 */
- (IBAction)selectGender:(id)sender
{
    [self updateGenderButton:sender];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // adjust view and tableview size for iphone5
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        // Adjust the height of the view
        CGRect frame                                = self.maleButton.frame;
        [self.maleButton removeFromSuperview];
        frame.size.height                           = frame.size.height + 45.0f;
        self.maleButton                             = [[UIButton alloc] initWithFrame:frame];
        [self.view addSubview:self.maleButton];
        [self.maleButton setBackgroundImage:[UIImage imageNamed:@"male.png"] forState:UIControlStateNormal];
        [self.maleButton addTarget:self action:@selector(selectGender:) forControlEvents:UIControlEventTouchUpInside];
        self.maleButton.tag                         = 0;

        frame                                       = self.femaleButton.frame;
        [self.femaleButton removeFromSuperview];
        frame.origin.y                              = frame.origin.y + 45.0f;
        frame.size.height                           = frame.size.height + 45.0f;
        self.femaleButton                           = [[UIButton alloc] initWithFrame:frame];
        [self.view addSubview:self.femaleButton];
        [self.femaleButton setBackgroundImage:[UIImage imageNamed:@"female.png"] forState:UIControlStateNormal];
        [self.femaleButton addTarget:self action:@selector(selectGender:) forControlEvents:UIControlEventTouchUpInside];
        self.femaleButton.tag                       = 0;
    }
}

- (void)viewWillAppear:(BOOL)animated {

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
