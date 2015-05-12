//
//  ExcerciseIndexViewController.m
//  Total Fitness And Nutrition
//
//  Created by Harveer Parmar on 2014-10-22.
//  Copyright (c) 2014 Total Fitness and Nutrition. All rights reserved.
//

#import "ExcerciseIndexViewController.h"
#import "WorkoutSelection.h"
#import "ExerciseListViewController.h"
#import "NSMutableArray+PlanLists.h"
#import "NSString+ExerciseToSwitch.h"
#import "NSMutableArray+SportsList.h"
#import "NSString+FindImage.h"

@interface ExcerciseIndexViewController ()

// Cell contents such as images, items and measurement displayed
- (void)cellContents:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath WithImageArray:(NSMutableArray *)imageArray AndKeyArray:(NSMutableArray *)keyArray AndValueArray:(NSMutableArray *)valueArray;
// Each section has its own images, key and value arrays
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath onTableView:tableView;

@end

@implementation ExcerciseIndexViewController

static const NSString *m_abs_Male_Image_Name                    = @"tfn_exercises_male_ABS.png";
static const NSString *m_arms_Male_Image_Name                   = @"tfn_exercises_male_ARMS.png";
static const NSString *m_back_Male_Image_Name                   = @"tfn_exercises_male_BACK.png";
static const NSString *m_chest_Male_Image_Name                  = @"tfn_exercises_male_CHEST.png";
static const NSString *m_legs_Male_Image_Name                   = @"tfn_exercises_male_LEGS.png";
static const NSString *m_shoulders_Male_Image_Name              = @"tfn_exercises_male_SHOULDERS.png";
static const NSString *m_cardio_Male_Image_Name                 = @"cardio_male_thumb.png";
static const NSString *m_sports_Male_Image_Name                 = @"sports_male_thumb.png";

static const NSString *m_abs_Female_Image_Name                  = @"tfn_exercises_women_ABS.png";
static const NSString *m_arms_Female_Image_Name                 = @"tfn_exercises_women_ARMS.png";
static const NSString *m_back_Female_Image_Name                 = @"tfn_exercises_women_BACK.png";
static const NSString *m_chest_Female_Image_Name                = @"tfn_exercises_women_CHEST.png";
static const NSString *m_legs_Female_Image_Name                 = @"tfn_exercises_women_LEGS.png";
static const NSString *m_shoulders_Female_Image_Name            = @"tfn_exercises_women_SHOULDERS.png";
static const NSString *m_cardio_Female_Image_Name               = @"cardio_female_thumb.png";
static const NSString *m_sports_Female_Image_Name               = @"sports_female_thumb.png";

// Database class object
Database *m_database;
// ViewFactory class object
ViewFactory *m_controllerViews;
// ViewTransitions class object
ViewTransitions *m_transition;
// ExerciseListViewController class object
ExerciseListViewController *m_exerciseListViewController;

// Exercise index array;
NSMutableArray *m_exerciseIndexArray;
// Image array for Exercise Index
NSMutableArray *m_imagesForExerciseIndexArray;
// WorkoutOrExerciseIndex Table
NSString *m_workoutOrExerciseIndexTable;
// User email from database
NSString *m_userEmail;
// User exercise goal from database
NSString *m_goal;
// Gender of user
NSString *m_gender;
//Sports Activities
NSMutableArray *m_sportsListExerciseView;
// Sports List Images
NSMutableArray *m_sportsListImages;
// Sports or Other Exercises

/*
 Singleton ExerciseViewController object
 */
+ (ExcerciseIndexViewController *)sharedInstance {
    static ExcerciseIndexViewController *globalInstance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
    return globalInstance;
}

/*
 Get Exercise Index
 */
