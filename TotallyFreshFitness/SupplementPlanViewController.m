//
//  NutritionPlanViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/16/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "SupplementPlanViewController.h"
#import "NSString+FindImage.h"
#import "NSString+SupplementImageName.h"
#import "SupplementProfileViewController.h"
#import "SupplementOrderWebViewController.h"
#import "NSURL+SupplementOrder.h"
#import "RootViewController.h"
#import "Database.h"
#import "Goals.h"
#import "NSString+UserEmail.h"

@interface SupplementPlanViewController ()
// ProfileViewController class object
@property (strong, nonatomic)ProfileViewController *m_profileViewController;
// CalenderViewController class object
@property (strong, nonatomic)CalenderViewController *m_calenderViewController;
// MealViewController class object
@property (strong, nonatomic)MealViewController *m_mealViewController;
// ExerciseViewController class object
@property (strong, nonatomic)ExerciseViewController *m_exerciseViewController;
// MusicTracksViewController class object
@property (strong, nonatomic)MusicTracksViewController *m_musicTracksViewController;
// SupplementProfileViewController class object
@property (strong, nonatomic)SupplementProfileViewController *m_supplementProfileViewController;
// SupplementOrderWebViewController class object
@property (strong, nonatomic)SupplementOrderWebViewController *m_supplementOrderWebViewController;
// RootViewController class object
@property (strong, nonatomic)RootViewController *m_rootViewController;
// Database class object
@property (strong, nonatomic)Database *m_database;
// ViewTransition class object
@property (strong, nonatomic)ViewTransitions *m_transition;
// ViewFactory class object
@property (strong, nonatomic)ViewFactory *m_controllerViews;


// Supplement plan array
@property (strong, nonatomic)NSArray *m_supplementPlanArray;
// Supplement order array
@property (strong, nonatomic)NSMutableArray *m_supplementOrderArray;
// Supplement order images array
@property (strong, nonatomic)NSMutableArray *m_supplementOrderImagesArray;
// Supplement order links array
@property (strong, nonatomic)NSMutableArray *m_supplementOrderLinksArray;
// To avoid redisplay an already active view
@property (strong, nonatomic)NSString *m_checkWhichSupplementButtonWasClicked;
// Meal Table is Meal Plan or Meal List
@property (strong, nonatomic)NSString *m_mealPlanOrFoodListOnMealTable;
// User email from database
@property (strong, nonatomic)NSString *m_userEmail;
// Gender of user
@property (strong, nonatomic)NSString *m_gender;
// NSMutableArray of cells
@property (strong, nonatomic)NSMutableArray *m_arrayOfCells;
// If switch or disclosure
@property (nonatomic)BOOL isDisclosure;

@property (strong, nonatomic)NSString *m_goal;
//@property (strong, nonatomic)NSString *m_gender;

// Help pop up button
@property (strong, nonatomic)UIButton *m_helpPopUpButtonViewInSupplementPlanView;
// NSUserDefault
@property (strong, nonatomic)NSUserDefaults *userDefaults;

// Move to CalenderViewController
- (void)moveToCalenderViewController:(id)sender;
// Move to ExerciseViewController
- (void)moveToExerciseViewController:(id)sender;
// Move to MealViewController
- (void)moveToMealViewController:(id)sender;
// Move to SupplementOrderWebViewController
- (void)moveToSupplementOrderWebViewController:(id)sender;
// Move to MusicTracksViewController
- (void)moveToMusicTracksViewController:(id)sender;
// Move to RootViewController's view
- (IBAction)moveToRootViewController:(id)sender;
// Details of nutrition plan and nutrition order for the day
- (IBAction)planSection:(id)sender;
// Add methods to each control buttons
- (void)addSelectorToControlButtons;
//  Cell contents such as images, items and measurement displayed
- (void)cellContents:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath WithImageArray:(NSMutableArray *)imageArray AndKeyArray:(NSMutableArray *)keyArray AndValueArray:(NSMutableArray *)valueArray;
// Each section has its own images, key and value arrays
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath onTableView:tableView;

