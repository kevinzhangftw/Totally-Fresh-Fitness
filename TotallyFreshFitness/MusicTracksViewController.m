//
//  MusicTracksViewController.m
//  MusicTracksViewController
//
//  Created by John Abeel on 7/15/11.
//  Copyright 2011 Wakefield School. All rights reserved.
//

#import "MusicTracksViewController.h"
#import "MusicListViewController.h"
#import "RootViewController.h"
#import "NSString+Music_Mix.h"

@interface MusicTracksViewController ()

// Move to CalenderViewController
- (void)moveToCalenderViewController:(id)sender;
// Move to MealViewController
- (void)moveToMealViewController:(id)sender;
// Move to ExerciseViewController
- (void)moveToExerciseViewController:(id)sender;
// Move to SupplementPlanViewController
- (void)moveToSupplementPlanViewController:(id)sender;
// Move to RootViewController's view
- (IBAction)moveToRootViewController:(id)sender;

@end

@implementation MusicTracksViewController
// ProfileViewController class object
ProfileViewController *m_profileViewController;
// ExerciseViewController class object
ExerciseViewController *m_exerciseViewController;
// MealViewContrioller class object
MealViewController *m_mealViewController;
// CalenderViewController class object
CalenderViewController *m_calenderViewController;
// MusicListViewController class object
MusicListViewController *m_musicListViewController;
// SupplementPlanViewController class object
SupplementPlanViewController *m_supplementPlanViewController;
// RootViewController class object
RootViewController *m_rootViewController;
// ViewFactory class object
ViewFactory *m_controllerViews;
// ViewTransitions class object
ViewTransitions *m_transition;
// Music categories array
NSMutableArray *m_musicCategoriesArray;
// Music mix urls array
NSMutableArray *m_musicMixesURLArray;
// Music images arrays
NSMutableArray *m_tracksImagesArray;
// Music contents
NSMutableArray *m_tracksContentsArray;

@synthesize topNavigationBar;
@synthesize backButton;
@synthesize theTableView;
@synthesize selectedMusicURL;

/*
 Singleton MusicTracksViewController object
 */
