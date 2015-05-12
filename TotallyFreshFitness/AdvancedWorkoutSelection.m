//
//  AdvancedWorkoutSelection.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/18/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "AdvancedWorkoutSelection.h"

@implementation AdvancedWorkoutSelection

/*
 Singleton AdvancedWorkoutSelection object
 */
+ (AdvancedWorkoutSelection *)sharedInstance {
	static AdvancedWorkoutSelection *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 Load up workout array
 */
- (NSMutableArray *)advancedWorkoutGoal:(NSString *)goal WithTheDay:(int)day ForTotalWorkOutDays:(int)totalNumberOfDays;
{
    // Load up the array with data
    NSMutableArray  *workoutArray                 = nil;
    
    if ([goal isEqualToString:@"SHRED FAT"]) {
        if (totalNumberOfDays == 1) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"1 min", @"Squat and Press", @"1 min", @"Kettle Bell Swing", @"1 min", @"Plea Squat Upright Row", @"1 min", @"Jump Tucks", @"1 min", @"Jumping Split Squat", @"1 min", @"High Knees", @"1 min", @"Butt Kicks", @"1 min", @"Sprint", @"1 min", @"Inch Worm Push Up", @"1 min", @"Burpee Push Up", @"1 min", @"Skip", @"1 min", @"Burpee Push Up", @"1 min", @"Skip", @"1 min", @"Mountain Climbers", @"1 min", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 2) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"High Knees", @"1 min", @"Squat and Press", @"1 min", @"Butt Kicks", @"1 min", @"Mountain Climbers", @"1 min", @"Knee Abductions", @"1 min", @"Jumping Jacks", @"1 min", @"Burpee Push Up", @"1 min", @"Jump Squat", @"1 min", @"Jumping Split Squat", @"1 min", @"Plea Squat Upright Row", @"1 min", @"Skip", @"1 min", @"High Knees", @"1 min", @"Skip", @"1 min", @"Butt Kicks", @"1 min", @"Skip", @"1 min", @"Sprint", @"1 min - 1 min / 20 sets", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if (day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Sprint", @" 1 min - 1 min / 10 sets", @"Skip", @"1 min", @"Burpees", @"5 reps", @"Skip", @"1 min", @"Burpees", @"10 reps", @"Skip", @"1 min", @"Burpees", @"15 reps", @"Skip", @"1 min", @"Burpees", @"20 reps", @"Skip", @"1 min", @"Burpees", @"25 reps", @"Skip", @"1 min", @"Burpees", @"30 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 3) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Running", @"5 mins", @"Skip", @"4 mins", @"Running", @"4 mins", @"Skip", @"3 mins", @"Running", @"3 mins", @"Skip", @"2 mins", @"Running", @"1 min", @"Skip", @"1 min", @"Running", @"30 secs", @"Skip", @"30 secs", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
                
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat and Press", @"20 secs - 10 secs rest / 8 sets", @"Burpees", @"20 secs - 10 secs rest / 8 sets", @"Sit Ups", @"20 secs - 10 secs rest / 8 sets", @"Knee Abductions", @"20 secs - 10 secs rest / 8 sets", @"Kettle Bell Swing", @"20 secs - 10 secs rest / 8 sets", @"Jogging", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if (day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jump Squat", @"100 reps", @"Jumping Split Squat", @"100 reps", @"High Knees", @"100 reps", @"Butt Kicks", @"100 reps", @"Mountain Climbers", @"100 reps",  @"Toe Touches", @"100 reps", @"Bicycle Crunch", @"100 reps", @"Kettle Bell Swing", @"100 reps", @"Supermans", @"100 reps", @"Skip", @"5 mins", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 4) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jogging", @"5 mins", @"Running", @"5 mins", @"Jogging", @"1 min", @"Running", @"5 mins", @"Jogging", @"1 min", @"Running", @"5 mins", @"Skip", @"5 mins", @"Toe Touches", @"100 reps", @"Bicycle Crunch", @"100 reps",  @"Supermans", @"100 reps", @"Bicep Curl", @"2 sets / 20 reps", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Inch Worm Push Up", @"20 secs - 10 secs rest / 8 sets", @"Burpees", @"20 secs - 10 secs rest / 8 sets", @"Jumping Split Squat", @"20 secs - 10 secs rest / 8 sets", @"Squat", @"20 secs - 10 secs rest / 8 sets", @"Skater Lunges", @"20 secs - 10 secs rest / 8 sets", @"Sprint", @"20 secs - 10 secs rest / 8 sets", @"Rowing", @"20 mins", @"Jogging", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Skip", @"2 mins", @"Mountain Climbers", @"100 reps",  @"Skip", @"2 mins", @"Mountain Climbers", @"80 reps",  @"Skip", @"2 mins", @"Mountain Climbers", @"60 reps",  @"Skip", @"2 mins", @"Mountain Climbers", @"40 reps",  @"Skip", @"2 mins", @"Mountain Climbers", @"20 reps",  @"Skip", @"2 mins", @"Skip", @"1 min", @"High Knees", @"80 reps", @"Skip", @"1 min", @"Butt Kicks", @"1 min", @"Skip", @"1 min", @"High Knees", @"40 reps", @"Skip", @"1 min", @"Butt Kicks", @"20 reps", @"Skip", @"1 min", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Sprint", @"1 min / 30 sec rest / 20 sets",@"Body Weight Squats", @"100 reps", nil];
            }
        }
        else if(totalNumberOfDays == 5) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Sprint", @"1 min / 30 sec rest / 10 sets", @"Skip", @"5 mins", @"Toe Touches", @"100 reps", @"Bicycle Crunch", @"100 reps",  @"Supermans", @"100 reps", @"Bicep Curl", @"2 sets / 20 reps", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Inch Worm Push Up", @"20 secs - 10 secs rest / 8 sets", @"Burpees", @"20 reps / 8 sets", @"Jumping Split Squat", @"20 secs 8 sets", @"Squat", @"20 secs - 10 secs rest / 8 sets", @"Skater Lunges", @"20 secs - 10 secs rest / 8 sets", @"Sprint", @"20 secs - 10 secs rest / 8 sets", @"Rowing", @"20 mins", @"Jogging", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga",@"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Skip", @"2 mins", @"Mountain Climbers", @"100 reps",  @"Skip", @"2 mins", @"Mountain Climbers", @"80 reps",  @"Skip", @"2 mins", @"Mountain Climbers", @"60 reps",  @"Skip", @"2 mins", @"Mountain Climbers", @"40 reps",  @"Skip", @"2 mins", @"Mountain Climbers", @"20 reps",  @"Skip", @"2 mins", @"Skip", @"1 min", @"High Knees", @"80 sets", @"Skip", @"1 min", @"Butt Kicks", @"1 min", @"Skip", @"1 min", @"High Knees", @"40 reps", @"Skip", @"1 min", @"Butt Kicks", @"20 reps", @"Skip", @"1 min", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Sprint", @"1 min / 30 sec rest / 20 sets", nil];
            }
        }
        else if(totalNumberOfDays == 6) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jogging", @"5 mins", @"Running", @"5 mins", @"Jogging", @"1 min", @"Running", @"5 mins", @"Jogging", @"1 min", @"Running", @"5 mins", @"Skip", @"5 mins", @"Toe Touches", @"100 reps", @"Bicycle Crunch", @"100 reps",  @"Supermans", @"100 reps", @"Bicep Curl", @"2 sets / 20 reps", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Inch Worm Push Up", @"20 secs - 10 secs rest / 8 sets", @"Burpees", @"20 secs - 10 secs rest / 8 sets", @"Jumping Split Squat", @"20 secs - 10 secs rest / 8 sets", @"Squat", @"20 secs - 10 secs rest / 8 sets", @"Skater Lunges", @"20 secs - 10 secs rest / 8 sets", @"Sprint", @"20 secs - 10 secs rest / 8 sets", @"Rowing", @"20 mins", @"Jogging", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga",@"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Skip", @"2 mins", @"Mountain Climbers", @"100 reps",  @"Skip", @"2 mins", @"Mountain Climbers", @"80 reps",  @"Skip", @"2 mins", @"Mountain Climbers", @"60 reps",  @"Skip", @"2 mins", @"Mountain Climbers", @"40 reps",  @"Skip", @"2 mins", @"Mountain Climbers", @"20 reps",  @"Skip", @"2 mins", @"Skip", @"1 min", @"High Knees", @"80 reps", @"Skip", @"1 min", @"Butt Kicks", @"60 reps", @"Skip", @"1 min", @"High Knees", @"40 sets", @"Skip", @"1 min", @"Butt Kicks", @"20 reps", @"Skip", @"1 min", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Sprint", @"1 min / 30 sec rest / 20 sets", nil];
            }
            else if(day == 5){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sports Activity", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 7) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jogging", @"5 mins", @"Running", @"5 mins", @"Jogging", @"1 min", @"Running", @"5 mins", @"Jogging", @"1 min", @"Running", @"5 mins", @"Skip", @"5 mins", @"Toe Touches", @"100 reps", @"Bicycle Crunch", @"100 reps",  @"Supermans", @"100 reps", @"Bicep Curl", @"2 sets / 20 reps", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Inch Worm Push Up", @"20 secs - 10 secs rest / 8 sets", @"Burpees", @"20 secs - 10 secs rest / 8 sets", @"Jumping Split Squat", @"20 secs - 10 secs rest / 8 sets", @"Squat", @"20 secs - 10 secs rest / 8 sets", @"Skater Lunges", @"20 secs - 10 secs rest / 8 sets", @"Sprint", @"20 secs - 10 secs rest / 8 sets", @"Rowing", @"20 mins", @"Jogging", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga",@"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Skip", @"2 mins", @"Mountain Climbers", @"100 reps",  @"Skip", @"2 mins", @"Mountain Climbers", @"80 reps",  @"Skip", @"2 mins", @"Mountain Climbers", @"60 reps",  @"Skip", @"2 mins", @"Mountain Climbers", @"40 reps",  @"Skip", @"2 mins", @"Mountain Climbers", @"20 reps",  @"Skip", @"2 mins", @"Skip", @"1 min", @"High Knees", @"80 reps", @"Skip", @"1 min", @"Butt Kicks", @"60 reps", @"Skip", @"1 min", @"High Knees", @"40 reps", @"Skip", @"1 min", @"Butt Kicks", @"20 reps", @"Skip", @"1 min", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Sprint", @"1 min / 30 sec rest / 20 sets", nil];
            }
            else if(day == 5){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sleep Benefits", @"Empty Space", nil];
            }
            else if(day == 6){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sports Activity", @"Empty Space", nil];
            }
        }
    }
    else if([goal isEqualToString:@"GET TONED"]) {
        if (totalNumberOfDays == 1) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"Empty Space", @"Jumping Split Squat", @"Empty Space", @"Deadlift", @"2 sets / 20 reps", @"Hanging Leg Raises", @"3 sets / 20 reps",  @"Bent Over Barbell Row", @"2 sets / 20 reps", @"Standing Shoulder Press", @"2 sets / 15 reps", @"Skip", @"2 mins / 2 sets", @"Jogging", @"15 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 2) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"2 sets / 12 reps", @"Push Ups", @"2 sets / 25 reps", @"Narrow Grip Pull Up", @"2 sets / 12 reps", @"Bent Over Alternating Row", @"2 sets / 12 reps", @"Standing Shoulder Press", @"2 sets / 15 reps", @"Bent Lateral Raises", @"2 sets / 20 reps", @"Bicep Curl", @"2 / 20 reps", @"Bench Dips", @"2 / 20 reps", @"Jogging", @"20 mins", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if (day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Front Squat", @"3 sets / 15 reps", @"Lunges", @"2 sets / 15 reps", @"Skater Lunges", @"2 sets / 15 reps", @"Skater Lunges", @"2 sets / 15 reps", @"Jumping Split Squat", @"2 sets / 15 reps", @"Deadlift", @"2 sets / 8 reps", @"Jump Squat", @"2 sets / 8 reps", @"Hanging Leg Raises", @"3 sets / 20 reps", @"Ab Roller", @"50 reps", @"Toe Touches", @"100 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 3) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 10 reps", @"Skater Lunges", @"2 sets / 15 reps", @"Bent Over Dumbbell Row", @"3 sets / 15 reps", @"Bicycle Crunch", @"3 sets / 100 reps", @"Hanging Leg Raises", @"3 sets / 10 reps", @"Ab Roller", @"3 sets / 20 reps", @"Supermans", @"100 reps", @"Skip", @"20 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Narrow Grip Pull Up", @"3 sets / 15 reps", @"Push Ups", @"2 sets / 20 reps", @"Skip", @"1 min / 2 sets", @"Standing Shoulder Press", @"2 sets / 15 reps", @"Bench Dips", @"2 sets / 15 reps", @"Skip", @"1 min / 2 sets", @"Bicep Curl", @"2 sets / 20 reps", @"Burpees", @"2 sets / 20 reps", @"Skip", @"1 min / 2 sets", @"Bicycle Crunch", @"100 reps", @"Toe Touches", @"100 reps", @"Side Plank", @"30 sets / 3 reps", @"Rowing", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
                
            }
            else if (day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Deadlift", @"3 sets / 12 reps", @"Plank", @"45 secs / 2 sets",  @"Lunges", @"2 sets / 20 reps", @"Plea Squat Upright Row", @"2 sets / 20 reps", @"Squat and Press", @"2 sets / 20 reps", @"Hanging Leg Raises", @"3 sets / 10 reps", @"Bicycle Crunch", @"50 reps", @"Sit Ups", @"50 reps", @"Bike", @"15 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 4) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 12 reps", @"Jumping Split Squat", @"3 sets / 30 reps", @"Skip", @"1 min / 3 sets", @"Narrow Grip Pull Up", @"3 sets / 15 reps", @"Burpee Push Up", @"3 sets / 20 reps", @"High Knees", @"3 sets / 100 reps", @"Hanging Leg Raises", @"3 sets / 12 reps", @"Plank", @"45 secs / 3 sets",  @"Side Plank", @"45 secs / 3 sets",  @"Jogging", @"20 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Single Arm Deadlift", @"3 sets / 15 reps", @"Inch Worm Push Up", @"3 sets / 15 reps", @"Skip", @"1 min / 3 sets",  @"Butt Kicks", @"3 mins / 100 reps", @"Standing Shoulder Press", @"3 sets / 15 reps", @"Bent Lateral Raises", @"3 sets / 15 reps", @"Skip", @"1 min / 3 sets", @"V Sit", @"100 reps", @"Sit Ups", @"50 reps", @"Flutter Kicks", @"100 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if (day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"5 sets / 15 reps", @"Push Ups", @"5 sets / 15 reps", @"Bent Over Barbell Row", @"3 sets / 15 reps", @"Standing Shrug", @"3 sets / 15 reps", @"Bench Dips", @"3 sets / 15 reps", @"Bike", @"5 mins", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat and Press", @"3 sets / 20 reps", @"Knee Abductions", @"3 sets / 50 reps", @"Burpee Push Up", @"3 sets / 30 reps", @"Sit Ups", @"3 sets / 50 reps",  @"Toe Touches", @"3 sets / 100 reps",  @"Bicycle Crunch", @"3 sets / 100 reps",  @"Concentration Curl", @"3 sets / 15 reps",  @"Narrow Grip Pull Up", @"3 sets / 12 reps",  @"Laying Windshield Wipers", @"3 sets / 20 reps", @"Sprint", @"1 min - 30 secs rest / 20 sets", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 5) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 12 reps", @"Jumping Split Squat", @"3 sets / 30 reps", @"Skip", @"1 min / 3 sets", @"Narrow Grip Pull Up", @"3 sets / 15 reps", @"Burpee Push Up", @"3 sets / 20 reps", @"High Knees", @"3 sets / 100 reps", @"Hanging Leg Raises", @"3 sets / 12 reps", @"Plank", @"45 secs / 3 sets",  @"Side Plank", @"45 secs / 3 sets",  @"Jogging", @"20 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Single Arm Deadlift", @"3 sets / 15 reps", @"Inch Worm Push Up", @"3 sets / 15 reps", @"Skip", @"1 min / 3 sets",  @"Butt Kicks", @"3 mins / 100 reps", @"Standing Shoulder Press", @"3 sets / 15 reps", @"Bent Lateral Raises", @"3 sets / 15 reps", @"Skip", @"1 min / 3 sets", @"V Sit", @"100 reps", @"Sit Ups", @"50 reps", @"Flutter Kicks", @"100 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if (day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"5 sets / 15 reps", @"Push Ups", @"5 sets / 15 reps", @"Bent Over Barbell Row", @"3 sets / 15 reps", @"Standing Shrug", @"3 sets / 15 reps", @"Bench Dips", @"3 sets / 15 reps", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat and Press", @"3 sets / 20 reps", @"Knee Abductions", @"3 sets / 50 reps", @"Burpee Push Up", @"3 sets / 30 reps", @"Sit Ups", @"3 sets / 50 reps",  @"Toe Touches", @"3 sets / 100 reps",  @"Bicycle Crunch", @"3 sets / 100 reps",  @"Concentration Curl", @"3 sets / 15 reps",  @"Narrow Grip Pull Up", @"3 sets / 12 reps",  @"Laying Windshield Wipers", @"3 sets / 20 reps", @"Sprint", @"1 min on 30 secs off / 20 sets", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 6) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 12 reps", @"Jumping Split Squat", @"3 sets / 30 reps", @"Skip", @"1 min / 3 sets", @"Narrow Grip Pull Up", @"3 sets / 15 reps", @"Burpee Push Up", @"3 sets / 20 reps", @"High Knees", @"3 sets / 100 reps", @"Hanging Leg Raises", @"3 sets / 12 reps", @"Plank", @"45 secs / 3 sets",  @"Side Plank", @"45 secs / 3 sets",  @"Jogging", @"20 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Single Arm Deadlift", @"3 sets / 15 reps", @"Inch Worm Push Up", @"3 sets / 15 reps", @"Skip", @"1 min / 3 sets",  @"Butt Kicks", @"3 mins / 100 reps", @"Standing Shoulder Press", @"3 sets / 15 reps", @"Bent Lateral Raises", @"3 sets / 15 reps", @"Skip", @"1 min / 3 sets", @"V Sit", @"100 reps", @"Sit Ups", @"50 reps", @"Flutter Kicks", @"100 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if (day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"5 sets / 15 reps", @"Push Ups", @"5 sets / 15 reps", @"Bent Over Barbell Row", @"3 sets / 15 reps", @"Standing Shrug", @"3 sets / 15 reps", @"Bench Dips", @"3 sets / 15 reps", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat and Press", @"3 sets / 20 reps", @"Knee Abductions", @"3 sets / 50 reps", @"Burpee Push Up", @"3 sets / 30 reps", @"Sit Ups", @"3 sets / 50 reps",  @"Toe Touches", @"3 sets / 100 reps",  @"Bicycle Crunch", @"3 sets / 100 reps",  @"Concentration Curl", @"3 sets / 15 reps",  @"Narrow Grip Pull Up", @"3 sets / 12 reps",  @"Laying Windshield Wipers", @"3 sets / 20 reps", @"Sprint", @"1 min on 30 sec off / 20 sets", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga", @"Empty Space", nil];
            }
            else if(day == 5){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sports Activity", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 7) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 12 reps", @"Jumping Split Squat", @"3 sets / 30 reps", @"Skip", @"1 min / 3 sets", @"Narrow Grip Pull Up", @"3 sets / 15 reps", @"Burpee Push Up", @"3 sets / 20 reps", @"High Knees", @"3 sets / 100 reps", @"Hanging Leg Raises", @"3 sets / 12 reps", @"Plank", @"45 secs / 3 sets",  @"Side Plank", @"45 secs / 3 sets",  @"Jogging", @"20 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Single Arm Deadlift", @"3 sets / 15 reps", @"Inch Worm Push Up", @"3 sets / 15 reps", @"Skip", @"1 min / 3 sets",  @"Butt Kicks", @"3 mins / 100 reps", @"Standing Shoulder Press", @"3 sets / 15 reps", @"Bent Lateral Raises", @"3 sets / 15 reps", @"Skip", @"1 min / 3 sets", @"V Sit", @"100 reps", @"Sit Ups", @"50 reps", @"Flutter Kicks", @"100 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if (day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"5 sets / 15 reps", @"Push Ups", @"5 sets / 15 reps", @"Bent Over Barbell Row", @"3 sets / 15 reps", @"Standing Shrug", @"3 sets / 15 reps", @"Bench Dips", @"3 sets / 15 reps", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat and Press", @"3 sets / 20 reps", @"Knee Abductions", @"3 sets / 50 reps", @"Burpee Push Up", @"3 sets / 30 reps", @"Sit Ups", @"3 sets / 50 reps",  @"Toe Touches", @"3 sets / 100 reps",  @"Bicycle Crunch", @"3 sets / 100 reps",  @"Concentration Curl", @"3 sets / 15 reps",  @"Narrow Grip Pull Up", @"3 sets / 12 reps",  @"Laying Windshield Wipers", @"3 sets / 20 reps", @"Sprint", @"1 min on 30 sec off / 20 sets", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga", @"Empty Space", nil];
            }
            else if(day == 5){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sleep Benefits", @"Empty Space", nil];
            }
            else if(day == 6){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sports Activity", @"Empty Space", nil];
            }
        }
    }
    if([goal isEqualToString:@"BUILD MUSCLE MASS"]) {
        if (totalNumberOfDays == 1) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Deadlift", @"3 sets / 8 reps", @"Squat", @"3 sets / 8 reps", @"Wide Grip Pull Up", @"3 sets / 8 reps",  @"Bench Press", @"3 sets / 12 reps", @"Standing Shoulder Press", @"3 sets / 12 reps", @"Hanging Leg Raises", @"3 sets / 10 reps", @"Side Plank Hip Raises", @"3 sets / 10 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 2) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Deadlift", @"3 sets / 8 reps", @"Squat", @"4 sets / 8 reps", @"Leg Press", @"3 sets / 15 reps",  @"Skater Lunges", @"3 sets / 15 reps",  @"Lunges", @"3 sets / 15 reps", @"Calf Raises", @"4 sets / 20 reps", @"Sit Ups", @"100 reps", @"Hanging Leg Raises", @"3 sets / 10 reps", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
                
            }
            else if (day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Deadlift", @"4 sets / 5 reps", @"Wide Grip Pull Up", @"4 sets / 10 reps", @"Bent Over Dumbbell Row", @"4 sets / 6 reps", @"Bench Press", @"4 sets / 6 reps",  @"Standing Dumbbell Shoulder Press", @"4 sets / 15 reps", @"Bicep Curl", @"4 sets / 8 reps", @"Jogging",@"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 3) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Front Squat", @"3 sets / 8 reps",  @"Leg Press", @"3 sets / 15 reps", @"Lunges", @"3 sets / 15 reps", @"Ball Roll Ins", @"3 sets / 15 reps",   @"Skater Lunges", @"3 sets / 15 reps", @"Plank", @"45 secs / 3 sets", @"Hanging Leg Raises", @"4 sets / 12 reps", @"Toe Touches", @"100 reps",  @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"8 reps", @"Bent Over Barbell Row", @"3 sets / 8 reps", @"Wide Grip Lateral Pull Down", @"3 sets / 5 reps", @"Push Up On Ball", @"3 sets / 10 reps",  @"Standing Shoulder Press", @"3 sets / 10 reps", @"Bent Lateral Raises", @"3 sets / 15 reps", @"Standing Shrug", @"3 sets / 6 reps",  @"Ez Bar Curl", @"4 sets / 15 reps", @"Bench Dips", @"4 sets / 15 reps", @"Jogging",@"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
                
            }
            else if (day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Deadlift", @"5 sets / 5 reps", @"Kettle Bell Swing", @"4 sets / 12 reps", @"Upright Row", @"3 sets / 15 reps", @"Push Ups", @"3 sets / 50 reps", @"Dumbbell Drop", @"3 sets / 15 reps", @"V Sit", @"100 reps", @"Sit Ups", @"100 reps", @"Rowing", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 4) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"8 reps", @"Bent Lateral Raises", @"4 sets / 20 reps", @"Push Ups", @"25 reps", @"Standing Dumbbell Shoulder Press", @"4 sets / 10 reps", @"Weighted Chest Fly", @"3 sets / 20 reps", @"Dumbbell Drop", @"3 sets / 20 reps", @"Plank", @"45 secs / 5 sets", @"Side Plank Hip Raises", @"3 sets / 10 sides", @"Running", @"20 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space",  @"Squat", @"4 sets / 12 reps", @"Leg Press", @"2 sets / 12 reps", @"Lunges", @"3 sets / 15 reps", @"Skater Lunges", @"3 sets / 15 reps", @"Hanging Leg Raises", @"3 sets / 10 reps",  @"Bicycle Crunch", @"100 reps", @"Toe Touches", @"100 reps", @"Jogging",@"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Wide Grip Lateral Pull Down", @"3 sets / 6 reps", @"Upright Row", @"3 sets / 15 reps",  @"Bent Over Barbell Row", @"3 sets / 8 reps", @"Power Shrug", @"3 sets / 15 reps", @"Bicep Curl", @"5 sets / 10 reps",  @"Supermans",  @"2 sets / 50 reps", @"Ab roller",@"Empty Space", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Deadlift", @"4 sets / 5 reps", @"Skater Lunges", @"3 sets / 15 reps", @"Single Arm Bent Over Row", @"3 sets / 20 reps", @"Jumping Split Squat", @"3 sets / 50 reps", @"Sit Ups", @"50 reps", @"Calf Raises", @"3 sets / 20 reps", @"Side Plank", @"30 secs / 3 sets", @"Plank",@"45 secs / 5 sets", @"Jogging",@"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 5) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"5 sets / 8 reps", @"Bent Lateral Raises", @"4 sets / 20 reps", @"Push Ups", @"25 reps", @"Standing Dumbbell Shoulder Press", @"4 sets / 10 reps", @"Weighted Chest Fly", @"3 sets / 20 reps", @"Dumbbell Drop", @"3 sets / 20 reps", @"Plank", @"45 secs / 5 sets", @"Side Plank Hip Raises", @"3 sets / 10 sides", @"Running", @"20 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space",  @"Squat", @"4 sets / 12 reps", @"Leg Press", @"3 sets / 12 reps", @"Lunges", @"3 sets / 15 reps", @"Skater Lunges", @"3 sets / 15 reps", @"Hanging Leg Raises", @"3 sets / 10 reps",  @"Bicycle Crunch", @"100 reps", @"Toe Touches", @"100 reps", @"Jogging",@"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Wide Grip Lateral Pull Down", @"3 sets / 6 reps", @"Upright Row", @"3 sets / 15 reps",  @"Bent Over Barbell Row", @"3 sets / 8 reps", @"Power Shrug", @"3 sets / 15 reps", @"Bicep Curl", @"5 sets / 10 reps",  @"Supermans",  @"2 sets / 50 reps", @"Ab roller",@"Empty Space", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Deadlift", @"4 sets / 5 reps", @"Skater Lunges", @"3 sets / 15 reps", @"Single Arm Bent Over Row", @"3 sets / 20 reps", @"Jumping Split Squat", @"3 sets / 50 reps", @"Sit Ups", @"50 reps", @"Calf Raises", @"3 sets / 20 reps", @"Side Plank", @"30 secs / 3 sets", @"Plank",@"45 secs / 5 sets", @"Jogging",@"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 6) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"4 sets / 8 reps", @"Bent Lateral Raises", @"4 sets / 20 reps", @"Push Ups", @"25 reps", @"Standing Dumbbell Shoulder Press", @"4 sets / 10 reps", @"Weighted Chest Fly", @"3 sets / 20 reps", @"Dumbbell Drop", @"3 sets / 20 reps", @"Plank", @"45 secs / 5 sets", @"Side Plank Hip Raises", @"3 sets / 10 sides", @"Running", @"20 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space",  @"Squat", @"4 sets / 12 reps", @"Leg Press", @"3 sets / 12 reps", @"Lunges", @"3 sets / 15 reps", @"Skater Lunges", @"3 sets / 15 reps", @"Hanging Leg Raises", @"3 sets / 10 reps",  @"Bicycle Crunch", @"100 reps", @"Toe Touches", @"100 reps", @"Jogging",@"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Wide Grip Lateral Pull Down", @"3 sets / 12 reps", @"Upright Row", @"3 sets / 15 reps",  @"Bent Over Barbell Row", @"3 sets / 8 reps", @"Power Shrug", @"3 sets / 15 reps", @"Bicep Curl", @"5 sets / 10 reps",  @"Supermans",  @"Empty Space", @"Ab roller",@"2 sets / 30 reps", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Deadlift", @"4 sets / 5 reps", @"Skater Lunges", @"3 sets / 15 reps", @"Single Arm Bent Over Row", @"3 sets / 20 reps", @"Jumping Split Squat", @"3 sets / 50 reps", @"Sit Ups", @"50 reps", @"Calf Raises", @"3 sets / 20 reps", @"Side Plank", @"30 secs / 3 sets", @"Plank",@"45 secs / 5 sets", @"Jogging",@"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga", @"Empty Space", nil];
            }
            else if(day == 5){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sports Activity", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 7) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"4 sets / 8 reps", @"Bent Lateral Raises", @"4 sets / 20 reps", @"Push Ups", @"2 sets / 25 reps", @"Standing Dumbbell Shoulder Press", @"4 sets / 10 reps", @"Weighted Chest Fly", @"3 sets / 20 reps", @"Dumbbell Drop", @"3 sets / 20 reps", @"Plank", @"45 secs / 5 sets", @"Side Plank Hip Raises", @"3 sets / 10 sides", @"Running", @"20 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space",  @"Squat", @"4 sets / 12 reps", @"Leg Press", @"2 sets / 12 reps", @"Lunges", @"3 sets / 15 reps", @"Skater Lunges", @"3 sets / 15 reps", @"Hanging Leg Raises", @"3 sets / 10 reps",  @"Bicycle Crunch", @"100 reps", @"Toe Touches", @"100 reps", @"Jogging",@"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Wide Grip Lateral Pull Down", @"3 sets / 6 reps", @"Upright Row", @"3 sets / 15 reps",  @"Bent Over Barbell Row", @"3 sets / 8 reps", @"Power Shrug", @"3 sets / 15 reps", @"Bicep Curl", @"5 sets / 10 reps",  @"Supermans",  @"Empty Space", @"Ab roller",@"Empty Space", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Deadlift", @"4 sets / 5 reps", @"Skater Lunges", @"3 sets / 15 reps", @"Single Arm Bent Over Row", @"3 sets / 20 reps", @"Jumping Split Squat", @"3 sets / 50 reps", @"Sit Ups", @"50 reps", @"Calf Raises", @"3 sets / 20 reps", @"Side Plank", @"30 secs / 3 sets", @"Plank",@"45 secs / 5 sets", @"Jogging",@"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 4) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga", @"Empty Space", nil];
            }
            else if(day == 5){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sleep Benefits", @"Empty Space", nil];
            }
            else if(day == 6){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sports Activity", @"Empty Space", nil];
            }
        }
    }
    else if([goal isEqualToString:@"MUSCLE ISOLATION"]) {
        if (totalNumberOfDays == 1) { // Abs
            workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Sit Ups", @"100 reps", @"Knee Abductions", @"100 reps", @"Side Plank Hip Raises", @"3 sets / 20 reps", @"Plank", @"45 secs / 5 sets", @"Ab Roller", @"50 sets", @"Hanging Leg Raises", @"3 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            
        }
        else if(totalNumberOfDays == 2) {
            if (day == 0) { // Abs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Sit Ups", @"100 reps", @"Knee Abductions", @"100 reps", @"Side Plank Hip Raises", @"3 sets / 20 reps", @"Plank", @"45 secs / 5 sets", @"Ab Roller", @"50 sets", @"Hanging Leg Raises", @"3 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
                
            }
            else if (day == 1) { // Legs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 15 reps", @"Lunges", @"3 sets / 15 reps", @"Deadlift", @"3 sets / 15 reps", @"Skater Lunges", @"3 sets / 15 reps",  @"Leg Press", @"3 sets / 15 reps", @"Jump Squat", @"3 sets / 15 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
        }
        else if(totalNumberOfDays == 3) {
            if (day == 0) { // Abs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Sit Ups", @"100 reps", @"Knee Abductions", @"100 reps", @"Side Plank Hip Raises", @"3 sets / 20 reps", @"Plank", @"45 secs / 5 sets", @"Ab Roller", @"50 sets", @"Hanging Leg Raises", @"3 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
                
            }
            else if (day == 1) { // Legs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 15 reps", @"Lunges", @"3 sets / 15 reps", @"Deadlift", @"3 sets / 15 reps", @"Skater Lunges", @"3 sets / 15 reps",  @"Leg Press", @"3 sets / 15 reps", @"Jump Squat", @"3 sets / 15 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if (day == 2) { // Chest
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Bench Press", @"3 sets / 15 reps", @"Weighted Chest Fly", @"3 sets / 15 reps", @"Push Ups", @"3 sets / 25 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
        }
        else if(totalNumberOfDays == 4) {
            if (day == 0) { // Abs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Sit Ups", @"100 reps", @"Knee Abductions", @"100 reps", @"Side Plank Hip Raises", @"3 sets / 20 reps", @"Plank", @"45 secs / 5 sets", @"Ab Roller", @"50 sets", @"Hanging Leg Raises", @"3 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
                
            }
            else if (day == 1) { // Legs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 15 reps", @"Lunges", @"3 sets / 15 reps", @"Deadlift", @"3 sets / 15 reps", @"Skater Lunges", @"3 sets / 15 reps",  @"Leg Press", @"3 sets / 15 reps", @"Jump Squat", @"3 sets / 15 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if (day == 2) { // Chest
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Bench Press", @"3 sets / 15 reps", @"Incline Bench Press", @"3 sets / 20 reps", @"Weighted Chest Fly", @"3 sets / 15 reps", @"Push Ups", @"50 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 3) { // Back
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Deadlift", @"3 sets / 20 reps", @"Wide Grip Pull Up", @"3 sets / 20 reps", @"Bent Over Alternating Row", @"3 sets / 20 reps", @"Power Shrug", @"3 sets / 20 reps", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
        }
        else if(totalNumberOfDays == 5) {
            if (day == 0) { // Abs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Sit Ups", @"100 reps", @"Knee Abductions", @"100 reps", @"Side Plank Hip Raises", @"3 sets / 20 reps", @"Plank", @"45 secs / 5 sets", @"Ab Roller", @"50 sets", @"Hanging Leg Raises", @"3 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
                
            }
            else if (day == 1) { // Legs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 15 reps", @"Lunges", @"3 sets / 15 reps", @"Deadlift", @"3 sets / 15 reps", @"Skater Lunges", @"3 sets / 15 reps",  @"Leg Press", @"3 sets / 15 reps", @"Jump Squat", @"3 sets / 15 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if (day == 2) { // Chest
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Bench Press", @"3 sets / 15 reps", @"Incline Bench Press", @"3 sets / 20 reps", @"Weighted Chest Fly", @"3 sets / 15 reps", @"Push Ups", @"3 sets / 25 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 3) { // Back
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Deadlift", @"3 sets / 20 reps", @"Wide Grip Pull Up", @"3 sets / 20 reps", @"Bent Over Alternating Row", @"3 sets / 20 reps", @"Power Shrug", @"3 sets / 20 reps", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 4) {  // Shoulders
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Standing Shoulder Press", @"3 sets / 8 reps", @"Bent Lateral Raises", @"3 sets / 12 reps", @"Seated Shoulder Press", @"3 sets / 8 reps", @"Front Raises", @"3 sets / 15 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
        }
        else if(totalNumberOfDays == 6) {
            if (day == 0) { // Abs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Sit Ups", @"100 reps", @"Knee Abductions", @"100 reps", @"Side Plank Hip Raises", @"3 sets / 20 reps", @"Plank", @"45 secs / 5 sets", @"Ab Roller", @"50 sets", @"Hanging Leg Raises", @"3 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
                
            }
            else if (day == 1) { // Legs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 15 reps", @"Lunges", @"3 sets / 15 reps", @"Deadlift", @"3 sets / 15 reps", @"Skater Lunges", @"3 sets / 15 reps",  @"Leg Press", @"3 sets / 15 reps", @"Jump Squat", @"3 sets / 15 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if (day == 2) { // Chest
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Bench Press", @"3 sets / 15 reps", @"Incline Bench Press", @"3 sets / 20 reps", @"Weighted Chest Fly", @"3 sets / 15 reps", @"Push Ups", @"50 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 3) { // Back
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Deadlift", @"3 sets / 20 reps", @"Wide Grip Pull Up", @"3 sets / 20 reps", @"Bent Over Alternating Row", @"3 sets / 20 reps", @"Power Shrug", @"3 sets / 20 reps", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 4) {  // Shoulders
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Standing Shoulder Press", @"3 sets / 8 reps", @"Bent Lateral Raises", @"3 sets / 12 reps", @"Seated Shoulder Press", @"3 sets / 8 reps", @"Front Raises", @"3 sets / 15 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 5) { // Arms
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Ez Bar Curl", @"3 sets / 10 reps", @"Bench Dips", @"5 sets / 10 reps", @"Preacher Curl", @"3 sets / 10 reps", @"Tricep Kick backs", @"3 sets / 15 reps",  @"Concentration Curl", @"3 sets / 8 reps", @"Dumbbell Skull Crushers", @"3 sets / 8 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
        }
        else if(totalNumberOfDays == 7) {
            if (day == 0) { // Abs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Sit Ups", @"100 reps", @"Knee Abductions", @"100 reps", @"Side Plank Hip Raises", @"3 sets / 20 reps", @"Plank", @"45 secs / 5 sets", @"Ab Roller", @"50 sets", @"Hanging Leg Raises", @"3 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
                
            }
            else if (day == 1) { // Legs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 15 reps", @"Lunges", @"3 sets / 15 reps", @"Deadlift", @"3 sets / 15 reps", @"Skater Lunges", @"3 sets / 15 reps",  @"Leg Press", @"3 sets / 15 reps", @"Jump Squat", @"3 sets / 15 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if (day == 2) { // Chest
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Bench Press", @"3 sets / 15 reps", @"Incline Bench Press", @"3 sets / 20 reps", @"Weighted Chest Fly", @"3 sets / 15 reps", @"Push Ups", @"3 sets / 25 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 3) { // Back
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Deadlift", @"3 sets / 20 reps", @"Wide Grip Pull Up", @"3 sets / 20 reps", @"Bent Over Alternating Row", @"3 sets / 20 reps", @"Power Shrug", @"3 sets / 20 reps", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 4) {  // Shoulders
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Standing Shoulder Press", @"3 sets / 8 reps", @"Bent Lateral Raises", @"3 sets / 12 reps", @"Seated Shoulder Press", @"3 sets / 8 reps", @"Front Raises", @"3 sets / 15 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 5) { // Arms
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Ez Bar Curl", @"3 sets / 10 reps", @"Bench Dips", @"5 sets / 10 reps", @"Preacher Curl", @"3 sets / 10 reps", @"Tricep Kick backs", @"3 sets / 15 reps",  @"Concentration Curl", @"3 sets / 8 reps", @"Dumbbell Skull Crushers", @"3 sets / 8 reps", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 6){
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Sports Activity", @"Empty Space", nil];
            }
        }
    }
    
    return workoutArray;
}

@end
