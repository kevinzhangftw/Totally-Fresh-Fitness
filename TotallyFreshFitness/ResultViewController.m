//
//  ResultViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-10-15.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "ResultViewController.h"
#import "CalenderViewController.h"

@interface ResultViewController ()

// Move to CalenderViewController
- (void)moveToCalenderViewController:(id)sender;

@end

@implementation ResultViewController

// CalenderViewController class object
CalenderViewController *m_calenderViewController;
// GenderViewController class object
GenderViewController *m_genderViewController;
// ViewFactory class object
ViewFactory *m_controllerViews;
// ViewTransitions clas object
ViewTransitions *m_transition;
// Result page images
NSMutableArray *m_resultPageImages;

// Help pop up button
UIButton *m_helpPopUpButtonView;
// NSUserDefault
NSUserDefaults *userDefaults;

// Buttons
UIButton *m_moreEnergyAndCreativity;
UIButton *m_optimumConditionForMarathon;
UIButton *m_lookGoodNaked;
UIButton *m_increaseStrengthAndSize;
UIButton *m_increaseSpeedAndStamina;
UILabel *m_moreEnergyAndCreativityLabel;
UILabel *m_optimumConditionForMarathonLabel;
UILabel *m_lookGoodNakedLabel;
UILabel *m_increaseStrengthAndSizeLabel;
UILabel *m_increaseSpeedAndStaminaLabel;
UIImageView *m_moreEnergyAndCreativityImageView;
UIImageView *m_optimumConditionForMarathonImageView;
UIImageView *m_lookGoodNakedImageView;
UIImageView *m_increaseStrengthAndSizeImageView;
UIImageView *m_increaseSpeedAndStaminaImageView;
UIButton *m_nextButton;
UIButton *m_previousButton;

/*
 Singleton ResultViewController object
 */
+ (ResultViewController *)sharedInstance {
	static ResultViewController *globalInstance;
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
    if (!m_transition) {
        m_transition                    = [ViewTransitions sharedInstance];
    }
    [m_transition performTransitionFromRight:self.view.superview];
    [self.view removeFromSuperview];

}


/*
 Move to CalenderViewController
 */