+ (MusicTracksViewController *)sharedInstance {
	static MusicTracksViewController *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 Move to MusicTracksViewController
 */
- (IBAction)moveToRootViewController:(id)sender
{
    if (!m_rootViewController) {
        m_rootViewController                = [RootViewController sharedInstance];
    }
    
    id instanceObject               = m_rootViewController;
    [self moveToView:m_rootViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

/*
 Move to ExerciseViewController
 */
- (void)moveToExerciseViewController:(id)sender
{
    if (!m_exerciseViewController) {
        m_exerciseViewController        = [ExerciseViewController sharedInstance];
    }
    
    id instanceObject                   = m_exerciseViewController;
    
    [self moveToView:m_exerciseViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
}

/*
 Move to MealViewController
 */
- (void)moveToMealViewController:(id)sender
{
    if (!m_mealViewController) {
        m_mealViewController        = [MealViewController sharedInstance];
    }
    id instanceObject               = m_mealViewController;
    [self moveToView:m_mealViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];

}

/*
 Move to CalenderViewController
 */
- (void)moveToCalenderViewController:(id)sender
{
    if (!m_calenderViewController) {
        m_calenderViewController    = [CalenderViewController sharedInstance];
    }
    id instanceObject               = m_calenderViewController;
    [self moveToView:m_calenderViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    
}

/*
 Move to SupplementPlanViewController
 */
- (void)moveToSupplementPlanViewController:(id)sender
{
    if (!m_supplementPlanViewController) {
        m_supplementPlanViewController         = [SupplementPlanViewController sharedInstance];
    }
    id instanceObject               = m_supplementPlanViewController;
    m_supplementPlanViewController.view.tag     = 1;

    [self moveToView:m_supplementPlanViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
    

    
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
    // Stay here
    
    self.exercisePlanButton             = [controlButtonArrays objectAtIndex:2];
    
    self.calendarButton                 = [controlButtonArrays objectAtIndex:3];
    
    self.mealPlanButton                 = [controlButtonArrays objectAtIndex:4];
    
    self.nutritionPlanButton                     = [controlButtonArrays objectAtIndex:5];
    
    // Refresh the view
    [self.view setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title       = @"Music";
        self.tabBarItem.image       = [UIImage imageNamed:@"red_check.png"];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor          = [UIColor whiteColor];
    
    // adjust view and tableview size for iphone5
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.backgroundImageView.image                      = [UIImage imageNamed:@"tfn-homebackground-iPhone5"];
        self.theTableView   = [self adjustiPhone5HeightOfTableView:self.theTableView ForController:self];
        [self.view addSubview:self.theTableView];
    }

    // setup bottom buttons
    [self addSelectorToControlButtons];
    
//    m_tracksArray           = [[NSMutableArray alloc] initWithObjects:@"EDM", @"http://8tracks.com/totalfitness-nutrition/beast-mode", @"Rock", @"http://8tracks.com/louder-space/pump-it-up", @"Mash up", @"http://8tracks.com/cunningstunt/daft-punk-mashed", @"Hip Hop", @"http://8tracks.com/vurj/get-pumped", @"Dubstep", @"http://8tracks.com/alisonggil/sick-drops-and-dirty-beats", @"Country", @"http://8tracks.com/cherhasthoughts/we-can-work-it-out", @"Indie", @"http://8tracks.com/tina-t-na/all-those-indie-songs-you-can-t-get-out-of-your-head", @"Pop", @"http://8tracks.com/vixjiang/basically-the-radio-but-not-really", nil];
    
    m_musicCategoriesArray      = [[NSMutableArray alloc] initWithObjects:@"EDM", @"Rock", @"Mash up", @"Hip Hop", @"Dubstep", @"Country",  @"Indie", @"Pop", nil];
    
    m_musicMixesURLArray           = [[NSMutableArray alloc] initWithObjects:@"http://8tracks.com/totalfitnessapp/mixes.json?", @"http://8tracks.com/louder-space/mixes.json?",  @"http://8tracks.com/cunningstunt/mixes.json?", @"http://8tracks.com/vurj/mixes.json?",  @"http://8tracks.com/alisonggil/mixes.json?", @"http://8tracks.com/cherhasthoughts/mixes.json?", @"http://8tracks.com/tina-t-na/mixes.json?", @"http://8tracks.com/vixjiang/mixes.json?", nil];

    
    m_tracksImagesArray     = [[NSMutableArray alloc] initWithObjects:@"EDM.png", @"rock.png", @"mashup.png", @"hiphop.png", @"dubstep.png", @"country.png", @"indie.png", @"pop.png", nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

/*
 Cell contents such as images, items displayed for Grocery List
 */
- (void)cellContents:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    UIImage *cellImage                                  = nil;
    if ([m_tracksImagesArray count] > 0) { // so that accessing the empty array doesn't crash the app
        cellImage                                       = [UIImage imageNamed:[m_tracksImagesArray objectAtIndex:indexPath.row]];     // Find the right image
    }
    ((UIImageView *)[cell viewWithTag:1]).image         = cellImage;
    // Customize accessoryView
    cell.accessoryType                                  = UITableViewCellAccessoryDisclosureIndicator;
    [cell setUserInteractionEnabled:YES];
    ((UILabel *)[cell viewWithTag:2]).text              = [m_musicCategoriesArray objectAtIndex:indexPath.row];
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_tracksImagesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *musicSelectionIdentifier = @"musicSelectionIdentifier";
    tableView.backgroundColor           = [UIColor whiteColor];
    
    UITableViewCell *cell               = [tableView dequeueReusableCellWithIdentifier:musicSelectionIdentifier];
    
    if (cell == nil) {
        cell                               = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:musicSelectionIdentifier];
        cell.backgroundColor               = [UIColor whiteColor];
        // there is no check button, so position from the left
        UIImageView *musicTracksImage      = [[UIImageView alloc] initWithFrame: CGRectMake(0,0,80,80)];
        musicTracksImage.tag               = 1; // Need to add outside the if statment
        [cell.contentView addSubview:musicTracksImage];
        
        // adjust the position to accommodate the calorie text label
        UILabel *musicTracksName           = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, 212, 25)];
        musicTracksName.backgroundColor    = [UIColor whiteColor];
        musicTracksName.font               = [UIFont customFontWithSize:17];
        musicTracksName.lineBreakMode      = NSLineBreakByWordWrapping;
        musicTracksName.numberOfLines      = 2;
        musicTracksName.textAlignment      = NSTextAlignmentLeft;
        musicTracksName.textColor          = [UIColor darkGrayColor];
        musicTracksName.tag                = 2; // Need to add outside the if statment
        [cell.contentView addSubview:musicTracksName];
    }
    
    [self cellContents:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    float heightForHeaderSection;
    heightForHeaderSection  = 30.0f;
    return heightForHeaderSection;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView      = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    UILabel *label          = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    label.text              = @"    Music Tracks";
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float heightForRow                  = 80.0f;
    return heightForRow;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedMusicURL           = [m_musicMixesURLArray objectAtIndex:indexPath.row];
    [NSString setMusicMixURL:self.selectedMusicURL];
    
    if (!m_musicListViewController) {
        m_musicListViewController   = [MusicListViewController sharedInstance];
    }
    if (!m_transition) {
        m_transition    = [ViewTransitions sharedInstance];
    }
    [m_transition performTransitionFromRight:m_musicListViewController.view];
    [self.view addSubview:m_musicListViewController.view];

    // Unselect the row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
