//
//  SwitchPlanItemViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2013-03-09.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "SwitchPlanItemViewController.h"
#import "SwitchPlanItemSelection.h"
#import "NSString+FindImage.h"
#import "NSString+FoodToSwitch.h"
#import "NSString+ExerciseToSwitch.h"

@interface SwitchPlanItemViewController ()

// CalenderViewController class object
@property (strong, nonatomic)CalenderViewController *m_calenderViewController;
// ExerciseViewController class object
@property (strong, nonatomic)ExerciseViewController *m_exerciseViewController;
// MealViewContrioller class object
@property (strong, nonatomic)MealViewController *m_mealViewController;
// MusicTracksViewController class object
@property (strong, nonatomic)MusicTracksViewController *m_musicTracksViewController;
// SupplementPlanViewController class object
@property (strong, nonatomic)SupplementPlanViewController *m_supplementPlanViewController;
// ViewTransition class object
@property (strong, nonatomic)ViewTransitions *m_transition;
// Database class object
@property (strong, nonatomic)Database *m_database;
// SwitchPlanItemSelection class object
@property (strong, nonatomic)SwitchPlanItemSelection *m_switchPlanItemSelection;

// Plan Mutable images array
@property (strong, nonatomic)NSMutableArray *m_planImagesArray;
// Plan Mutable Key array
@property (strong, nonatomic)NSMutableArray *m_planItemArray;
// Plan Mutable Value array
@property (strong, nonatomic)NSMutableArray *m_planDetailArray;
// Selected plan item
@property (strong, nonatomic)NSString *m_selectedPlanItem;
// Selected plan details
@property (strong, nonatomic)NSString *m_selectedPlanDetails;
// User email address
@property (strong, nonatomic)NSString *m_userEmail;
// days selected array
@property (strong, nonatomic)NSMutableArray *m_daysArray;

// Move to CalenderViewController
- (void)moveToCalenderViewController:(id)sender;
// Move to ExerciseViewController
- (void)moveToExerciseViewController:(id)sender;
// Move to MealViewController
- (void)moveToMealViewController:(id)sender;
// Move to supplements at website
- (void)moveToSupplementsAtWebsite:(id)sender;
// Move to MusicTracksViewController
- (void)moveToMusicTracksViewController:(id)sender;
// Move to SupplementPlanViewController
- (void)moveToSupplementPlanViewController:(id)sender;
// Display message to user
- (void)displayMessage:(NSString *)message;
// update workout plan for the selected day with selected exercise
- (NSString *)updateWorkoutPlanWithExercise:(NSString *)excercise andDetails:(NSString *)details forDay:(int)selectedSection;

@end

@implementation SwitchPlanItemViewController



@synthesize messageButton;
@synthesize theTableView;
@synthesize checkedIndexPath;
@synthesize indicatorView;
@synthesize bottomBarButton;
@synthesize musicPlayerButton;
@synthesize exercisePlanButton;
@synthesize calendarButton;
@synthesize mealPlanButton;
@synthesize nutritionPlanButton;

/*
 Singleton SwitchPlanItemViewController object
 */
