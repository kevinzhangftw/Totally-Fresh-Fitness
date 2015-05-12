//
//  HomeViewController.m
//  Total Fitness And Nutrition
//
//  Created by Harveer Parmar on 2014-10-27.
//  Copyright (c) 2014 Total Fitness and Nutrition. All rights reserved.
//

#import "HomeViewController.h"
#import "TFNGateway.h"
#import "HomeTableViewCell.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

static NSString *CellIdentifier = @"CellIdentifier";
//TFN Gateway
TFNGateway *m_serverConnection;

/*
 Singleton ExerciseViewController object
 */
+ (HomeViewController *)sharedInstance {
    static HomeViewController *globalInstance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
    return globalInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.view.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TotalFitnessHomePage" ofType:@"json"];
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    self.titleLabels = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.titleLabels count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    }
    NSDictionary *titleLabels = [self.titleLabels objectAtIndex:indexPath.row];
    NSString *label = [titleLabels objectForKey:@"Heading"];
    NSString *image = [titleLabels objectForKey:@"Image"];
    
    cell.imageView.image = [UIImage imageNamed:image];
    cell.label.text = label;
    cell.cardView.frame = CGRectMake(10, 5, 300, 395);
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 405;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *titleLabels = [self.titleLabels objectAtIndex:indexPath.row];
    NSString *urlForTitle = [titleLabels objectForKey:@"Link"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlForTitle]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
