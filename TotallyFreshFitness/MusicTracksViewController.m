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

// ProfileViewController class object
@property (strong, nonatomic)ProfileViewController *m_profileViewController;
// ExerciseViewController class object
@property (strong, nonatomic)ExerciseViewController *m_exerciseViewController;
// MealViewContrioller class object
@property (strong, nonatomic)MealViewController *m_mealViewController;
// CalenderViewController class object
@property (strong, nonatomic)CalenderViewController *m_calenderViewController;
// MusicListViewController class object
@property (strong, nonatomic)MusicListViewController *m_musicListViewController;
// SupplementPlanViewController class object
@property (strong, nonatomic)SupplementPlanViewController *m_supplementPlanViewController;
// RootViewController class object
@property (strong, nonatomic)RootViewController *m_rootViewController;
// ViewFactory class object
@property (strong, nonatomic)ViewFactory *m_controllerViews;
// ViewTransitions class object
@property (strong, nonatomic)ViewTransitions *m_transition;
// Music categories array
@property (strong, nonatomic)NSMutableArray *m_musicCategoriesArray;
// Music mix urls array
@property (strong, nonatomic)NSMutableArray *m_musicMixesURLArray;
// Music images arrays
@property (strong, nonatomic)NSMutableArray *m_tracksImagesArray;
// Music contents
@property (strong, nonatomic)NSMutableArray *m_tracksContentsArray;

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
  //HAX
//    if (!self.m_rootViewController) {
//        self.m_rootViewController                = [RootViewController sharedInstance];
//    }
//    
//    id instanceObject               = self.m_rootViewController;
//    [self moveToView:self.m_rootViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
  [self.navigationController popToRootViewControllerAnimated:NO];
}
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
    
    self.m_musicCategoriesArray      = [[NSMutableArray alloc] initWithObjects:@"EDM", @"Rock", @"Mash up", @"Hip Hop", @"Dubstep", @"Country",  @"Indie", @"Pop", nil];
  
    self.m_musicMixesURLArray           = [[NSMutableArray alloc] initWithObjects:@"http://8tracks.com/totalfitnessapp/mixes.json?", @"http://8tracks.com/louder-space/mixes.json?",  @"http://8tracks.com/cunningstunt/mixes.json?", @"http://8tracks.com/vurj/mixes.json?",  @"http://8tracks.com/alisonggil/mixes.json?", @"http://8tracks.com/cherhasthoughts/mixes.json?", @"http://8tracks.com/tina-t-na/mixes.json?", @"http://8tracks.com/vixjiang/mixes.json?", nil];

    
    self.m_tracksImagesArray     = [[NSMutableArray alloc] initWithObjects:@"EDM.png", @"rock.png", @"mashup.png", @"hiphop.png", @"dubstep.png", @"country.png", @"indie.png", @"pop.png", nil];
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
    if ([self.m_tracksImagesArray count] > 0) { // so that accessing the empty array doesn't crash the app
        cellImage                                       = [UIImage imageNamed:[self.m_tracksImagesArray objectAtIndex:indexPath.row]];     // Find the right image
    }
    ((UIImageView *)[cell viewWithTag:1]).image         = cellImage;
    // Customize accessoryView
    cell.accessoryType                                  = UITableViewCellAccessoryDisclosureIndicator;
    [cell setUserInteractionEnabled:YES];
    ((UILabel *)[cell viewWithTag:2]).text              = [self.m_musicCategoriesArray objectAtIndex:indexPath.row];
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.m_tracksImagesArray count];
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
    self.selectedMusicURL           = [self.m_musicMixesURLArray objectAtIndex:indexPath.row];
    [NSString setMusicMixURL:self.selectedMusicURL];
    
    if (!self.m_musicListViewController) {
        self.m_musicListViewController   = [MusicListViewController sharedInstance];
    }
    if (!self.m_transition) {
        self.m_transition    = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionFromRight:self.m_musicListViewController.view];
    [self.view addSubview:self.m_musicListViewController.view];

    // Unselect the row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