@end

@implementation SupplementPlanViewController


@synthesize controlsImageView;
@synthesize supplementPlanSectionButton;
@synthesize supplementOrderSectionButton;
@synthesize supplementPlanTableView;
//@synthesize supplementOrderTableView;
@synthesize indicatorView;
@synthesize bottomBarButton;
@synthesize musicPlayerButton;
@synthesize exercisePlanButton;
@synthesize calendarButton;
@synthesize mealPlanButton;
@synthesize nutritionPlanButton;
@synthesize messageButton;
@synthesize selectedImage;

/*
 Singleton NutritionPlanViewController object
 */
+ (SupplementPlanViewController *)sharedInstance {
	static SupplementPlanViewController *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
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
 Move to SupplementProfileViewController
 */
- (void)moveToSupplementProfileViewController:(id)sender
{
    if (!self.m_supplementProfileViewController) {
        self.m_supplementProfileViewController    = [SupplementProfileViewController sharedInstance];
    }
    
    id instanceObject               = self.m_supplementProfileViewController;
    [self moveToView:self.m_supplementProfileViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
}

/*
 Move to moveToSupplementOrderWebViewController
 */
- (void)moveToSupplementOrderWebViewController:(id)sender
{
    if (!self.m_supplementOrderWebViewController) {
        self.m_supplementOrderWebViewController    = [SupplementOrderWebViewController sharedInstance];
    }
    
    id instanceObject               = self.m_supplementOrderWebViewController;
    [self moveToView:self.m_supplementOrderWebViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];

}

/*
 Move to MusicTracksViewController
 */
- (IBAction)moveToRootViewController:(id)sender
{
    if (!self.m_rootViewController) {
        self.m_rootViewController                = [RootViewController sharedInstance];
    }
    
    id instanceObject               = self.m_rootViewController;
    [self moveToView:self.m_rootViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Show supplement order view
 */
- (void)showSupplementOrderView
{
    if (!self.m_transition) {
        self.m_transition    = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionFromRight:self.supplementOrderWebPlanView];

    self.m_checkWhichSupplementButtonWasClicked  = @"Supplement Order";
    self.controlsImageView.image            = [UIImage imageNamed:@"tfn_Supplementorder_active.png"];
    self.supplementOrderWebPlanView.hidden    = NO;
    self.toolBar.hidden = NO;
    self.supplementPlanTableView.hidden     = YES;
    //[self.supplementOrderTableView reloadData];
}

/*
 Details of meal plan and grocery list
 */
- (IBAction)planSection:(id)sender;
{

    
    if (!self.m_transition) {
        self.m_transition    = [ViewTransitions sharedInstance];
    }
    
    if ((sender == self.supplementPlanSectionButton) && ([self.m_checkWhichSupplementButtonWasClicked isEqualToString:@"Supplement Order"])) {
        self.m_checkWhichSupplementButtonWasClicked  = @"Supplement Plan";
        self.controlsImageView.image            = [UIImage imageNamed:@"tfn_Supplementplan_active.png"];
        [self.m_transition performTransitionFromLeft:self.supplementPlanTableView];
        self.supplementPlanTableView.hidden     = NO;
        self.toolBar.hidden = YES;
        self.supplementOrderWebPlanView.hidden    = YES;
        // Reload the data
        [self.supplementPlanTableView reloadData];
        // Refocus from the top
        [self.supplementPlanTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

        
    }
    else if([self.m_checkWhichSupplementButtonWasClicked isEqualToString:@"Supplement Plan"]) {
        [self showSupplementOrderView];

    }
}

/*
 Get Supplement details from the database
 */
- (void)getSupplementDetails
{
    self.m_supplementPlanArray         = [NSMutableArray loadUpSupplementPlan];
}

/*
 Get Supplement order list
 */
- (void)getSupplementOrderList
{
    self.m_supplementOrderArray        = [NSMutableArray loadUpSupplementOrder];
}

/*
 Get Supplement order images
 */
- (void)getSupplementOrderImages
{
    self.m_supplementOrderImagesArray  = [NSMutableArray loadUpSupplementOrderImages];
}

/*
 Get Supplement order links
 */
- (void)getSupplementOrderLinks
{
    self.m_supplementOrderLinksArray  = [NSMutableArray loadUpSupplementOrderLinks];
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
    // Stay here
    
    self.nutritionPlanButton            = [controlButtonArrays objectAtIndex:5];
    
    // Refresh the view
    [self.view setNeedsDisplay];
}

- (void)helpButtonClicked
{
    self.userDefaults        = [NSUserDefaults standardUserDefaults];
    [self.userDefaults setInteger:1 forKey:@"Supplement_Help"];
    [self.userDefaults synchronize];
    
    [self.m_helpPopUpButtonViewInSupplementPlanView removeFromSuperview];
    self.homeButton.userInteractionEnabled      = YES;
    self.supplementOrderSectionButton.userInteractionEnabled        = YES;
    self.supplementPlanSectionButton.userInteractionEnabled     = YES;
    self.supplementPlanTableView.userInteractionEnabled     = YES;
    self.supplementOrderWebPlanView.userInteractionEnabled        = YES;
}

- (void)createHelpPopUp
{
    CGRect helpPopUpButtonFrame;
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        helpPopUpButtonFrame     = CGRectMake(0.0f, 0.0f, 320.0f, 568.0f);
        self.m_helpPopUpButtonViewInSupplementPlanView       = [[UIButton alloc] initWithFrame:helpPopUpButtonFrame];
        [self.m_helpPopUpButtonViewInSupplementPlanView setBackgroundImage:[UIImage imageNamed:@"supplement_instruction_i5.png"] forState:UIControlStateNormal];
    }
    else {
        helpPopUpButtonFrame     = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
        self.m_helpPopUpButtonViewInSupplementPlanView       = [[UIButton alloc] initWithFrame:helpPopUpButtonFrame];
        [self.m_helpPopUpButtonViewInSupplementPlanView setBackgroundImage:[UIImage imageNamed:@"supplement_instruction.png"] forState:UIControlStateNormal];
    }
    [self.view addSubview:self.m_helpPopUpButtonViewInSupplementPlanView];
    [self.m_helpPopUpButtonViewInSupplementPlanView addTarget:self action:@selector(helpButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.homeButton.userInteractionEnabled      = NO;
    self.supplementOrderSectionButton.userInteractionEnabled        = NO;
    self.supplementPlanSectionButton.userInteractionEnabled     = NO;
    self.supplementPlanTableView.userInteractionEnabled     = NO;
    self.supplementOrderWebPlanView.userInteractionEnabled        = NO;

}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)getURL{
    self.m_database = [Database alloc];
    self.m_userEmail = [NSString getUserEmail];
    self.m_goal = [self.m_database getLatestExerciseGoal:self.m_userEmail];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    // Do any additional setup after loading the view from its nib.

    // adjust view and tableview size for iphone5
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        [self.supplementPlanTableView removeFromSuperview];
        self.supplementPlanTableView           = [self adjustiPhone5HeightOfTableView:self.supplementPlanTableView ForController:self];
        [self.view addSubview:self.supplementPlanTableView];

//        [self.supplementOrderTableView removeFromSuperview];
//        self.supplementOrderTableView           = [self adjustiPhone5HeightOfTableView:self.supplementOrderTableView ForController:self];
        //[self.view addSubview:self.supplementOrderTableView];
        
        // adjust the height of the tableview and readd the indicator view
        [self.indicatorView removeFromSuperview];
        self.indicatorView              = [self reAddActivityIndicatorforiPhone5:self.indicatorView];
        [self.view addSubview:self.indicatorView];
    }
    
    [self.messageButton removeFromSuperview];
    self.messageButton.titleLabel.font          = [UIFont customFontWithSize:13];
    self.messageButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messageButton.titleLabel.numberOfLines = 2;
    self.messageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.messageButton];
    
    // Refresh the control buttons
    [self addSelectorToControlButtons];

    // Get Supplement order list
    [self getSupplementOrderList];
    // Get Supplement order images
    [self getSupplementOrderImages];
    // Get Supplement order links
    [self getSupplementOrderLinks];
    
    // start indicator view on the tableview
    [self.indicatorView startAnimating];
    
    // The default view is "Meal Plan"
    self.m_checkWhichSupplementButtonWasClicked        = @"Supplement Plan";
    
    self.supplementOrderWebPlanView.hidden    = YES;
    self.toolBar.hidden = YES;

    self.userDefaults        = [NSUserDefaults standardUserDefaults];
    if (![self.userDefaults integerForKey:@"Supplement_Help"]) {
        // Add Help Pop Up
        [self createHelpPopUp];
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.m_database) {
        self.m_database                          = [Database alloc];
    }
    self.m_userEmail                             = [NSString getUserEmail];
    
    if (!self.m_arrayOfCells) {
        self.m_arrayOfCells                      = [NSMutableArray mutableArrayObject];
    }
    
    if (self.view.tag == 1) {
        // Get supplement plan details
        [self getSupplementDetails];
        [self.supplementPlanTableView reloadData];
    }
    else if(self.view.tag == 2){
        // Get supplement order details
        [self showSupplementOrderView];
    }
    
    NSURL *url;
    NSURLRequest *request;
    self.supplementOrderWebPlanView.delegate = self;

    self.m_goal = [self.m_database getLatestExerciseGoal:self.m_userEmail];
    self.m_gender = [self.m_database getGender:self.m_userEmail];
    NSLog(@"Gender: %@", self.m_gender);
    if([self.m_goal isEqualToString:@"SHRED FAT"] && [self.m_gender isEqualToString:@"Male"]){
        url = [NSURL URLWithString:@"http://www.totalfitness.com/shop/shredfatmen"];
        request = [NSURLRequest requestWithURL:url];
    }
    else if([self.m_goal isEqualToString:@"BUILD MUSCLE MASS"] && [self.m_gender isEqualToString:@"Male"]){
        url = [NSURL URLWithString:@"http://www.totalfitness.com/shop/buildmusclemen"];
        request = [NSURLRequest requestWithURL:url];
        
    }
             else if([self.m_goal isEqualToString:@"GET TONED"] && [self.m_gender isEqualToString:@"Male"]){
        url = [NSURL URLWithString:@"http://www.totalfitness.com/shop/buildmusclemen"];
        request = [NSURLRequest requestWithURL:url];
    }
    else if([self.m_goal isEqualToString:@"MUSCLE ISOLATION"] && [self.m_gender isEqualToString:@"Male"]){
        url = [NSURL URLWithString:@"http://www.totalfitness.com/shop/buildmusclemen"];
        request = [NSURLRequest requestWithURL:url];
    }
    else if([self.m_goal isEqualToString:@"SHRED FAT"] && [self.m_gender isEqualToString:@"Female"]){
        url = [NSURL URLWithString:@"http://www.totalfitness.com/shop/shredfatwomen"];
        request = [NSURLRequest requestWithURL:url];
    }
    else if([self.m_goal isEqualToString:@"BUILD MUSCLE MASS"] && [self.m_gender isEqualToString:@"Female"]){
        url = [NSURL URLWithString:@"http://www.totalfitness.com/shop/gettonedwomen"];
        request = [NSURLRequest requestWithURL:url];
        
    }
    else if([self.m_goal isEqualToString:@"GET TONED"] && [self.m_gender isEqualToString:@"Female"]){
        url = [NSURL URLWithString:@"http://www.totalfitness.com/shop/gettonedwomen"];
        request = [NSURLRequest requestWithURL:url];
    }
    else if([self.m_goal isEqualToString:@"MUSCLE ISOLATION"] && [self.m_gender isEqualToString:@"Female"]){
        url = [NSURL URLWithString:@"http://www.totalfitness.com/shop/gettonedwomen"];
        request = [NSURLRequest requestWithURL:url];
    }
    NSLog(@"URL: %@", url);
    [self.supplementOrderWebPlanView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSource
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Stop the indicatorview when cells are to be loaded
    [self.indicatorView stopAnimating];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView;
    headerView              = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    UILabel *label          = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    
    if (tableView == supplementPlanTableView) {
        if (section == 0) {
            label.text        = @"  Breakfast";
        }
        else if(section == 1) {
            label.text        = @"  Pre Workout";
        }
        else if(section == 2) {
            label.text        = @"  Post Workout";
        }
        else if(section == 3) {
            label.text        = @"  Before Bed";
        }
        else if(section == 4) {
            label.text        = @"  Order Now";
        }
    }

    label.textAlignment         = NSTextAlignmentLeft;
    label.textColor             = [UIColor redColor];
    label.backgroundColor       = [UIColor clearColor];
    label.font                  = [UIFont customFontWithSize:16];
    [headerView addSubview:label];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    CGRect sepFrame = CGRectMake(0, headerView.frame.size.height-1, 320, 1);
    UIView *seperatorView = [[UIView alloc] initWithFrame:sepFrame];
    seperatorView.backgroundColor = [UIColor redColor];
    [headerView addSubview:seperatorView];
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int numberOfSections;
    
    numberOfSections                = 5;
    
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger numberOfRowsInSection           = 0;
    if (tableView == supplementPlanTableView) {
        if(section == 4) {
            return numberOfRowsInSection    = 1;
        }
        else {
            return numberOfRowsInSection    = [[[self.m_supplementPlanArray objectAtIndex:section] objectAtIndex:0] count];
        }
    }
    return numberOfRowsInSection;
}

/*
 Cell contents such as images, items and measurement displayed for Meal Plan
 */
- (void)cellContents:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath WithImageArray:(NSMutableArray *)imageArray AndKeyArray:(NSMutableArray *)keyArray AndValueArray:(NSMutableArray *)valueArray
{
    UIImage *cellImage                                  = nil;
    if ([imageArray count] > 0) { // So that assessing empty array, doesn't crash the app
        cellImage                                       = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];     // Find the right image
    }
    ((UIImageView *)[cell viewWithTag:1]).image         = cellImage;
    if (!cellImage) { // If the there is no image displayed then, there isn't any food item for that
        cell.accessoryType                              = UITableViewCellAccessoryNone;
        [cell setUserInteractionEnabled:NO];
    }
    else if(indexPath.section == 6) { // Total calories cell should be interaction disabled
        cell.accessoryType                              = UITableViewCellAccessoryNone;
        [cell setUserInteractionEnabled:NO];
    }
    else { // Cell the set have the accessory and interaction as well to avoid remaining disabled from the above if
        // Customize accessoryView
        [cell setUserInteractionEnabled:YES];
    }
    ((UILabel *)[cell viewWithTag:2]).text              = [keyArray objectAtIndex:indexPath.row];
    
    if ([[valueArray objectAtIndex:indexPath.row] isEqualToString:@"Empty Space"]) {
        ((UILabel *)[cell viewWithTag:3]).text      = @"";
    }
    else {
        ((UILabel *)[cell viewWithTag:3]).text      = [valueArray objectAtIndex:indexPath.row];
    }
}

/*
 Each section has its own images, key and value arrays
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath onTableView:tableView
{
    if (tableView == supplementPlanTableView) {
        if(indexPath.section == 4) { // Order Now section
            [self cellContents:cell atIndexPath:indexPath WithImageArray:nil AndKeyArray:nil AndValueArray:nil];
            ((UIImageView *)[cell viewWithTag:1]).image = [UIImage imageNamed:@"order_now"];
            ((UILabel *)[cell viewWithTag:2]).text      = @"Order Now";
            [cell setUserInteractionEnabled:YES];
        }
        else {
            [self cellContents:cell atIndexPath:indexPath WithImageArray:[[self.m_supplementPlanArray objectAtIndex:indexPath.section] objectAtIndex:0] AndKeyArray:[[self.m_supplementPlanArray objectAtIndex:indexPath.section] objectAtIndex:1] AndValueArray:[[self.m_supplementPlanArray objectAtIndex:indexPath.section] objectAtIndex:2]];
        }
    }
//    else {
//        [self cellContents:cell atIndexPath:indexPath WithImageArray:m_supplementOrderImagesArray AndKeyArray:m_supplementOrderArray AndValueArray:nil];
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SupplementIdentifier         = @"SupplementIdentifier";
    UITableViewCell *cell                         = [tableView dequeueReusableCellWithIdentifier:SupplementIdentifier];
    
    if (cell == nil) {
        cell                                      = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SupplementIdentifier];

        // there is no check button, so position from the left
        UIImageView *supplementImageView            = [[UIImageView alloc] initWithFrame: CGRectMake(10,5,75,75)];
        supplementImageView.tag                     = 1; // Need to add outside the if statment
        [cell.contentView addSubview:supplementImageView];
        
        // adjust the position to accommodate the calorie text label
        UILabel *supplementTextLabel                = [[UILabel alloc] initWithFrame:CGRectMake(95, 0, 180, 60)];
        supplementTextLabel.font                    = [UIFont customFontWithSize:15];
        supplementTextLabel.lineBreakMode           = NSLineBreakByWordWrapping;
        supplementTextLabel.numberOfLines           = 3;
        supplementTextLabel.textAlignment           = NSTextAlignmentLeft;
        supplementTextLabel.textColor               = [UIColor blackColor];
        supplementTextLabel.tag                     = 2; // Need to add outside the if statment
        [cell.contentView addSubview:supplementTextLabel];
        
        //  Position the detail text label
        UILabel *theDetailTextLabel               = [[UILabel alloc] initWithFrame:CGRectMake(95, 45, 180, 20)];
        theDetailTextLabel.font                   = [UIFont customFontWithSize:10];
        theDetailTextLabel.lineBreakMode          = NSLineBreakByWordWrapping;
        theDetailTextLabel.numberOfLines          = 2;
        theDetailTextLabel.textAlignment          = NSTextAlignmentLeft;
        theDetailTextLabel.textColor              = [UIColor blackColor];
        theDetailTextLabel.tag                    = 3; // Need to add outside the if statment
        [cell.contentView addSubview:theDetailTextLabel];
    }
    // Configure the cell.
    
    // Remove the default blue selction color with clear color
    UIImageView *cellBackgroundSelectionColor          = [[UIImageView alloc] init];
    cellBackgroundSelectionColor.backgroundColor       = [UIColor clearColor];
    cell.selectedBackgroundView                        = cellBackgroundSelectionColor;
    
    // Neccessary to use tag to add content to avoid overwritting by reference the imageview and label outside the if(cell == nil) statement
    
    [self configureCell:cell atIndexPath:indexPath onTableView:tableView];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float heightForRow                  = 80.0f;
    return heightForRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    float heightForHeaderSection;
    heightForHeaderSection  = 30.0f;
    return heightForHeaderSection;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedImage) {
        self.selectedImage      = nil;
    }

    if (tableView == supplementPlanTableView) {
        // assign image for the next view
        if (indexPath.section == 4) {
            [self showSupplementOrderView];
        }
        else {
            self.selectedImage         = [[NSString alloc ] initWithFormat:@"%@",[[[self.m_supplementPlanArray objectAtIndex:indexPath.section] objectAtIndex:0]  objectAtIndex:indexPath.row]];
            // Set supplementImage name
            [NSString setSupplementImageName:self.selectedImage];
            
            // Move to SupplementProfileViewController
            [self moveToSupplementProfileViewController:indexPath];
        }
    }
//    else {
//        [NSURL setSupplementOrderUrl:[m_supplementOrderLinksArray objectAtIndex:indexPath.row]];
////        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[m_supplementOrderLinksArray objectAtIndex:indexPath.row]]];
//        [self moveToSupplementOrderWebViewController:self];
//    }
    // Unselect the row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