- (void)getExerciseIndex
{
    // clean the arrays first
    m_imagesForExerciseIndexArray         = nil;
    
    if (!m_exerciseIndexArray) {
        m_exerciseIndexArray              = [NSMutableArray mutableArrayObject];
        [m_exerciseIndexArray addObject:@"Abdomimals"];
        [m_exerciseIndexArray addObject:@"Arms"];
        [m_exerciseIndexArray addObject:@"Back"];
        [m_exerciseIndexArray addObject:@"Chest"];
        [m_exerciseIndexArray addObject:@"Legs"];
        [m_exerciseIndexArray addObject:@"Shoulders"];
        [m_exerciseIndexArray addObject:@"Cardio"];
        [m_exerciseIndexArray addObject:@"Sports"];
    }
    
    if (!m_imagesForExerciseIndexArray) {
        m_imagesForExerciseIndexArray     = [NSMutableArray mutableArrayObject];
    }
    if (!m_database) {
        m_database                        = [Database alloc];
    }
    if (!m_userEmail) {
        m_userEmail                       = [NSString getUserEmail];
    }
    
    if ([[m_database getGender:m_userEmail] isEqualToString:@"Male"]) {
        [m_imagesForExerciseIndexArray addObject:m_abs_Male_Image_Name];
        [m_imagesForExerciseIndexArray addObject:m_arms_Male_Image_Name];
        [m_imagesForExerciseIndexArray addObject:m_back_Male_Image_Name];
        [m_imagesForExerciseIndexArray addObject:m_chest_Male_Image_Name];
        [m_imagesForExerciseIndexArray addObject:m_legs_Male_Image_Name];
        [m_imagesForExerciseIndexArray addObject:m_shoulders_Male_Image_Name];
        [m_imagesForExerciseIndexArray addObject:m_cardio_Male_Image_Name];
        [m_imagesForExerciseIndexArray addObject:m_sports_Male_Image_Name];
    }
    else if ([[m_database getGender:m_userEmail] isEqualToString:@"Female"]) {
        [m_imagesForExerciseIndexArray addObject:m_abs_Female_Image_Name];
        [m_imagesForExerciseIndexArray addObject:m_arms_Female_Image_Name];
        [m_imagesForExerciseIndexArray addObject:m_back_Female_Image_Name];
        [m_imagesForExerciseIndexArray addObject:m_chest_Female_Image_Name];
        [m_imagesForExerciseIndexArray addObject:m_legs_Female_Image_Name];
        [m_imagesForExerciseIndexArray addObject:m_shoulders_Female_Image_Name];
        [m_imagesForExerciseIndexArray addObject:m_cardio_Female_Image_Name];
        [m_imagesForExerciseIndexArray addObject:m_sports_Female_Image_Name];
    }
}

/*
 Move to ExerciseListViewController
 */