- (void)moveToCalenderViewController:(id)sender
{
    if (!m_calenderViewController) {
        m_calenderViewController            = [CalenderViewController sharedInstance];
    }
    id instanceObject               = m_calenderViewController;
    [self moveToView:m_calenderViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}


/*
 Move to GenderViewController
 */
- (void)moveToGenderViewController:(id)sender
{
    if (!m_genderViewController) {
        m_genderViewController           = [GenderViewController sharedInstance];
    }
    id instanceObject               = m_genderViewController;
    [self moveToView:m_genderViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Update image for the first button
 */
- (void)clickMoreEnergyButtonAndCreativity:(id)sender
{
    if (m_moreEnergyAndCreativity.tag == 0) {
        [m_moreEnergyAndCreativity setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        m_moreEnergyAndCreativity.tag   = 1;
        m_moreEnergyAndCreativityLabel.textColor        = [UIColor redColor];
        m_moreEnergyAndCreativityImageView.image        = [UIImage imageNamed:@"red_check.png"];
    }
    else {
        [m_moreEnergyAndCreativity setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        m_moreEnergyAndCreativity.tag   = 0;
        m_moreEnergyAndCreativityLabel.textColor        = [UIColor blackColor];
        m_moreEnergyAndCreativityImageView.image        = [UIImage imageNamed:@"unchecked.png"];
    }
}

/*
 Update image for the second button
 */
- (void)clickOptimumConditionForMarathon:(id)sender
{
    if (m_optimumConditionForMarathon.tag == 0) {
        [m_optimumConditionForMarathon setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        m_optimumConditionForMarathon.tag   = 1;
        m_optimumConditionForMarathonLabel.textColor        = [UIColor redColor];
        m_optimumConditionForMarathonImageView.image        = [UIImage imageNamed:@"red_check.png"];
    }
    else {
        [m_optimumConditionForMarathon setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        m_optimumConditionForMarathon.tag   = 0;
        m_optimumConditionForMarathonLabel.textColor        = [UIColor blackColor];
        m_optimumConditionForMarathonImageView.image        = [UIImage imageNamed:@"unchecked.png"];
    }
}

/*
 Update image for the third button
 */
- (void)clickLookGoodNaked:(id)sender
{
    if (m_lookGoodNaked.tag == 0) {
        [m_lookGoodNaked setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        m_lookGoodNaked.tag   = 1;
        m_lookGoodNakedLabel.textColor        = [UIColor redColor];
        m_lookGoodNakedImageView.image        = [UIImage imageNamed:@"red_check.png"];
    }
    else {
        [m_lookGoodNaked setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        m_lookGoodNaked.tag   = 0;
        m_lookGoodNakedLabel.textColor        = [UIColor blackColor];
        m_lookGoodNakedImageView.image        = [UIImage imageNamed:@"unchecked.png"];
    }
}

/*
 Update image for the fourth button
 */
- (void)clickIncreaseStrengthAndSize:(id)sender
{
    if (m_increaseStrengthAndSize.tag == 0) {
        [m_increaseStrengthAndSize setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        m_increaseStrengthAndSize.tag   = 1;
        m_increaseStrengthAndSizeLabel.textColor        = [UIColor redColor];
        m_increaseStrengthAndSizeImageView.image        = [UIImage imageNamed:@"red_check.png"];
    }
    else {
        [m_increaseStrengthAndSize setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        m_increaseStrengthAndSize.tag   = 0;
        m_increaseStrengthAndSizeLabel.textColor        = [UIColor blackColor];
        m_increaseStrengthAndSizeImageView.image        = [UIImage imageNamed:@"unchecked.png"];
    }
}

/*
 Update image for the fifth button
 */
- (void)clickIncreaseSpeedAndStamina:(id)sender
{
    if (m_increaseSpeedAndStamina.tag == 0) {
        [m_increaseSpeedAndStamina setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        m_increaseSpeedAndStamina.tag   = 1;
        m_increaseSpeedAndStaminaLabel.textColor        = [UIColor redColor];
        m_increaseSpeedAndStaminaImageView.image        = [UIImage imageNamed:@"red_check.png"];
    }
    else {
        [m_increaseSpeedAndStamina setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        m_increaseSpeedAndStamina.tag   = 0;
        m_increaseSpeedAndStaminaLabel.textColor        = [UIColor blackColor];
        m_increaseSpeedAndStaminaImageView.image        = [UIImage imageNamed:@"unchecked.png"];
    }
}

- (void)helpButtonClicked
{
    userDefaults        = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:1 forKey:@"Result_Help"];
    [userDefaults synchronize];
    
    [m_helpPopUpButtonView removeFromSuperview];
    m_moreEnergyAndCreativity.userInteractionEnabled        = YES;
    m_optimumConditionForMarathon.userInteractionEnabled        = YES;
    m_lookGoodNaked.userInteractionEnabled      = YES;
    m_increaseStrengthAndSize.userInteractionEnabled        = YES;
    m_increaseSpeedAndStamina.userInteractionEnabled        = YES;
    m_previousButton.userInteractionEnabled     = YES;
    m_nextButton.userInteractionEnabled     = YES;
    self.backButton.userInteractionEnabled      = YES;
}

- (void)createHelpPopUp
{
    CGRect helpPopUpButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        helpPopUpButtonFrame     = CGRectMake(0.0f, 0.0f, 320.0f, 568.0f);
        m_helpPopUpButtonView       = [[UIButton alloc] initWithFrame:helpPopUpButtonFrame];
        [m_helpPopUpButtonView setBackgroundImage:[UIImage imageNamed:@"result_instruction_i5.png"] forState:UIControlStateNormal];
    }
    else {
        helpPopUpButtonFrame     = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
        m_helpPopUpButtonView       = [[UIButton alloc] initWithFrame:helpPopUpButtonFrame];
        [m_helpPopUpButtonView setBackgroundImage:[UIImage imageNamed:@"result_instruction.png"] forState:UIControlStateNormal];
    }
    [self.view addSubview:m_helpPopUpButtonView];
    [m_helpPopUpButtonView addTarget:self action:@selector(helpButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    m_moreEnergyAndCreativity.userInteractionEnabled        = NO;
    m_optimumConditionForMarathon.userInteractionEnabled        = NO;
    m_lookGoodNaked.userInteractionEnabled      = NO;
    m_increaseStrengthAndSize.userInteractionEnabled        = NO;
    m_increaseSpeedAndStamina.userInteractionEnabled        = NO;
    m_previousButton.userInteractionEnabled     = NO;
    m_nextButton.userInteractionEnabled     = NO;
    self.backButton.userInteractionEnabled      = NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        CGRect m_backgroundImageViewFrame   = self.backgroundImageView.frame;
        [self.backgroundImageView removeFromSuperview];
        m_backgroundImageViewFrame.size.height  = m_backgroundImageViewFrame.size.height + 91.0f;
        self.backgroundImageView            = [[UIImageView alloc] initWithFrame:m_backgroundImageViewFrame];
        self.backgroundImageView.image      = [UIImage imageNamed:@"result_background.png"];
        [self.view addSubview:self.backgroundImageView];
    }
    // Custom initialization
    CGRect m_firstButtonFrame;
    
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_firstButtonFrame           = CGRectMake(0.0f, 60.0f, 320.0f, 86.0f);
    }
    else {
        m_firstButtonFrame           = CGRectMake(0.0f, 60.0f, 320.0f, 70.0f);
    }
    m_moreEnergyAndCreativity           = [[UIButton alloc] initWithFrame:m_firstButtonFrame];
    [m_moreEnergyAndCreativity setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [m_moreEnergyAndCreativity addTarget:self action:@selector(clickMoreEnergyButtonAndCreativity:) forControlEvents:UIControlEventTouchUpInside];
    m_moreEnergyAndCreativity.tag       = 0;
    [self.view addSubview:m_moreEnergyAndCreativity];
    
    CGRect m_moreEnergyAndCreativityLabelFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_moreEnergyAndCreativityLabelFrame  = CGRectMake(15.0f, 65.0f, 160.0f, 76.0f);
    }
    else {
        m_moreEnergyAndCreativityLabelFrame  = CGRectMake(15.0f, 63.0f, 160.0f, 66.0f);
    }
    m_moreEnergyAndCreativityLabel     = [[UILabel alloc] initWithFrame:m_moreEnergyAndCreativityLabelFrame];
    m_moreEnergyAndCreativityLabel.text     = @"More Energy and Creativity";
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_moreEnergyAndCreativityLabel.font     = [UIFont customFontWithSize:22.0f];
    }
    else {
        m_moreEnergyAndCreativityLabel.font     = [UIFont customFontWithSize:20.0f];
    }
    m_moreEnergyAndCreativityLabel.numberOfLines    = 2;
    m_moreEnergyAndCreativityLabel.lineBreakMode    = NSLineBreakByWordWrapping;
    m_moreEnergyAndCreativityLabel.backgroundColor  = [UIColor clearColor];
    [self.view addSubview:m_moreEnergyAndCreativityLabel];
    
    CGRect m_moreEnergyAndCreativityImageViewFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_moreEnergyAndCreativityImageViewFrame  = CGRectMake(260.0f, 85.0f, 50.0f, 41.0f);
    }
    else {
        m_moreEnergyAndCreativityImageViewFrame  = CGRectMake(260.0f, 80.0f, 45.0f, 39.0f);
    }
    m_moreEnergyAndCreativityImageView              = [[UIImageView alloc] initWithFrame:m_moreEnergyAndCreativityImageViewFrame];
    m_moreEnergyAndCreativityImageView.image        = [UIImage imageNamed:@"unchecked.png"];
    [self.view addSubview:m_moreEnergyAndCreativityImageView];

    
    CGRect m_firstButtonSeperatorFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_firstButtonSeperatorFrame  = CGRectMake(0.0f, 147.0f, 320.0f, 1.5f);
    }
    else {
        m_firstButtonSeperatorFrame  = CGRectMake(0.0f, 131.0f, 320.0f, 1.5f);
    }
    UIImageView *firstButtonSeperatorImageView  = [[UIImageView alloc] initWithFrame:m_firstButtonSeperatorFrame];
    firstButtonSeperatorImageView.image = [UIImage imageNamed:@"seperator.png"];
    [self.view addSubview:firstButtonSeperatorImageView];

    CGRect m_secondButtonFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_secondButtonFrame          = CGRectMake(0.0f, 149.0f, 320.0f, 86.0f);
    }
    else {
        m_secondButtonFrame          = CGRectMake(0.0f, 133.0f, 320.0f, 70.0f);
    }
    m_optimumConditionForMarathon       = [[UIButton alloc] initWithFrame:m_secondButtonFrame];
    [m_optimumConditionForMarathon setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [m_optimumConditionForMarathon addTarget:self action:@selector(clickOptimumConditionForMarathon:) forControlEvents:UIControlEventTouchUpInside];
    m_optimumConditionForMarathon.tag   = 0;
    [self.view addSubview:m_optimumConditionForMarathon];

    CGRect m_optimumConditionForMarathonLabelFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_optimumConditionForMarathonLabelFrame  = CGRectMake(15.0f, 154.0f, 200.0f, 76.0f);
    }
    else {
        m_optimumConditionForMarathonLabelFrame  = CGRectMake(15.0f, 133.0f, 200.0f, 66.0f);
    }
    m_optimumConditionForMarathonLabel              = [[UILabel alloc] initWithFrame:m_optimumConditionForMarathonLabelFrame];
    m_optimumConditionForMarathonLabel.text         = @"Optimum Condition for Marathon";
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_optimumConditionForMarathonLabel.font         = [UIFont customFontWithSize:22.0f];
    }
    else {
        m_optimumConditionForMarathonLabel.font         = [UIFont customFontWithSize:20.0f];
    }
    m_optimumConditionForMarathonLabel.numberOfLines    = 2;
    m_optimumConditionForMarathonLabel.lineBreakMode    = NSLineBreakByWordWrapping;
    m_optimumConditionForMarathonLabel.backgroundColor  = [UIColor clearColor];
    [self.view addSubview:m_optimumConditionForMarathonLabel];
    
    CGRect m_optimumConditionForMarathonImageViewFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_optimumConditionForMarathonImageViewFrame  = CGRectMake(260.0f, 165.0f, 50.0f, 41.0f);
    }
    else {
        m_optimumConditionForMarathonImageViewFrame  = CGRectMake(260.0f, 150.0f, 45.0f, 39.0f);
    }
    m_optimumConditionForMarathonImageView              = [[UIImageView alloc] initWithFrame:m_optimumConditionForMarathonImageViewFrame];
    m_optimumConditionForMarathonImageView.image        = [UIImage imageNamed:@"unchecked.png"];
    [self.view addSubview:m_optimumConditionForMarathonImageView];
    
    CGRect m_secondButtonSeperatorFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_secondButtonSeperatorFrame  = CGRectMake(0.0f, 236.0f, 320.0f, 1.5f);
    }
    else {
        m_secondButtonSeperatorFrame  = CGRectMake(0.0f, 205.0f, 320.0f, 1.5f);
    }
    UIImageView *secondButtonSeperatorImageView  = [[UIImageView alloc] initWithFrame:m_secondButtonSeperatorFrame];
    secondButtonSeperatorImageView.image = [UIImage imageNamed:@"seperator.png"];
    [self.view addSubview:secondButtonSeperatorImageView];
    
    CGRect m_thirdButtonFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_thirdButtonFrame           = CGRectMake(0.0f, 238.0f, 320.0f, 86.0f);
    }
    else {
        m_thirdButtonFrame           = CGRectMake(0.0f, 202.0f, 320.0f, 70.0f);
    }
    m_lookGoodNaked                     = [[UIButton alloc] initWithFrame:m_thirdButtonFrame];
    [m_lookGoodNaked setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [m_lookGoodNaked addTarget:self action:@selector(clickLookGoodNaked:) forControlEvents:UIControlEventTouchUpInside];
    m_lookGoodNaked.tag                 = 0;
    [self.view addSubview:m_lookGoodNaked];
    
    CGRect m_lookGoodNakedLabelFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_lookGoodNakedLabelFrame  = CGRectMake(15.0f, 243.0f, 200.0f, 76.0f);
    }
    else {
        m_lookGoodNakedLabelFrame  = CGRectMake(15.0f, 205.0f, 200.0f, 66.0f);
    }
    m_lookGoodNakedLabel              = [[UILabel alloc] initWithFrame:m_lookGoodNakedLabelFrame];
    m_lookGoodNakedLabel.text         = @"Look Good Naked";
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_lookGoodNakedLabel.font         = [UIFont customFontWithSize:22.0f];
    }
    else {
        m_lookGoodNakedLabel.font         = [UIFont customFontWithSize:20.0f];
    }
    m_lookGoodNakedLabel.numberOfLines    = 2;
    m_lookGoodNakedLabel.lineBreakMode    = NSLineBreakByWordWrapping;
    m_lookGoodNakedLabel.backgroundColor  = [UIColor clearColor];
    [self.view addSubview:m_lookGoodNakedLabel];
    
    CGRect m_lookGoodNakedImageViewFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_lookGoodNakedImageViewFrame  = CGRectMake(260.0f, 263.0f, 50.0f, 41.0f);
    }
    else {
        m_lookGoodNakedImageViewFrame  = CGRectMake(260.0f, 222.0f, 45.0f, 39.0f);
    }
    m_lookGoodNakedImageView              = [[UIImageView alloc] initWithFrame:m_lookGoodNakedImageViewFrame];
    m_lookGoodNakedImageView.image        = [UIImage imageNamed:@"unchecked.png"];
    [self.view addSubview:m_lookGoodNakedImageView];
    
    CGRect m_thirdButtonSeperatorFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_thirdButtonSeperatorFrame  = CGRectMake(0.0f, 325.0f, 320.0f, 1.5f);
    }
    else {
        m_thirdButtonSeperatorFrame  = CGRectMake(0.0f, 273.0f, 320.0f, 1.5f);
    }
    UIImageView *thirdButtonSeperatorImageView  = [[UIImageView alloc] initWithFrame:m_thirdButtonSeperatorFrame];
    thirdButtonSeperatorImageView.image = [UIImage imageNamed:@"seperator.png"];
    [self.view addSubview:thirdButtonSeperatorImageView];
    
    CGRect m_fourthButtonFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_fourthButtonFrame          = CGRectMake(0.0f, 327.0f, 320.0f, 86.0f);
    }
    else {
        m_fourthButtonFrame          = CGRectMake(0.0f, 275.0f, 320.0f, 70.0f);
    }
    m_increaseStrengthAndSize           = [[UIButton alloc] initWithFrame:m_fourthButtonFrame];
    [m_increaseStrengthAndSize setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [m_increaseStrengthAndSize addTarget:self action:@selector(clickIncreaseStrengthAndSize:) forControlEvents:UIControlEventTouchUpInside];
    m_increaseStrengthAndSize.tag       = 0;
    [self.view addSubview:m_increaseStrengthAndSize];
    
    CGRect m_increaseStrengthAndSizeLabelFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_increaseStrengthAndSizeLabelFrame  = CGRectMake(15.0f, 332.0f, 200.0f, 76.0f);
    }
    else {
        m_increaseStrengthAndSizeLabelFrame  = CGRectMake(15.0f, 275.0f, 200.0f, 66.0f);
    }
    m_increaseStrengthAndSizeLabel              = [[UILabel alloc] initWithFrame:m_increaseStrengthAndSizeLabelFrame];
    m_increaseStrengthAndSizeLabel.text         = @"Increase Strength and Size";
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_increaseStrengthAndSizeLabel.font         = [UIFont customFontWithSize:22.0f];
    }
    else {
        m_increaseStrengthAndSizeLabel.font         = [UIFont customFontWithSize:20.0f];
    }
    m_increaseStrengthAndSizeLabel.numberOfLines    = 2;
    m_increaseStrengthAndSizeLabel.lineBreakMode    = NSLineBreakByWordWrapping;
    m_increaseStrengthAndSizeLabel.backgroundColor  = [UIColor clearColor];
    [self.view addSubview:m_increaseStrengthAndSizeLabel];
    
    CGRect m_increaseStrengthAndSizeImageViewFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_increaseStrengthAndSizeImageViewFrame  = CGRectMake(260.0f, 352.0f, 50.0f, 41.0f);
    }
    else {
        m_increaseStrengthAndSizeImageViewFrame  = CGRectMake(260.0f, 297.0f, 45.0f, 39.0f);
    }
    m_increaseStrengthAndSizeImageView              = [[UIImageView alloc] initWithFrame:m_increaseStrengthAndSizeImageViewFrame];
    m_increaseStrengthAndSizeImageView.image        = [UIImage imageNamed:@"unchecked.png"];
    [self.view addSubview:m_increaseStrengthAndSizeImageView];
    
    CGRect m_fourthButtonSeperatorFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_fourthButtonSeperatorFrame  = CGRectMake(0.0f, 413.5f, 320.0f, 1.5f);
    }
    else {
        m_fourthButtonSeperatorFrame  = CGRectMake(0.0f, 346.0f, 320.0f, 1.5f);
    }
    UIImageView *fourthButtonSeperatorImageView  = [[UIImageView alloc] initWithFrame:m_fourthButtonSeperatorFrame];
    fourthButtonSeperatorImageView.image = [UIImage imageNamed:@"seperator.png"];
    [self.view addSubview:fourthButtonSeperatorImageView];
    
    CGRect m_fifthButtonFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_fifthButtonFrame           = CGRectMake(0.0f, 416.0f, 320.0f, 86.0f);
    }
    else {
        m_fifthButtonFrame           = CGRectMake(0.0f, 348.0f, 320.0f, 70.0f);
    }
    m_increaseSpeedAndStamina           = [[UIButton alloc] initWithFrame:m_fifthButtonFrame];
    [m_increaseSpeedAndStamina setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [m_increaseSpeedAndStamina addTarget:self action:@selector(clickIncreaseSpeedAndStamina:) forControlEvents:UIControlEventTouchUpInside];
    m_increaseSpeedAndStamina.tag       = 0;
    [self.view addSubview:m_increaseSpeedAndStamina];
    
    CGRect m_increaseSpeedAndStaminaLabelFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_increaseSpeedAndStaminaLabelFrame  = CGRectMake(15.0f, 417.0f, 200.0f, 76.0f);
    }
    else {
        m_increaseSpeedAndStaminaLabelFrame  = CGRectMake(15.0f, 348.0f, 200.0f, 66.0f);
    }
    m_increaseSpeedAndStaminaLabel              = [[UILabel alloc] initWithFrame:m_increaseSpeedAndStaminaLabelFrame];
    m_increaseSpeedAndStaminaLabel.text         = @"Increase Speed and Stamina";
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_increaseSpeedAndStaminaLabel.font         = [UIFont customFontWithSize:22.0f];
    }
    else {
        m_increaseSpeedAndStaminaLabel.font         = [UIFont customFontWithSize:20.0f];
    }
    m_increaseSpeedAndStaminaLabel.numberOfLines    = 2;
    m_increaseSpeedAndStaminaLabel.lineBreakMode    = NSLineBreakByWordWrapping;
    m_increaseSpeedAndStaminaLabel.backgroundColor  = [UIColor clearColor];
    [self.view addSubview:m_increaseSpeedAndStaminaLabel];
    
    CGRect m_increaseSpeedAndStaminaImageViewFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_increaseSpeedAndStaminaImageViewFrame  = CGRectMake(260.0f, 442.0f, 50.0f, 41.0f);
    }
    else {
        m_increaseSpeedAndStaminaImageViewFrame  = CGRectMake(260.0f, 368.0f, 45.0f, 39.0f);
    }
    m_increaseSpeedAndStaminaImageView              = [[UIImageView alloc] initWithFrame:m_increaseSpeedAndStaminaImageViewFrame];
    m_increaseSpeedAndStaminaImageView.image        = [UIImage imageNamed:@"unchecked.png"];
    [self.view addSubview:m_increaseSpeedAndStaminaImageView];
    
    CGRect m_nextButtonFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_nextButtonFrame            = CGRectMake(260.0f, 510.0f, 50.0f, 40.0f);
    }
    else {
        m_nextButtonFrame            = CGRectMake(260.0f, 430.0f, 50.0f, 40.0f);
    }
    m_nextButton                        = [[UIButton alloc] initWithFrame:m_nextButtonFrame];
    [m_nextButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [m_nextButton addTarget:self action:@selector(moveToCalenderViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:m_nextButton];
    
    CGRect m_previousButtonFrame;
    if ([UIScreen mainScreen].bounds.size.height == 568) {
        m_previousButtonFrame            = CGRectMake(15.0f, 510.0f, 50.0f, 40.0f);
    }
    else {
        m_previousButtonFrame            = CGRectMake(15.0f, 430.0f, 50.0f, 40.0f);
    }
    m_previousButton                        = [[UIButton alloc] initWithFrame:m_previousButtonFrame];
    [m_previousButton addTarget:self action:@selector(moveToPreviousViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:m_previousButton];
    
    userDefaults        = [NSUserDefaults standardUserDefaults];
    if (![userDefaults integerForKey:@"Result_Help"]) {
        // Add Help Pop Up
        [self createHelpPopUp];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
