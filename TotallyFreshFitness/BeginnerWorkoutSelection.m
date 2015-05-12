//
//  BeginnerWorkoutSelection.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/19/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "BeginnerWorkoutSelection.h"

@implementation BeginnerWorkoutSelection

/*
 Singleton BeginnerWorkoutSelection object
 */
+ (BeginnerWorkoutSelection *)sharedInstance {
	static BeginnerWorkoutSelection *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 Load up workout array
 */
- (NSMutableArray *)beginnerWorkoutGoal:(NSString *)goal WithTheDay:(int)day ForTotalWorkOutDays:(int)totalNumberOfDays;
{
    // Load up the array with data
    NSMutableArray  *workoutArray                 = nil;
    
    if ([goal isEqualToString:@"SHRED FAT"]) {
        if (totalNumberOfDays == 1) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"1 min", @"High Knees", @"1 min", @"Butt Kicks", @"1 min", @"Skip", @"1 min", @"Jogging", @"1 min", @"Burpees", @"1 min", @"Skip", @"1 min", @"Jogging", @"1 min", @"Burpees", @"1 min", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 2) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"1 min", @"High Knees", @"1 min", @"Butt Kicks", @"1 min", @"Skip", @"1 min", @"Jogging", @"1 min", @"Burpees", @"1 min", @"Skip", @"1 min", @"Jogging", @"1 min", @"Burpees", @"1 min", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if (day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jogging", @"10 mins", @"Burpees", @"20 reps", @"Mountain Climbers", @"50 reps", @"Skip", @"2 mins", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 3) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"1 min", @"High Knees", @"1 min", @"Reverse Lunge", @"1 min", @"Butt Kicks", @"1 min", @"Skip", @"1 min", @"Burpees", @"1 min", @"Sleep Benefits", @"Mountain Climbers", @"1 min", @"Bike", @"20 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
                
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Bike", @"15 mins", @"Bicycle Crunch", @"100 reps", @"Skip", @"2 mins", @"Jogging", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
                
            }
            else if (day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Lunges", @"20 reps", @"Mountain Climbers", @"50 reps", @"Push Ups", @"20 reps", @"Burpees", @"20 reps", @"High Knees", @"50 reps", @"Butt Kicks", @"50 reps", @"Jogging", @"10 mins", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 4) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"1 min", @"High Knees", @"1 min", @"Reverse Lunge", @"1 min", @"Butt Kicks", @"1 min", @"Skip", @"1 min", @"Burpees", @"1 min", @"Mountain Climbers", @"1 min", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Bike", @"15 mins", @"Bicycle Crunch", @"100 reps", @"Skip", @"2 mins", @"Jogging", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Lunges", @"20 reps", @"Mountain Climbers", @"50 reps", @"Push Ups", @"20 reps", @"Burpees", @"20 reps", @"High Knees", @"50 reps", @"Butt Kicks", @"50 reps", @"Jogging", @"10 mins", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"10 mins", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 5) {
            if(day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"1 min", @"High Knees", @"1 min", @"Reverse Lunge", @"1 min", @"Butt Kicks", @"1 min", @"Skip", @"1 min", @"Burpees", @"1 min", @"Mountain Climbers", @"1 min", nil];
                
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jogging", @"15 mins", @"Bike", @"15 mins", @"Bicycle Crunch", @"100 reps", @"Skip", @"1 min", nil];
                
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sleep Benefits", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Lunges", @"20 reps", @"Mountain Climbers", @"50 reps", @"Push Ups", @"20 reps", @"Burpees", @"20 reps", @"High Knees", @"50 reps", @"Butt Kicks", @"50 reps", nil];
                
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sports Activity", @"Empty Space", @"Sleep Benefits", nil];
            }
        }
        else if(totalNumberOfDays == 6) {
            if(day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"1 min", @"High Knees", @"1 min", @"Reverse Lunge", @"1 min", @"Butt Kicks", @"1 min", @"Skip", @"1 min", @"Burpees", @"1 min", @"Mountain Climbers", @"1 min", nil];
                
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Bike", @"15 mins", @"Bicycle Crunch", @"100 reps", @"Skip", @"1 min", nil];
                
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Lunges", @"20 reps", @"Mountain Climbers", @"50 reps", @"Push Ups", @"20 reps", @"Burpees", @"20 reps", @"High Knees", @"50 reps", @"Butt Kicks", @"50 reps", nil];
                
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sports Activity", @"Empty Space", nil];
            }
            else if(day == 5){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sports Activity", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 7) {
            if(day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"1 min", @"High Knees", @"1 min", @"Reverse Lunge", @"1 min", @"Butt Kicks", @"1 min", @"Skip", @"1 min", @"Burpees", @"1 min", @"Mountain Climbers", @"1 min", nil];
                
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"15 mins",@"Foam Roll", @"Empty Space", @"Bike", @"15 mins", @"Bicycle Crunch", @"100 reps", @"Skip", @"1 min", nil];
                
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Lunges", @"20 reps", @"Mountain Climbers", @"50 reps", @"Push Ups", @"20 reps", @"Burpees", @"20 reps", @"High Knees", @"50 reps", @"Butt Kicks", @"50 reps", nil];
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sleep Benefits", @"Empty Space", nil];
            }
            else if(day == 5){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sports Activity", @"Empty Space", nil];
            }
            else if(day == 6){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sleep Benefits", @"Empty Space", nil];
            }
        }
    }
    else if([goal isEqualToString:@"GET TONED"]) {
        if (totalNumberOfDays == 1) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Body Weight Squats", @"2 sets / 20 reps", @"Crunches", @"20 reps", @"Lunges", @"20 reps", @"Bent Over Dumbbell Row", @"20 reps", @"Bicycle Crunch", @"20 reps", @"Supermans", @"20 reps", @"Plank", @"30 secs / 3 sets", @"Bike", @"20 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 2) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Push Ups", @"2 sets / 30 reps", @"Bent Over Dumbbell Row", @"2 sets / 20 reps", @"High Knees", @"30 reps", @"Standing Shoulder Press", @"2 sets / 20 reps", @"Burpees", @"10 reps", @"Bicep Curl", @"2 sets / 15 reps", @"Bench Dips", @"15 reps", @"Plank", @"30 secs / 3 sets", @"Bike", @"20 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if (day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Body Weight Squats", @"3 sets / 30 reps", @"Lunges", @"3 sets / 30 reps", @"Ball Roll Ins", @"3 sets / 30 reps", @"Calf Raises", @"3 sets / 30 reps", @"Bicycle Crunch", @"3 sets / 30 reps", @"Elliptical", @"20 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 3) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Push Ups", @"3 sets / 20 reps", @"Bicycle Crunch", @"3 sets / 30 reps", @"Bent Over Dumbbell Row", @"3 sets / 30 reps", @"Mountain Climbers", @"50 reps", @"Squat and Press", @"3 sets / 15 reps", @"Supermans", @"50 reps", @"Bike", @"20 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Body Weight Squats", @"3 sets / 20 reps", @"Toe Touches", @"3 sets / 20 reps", @"Lunges", @"3 sets / 20 reps", @"Flutter Kicks", @"50 reps", @"Squat and Press", @"2 sets / 15 reps", @"Plank", @"3 sets / 30 reps", @"Jogging", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
                
            }
            else if (day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jogging", @"30 sec / 20 sets", @"Bicycle Crunch", @"100 reps", @"Toe Touches", @"100 reps", @"Side Plank", @"3 sets / 30 reps", @"Jogging", @"10 mins", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 4) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Push Ups", @"2 sets / 20 reps", @"Bicycle Crunch", @"50 reps", @"Bent Over Dumbbell Row", @"2 sets / 20 reps", @"Mountain Climbers", @"50 reps", @"Squat and Press", @"3 sets / 15 reps", @"Supermans", @"50 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
                
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 20 reps", @"Toe Touches", @"50 reps", @"Reverse Lunge", @"3 sets / 20 reps", @"Flutter Kicks", @"Empty Space", @"Squat and Press", @"2 sets / 15 reps", @"Plank", @"30 secs / 13 sets", @"Bicycle Crunch", @"100 reps", @"Jogging", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
                
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jogging", @"1 min - 30 sec rest / 25 sets", @"Seated Shoulder Press", @"2 sets / 15 reps", @"Toe Touches", @"50 reps", @"Supermans", @"50 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
                
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Bike", @"5 mins", @"Squat", @"12 reps", @"Push Ups", @"12 reps", @"Bent Over Dumbbell Row", @"4 sets / 12 reps", @"Jogging", @"10 mins", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 5) {
            if(day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Push ups", @"2 sets / 20 reps", @"Bicycle Crunch", @"50 reps", @"Bent Over Dumbbell Row", @"2 sets / 20 reps", @"Mountain Climbers", @"50 reps", @"Squat and Press", @"2 sets / 15 reps", @"Supermans", @"50 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 20 reps", @"Toe Touches", @"50 reps", @"Reverse Lunge", @"3 sets / 20 reps", @"Flutter Kicks", @"Empty Space", @"Plea Squat Upright Row", @"2 sets / 15 reps", @"Plank", @"30 secs / 13 sets", @"Bicycle Crunch", @"100 reps", @"Jogging", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jogging", @"1 min - 30 sec rest / 25 sets", @"Seated Shoulder Press", @"2 sets / 15 reps", @"Toe Touches", @"50 reps", @"Supermans", @"50 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
                
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Bike", @"5 mins", @"Squat", @"3 sets / 30 reps", @"Push Ups", @"3 sets / 30 reps", @"Bent Over Dumbbell Row", @"4 sets / 12 reps", @"Jogging", @"10 mins", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 6) {
            if(day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Push ups", @"3 sets / 30 reps", @"Bicycle Crunch", @"50 reps", @"Bent Over Dumbbell Row", @"3 sets / 30 reps", @"Mountain Climbers", @"50 reps", @"Squat and Press", @"3 sets / 15 reps", @"Supermans", @"50 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 20 reps", @"Toe Touches", @"50 reps", @"Reverse Lunge", @"3 sets / 20 reps", @"Flutter Kicks", @"Empty Space", @"Plea Squat Upright Row", @"3 sets / 15 reps", @"Plank", @"30 secs / 13 sets", @"Bicycle Crunch", @"100 reps", @"Jogging", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jogging", @"1 min - 30 sec rest / 25 sets", @"Seated Shoulder Press", @"3 sets / 15 reps", @"Toe Touches", @"50 reps", @"Supermans", @"50 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
                
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Bike", @"5 mins", @"Squat", @"3 sets / 30 reps", @"Push Ups", @"3 sets / 30 reps", @"Bent Over Dumbbell Row", @"4 sets / 12 reps", @"Jogging", @"10 mins", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 5){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sports Activity", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 7) {
            if(day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Push ups", @"3 sets / 20 reps", @"Bicycle Crunch", @"50 reps", @"Bent Over Dumbbell Row", @"3 sets / 20 reps", @"Mountain Climbers", @"50 reps", @"Squat and Press", @"2 sets / 15 reps", @"Supermans", @"50 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 20 reps", @"Toe Touches", @"50 reps", @"Reverse Lunge", @"3 sets / 20 reps", @"Flutter Kicks", @"Empty Space", @"Squat and Press", @"2 sets / 15 reps", @"Plank", @"30 secs / 13 sets", @"Bicycle Crunch", @"100 reps", @"Jogging", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jogging", @"1 min - 30 sec rest / 25 sets", @"Seated Shoulder Press", @"2 sets / 15 reps", @"Toe Touches", @"50 reps", @"Supermans", @"50 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
                
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Bike", @"5 mins", @"Squat", @"3 sets / 30 reps", @"Push Ups", @"3 sets / 30 reps", @"Bent Over Dumbbell Row", @"4 sets / 12 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 5){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sleep Benefits", @"Empty Space", nil];
            }
            else if(day == 6){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sports Activity", @"Empty Space", nil];
            }
        }
    }
    else if([goal isEqualToString:@"BUILD MUSCLE MASS"]) {
        if (totalNumberOfDays == 1) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Bench Press", @"4 sets / 10 reps", @"Seated Row", @"4 sets / 10 reps", @"Seated Shoulder Press", @"4 sets / 10 reps", @"Leg Press", @"4 sets / 10 reps", @"Calf Raises", @"4 sets / 20 reps", @"Plank", @"30 secs / 3 sets", @"Crunches", @"2 sets / 30 reps", @"Supermans", @"2 sets / 20 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 2) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Bench Press", @"3 sets / 10 reps", @"Seated Row", @"3 sets / 10 reps", @"Seated Shoulder Press", @"3 sets / 10 reps", @"Wide Grip Lateral Pull Down", @"3 sets / 10 reps", @"Crunches", @"3 sets / 20 reps", @"Plank", @"30 secs", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
                
            }
            else if (day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Leg Press", @"3 sets / 15 reps", @"Lunges", @"3 sets / 15 reps", @"Ball Roll Ins", @"3 sets / 15 reps", @"Bicep Curl", @"3 sets / 15 reps", @"Tricep Rope Pull Down", @"3 sets / 15 reps", @"Calf Raises", @"3 sets / 10 reps", @"Jogging",@"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 3) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Bench Press", @"3 sets / 8 reps", @"Seated Row", @"3 sets / 8 reps", @"Bicep Curl", @"3 sets/ 12 reps", @"Bench Dips", @"3 sets / 15 reps", @"Toe Touches", @"50 reps", @"Supermans", @"50 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Leg Press", @"3 sets / 15 reps", @"Lunges", @"3 sets / 20 reps", @"Ball Roll Ins", @"3 sets / 20 reps", @"Calf Raises", @"2 sets / 15 reps", @"Plank", @"30 secs / 5 sets", @"Side Plank", @"30 secs / 3 sets", @"Jogging",@"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
                
            }
            else if (day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"3 sets / 8 reps", @"Wide Grip Lateral Pull Down", @"3 sets / 12 reps", @"Seated Shoulder Press", @"3 sets / 10 reps", @"Bent Lateral Raises", @"3 sets / 15 reps", @"Bicep Curl", @"3 sets / 10 reps", @"Tricep Extension", @"3 sets / 10 reps", @"Jogging",@"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 4) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Bench Press", @"3 sets / 8 reps", @"Seated Row", @"3 sets / 12 reps", @"Seated Shoulder Press", @"3 sets/ 10 reps", @"Wide Grip Lateral Pull Down", @"3 sets / 15 reps", @"Knee Abductions", @"50 reps", @"Plank", @"30 secs / 5 sets", @"Supermans", @"50 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"4 sets / 15 reps", @"Lunges", @"4 sets / 15 reps", @"Leg Press", @"4 sets / 12 reps", @"Calf Raises", @"4 sets / 10 reps", @"Side Plank", @"30 secs / 2 sets", @"Supermans", @"100 reps", @"Jogging",@"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"3 sets / 12 reps", @"Seated Row", @"3 sets / 12 reps", @"Seated Shoulder Press", @"3 sets / 12 reps", @"Wide Grip Lateral Pull Down", @"3 sets / 12 reps", @"Bicep Curl", @"3 sets / 10 reps", @"Bench Dips", @"3 sets / 10 reps", @"Toe Touches",@"50 reps", @"Bicycle Crunch", @"50 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 15 reps", @"Lunges", @"3 sets / 15 reps", @"Leg Press", @"3 sets / 15 reps", @"Calf Raises", @"3 sets / 10 reps", @"Hanging Leg Raises", @"3 sets / 10 reps", @"Weighted Crunch On Ball", @"3 sets / 15 reps", @"Seated Row",@"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 5) {
            if(day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Bench Press", @"3 sets / 8 reps", @"Seated Row", @"3 sets / 12 reps", @"Seated Shoulder Press", @"3 sets/ 10 reps", @"Wide Grip Lateral Pull Down", @"3 sets / 15 reps", @"Knee Abductions", @"50 reps", @"Plank", @"30 secs / 5 sets", @"Supermans", @"50 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 15 reps", @"Lunges", @"3 sets / 15 reps", @"Leg Press", @"3 sets / 12 reps", @"Calf Raises", @"3 sets / 10 reps", @"Side Plank", @"30 secs / 3 sets", @"Supermans", @"100 reps", @"Jogging",@"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"3 sets / 12 reps", @"Seated Row", @"3 sets / 12 reps", @"Seated Shoulder Press", @"3 sets / 12 reps", @"Wide Grip Lateral Pull Down", @"3 sets / 12 reps", @"Bicep Curl", @"3 sets / 10 reps", @"Bench Dips", @"3 sets / 10 reps", @"Toe Touches",@"50 reps", @"Bicycle Crunch", @"50 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 15 reps", @"Lunges", @"3 sets / 15 reps", @"Leg Press", @"3 sets / 15 reps", @"Calf Raises", @"3 sets / 10 reps", @"Hanging Leg Raises", @"3 sets / 10 reps", @"Weighted Crunch On Ball", @"3 sets / 15 reps", @"Seated Row",@"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 6) {
            if(day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Bench Press", @"3 sets / 8 reps", @"Seated Row", @"32 sets / 12 reps", @"Seated Shoulder Press", @"3 sets/ 10 reps", @"Wide Grip Lateral Pull Down", @"3 sets / 15 reps", @"Knee Abductions", @"50 reps", @"Plank", @"30 secs / 5 sets", @"Supermans", @"50 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 15 reps", @"Lunges", @"3 sets / 15 reps", @"Leg Press", @"3 sets / 12 reps", @"Calf Raises", @"4 sets / 10 reps", @"Side Plank", @"30 secs / 3 sets", @"Supermans", @"100 reps", @"Jogging",@"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"3 sets / 12 reps", @"Seated Row", @"3 sets / 12 reps", @"Seated Shoulder Press", @"3 sets / 12 reps", @"Wide Grip Lateral Pull Down", @"3 sets / 12 reps", @"Bicep Curl", @"3 sets / 10 reps", @"Bench Dips", @"3 sets / 10 reps", @"Toe Touches",@"50 reps", @"Bicycle Crunch", @"50 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 15 reps", @"Lunges", @"3 sets / 15 reps", @"Leg Press", @"2 sets / 15 reps", @"Calf Raises", @"2 sets / 10 reps", @"Hanging Leg Raises", @"3 sets / 10 reps", @"Weighted Crunch On Ball", @"3 sets / 15 reps", @"Seated Row",@"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga", @"Empty Space", nil];
            }
            else if(day == 5){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sleep Benefits", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 7) {
            if(day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Bench Press", @"3 sets / 8 reps", @"Seated Row", @"3 sets / 12 reps", @"Seated Shoulder Press", @"3 sets/ 10 reps", @"Wide Grip Lateral Pull Down", @"2 sets / 15 reps", @"Knee Abductions", @"50 reps", @"Plank", @"30 secs / 5 sets", @"Supermans", @"50 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 15 reps", @"Lunges", @"3 sets / 15 reps", @"Leg Press", @"3 sets / 12 reps", @"Calf Raises", @"3 sets / 10 reps", @"Side Plank", @"30 secs / 3 sets", @"Supermans", @"100 reps", @"Jogging",@"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"3 sets / 12 reps", @"Seated Row", @"3 sets / 12 reps", @"Seated Shoulder Press", @"3 sets / 12 reps", @"Wide Grip Lateral Pull Down", @"3 sets / 12 reps", @"Bicep Curl", @"3 sets / 10 reps", @"Bench Dips", @"3 sets / 10 reps", @"Toe Touches",@"50 reps", @"Bicycle Crunch", @"50 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 15 reps", @"Lunges", @"3 sets / 15 reps", @"Leg Press", @"2 sets / 15 reps", @"Calf Raises", @"3 sets / 10 reps", @"Hanging Leg Raises", @"3 sets / 10 reps", @"Weighted Crunch On Ball", @"3 sets / 15 reps", @"Seated Row",@"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
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
            workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Crunches", @"2 sets / 30 reps", @"Plank", @"30 secs / 3 sets", @"Side Plank", @"30 secs / 3 sets", @"Supermans", @"3 sets / 30 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            
        }
        else if(totalNumberOfDays == 2) {
            if (day == 0) { // Abs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Crunches", @"2 sets / 30 reps", @"Plank", @"30 secs / 3 sets", @"Side Plank", @"30 secs / 3 sets", @"Supermans", @"3 sets / 30 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
                
            }
            else if (day == 1) { // Legs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 20 reps", @"Lunges", @"3 sets / 20 reps", @"Ball Roll Ins", @"3 sets / 20 reps", @"Calf Raises", @"3 sets / 10 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
        }
        else if(totalNumberOfDays == 3) {
            if (day == 0) { // Abs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Crunches", @"2 sets / 30 reps", @"Plank", @"30 secs / 3 sets", @"Side Plank", @"30 secs / 3 sets", @"Supermans", @"3 sets / 30 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
                
            }
            else if (day == 1) { // Legs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 20 reps", @"Lunges", @"3 sets / 20 reps", @"Ball Roll Ins", @"3 sets / 20 reps", @"Calf Raises", @"3 sets / 10 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if (day == 2) { // Chest
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Push Ups", @"3 sets / 20 reps", @"Incline Dumbbell Bench", @"3 sets / 20 reps", @"Weighted Chest Fly", @"3 sets / 20 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
        }
        else if(totalNumberOfDays == 4) {
            if (day == 0) { // Abs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Crunches", @"2 sets / 30 reps", @"Middle Plank", @"30 secs / 3 sets", @"Side Plank", @"30 secs / 3 sets", @"Supermans", @"3 sets / 30 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
                
            }
            else if (day == 1) { // Legs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 20 reps", @"Lunges", @"3 sets / 20 mins", @"Ball Roll Ins", @"3 sets / 20 mins", @"Calf Raises", @"3 sets / 10 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if (day == 2) { // Chest
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Push Ups", @"3 sets / 20 reps", @"Incline Dumbbell Bench", @"3 sets / 20 reps", @"Weighted Chest Fly", @"3 sets / 20 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 3) { // Back
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Wide Grip Lateral Pull Down", @"3 sets / 20 reps", @"Bent Over Alternating Row", @"3 sets / 20 reps", @"Power Shrug", @"3 sets / 20 reps", @"Seated Row", @"3 sets / 10 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
        }
        else if(totalNumberOfDays == 5) {
            if (day == 0) { // Abs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Crunches", @"2 sets / 30 reps", @"Middle Plank", @"30 secs / 3 sets", @"Side Plank", @"30 secs / 3 sets", @"Supermans", @"3 sets / 30 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
                
            }
            else if (day == 1) { // Legs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 20 reps", @"Lunges", @"3 sets / 20 mins", @"Ball Roll Ins", @"3 sets / 20 mins", @"Calf Raises", @"3 sets / 10 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if (day == 2) { // Chest
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Push Ups", @"3 sets / 20 reps", @"Incline Dumbbell Bench", @"3 sets / 20 reps", @"Weighted Chest Fly", @"3 sets / 20 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 3) { // Back
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Wide Grip Lateral Pull Down", @"3 sets / 20 reps", @"Bent Over Alternating Row", @"3 sets / 20 reps", @"Power Shrug", @"3 sets / 20 reps", @"Seated Row", @"3 sets / 10 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 4) {  // Shoulders
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Seated Shoulder Press", @"2 sets / 15 reps", @"Bent Lateral Raises", @"2 sets / 15 reps", @"Front Raises", @"2 sets / 15 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
        }
        else if(totalNumberOfDays == 6) {
            if (day == 0) { // Abs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Crunches", @"2 sets / 30 reps", @"Middle Plank", @"30 secs / 3 sets", @"Side Plank", @"30 secs / 3 sets", @"Supermans", @"3 sets / 30 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
                
            }
            else if (day == 1) { // Legs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 20 reps", @"Lunges", @"3 sets / 20 mins", @"Ball Roll Ins", @"3 sets / 20 mins", @"Calf Raises", @"3 sets / 10 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if (day == 2) { // Chest
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Push Ups", @"3 sets / 20 reps", @"Incline Dumbbell Bench", @"3 sets / 20 reps", @"Weighted Chest Fly", @"3 sets / 20 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 3) { // Back
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Wide Grip Lateral Pull Down", @"3 sets / 20 reps", @"Bent Over Alternating Row", @"3 sets / 20 reps", @"Power Shrug", @"3 sets / 20 reps", @"Seated Row", @"3 sets / 10 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 4) {  // Shoulders
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Seated Shoulder Press", @"2 sets / 15 reps", @"Bent Lateral Raises", @"2 sets / 15 reps", @"Front Raises", @"2 sets / 15 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 5) { // Arms
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Bicep Curl", @"2 sets / 15 reps", @"Bench Dips", @"2 sets / 15 reps", @"Concentration Curl", @"2 sets / 15 reps", @"Tricep Rope Pull Down", @"2 sets / 15 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
        }
        else if(totalNumberOfDays == 7) {
            if (day == 0) { // Abs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Crunches", @"2 sets / 30 reps", @"Middle Plank", @"30 secs / 3 sets", @"Side Plank", @"30 secs / 3 sets", @"Supermans", @"3 sets / 30 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
                
            }
            else if (day == 1) { // Legs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 20 reps", @"Lunges", @"3 sets / 20 mins", @"Ball Roll Ins", @"3 sets / 20 mins", @"Calf Raises", @"3 sets / 10 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if (day == 2) { // Chest
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Push Ups", @"3 sets / 20 reps", @"Incline Dumbbell Bench", @"3 sets / 20 reps", @"Weighted Chest Fly", @"3 sets / 20 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 3) { // Back
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Wide Grip Lateral Pull Down", @"3 sets / 20 reps", @"Bent Over Alternating Row", @"3 sets / 20 reps", @"Power Shrug", @"3 sets / 20 reps", @"Seated Row", @"3 sets / 10 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 4) {  // Shoulders
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Seated Shoulder Press", @"2 sets / 15 reps", @"Bent Lateral Raises", @"2 sets / 15 reps", @"Front Raises", @"2 sets / 15 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 5) { // Arms
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Bicep Curl", @"2 sets / 15 reps", @"Bench Dips", @"2 sets / 15 reps", @"Concentration Curl", @"2 sets / 15 reps", @"Tricep Rope Pull Down", @"2 sets / 15 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 6){
             workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Sports Activity", @"Empty Space", nil];
            }
        }
    }
    
    return workoutArray;
}

@end
