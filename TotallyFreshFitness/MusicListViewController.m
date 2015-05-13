//
//  MusicListViewController.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 1/22/2014.
//  Copyright (c) 2014 Total Fitness and Nutrition. All rights reserved.
//

#import "MusicListViewController.h"
#import "NSMutableArray+Music_Data.h"
#import "TFNGateway.h"
#import "NSString+Music_Mix.h"
#import "RootViewController.h"
#import "PlayMusicViewController.h"

@interface MusicListViewController ()

@property (strong, nonatomic)TFNGateway *tfnGateway;
// ProfileViewController class object
@property (strong, nonatomic)ProfileViewController *m_profileViewController;
// ExerciseViewController class object
@property (strong, nonatomic)ExerciseViewController *m_exerciseViewController;
// MealViewContrioller class object
@property (strong, nonatomic)MealViewController *m_mealViewController;
// CalenderViewController class object
@property (strong, nonatomic)CalenderViewController *m_calenderViewController;
// MusicTracksViewController class object
@property (strong, nonatomic)MusicTracksViewController *m_musicTracksViewController;
// SupplementPlanViewController class object
@property (strong, nonatomic)SupplementPlanViewController *m_supplementPlanViewController;
// RootViewController class object
@property (strong, nonatomic)RootViewController *m_rootViewController;
// PlayMusicViewController class object
@property (strong, nonatomic)PlayMusicViewController *m_playMusicViewController;
// ViewFactory class object
@property (strong, nonatomic)ViewFactory *m_controllerViews;
// ViewTransitions class object
@property (strong, nonatomic)ViewTransitions *m_transition;

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
// Move to MusicTracksViewContorller's view
- (void)moveToMusicTracksViewController:(id)sender;

@end



@implementation MusicListViewController

@synthesize musicListTableView;
@synthesize indicatorView;

/*
 Singleton MusicListViewController object
 */
+ (MusicListViewController *)sharedInstance {
	static MusicListViewController *globalInstance;
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
 Move to MusicTracksViewController
 */
- (IBAction)moveToRootViewController:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)displayMusicMixeDetails
{
    [self.musicListTableView reloadData];
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
	// Do any additional setup after loading the view.
    
    // adjust view and tableview size for iphone5
    if ([[UIScreen mainScreen] bounds].size.height == 568) { // the device is iPhone 5
        self.musicListTableView   = [self adjustiPhone5HeightOfTableView:self.musicListTableView ForController:self];
        [self.view addSubview:self.musicListTableView];
        
        self.indicatorView              = [self reAddActivityIndicatorforiPhone5:self.indicatorView];
        [self.view addSubview:self.indicatorView];
    }

    // setup bottom buttons
    [self addSelectorToControlButtons];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.indicatorView setHidden:NO];
    [self.indicatorView startAnimating];
    
    self.tfnGateway      = [TFNGateway sharedInstance];
    [self.tfnGateway getMusicToken:[NSString getMusicMixURL]];
    
    [self setUpNotificationForMusicMixDetails];
}

- (void)setUpNotificationForMusicMixDetails
{
    __block id weakSelf        = self;
    __block id observer =  [[NSNotificationCenter defaultCenter] addObserverForName:@"Music Mix Notification" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf displayMusicMixeDetails];
            [[NSNotificationCenter defaultCenter] removeObserver:observer];
        });
    }];
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
    label.textAlignment         = NSTextAlignmentLeft;
    label.textColor             = [UIColor redColor];
    label.backgroundColor       = [UIColor clearColor];
    label.font                  = [UIFont customFontWithSize:16];
    label.text      = @"    Mixes";
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
    int numberOfSections = 1;
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRowsInSection           = [[NSMutableArray getPlayCount] count];
    return numberOfRowsInSection;
}

/*
 Cell contents such as images, items and measurement displayed for Meal Plan
 */
- (void)cellContents:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath WithImageArray:(NSMutableArray *)imageArray AndMusicNameArray:(NSMutableArray *)musicNameArray AndTagListArray:(NSMutableArray *)tagListArray AndLikeCountArray:(NSMutableArray *)likeCountArray AndPlayCountArray:(NSMutableArray *)playCountArray
{
    UIImage *cellImage                                  = nil;
    if ([imageArray count] > 0) { // So that assessing empty array, doesn't crash the app
        cellImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[imageArray objectAtIndex:indexPath.row]]]];
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
    ((UILabel *)[cell viewWithTag:2]).text              = [musicNameArray objectAtIndex:indexPath.row];
    ((UILabel *)[cell viewWithTag:3]).text      = [tagListArray objectAtIndex:indexPath.row];
    ((UIImageView *)[cell viewWithTag:4]).image      = [UIImage imageNamed:@"heart.png"];
    ((UILabel *)[cell viewWithTag:5]).text      = [NSString stringWithFormat:@"%@", [likeCountArray objectAtIndex:indexPath.row]];
    ((UIImageView *)[cell viewWithTag:6]).image      = [UIImage imageNamed:@"play.png"];
    ((UILabel *)[cell viewWithTag:7]).text      = [NSString stringWithFormat:@"%@", [playCountArray objectAtIndex:indexPath.row]];
}

