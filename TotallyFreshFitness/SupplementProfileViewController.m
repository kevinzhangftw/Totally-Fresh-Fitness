//
//  SupplementProfileViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/16/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "SupplementProfileViewController.h"
#import "SupplementPlanViewController.h"
#import "NSString+SupplementImageName.h"
#import "SupplementPlanSelection.h"

@interface SupplementProfileViewController ()
// ViewTransition class object
@property (strong, nonatomic)ViewTransitions *m_transition;
// ExerciseViewController class object
@property (strong, nonatomic)ExerciseViewController *m_exerciseViewController;
// CalenderViewController class object
@property (strong, nonatomic)CalenderViewController *m_calenderViewController;
// MealViewController class object
@property (strong, nonatomic)MealViewController *m_mealViewController;
// MusicTracksViewController class object
@property (strong, nonatomic)MusicTracksViewController *m_musicTracksViewController;
// SupplementPlanViewController class object
@property (strong, nonatomic)SupplementPlanViewController *m_supplementPlanViewController;
// SupplementPlanSelection class object
@property (strong, nonatomic)SupplementPlanSelection *m_supplementPlanSelection;
@property (strong, nonatomic)UILabel *m_supplementNameLabel;
@property (strong, nonatomic)UIImageView *m_supplementImageView;
@property (strong, nonatomic)UITextView *m_supplementDescriptionView;
@property (strong, nonatomic)NSString *m_imageNameString;
@property (strong, nonatomic)NSMutableDictionary *m_supplementDescriptionDictionary;

@end

@implementation SupplementProfileViewController


/*
 Singleton NutritionPlanViewController object
 */
