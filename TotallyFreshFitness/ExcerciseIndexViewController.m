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

@property (strong, nonatomic)Database *m_database;
@property (strong, nonatomic)ViewFactory *m_controllerViews;
@property (strong, nonatomic)ViewTransitions *m_transition;
@property (strong, nonatomic)ExerciseListViewController *m_exerciseListViewController;
@property (strong, nonatomic)NSMutableArray *m_exerciseIndexArray;
@property (strong, nonatomic)NSMutableArray *m_imagesForExerciseIndexArray;
@property (strong, nonatomic)NSString *m_workoutOrExerciseIndexTable;
@property (strong, nonatomic)NSString *m_userEmail;
@property (strong, nonatomic)NSString *m_goal;
@property (strong, nonatomic)NSString *m_gender;
@property (strong, nonatomic)NSMutableArray *m_sportsListExerciseView;
@property (strong, nonatomic)NSMutableArray *m_sportsListImages;

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
    self.m_imagesForExerciseIndexArray         = nil;
    
    if (!self.m_exerciseIndexArray) {
        self.m_exerciseIndexArray              = [NSMutableArray mutableArrayObject];
        [self.m_exerciseIndexArray addObject:@"Abdomimals"];
        [self.m_exerciseIndexArray addObject:@"Arms"];
        [self.m_exerciseIndexArray addObject:@"Back"];
        [self.m_exerciseIndexArray addObject:@"Chest"];
        [self.m_exerciseIndexArray addObject:@"Legs"];
        [self.m_exerciseIndexArray addObject:@"Shoulders"];
        [self.m_exerciseIndexArray addObject:@"Cardio"];
        [self.m_exerciseIndexArray addObject:@"Sports"];
    }
    
    if (!self.m_imagesForExerciseIndexArray) {
        self.m_imagesForExerciseIndexArray     = [NSMutableArray mutableArrayObject];
    }
    if (!self.m_database) {
        self.m_database                        = [Database alloc];
    }
    if (!self.m_userEmail) {
        self.m_userEmail                       = [NSString getUserEmail];
    }
    
    if ([[self.m_database getGender:self.m_userEmail] isEqualToString:@"Male"]) {
        [self.m_imagesForExerciseIndexArray addObject:m_abs_Male_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_arms_Male_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_back_Male_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_chest_Male_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_legs_Male_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_shoulders_Male_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_cardio_Male_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_sports_Male_Image_Name];
    }
    else if ([[self.m_database getGender:self.m_userEmail] isEqualToString:@"Female"]) {
        [self.m_imagesForExerciseIndexArray addObject:m_abs_Female_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_arms_Female_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_back_Female_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_chest_Female_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_legs_Female_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_shoulders_Female_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_cardio_Female_Image_Name];
        [self.m_imagesForExerciseIndexArray addObject:m_sports_Female_Image_Name];
    }
}

/*
 Move to ExerciseListViewController
 */
- (void)moveToExerciseListViewController:(id)sender
{
    if (!self.m_exerciseListViewController) {
        self.m_exerciseListViewController    = [ExerciseListViewController sharedInstance];
    }
    id instanceObject               = self.m_exerciseListViewController;
    [self moveToView:self.m_exerciseListViewController.view FromCurrentView:self.view ByRefreshing:instanceObject];
}

-(void)planSelection{
    [self getExerciseIndex];
    [self.exerciseIndexTableView reloadData];
    [self.exerciseIndexTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    if (!self.m_database) {
        self.m_database                          = [Database alloc];
    }
    self.m_userEmail                             = [NSString getUserEmail];
    self.m_gender                                = [self.m_database getGender:self.m_userEmail];
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
        return numberOfRowsInSection = [self.m_exerciseIndexArray count];
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
    
    [self cellContents:cell atIndexPath:indexPath WithImageArray:self.m_imagesForExerciseIndexArray AndKeyArray:self.m_exerciseIndexArray AndValueArray:nil];
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
    
    self.selectedImage = [self.m_exerciseIndexArray objectAtIndex:indexPath.row];
    if(([self.selectedImage length] != 0) && (self.selectedImage != NULL)){
        if(!self.m_exerciseListViewController){
            self.m_exerciseListViewController = [ExerciseListViewController alloc];
        }
        self.m_exerciseListViewController.selectedImage = self.selectedImage;
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
    
    if(!self.m_transition){
        self.m_transition = [ViewTransitions sharedInstance];
    }
    [self.m_transition performTransitionFromRight:self.view.superview];
    [self.view removeFromSuperview];
}
@end