- (void)moveToExerciseListViewController:(id)sender
{
    if (!m_exerciseListViewController) {
        m_exerciseListViewController    = [ExerciseListViewController sharedInstance];
    }
    id instanceObject               = m_exerciseListViewController;
    [self moveToView:m_exerciseListViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

-(void)planSelection{
    [self getExerciseIndex];
    [self.exerciseIndexTableView reloadData];
    [self.exerciseIndexTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    if (!m_database) {
        m_database                          = [Database alloc];
    }
    m_userEmail                             = [NSString getUserEmail];
    m_gender                                = [m_database getGender:m_userEmail];
    [self getExerciseIndex];
    [self.exerciseIndexTableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger numberOfSections = 0;
    if(self.exerciseIndexTableView){
        numberOfSections = 1;
    }
    return numberOfSections;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger numberOfRowsInSection = 0;
    
    if(self.exerciseIndexTableView){
        return numberOfRowsInSection = [m_exerciseIndexArray count];
    }
    return numberOfRowsInSection;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ExerciseIndexIdentifier = @"ExerciseIndexIdentifier";
    UITableViewCell *cell;
    [self.exerciseIndexTableView dequeueReusableCellWithIdentifier:ExerciseIndexIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ExerciseIndexIdentifier];
        UIImageView *theImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        theImageView.tag = 1;
        [cell.contentView addSubview:theImageView];
        
        UILabel *theTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 150, 60)];
        theTextLabel.font = [UIFont customFontWithSize:15];
        theTextLabel.numberOfLines = 3;
        theTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        theTextLabel.textAlignment = NSTextAlignmentLeft;
        theTextLabel.textColor = [UIColor darkGrayColor];
        theTextLabel.tag = 2;
        [cell.contentView addSubview:theTextLabel];
        
    }
    [self configureCell:cell atIndexPath:indexPath onTableView:tableView];
    return cell;
}

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath onTableView:(id)tableView{
    
    [self cellContents:cell atIndexPath:indexPath WithImageArray:m_imagesForExerciseIndexArray AndKeyArray:m_exerciseIndexArray AndValueArray:nil];
}

-(void)cellContents:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath WithImageArray:(NSMutableArray *)imageArray AndKeyArray:(NSMutableArray *)keyArray AndValueArray:(NSMutableArray *)valueArray{
    
    UIImage *cellImage = nil;
    
    if([imageArray count] > 0){
        cellImage = [self imageWithFilename:imageArray[indexPath.row]];
    }
    ((UIImageView *)[cell viewWithTag:1]).image = cellImage;
    
    if(!cellImage) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setUserInteractionEnabled:NO];
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setUserInteractionEnabled:YES];
    }
    
    if(![[keyArray objectAtIndex:indexPath.row] isEqualToString:@"Empty Space"]){
        ((UILabel *)[cell viewWithTag:2]).text = [keyArray objectAtIndex:indexPath.row];
    }
    else{
        ((UILabel *)[cell viewWithTag:2]).text = @"";
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float heightForRow                  = 80.0f;
    return heightForRow;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.selectedImage){
        self.selectedImage = nil;
    }
    
    self.selectedImage = [m_exerciseIndexArray objectAtIndex:indexPath.row];
    if(([self.selectedImage length] != 0) && (self.selectedImage != NULL)){
        if(!m_exerciseListViewController){
            m_exerciseListViewController = [ExerciseListViewController alloc];
        }
        m_exerciseListViewController.selectedImage = self.selectedImage;
        [self moveToExerciseListViewController:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
 Load up data and images for the muscle isolation workout
 */
- (void)loadUpSportsListForGender:(NSString *)gender WithArray:(NSMutableArray *)sportsListArray ForImagesArray:(NSMutableArray *)imagesArray
{
    NSInteger numberOfItems                               = [sportsListArray count];
    for (int i = 0; i < numberOfItems; i++) {
        NSString *keyString                         = [sportsListArray objectAtIndex:i];
        //[imagesArray addObject:[NSString findImageForWorkout:[NSString stringWithFormat:@"%@",keyString]]]; // add images
        [imagesArray addObject:[self imageWithFilename:[NSString findImageForWorkout:[NSString stringWithFormat:@"%@", keyString]]]];
    }
}


- (UIImage *)imageWithFilename:(NSString *)filename
{
    NSString *path;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path = [paths[0] stringByAppendingPathComponent:@""];
    path = [path stringByAppendingPathComponent:filename];
    
    return [UIImage imageWithContentsOfFile:path];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    label.text = @"   Exercise Index";
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor redColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont customFontWithSize:16];
    [headerView addSubview:label];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    CGRect seperateFrame = CGRectMake(0, headerView.frame.size.height - 1, 320, 1);
    UIView *seperatorView = [[UIView alloc] initWithFrame:seperateFrame];
    seperatorView.backgroundColor = [UIColor redColor];
    [headerView addSubview:seperatorView];
    return headerView;
}

- (IBAction)previousViewController:(id)sender {
    
    if(!m_transition){
        m_transition = [ViewTransitions sharedInstance];
    }
    [m_transition performTransitionFromRight:self.view.superview];
    [self.view removeFromSuperview];
}
@end