+ (SupplementProfileViewController *)sharedInstance {
	static SupplementProfileViewController *globalInstance;
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
 Move to CalenderViewController
 */
- (void)moveToCalenderViewController:(id)sender
{
    if (!self.m_calenderViewController) {
        self.m_calenderViewController    = [CalenderViewController sharedInstance];
    }
  
    id instanceObject               = self.m_calenderViewController;
    [self moveToView:self.m_calenderViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
}


/*
 Move to MealViewController
 */
- (void)moveToMealViewController:(id)sender
{
    if (!self.m_mealViewController) {
        self.m_mealViewController        = [MealViewController sharedInstance];
    }
    id instanceObject               = self.m_mealViewController;
    [self moveToView:self.m_mealViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];

}

/*
 Move to ExerciseViewController
 */
- (void)moveToExerciseViewController:(id)sender
{
    if (!self.m_exerciseViewController) {
        self.m_exerciseViewController        = [ExerciseViewController sharedInstance];
    }
    
    id instanceObject                   = self.m_exerciseViewController;
    [self moveToView:self.m_exerciseViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    

}

/*
 Move to MusicTracksViewController
 */
- (void)moveToMusicTracksViewController:(id)sender
{
    if (!self.m_musicTracksViewController) {
        self.m_musicTracksViewController         = [MusicTracksViewController sharedInstance];
    }
    id instanceObject                       = self.m_musicTracksViewController;
    [self moveToView:self.m_musicTracksViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];

}

/*
 Move to SupplementPlanViewController
 */
- (void)moveToSupplementPlanViewController:(id)sender
{
    if (!self.m_supplementPlanViewController) {
        self.m_supplementPlanViewController         = [SupplementPlanViewController sharedInstance];
    }
    id instanceObject               = self.m_supplementPlanViewController;
    self.m_supplementPlanViewController.view.tag     = 1;

    [self moveToView:self.m_supplementPlanViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
}

/*
 Add methods to each control buttons
 */
- (void)addSelectorToControlButtons
{
    // Set up the bottom bar control buttons
    NSMutableArray *controlButtonArrays;
    controlButtonArrays                 = [self bottomBar:self.bottomBarButton MusicPlayerButton:self.musicPlayerButton ExercisePlanButton:self.exercisePlanButton Calendar:self.calendarButton MealPlan:self.mealPlanButton MoreButton:self.nutritionPlanButton InView:self.view];
    
    self.bottomBarButton                = [controlButtonArrays objectAtIndex:0];
    
    self.musicPlayerButton              = [controlButtonArrays objectAtIndex:1];
    
    self.exercisePlanButton             = [controlButtonArrays objectAtIndex:2];
    
    self.calendarButton                 = [controlButtonArrays objectAtIndex:3];
    
    self.mealPlanButton                 = [controlButtonArrays objectAtIndex:4];
    
    self.nutritionPlanButton            = [controlButtonArrays objectAtIndex:5];
    
    // Refresh the view
    [self.view setNeedsDisplay];
}

/*
 Remove space before the first word
 */
- (NSString *)removeWhiteSpaceBeforeFirstWord:(NSString *)nutritionBenefitsText
{
    // trim the whitespace before the first character
    NSCharacterSet *whitespace                      = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    nutritionBenefitsText                           = [nutritionBenefitsText stringByTrimmingCharactersInSet:whitespace];
    return nutritionBenefitsText;
}

/*
 Capatalized first letter of each food name's words
 */
- (NSString *)capatalizeFirstLetterOfWordsOfExerciseName:(NSString *)initialExerciseName
{
    NSString *firstCharCapatalized              = @"";
    NSArray *exerciseNameArray                  = [initialExerciseName componentsSeparatedByString:@" "];
    NSString *subExerciseName                   = @"";
    // Make sure each word in the exercise have first letter capatalized
    for (NSString *subString in exerciseNameArray) {
        firstCharCapatalized                    = [[subString substringToIndex:1] capitalizedString];
        
        subExerciseName                         = [NSString stringWithFormat:@"%@ %@",subExerciseName, [subString stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:firstCharCapatalized]];
    }
    return subExerciseName;
}

/*
 Exercise descriptions displayed on textview
 */
- (void)setUpSupplementItemDescription :(NSMutableDictionary *)supplementDescriptionDictionary
{
    NSString *supplementDescriptionText                     = @"";
    
    if ([supplementDescriptionDictionary count] != 0) {
        NSArray *keys                       = [supplementDescriptionDictionary allKeys];
        if (([keys objectAtIndex:0] != NULL) && ([[keys objectAtIndex:0] length] != 0)) {
            supplementDescriptionText         = [NSString stringWithFormat:@"%@ \n %@", supplementDescriptionText,[keys objectAtIndex:0]];
            if (([supplementDescriptionDictionary objectForKey:[keys objectAtIndex:0]] != NULL) && ([[supplementDescriptionDictionary objectForKey:[keys objectAtIndex:0]] length] != 0)) {
                supplementDescriptionText             = [NSString stringWithFormat:@"      %@ \n      %@ \n", supplementDescriptionText,[supplementDescriptionDictionary objectForKey:[keys objectAtIndex:0]]];
            }
        }
    }
    // Remove the empty line from the supplement Description
    self.m_supplementDescriptionView.text                              = [self removeWhiteSpaceBeforeFirstWord:supplementDescriptionText];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
 set up views
 */
- (void)setUpViews
{
    CGRect supplementNameLabel              = CGRectMake(0.0f, 60.0f, 320.0f, 20.0f);
    self.m_supplementNameLabel                   = [[UILabel alloc] initWithFrame:supplementNameLabel];
    self.m_supplementNameLabel.font              = [UIFont customFontWithSize:15];
    self.m_supplementNameLabel.textColor         = [UIColor darkGrayColor];
    self.m_supplementNameLabel.textAlignment     = NSTextAlignmentCenter;
    [self.view addSubview:self.m_supplementNameLabel];
    
    CGRect supplementImageViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        supplementImageViewFrame            = CGRectMake(60.0f, 91.0f, 200.0f, 200.0f);
    }
    else {
        supplementImageViewFrame            = CGRectMake(80.0f, 91.0f, 150.0f, 150.0f);
    }
    self.m_supplementImageView                   = [[UIImageView alloc] initWithFrame:supplementImageViewFrame];
    [self.view addSubview:self.m_supplementImageView];
    
    CGRect redLineFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        redLineFrame                        = CGRectMake(0.0f, 295.0f, 320.0f, 2.0f);
    }
    else {
        redLineFrame                        = CGRectMake(0.0f, 245.0f, 320.0f, 2.0f);
    }
    UILabel *redLine                        = [[UILabel alloc] initWithFrame:redLineFrame];
    redLine.backgroundColor                 = [UIColor redColor];
    [self.view addSubview:redLine];
    
    CGRect supplementDescriptionViewFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        supplementDescriptionViewFrame      = CGRectMake(0.0f, 298.0f, 320.0f, 225.0f);
    }
    else{
        supplementDescriptionViewFrame      = CGRectMake(0.0f, 248.0f, 320.0f, 180.0f);
    }
    self.m_supplementDescriptionView             = [[UITextView alloc] initWithFrame:supplementDescriptionViewFrame];
    self.m_supplementDescriptionView.backgroundColor = [UIColor whiteColor];
    self.m_supplementDescriptionView.scrollEnabled   = YES;
    self.m_supplementDescriptionView.font            = [UIFont customFontWithSize:12];
    self.m_supplementDescriptionView.textColor       = [UIColor darkGrayColor];
    self.m_supplementDescriptionView.editable        = NO;
    [self.view addSubview:self.m_supplementDescriptionView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUpViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    // We need to remove underscore from the image name
    NSString *underscore                        = @"_";
    self.m_imageNameString                           = [NSString getSupplementImageName];
    // Remove underscore from the image name
    self.m_imageNameString                           = [self.m_imageNameString stringByReplacingOccurrencesOfString:underscore withString:@" "];
    
    NSString *supplementName;
    // Display exercise name with first letter of the each words capatalized
    supplementName                              = [self removeWhiteSpaceBeforeFirstWord:[self capatalizeFirstLetterOfWordsOfExerciseName:self.m_imageNameString]];
    self.m_supplementNameLabel.text                  = supplementName;
    
    // Display this image
    self.m_imageNameString                           = [NSString stringWithFormat:@"%@.png", [NSString getSupplementImageName]];
    UIImage *imageName                          = [UIImage imageNamed:self.m_imageNameString];
    [self.m_supplementImageView setImage:imageName];
    
    if ((supplementName != NULL) && (supplementName.length != 0)) {

        if (!self.m_supplementPlanSelection) {
            self.m_supplementPlanSelection               = [SupplementPlanSelection sharedInstance];
        }
        self.m_supplementDescriptionDictionary           = [[NSMutableDictionary alloc] init];
        
        // Load array from the plist having same image name
        self.m_supplementDescriptionDictionary           = [self.m_supplementPlanSelection loadUpPlist:[supplementName lowercaseString]];
        
        [self setUpSupplementItemDescription:self.m_supplementDescriptionDictionary];
    }
    
       [self addSelectorToControlButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