+ (SwitchPlanItemViewController *)sharedInstance {
	static SwitchPlanItemViewController *globalInstance;
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


- (void)moveToSupplementsAtWebsite:(id)sender
{
    NSURL *url                  = [[NSURL alloc] initWithString:@"http://totalfitness.com/supplements"];
    [[UIApplication sharedApplication] openURL:url];

}

/*
 Display message to user with animation
 */
- (void)displayMessage:(NSString *)message
{
    self.messageButton.hidden  = NO;
    
    [UIButton animateWithDuration:3.0f animations:^{self.messageButton.alpha = 5.0;} completion:nil];
    
    [self.messageButton setTitle:message forState:UIControlStateNormal];
    
    if (!self.m_transition) {
        self.m_transition    = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionFromBottom:self.messageButton];
    
    if(self.view.tag == 1) { // if meal plan
        [UIButton animateWithDuration:3.0f animations:^{self.messageButton.alpha = 0.0;} completion:^(BOOL finished){
            [self moveToMealViewController:self];
        }];
    }
    else if(self.view.tag == 2) { // if workout plan
        [UIButton animateWithDuration:3.0f animations:^{self.messageButton.alpha = 0.0;} completion:^(BOOL finished){
            [self moveToExerciseViewController:self];
        }];
    }
}

/*
 meal plan images assigned to be displayed
 */
- (void)getImagesforMealPlanItems
{
    NSUInteger numberOfItems                    = [self.m_planItemArray count];
    for (int i = 0; i < numberOfItems; i++) {
        // First remove whitespace at the end
        [self.m_planImagesArray addObject:[NSString findImageForMealPlan:[[self.m_planItemArray objectAtIndex:i] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]]]; // add meal images
    }
}

// Find the right image for the cell for workout
- (NSString *)findImageForWorkoutSub:(NSString *)possibleImageName
{
    // Add gender to the image name
    possibleImageName         = [NSString stringWithFormat:@"%@ %@", possibleImageName, [NSString getGenderOfUser]];
    // make the strings lowercase to match image names
    possibleImageName           = [possibleImageName lowercaseString];
    NSString *imageName         = [possibleImageName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    imageName                   = [[NSString stringWithFormat:@"%@_thumb",imageName] lowercaseString];
    //UIImage *cellImage          = [UIImage imageNamed:imageName];
    UIImage *cellImage = [self imageWithFilename:imageName];
    
    if (cellImage) {
        return imageName;
    }
    else {
        return imageName        = @"No Image";
    }
}

/*
 workout plan images assigned to be displayed
 */
- (void)getImagesforWorkoutPlanItems
{
    NSUInteger numberOfItems                    = [self.m_planItemArray count];
    for (int i = 0; i < numberOfItems; i++) {
        // First remove whitespace at the end
        [self.m_planImagesArray addObject:[NSString findImageForWorkout:[NSString stringWithFormat:@"%@",[[self.m_planItemArray objectAtIndex:i] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]]]]; // add workout images
    }
}

/*
 update workout plan for the selected day with selected exercise
 */
- (NSString *)updateWorkoutPlanWithExercise:(NSString *)excercise andDetails:(NSString *)details forDay:(int)selectedSection
{
    // to match with exercise name stored in database
    excercise                       = [excercise capitalizedString];
    excercise = [excercise stringByReplacingOccurrencesOfString:@".Png" withString:@""];

    NSString *status                = @"";
    if (!self.m_database) {
        self.m_database                  = [Database alloc];
    }
    if (!self.m_userEmail) {
        self.m_userEmail                 = [NSString getUserEmail];
    }

    if (!self.m_daysArray) {
        self.m_daysArray                 = [NSMutableArray mutableArrayObject];
    }
    if (!self.m_database) {
        self.m_daysArray                 = [self.m_database getLatestExerciseDays:self.m_userEmail]; // Get latest selected days
    }
    NSMutableArray *daysArray       = [NSMutableArray mutableArrayObject];

    for (int i = 0; i < [self.m_daysArray count]; i++) {
        if ([[self.m_daysArray objectAtIndex:i] isEqualToString:@"YES"]) {
            [daysArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }

    if (([excercise length] != 0) || (excercise != NULL )) { // if workout item plan is not empty or null
        if ([[daysArray objectAtIndex:selectedSection] isEqualToString:@"0"]) {
            status                      = [self.m_database updateFirstDayWorkOut:excercise Details:details forUser:self.m_userEmail];
            if ([status isEqualToString:@"deleted"]) {
                status                  = [self.m_database insertIntoFirstDayWorkOut:self.m_selectedPlanItem Details:details forUser:self.m_userEmail];
            }
        }
        else if ([[daysArray objectAtIndex:selectedSection] isEqualToString:@"1"]) {
            status                      = [self.m_database updateSecondDayWorkOut:excercise Details:details forUser:self.m_userEmail];
            if ([status isEqualToString:@"deleted"]) {
                status                  = [self.m_database insertIntoSecondDayWorkOut:self.m_selectedPlanItem Details:details forUser:self.m_userEmail];
            }
        }
        else if ([[daysArray objectAtIndex:selectedSection] isEqualToString:@"2"]) {
            status                      = [self.m_database updateThirdDayWorkOut:excercise Details:details forUser:self.m_userEmail];
            if ([status isEqualToString:@"deleted"]) {
                status                  = [self.m_database insertIntoThirdDayWorkOut:self.m_selectedPlanItem Details:details forUser:self.m_userEmail];
            }
        }
        else if ([[daysArray objectAtIndex:selectedSection] isEqualToString:@"3"]) {
            status                      = [self.m_database updateFourthDayWorkOut:excercise Details:details forUser:self.m_userEmail];
            if ([status isEqualToString:@"deleted"]) {
                status                  = [self.m_database insertIntoFourthDayWorkOut:self.m_selectedPlanItem Details:details forUser:self.m_userEmail];
            }
        }
        else if ([[daysArray objectAtIndex:selectedSection] isEqualToString:@"4"]) {
            status                      = [self.m_database updateFifthDayWorkOut:excercise Details:details forUser:self.m_userEmail];
            if ([status isEqualToString:@"deleted"]) {
                status                  = [self.m_database insertIntoFifthDayWorkOut:self.m_selectedPlanItem Details:details forUser:self.m_userEmail];
            }
        }
        else if ([[daysArray objectAtIndex:selectedSection] isEqualToString:@"5"]) {
            status                      = [self.m_database updateSixthDayWorkOut:excercise Details:details forUser:self.m_userEmail];
            if ([status isEqualToString:@"deleted"]) {
                status                  = [self.m_database insertIntoSixthDayWorkOut:self.m_selectedPlanItem Details:details forUser:self.m_userEmail];
            }
        }
        else if ([[daysArray objectAtIndex:selectedSection] isEqualToString:@"6"]) {
            status                      = [self.m_database updateSeventhDayWorkOut:excercise Details:details forUser:self.m_userEmail];
            if ([status isEqualToString:@"deleted"]) {
                status                  = [self.m_database insertIntoSeventhDayWorkOut:self.m_selectedPlanItem Details:details forUser:self.m_userEmail];
            }
        }
    }
    else { // if empty or null
        [self displayMessage:@"No exercise selected, please try again"];
    }
    return status;
}

/*
 Switch food items
 */
- (IBAction)switchPlanItems:(id)sender
{
    if (!self.m_database) {
        self.m_database                  = [Database alloc];
    }
    if (!self.m_userEmail) {
        self.m_userEmail                 = [NSString getUserEmail];
    }
    
    NSString *status;

    if (self.view.tag == 1) { // Meal plan switch
        if (!self.m_mealViewController) {
            self.m_mealViewController        = [MealViewController alloc];
        }
        if (([self.m_selectedPlanItem length] != 0) || (self.m_selectedPlanItem != NULL)) { // if selected meal plan is not empty or null

            if (self.m_mealViewController.selectedSection == 0) {
                status                      = [self.m_database updateBreakfastFood:[NSString getFoodItemToSwitch] Quantity:[NSString stringWithFormat:@"%lu", (unsigned long)self.m_mealViewController.selectedSection] forUser:self.m_userEmail];
                if ([status isEqualToString:@"deleted"]) {
                    status                  = [self.m_database insertIntoBreakfastFood:self.m_selectedPlanItem Quantity:self.m_selectedPlanDetails forUser:self.m_userEmail];
                }
            }
            else if(self.m_mealViewController.selectedSection == 1) {
                status                      = [self.m_database updateFirstSnackFood:[NSString getFoodItemToSwitch] Quantity:[NSString stringWithFormat:@"%lu", (unsigned long)self.m_mealViewController.selectedSection] forUser:self.m_userEmail];
                if ([status isEqualToString:@"deleted"]) {
                    status                  = [self.m_database insertIntoFirstSnackFood:self.m_selectedPlanItem Quantity:self.m_selectedPlanDetails forUser:self.m_userEmail];
                }
            }
            else if(self.m_mealViewController.selectedSection == 2) {
                status                      = [self.m_database updateLunchFood:[NSString getFoodItemToSwitch] Quantity:[NSString stringWithFormat:@"%lu", (unsigned long)self.m_mealViewController.selectedSection] forUser:self.m_userEmail];
                if ([status isEqualToString:@"deleted"]) {
                    status                  = [self.m_database insertIntoLunchFood:self.m_selectedPlanItem Quantity:self.m_selectedPlanDetails forUser:self.m_userEmail];
                }
            }
            else if(self.m_mealViewController.selectedSection == 3) {
                status                      = [self.m_database updateSecondSnackFood:[NSString getFoodItemToSwitch] Quantity:[NSString stringWithFormat:@"%lu", (unsigned long)self.m_mealViewController.selectedSection] forUser:self.m_userEmail];
                if ([status isEqualToString:@"deleted"]) {
                    status                  = [self.m_database insertIntoSecondSnackFood:self.m_selectedPlanItem Quantity:self.m_selectedPlanDetails forUser:self.m_userEmail];
                }
            }
            else if(self.m_mealViewController.selectedSection == 4) {
                status                      = [self.m_database updateDinnerFood:[NSString getFoodItemToSwitch] Quantity:[NSString stringWithFormat:@"%lu", (unsigned long)self.m_mealViewController.selectedSection] forUser:self.m_userEmail];
                if ([status isEqualToString:@"deleted"]) {
                    status                  = [self.m_database insertIntoDinnerFood:self.m_selectedPlanItem Quantity:self.m_selectedPlanDetails forUser:self.m_userEmail];
                }
            }
            else if(self.m_mealViewController.selectedSection == 5) {
                status                      = [self.m_database updateThirdSnackFood:[NSString getFoodItemToSwitch] Quantity:[NSString stringWithFormat:@"%lu", (unsigned long)self.m_mealViewController.selectedSection] forUser:self.m_userEmail];
                if ([status isEqualToString:@"deleted"]) {
                    status                  = [self.m_database insertIntoThirdSnackFood:self.m_selectedPlanItem Quantity:self.m_selectedPlanDetails forUser:self.m_userEmail];
                }
            }
            
            if ([status isEqualToString:@"inserted"]) { // successfully switched food items
                self.navigationItem.rightBarButtonItem      = nil;
                [self displayMessage:@"You have successfully switched food items"];
            }
            else {
                [self displayMessage:@"Sorry, failed to switch food items"];
            }
        }
        else { // no meal plan selected
            [self displayMessage:@"No meal item selected, please try again"];
        }
    }
    else if(self.view.tag == 2) { // if workout plan
        if (!self.m_exerciseViewController) {
            self.m_exerciseViewController            = [ExerciseViewController alloc];
        }
        status                                  = [self updateWorkoutPlanWithExercise:[NSString getExerciseItemToSwitch] andDetails:@"Empty Space" forDay:(int)self.m_exerciseViewController.selectedSection]; // update workout plan
        if ([status isEqualToString:@"inserted"]) { // successfully switched food items
            // Make done button visible
            [self displayMessage:@"You have successfully switched exercise items"];
        }
        else {
            [self displayMessage:@"Sorry, failed to switch exercise items"];
        }
    }
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
    
    self.nutritionPlanButton                     = [controlButtonArrays objectAtIndex:5];
    
    // Refresh the view
    [self.view setNeedsDisplay];
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
        // adjust the height of the tableview and readd the indicator view
        [self.theTableView removeFromSuperview];
        self.theTableView               = [self adjustiPhone5HeightOfTableView:self.theTableView ForController:self];
        [self.view addSubview:self.theTableView];
    }
    [self.messageButton removeFromSuperview];
    self.messageButton.titleLabel.font          = [UIFont customFontWithSize:13];
    self.messageButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.messageButton.titleLabel.numberOfLines = 2;
    self.messageButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.messageButton];
    
    // set up the bottom bar
    [self addSelectorToControlButtons];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    // plan arrays initialized
    self.m_planImagesArray                       = [NSMutableArray mutableArrayObject];
    self.m_planItemArray                         = [NSMutableArray mutableArrayObject];
    self.m_planDetailArray                       = [NSMutableArray mutableArrayObject];

    if (!self.m_switchPlanItemSelection) {
        self.m_switchPlanItemSelection           = [SwitchPlanItemSelection sharedInstance];
    }
    
    if (!self.m_mealViewController) {
        self.m_mealViewController                = [MealViewController sharedInstance];
    }
    
    if (!self.m_exerciseViewController) {
        self.m_exerciseViewController            = [ExerciseViewController sharedInstance];
    }
    
    NSMutableArray *tempArray;
    
    if (self.view.tag == 1) {
        tempArray           = [self.m_switchPlanItemSelection getMealPanItems:[NSString getFoodItemToSwitch]];
        if ([tempArray count] > 0) {
            for (int i = 0; i < [tempArray count]; i = i + 2) {
                [self.m_planItemArray addObject:[tempArray objectAtIndex:i]];
                [self.m_planDetailArray addObject:[tempArray objectAtIndex:i + 1]];
            }
            // get images
            [self getImagesforMealPlanItems];
            
        }
        else { // if no items exisit
            [self displayMessage:@"There are no meal items in this category"];
        }
        
    }
    else if(self.view.tag == 2) {
        NSLog(@"[NSString getExerciseItemToSwitch] %@", [NSString getExerciseItemToSwitch]);

        tempArray           = [self.m_switchPlanItemSelection getWorkoutPlanItems:[NSString getExerciseItemToSwitch]];
        if ([tempArray count] > 0) {
            for (int i = 0; i < [tempArray count]; i++) {
                [self.m_planItemArray addObject:[tempArray objectAtIndex:i]];
            }
            // get images
            [self getImagesforWorkoutPlanItems];
        }
        else { // if no items exisit
            [self displayMessage:@"There are no workout items in this category - Suck it up and do the exercise!"];
        }
    }
    
    [self.theTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 Checkbox for the grocery list
 */
- (void)checkBoxForGroceryList:(id)sender
{
    UIButton *button            = (UIButton *)sender;
    [button setBackgroundImage:[UIImage imageNamed:@"grocery_selected.png"] forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark UITableViewDataSource
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView;        
    headerView                  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    UILabel *label              = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    UIView *seperatorView;
    if (!self.m_switchPlanItemSelection) {
        self.m_switchPlanItemSelection           = [SwitchPlanItemSelection sharedInstance];
    }
    if (self.m_switchPlanItemSelection.categoryName == NULL) {
        label.text              = @"";
    }
    else {
        label.text              = [NSString stringWithFormat:@"  %@", self.m_switchPlanItemSelection.categoryName];
    }
    label.textAlignment         = NSTextAlignmentLeft;
    label.textColor             = [UIColor redColor];
    label.backgroundColor       = [UIColor clearColor];
    label.font                  = [UIFont customFontWithSize:16];
    [headerView addSubview:label];
    
    CGRect sepFrame = CGRectMake(0, headerView.frame.size.height-1, 320, 1);
    seperatorView = [[UIView alloc] initWithFrame:sepFrame];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    seperatorView.backgroundColor = [UIColor redColor];
    [headerView addSubview:seperatorView];
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.m_planItemArray count];
}

- (UIImage *)imageWithFilename:(NSString *)filename
{
    NSString *path;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	path = [paths[0] stringByAppendingPathComponent:@""];
	path = [path stringByAppendingPathComponent:filename];
    
    return [UIImage imageWithContentsOfFile:path];
}

/*
 Cell contents such as images, items and measurement displayed for Plan
 */
- (void)cellContents:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath WithImageArray:(NSMutableArray *)imageArray AndKeyArray:(NSMutableArray *)keyArray AndValueArray:(NSMutableArray *)valueArray
{
    
    if(self.view.tag == 1){
    UIImage *cellImage                                  = nil;
    if ([imageArray count] > 0) { // So that assessing empty array, doesn't crash the app
        cellImage                                       = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];     // Find the right image
    }
    ((UIImageView *)[cell viewWithTag:1]).image         = cellImage;
    if (!cellImage) { // If the there is no image displayed then, there isn't any food item for that
        cell.accessoryType                              = UITableViewCellAccessoryNone;
        [cell setUserInteractionEnabled:NO];
    }
    else { // Cell the set have the accessory and interaction as well to avoid remaining disabled from the above if
        // Customize accessoryView
        [cell setUserInteractionEnabled:YES];
    }
    ((UILabel *)[cell viewWithTag:2]).text              = [keyArray objectAtIndex:indexPath.row];
    if (self.view.tag != 2) { // if the list is not workout plan
        if (!([[valueArray objectAtIndex:indexPath.row] isEqualToString:@"Empty Space"]) && ([[valueArray objectAtIndex:indexPath.row] length] != 0)) { // if the there is no quantity for meal plan or it is workout plan
            ((UILabel *)[cell viewWithTag:3]).text          = [valueArray objectAtIndex:indexPath.row];
        }
        else {
            ((UILabel *)[cell viewWithTag:3]).text          = @"";
        }
      }
    }
    else if(self.view.tag == 2){
        UIImage *cellImage                                  = nil;
        if ([imageArray count] > 0) { // So that assessing empty array, doesn't crash the app
            cellImage                                       = [self imageWithFilename:imageArray[indexPath.row]]; // Find the right image
        }
        ((UIImageView *)[cell viewWithTag:1]).image         = cellImage;
        if (!cellImage) { // If the there is no image displayed then, there isn't any food item for that
            cell.accessoryType                              = UITableViewCellAccessoryNone;
            [cell setUserInteractionEnabled:NO];
        }
        else { // Cell the set have the accessory and interaction as well to avoid remaining disabled from the above if
            // Customize accessoryView
            [cell setUserInteractionEnabled:YES];
        }
        ((UILabel *)[cell viewWithTag:2]).text              = [keyArray objectAtIndex:indexPath.row];
        if (self.view.tag != 2) { // if the list is not workout plan
            if (!([[valueArray objectAtIndex:indexPath.row] isEqualToString:@"Empty Space"]) && ([[valueArray objectAtIndex:indexPath.row] length] != 0)) { // if the there is no quantity for meal plan or it is workout plan
                ((UILabel *)[cell viewWithTag:3]).text          = [valueArray objectAtIndex:indexPath.row];
            }
            else {
                ((UILabel *)[cell viewWithTag:3]).text          = @"";
            }
        }
    }
    
}

/*
 Each section has its own images, key and value arrays
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath onTableView:tableView
{
    [self cellContents:cell atIndexPath:indexPath WithImageArray:self.m_planImagesArray AndKeyArray:self.m_planItemArray AndValueArray:self.m_planDetailArray];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *daySelectionIdentifier = @"daySelectionIdentifier";
    UITableViewCell *cell                   = [tableView dequeueReusableCellWithIdentifier:daySelectionIdentifier];
    if (cell == nil) {
        cell                                = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:daySelectionIdentifier];
        // there is no check button, so position from the left
        UIImageView *mealPlanImageView      = [[UIImageView alloc] initWithFrame: CGRectMake(0,0,80,80)];
        mealPlanImageView.tag               = 1; // Need to add outside the if statment
        [cell.contentView addSubview:mealPlanImageView];
        
        // adjust the position to accommodate the plan text label           
        UILabel *planTextLabel              = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 180, 60)];
        planTextLabel.font                  = [UIFont customFontWithSize:15];
        planTextLabel.lineBreakMode         = NSLineBreakByWordWrapping;
        planTextLabel.numberOfLines         = 3;
        planTextLabel.textAlignment         = NSTextAlignmentLeft;
        planTextLabel.textColor             = [UIColor darkGrayColor];
        planTextLabel.tag                   = 2; // Need to add outside the if statment
        [cell.contentView addSubview:planTextLabel];

        //  Position the detail text label
        UILabel *detailTextLabel            = [[UILabel alloc] initWithFrame:CGRectMake(85, 45, 180, 20)];
        detailTextLabel.font                = [UIFont customFontWithSize:11];
        detailTextLabel.lineBreakMode       = NSLineBreakByWordWrapping;
        detailTextLabel.numberOfLines       = 2;
        detailTextLabel.textAlignment       = NSTextAlignmentLeft;
        detailTextLabel.textColor           = [UIColor darkGrayColor];
        detailTextLabel.tag                 = 3; // Need to add outside the if statment
        [cell.contentView addSubview:detailTextLabel];
        
        // cell selection color
        cell.selectionStyle                 = UITableViewCellSelectionStyleNone;
    }
    
    if([self.checkedIndexPath isEqual:indexPath])
    {
        cell.accessoryType                  = UITableViewCellAccessoryCheckmark;
        
    }
    else
    {
        cell.accessoryType                  = UITableViewCellAccessoryNone;
    }

    [self configureCell:cell atIndexPath:indexPath onTableView:tableView];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float heightForRow                  = 80.0f;
    return heightForRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    float heightForHeaderSection        = 30.0f;
    return heightForHeaderSection;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Stop the indicatorview when cells are to be loaded
    [self.indicatorView stopAnimating];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Uncheck the previous checked row
    if(self.checkedIndexPath)
    {
        UITableViewCell* uncheckCell    = [tableView cellForRowAtIndexPath:self.checkedIndexPath];
        uncheckCell.accessoryType       = UITableViewCellAccessoryNone;
    }
    if([self.checkedIndexPath isEqual:indexPath])
    {
        self.checkedIndexPath = nil;
        // no item selected
        self.m_selectedPlanItem              = @"";
        self.m_selectedPlanDetails           = @"";
    }
    else
    {
        UITableViewCell* cell           = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType              = UITableViewCellAccessoryCheckmark;
        self.checkedIndexPath           = indexPath;
        
        self.m_selectedPlanItem              = [self.m_planItemArray objectAtIndex:indexPath.row];
        if ([self.m_planDetailArray count] > 0) { // if it is meal plan
            self.m_selectedPlanDetails       = [self.m_planDetailArray objectAtIndex:indexPath.row];
        }
    }
}


@end