/*
 Each section has its own images, key and value arrays
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath onTableView:tableView
{
    [self cellContents:cell atIndexPath:indexPath WithImageArray:[NSMutableArray getSmallCoverURLs] AndMusicNameArray:[NSMutableArray getMusicNames] AndTagListArray:[NSMutableArray getTagList] AndLikeCountArray:[NSMutableArray getLikeCount] AndPlayCountArray:[NSMutableArray getPlayCount]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MusicListIdentifier         = @"MusicListIdentifier";
    UITableViewCell *cell                         = [tableView dequeueReusableCellWithIdentifier:MusicListIdentifier];
    
    if (cell == nil) {
        cell                                      = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MusicListIdentifier];
        
        UIImageView *musicListImageView            = [[UIImageView alloc] initWithFrame: CGRectMake(0,0,80,80)];
        musicListImageView.tag                     = 1; // Need to add outside the if statment
        [cell.contentView addSubview:musicListImageView];
        
        UILabel *musicNameTextLabel                = [[UILabel alloc] initWithFrame:CGRectMake(95, 0, 180, 25)];
        musicNameTextLabel.font                    = [UIFont customFontWithSize:15];
        musicNameTextLabel.lineBreakMode           = NSLineBreakByWordWrapping;
        musicNameTextLabel.numberOfLines           = 2;
        musicNameTextLabel.textAlignment           = NSTextAlignmentLeft;
        musicNameTextLabel.textColor               = [UIColor blackColor];
        musicNameTextLabel.tag                     = 2; // Need to add outside the if statment
        [cell.contentView addSubview:musicNameTextLabel];
        
        UILabel *musicTagListTextLabel               = [[UILabel alloc] initWithFrame:CGRectMake(95, 30, 180, 20)];
        musicTagListTextLabel.font                   = [UIFont customFontWithSize:10];
        musicTagListTextLabel.lineBreakMode          = NSLineBreakByWordWrapping;
        musicTagListTextLabel.numberOfLines          = 2;
        musicTagListTextLabel.textAlignment          = NSTextAlignmentLeft;
        musicTagListTextLabel.textColor              = [UIColor blackColor];
        musicTagListTextLabel.tag                    = 3; // Need to add outside the if statment
        [cell.contentView addSubview:musicTagListTextLabel];
        
        UIImageView *musicLikeImageView               = [[UIImageView alloc] initWithFrame:CGRectMake(95, 60, 20, 20)];
        musicLikeImageView.tag                    = 4; // Need to add outside the if statment
        [cell.contentView addSubview:musicLikeImageView];

        UILabel *musicLikeLabel               = [[UILabel alloc] initWithFrame:CGRectMake(115, 60, 50, 20)];
        musicLikeLabel.font                   = [UIFont customFontWithSize:9];
        musicLikeLabel.lineBreakMode          = NSLineBreakByWordWrapping;
        musicLikeLabel.textAlignment          = NSTextAlignmentLeft;
        musicLikeLabel.textColor              = [UIColor blackColor];
        musicLikeLabel.tag                    = 5; // Need to add outside the if statment
        [cell.contentView addSubview:musicLikeLabel];
        
        UIImageView *musicPlayedImageView               = [[UIImageView alloc] initWithFrame:CGRectMake(135, 60, 20, 20)];
        musicPlayedImageView.tag                    = 6; // Need to add outside the if statment
        [cell.contentView addSubview:musicPlayedImageView];
        
        UILabel *musicPlayedLabel               = [[UILabel alloc] initWithFrame:CGRectMake(155, 60, 50, 20)];
        musicPlayedLabel.font                   = [UIFont customFontWithSize:9];
        musicPlayedLabel.lineBreakMode          = NSLineBreakByWordWrapping;
        musicPlayedLabel.textAlignment          = NSTextAlignmentLeft;
        musicPlayedLabel.textColor              = [UIColor blackColor];
        musicPlayedLabel.tag                    = 7; // Need to add outside the if statment
        [cell.contentView addSubview:musicPlayedLabel];

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
    // Set Selected Music sources
    [NSString setSelectedMusicRestfulURL:[[NSMutableArray getRestfulURL] objectAtIndex:indexPath.row]];
    [NSString setSelectedMusicTitle:[[NSMutableArray getMusicNames] objectAtIndex:indexPath.row]];
    [NSString setSelectedMusicId:[[NSMutableArray getMusicIDS] objectAtIndex:indexPath.row]];
    [NSString setMusicBigCoverURL:[[NSMutableArray getBigCoverURLs] objectAtIndex:indexPath.row]];
    
    // Unselect the row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  //HAX
    //[self moveToPlayMusicViewController:self];
}

@end
