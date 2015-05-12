//
//  IntermediateWorkoutSelection.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/18/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "IntermediateWorkoutSelection.h"

@implementation IntermediateWorkoutSelection

/*
 Singleton AdvancedWorkoutSelection object
 */
+ (IntermediateWorkoutSelection *)sharedInstance {
	static IntermediateWorkoutSelection *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 Load up workout array
 */
- (NSMutableArray *)intermediateWorkoutGoal:(NSString *)goal WithTheDay:(int)day ForTotalWorkOutDays:(int)totalNumberOfDays;
{
    // Load up the array with data
    NSMutableArray  *workoutArray                 = nil;
    
    if ([goal isEqualToString:@"SHRED FAT"]) {
        if (totalNumberOfDays == 1) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"1 min", @"Lunges", @"1 min", @"Body Weight Squats", @"1 min", @"Burpees", @"1 min", @"High Knees", @"1 min", @"Butt Kicks", @"1 min", @"Skip", @"1 min", @"Mountain Climbers", @"1 min", @"Jump Tucks", @"1 min", @"Jumping Jacks", @"1 min", @"Sprint", @"1 min", @"Knee Abductions", @"1 min / 2 sets", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 2) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"1 min", @"Lunges", @"1 min", @"Body Weight Squats", @"1 min", @"Jumping Jacks", @"1 min", @"Squat", @"1 min", @"Skip", @"1 min", @"High Knees", @"1 min", @"Butt Kicks", @"1 min",  @"Burpees", @"1 min / 2 sets", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if (day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat and Press", @"30 secs - 10 sec rest / 8 sets", @"Inch Worm Push Up", @"30 secs - 10 sec rest / 8 sets", @"High Knees", @"30 secs - 10 sec rest / 8 sets",  @"Burpees", @"30 secs - 10 secs rest / 8 sets",  @"Butt Kicks", @"30 secs - 10 secs rest / 8 sets", @"Lunges", @"30 secs - 10 secs rest / 8 sets", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 3) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jogging", @"1 min - 30 sec rest / 5 sets", @"Running", @"1 min / 20 sets", @"Jogging", @"5 mins", @"Calf Raises", @"3 sets / 20 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
                
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"100 reps", @"High Knees", @"100 reps", @"Butt Kicks", @"100 reps", @"Jumping Split Squat", @"100 reps", @"Skip", @"2 mins / 100 sets", @"Mountain Climbers", @"100 sets", @"Knee Abductions", @"100 reps", @"Jogging", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if (day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat and Press", @"30 secs - 10 sec rest / 8 sets", @"Burpees", @"30 secs - 10 secs rest / 8 sets", @"Jumping Split Squat", @"30 secs - 10 sec rest / 8 sets", @"Mountain Climbers", @"30 secs - 10 secs rest / 8 sets",  @"High Knees", @"30 secs - 10 sec rest / 8 sets", @"Jumping Jacks", @"30 secs - 10 secs rest / 8 sets", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 4) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"1 min / 2 sets", @"Skip", @"1 min / 2 sets", @"High Knees", @"1 min  / 2 sets", @"Kettle Bell Swing", @"1 min", @"Jumping Split Squat", @"1 min", @"Plea Squat Upright Row", @"1 min / 2 sets", @"Mountain Climbers", @"1 min / 2 sets",  @"Burpees", @"1 min / 2 sets", @"Bike", @"20 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jogging", @"30 - 60 mins", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"2 mins", @"High Knees", @"1 min", @"Butt Kicks", @"1 min / 5 sets", @"Skip", @"1 min / 10 sets", @"Bicep Curl", @"12 / 2 sets", @"V Sit Ball Twists", @"100 reps", @"Sit Ups", @"50 reps", @"Bicycle Crunch", @"100 reps",  @"Plank", @"45 secs / 3 sets", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"30 secs - 10 sec rest / 8 sets", @"Kettle Bell Swing", @"30 secs - 10 sec rest / 8 sets", @"Plea Squat Upright Row", @"30 secs - 10 sec rest / 8 sets", @"Skip", @"30 secs - 10 sec rest / 8 sets",  @"Running", @"30 secs - 10 sec rest / 8 sets", @"Burpees", @"30 secs - 10 secs rest / 8 sets", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 5) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"1 min  / 2 sets", @"Skip", @"1 min / 2 sets", @"High Knees", @"1 min / 2 sets", @"Kettle Bell Swing", @"1 min / 2 sets", @"Jumping Split Squat", @"1 min / 2 sets", @"Plea Squat Upright Row", @"1 min / 2 sets", @"Mountain Climbers", @"1 min / 2 sets",  @"Burpees", @"1 min", @"Bike", @"20 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jogging", @"30 - 60 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"2 mins  / 2 sets", @"High Knees", @"1 min", @"Butt Kicks", @"1 min / 5 sets", @"Skip", @"1 min / 5 sets", @"Bicep Curl", @"12 / 2 sets", @"V Sit Ball Twists", @"100 reps", @"Sit Ups", @"50 reps", @"Bicycle Crunch", @"100 reps",  @"Plank", @"45 secs / 3 sets", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"30 secs - 10 sec rest / 8 sets", @"Kettle Bell Swing", @"30 secs - 10 sec rest / 8 sets", @"Plea Squat Upright Row", @"30 secs - 10 sec rest / 8 sets", @"Skip", @"30 secs - 10 sec rest / 8 sets",  @"Running", @"30 secs - 10 sec rest / 8 sets", @"Burpees", @"30 secs - 10 secs rest / 8 sets", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 6) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"1 min / 2 sets", @"Skip", @"1 min / 2 sets", @"High Knees", @"1 min / 2 sets", @"Kettle Bell Swing", @"1 min / 2 sets", @"Jumping Split Squat", @"1 min / 2 sets", @"Plea Squat Upright Row", @"1 min / 2 sets", @"Mountain Climbers", @"1 min / 2 sets",  @"Burpees", @"1 min / 2 sets", @"Bike", @"20 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jogging", @"30 - 60 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"2 mins / 2 sets", @"High Knees", @"1 min / 2 sets", @"Butt Kicks", @"1 min / 5 sets", @"Skip", @"1 min / 5 sets", @"Bicep Curl", @"12 / 2 sets", @"V Sit Ball Twists", @"100 reps", @"Sit Ups", @"50 reps", @"Bicycle Crunch", @"100 reps",  @"Plank", @"45 secs / 3 sets", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"30 secs - 10 sec rest / 8 sets", @"Kettle Bell Swing", @"30 secs - 10 sec rest / 8 sets", @"Plea Squat Upright Row", @"30 secs - 10 sec rest / 8 sets", @"Skip", @"30 secs - 10 sec rest / 8 sets",  @"Running", @"30 secs - 10 sec rest / 8 sets", @"Burpees", @"30 secs - 10 secs rest / 8 sets", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
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
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"1 min / 2 sets", @"Skip", @"1 min / 2 sets", @"High Knees", @"1 min / 2 sets", @"Kettle Bell Swing", @"1 min / 2 sets", @"Jumping Split Squat", @"1 min / 2 sets", @"Plea Squat Upright Row", @"1 min / 2 sets", @"Mountain Climbers", @"1 min / 2 sets",  @"Burpees", @"1 min / 2 sets", @"Bike", @"20 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jogging", @"30 - 60 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"2 mins / 2 sets", @"High Knees", @"1 min / 2 sets", @"Butt Kicks", @"1 min / 5 sets", @"Skip", @"1 min / 5 sets", @"Bicep Curl", @"12 / 2 sets", @"V Sit Ball Twists", @"100 reps", @"Sit Ups", @"50 reps", @"Bicycle Crunch", @"100 reps",  @"Plank", @"45 secs / 3 sets", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Jumping Jacks", @"30 secs - 10 sec rest / 8 sets", @"Kettle Bell Swing", @"30 secs - 10 sec rest / 8 sets", @"Plea Squat Upright Row", @"30 secs - 10 sec rest / 8 sets", @"Skip", @"30 secs - 10 sec rest / 8 sets",  @"Running", @"30 secs - 10 sec rest / 8 sets", @"Burpees", @"20 secs - 10 secs rest / 8 sets", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
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
    else if([goal isEqualToString:@"GET TONED"]) {
        if (totalNumberOfDays == 1) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"5 sets / 20 reps", @"Toe Touches", @"2 sets / 50 reps", @"Dumbbell Deadlift", @"3 sets / 20 reps", @"Hanging Leg Raises", @"3 sets / 20 reps", @"Bench Press", @"3 sets / 15 reps", @"Bent Over Dumbbell Row", @"3 sets / 15 reps",  @"Standing Shoulder Press", @"3 sets / 15 reps", @"Burpees", @"3 sets / 20 reps", @"Skip", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 2) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat and Press", @"3 sets / 20 reps", @"Hanging Leg Raises", @"2 sets / 10 reps", @"Bent Over Alternating Row", @"2 sets / 20 reps", @"Burpees", @"2 sets / 20 reps", @"Bicycle Crunch", @"2 sets / 100 reps", @"Standing Shoulder Press", @"2 / 20 reps", @"Skip", @"1 min / 2 sets", @"Bike", @"20 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if (day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"5 sets / 20 reps", @"Jump Squat", @"2 sets / 20 reps", @"Lunges", @"2 sets / 20 reps", @"Burpees", @"2 sets / 20 reps", @"Skater Lunges", @"2 sets / 30 reps", @"Jumping Split Squat", @"2 sets / 20 reps", @"Bicep Curl", @"3 sets / 20 reps", @"Skip", @"1 min / 3 sets", @"V Sit Ball Twists", @"100 sets",  @"Flutter Kicks", @"100 reps", @"Plank", @"45 secs / 5 sets", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 3) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 15 reps", @"Jump Squat", @"3 sets / 15 reps", @"Deadlift", @"3 sets / 15 reps", @"Skater Lunges", @"3 sets / 15 reps", @"Plea Squat Upright Row", @"2 sets / 15 reps", @"V Sit Ball Twists", @"100 reps", @"Hanging Leg Raises", @"3 sets / 10 reps", @"Plank", @"45 secs / 5 sets", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"3 sets / 15 reps", @"Mountain Climbers", @"3 sets / 100 reps", @"Standing Shoulder Press", @"3 sets / 15 reps", @"Bent Lateral Raises", @"3 sets / 15 reps", @"Bent Over Dumbbell Row", @"3 sets / 15 reps", @"Supermans", @"3 sets / 50 reps", @"Bicep Curl", @"3 sets / 20 reps", @"Skip", @"1 min / 3 sets", @"V Sit Ball Twists", @"100 reps", @"Toe Touches", @"100 reps", @"Skip", @"5 mins", @"Jogging", @"15 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
                
            }
            else if (day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Push Ups", @"5 sets / 15 reps", @"Knee Abductions", @"5 sets / 15 reps", @"Plea Squat Upright Row", @"2 sets / 15 reps", @"Hanging Leg Raises", @"3 sets / 10 reps", @"Bicep Curl", @"2 sets / 15 reps", @"Bench Dips", @"2 sets / 15 reps", @"Bicycle Crunch", @"100 reps", @"Toe Touches", @"100 reps", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 4) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 15 reps", @"Jump Squat", @"3 sets / 15 reps", @"Deadlift", @"3 sets / 15 reps", @"Skater Lunges", @"3 sets / 15 reps", @"Plea Squat Upright Row", @"2 sets / 15 reps", @"V Sit Ball Twists", @"100 reps", @"Hanging Leg Raises", @"3 sets / 10 reps", @"Plank", @"45 secs / 5 sets", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"3 sets / 15 reps", @"Mountain Climbers", @"3 sets / 100 reps", @"Standing Shoulder Press", @"3 sets / 15 reps", @"Bent Lateral Raises", @"3 sets / 15 reps", @"Bent Over Dumbbell Row", @"3 sets / 15 reps", @"Supermans", @"3 sets / 50 reps", @"Bicep Curl", @"3 sets / 20 reps", @"Skip", @"1 min / 3 sets", @"V Sit Ball Twists", @"100 reps", @"Toe Touches", @"100 reps", @"Skip", @"5 mins", @"Jogging", @"15 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if (day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Push Ups", @"5 sets / 15 reps", @"Knee Abductions", @"5 sets / 15 reps", @"Plea Squat Upright Row", @"2 sets / 15 reps", @"Hanging Leg Raises", @"2 sets / 10 reps", @"Bicep Curl", @"2 sets / 15 reps", @"Bench Dips", @"2 sets / 15 reps", @"Bicycle Crunch", @"100 reps", @"Toe Touches", @"100 reps", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Bike", @"5 mins", @"Squat", @"4 sets / 12 reps", @"Push Ups", @"4 sets / 12 reps", @"Bent Over Dumbbell Row", @"4 sets / 12 reps", @"Jogging", @"10 mins", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 5) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 15 reps", @"Jump Squat", @"3 sets / 15 reps", @"Deadlift", @"3 sets / 15 reps", @"Skater Lunges", @"3 sets / 15 reps", @"Plea Squat Upright Row", @"2 sets / 15 reps", @"V Sit Ball Twists", @"100 reps", @"Hanging Leg Raises", @"3 sets / 10 reps", @"Plank", @"45 secs / 5 sets", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"4 sets / 20 reps", @"Toe Touches", @"2 sets / 50 reps", @"Deadlift", @"3 sets / 20 reps", @"Hanging Raises", @"3 sets / 20 reps", @"Bench Press", @"3 sets / 15 reps", @"Bent Over Dumbbell Row", @"3 sets / 15 reps", @"Standing Shoulder Press", @"3 sets / 15 reps", @"Burpees", @"3 sets / 20 reps", @"Skip", @"5 mins", @"Jogging", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"3 sets / 15 reps", @"Mountain Climbers", @"3 sets / 100 reps", @"Standing Shoulder Press", @"3 sets / 15 reps", @"Bent Lateral Raises", @"3 sets / 15 reps", @"Bent Over Dumbbell Row", @"3 sets / 15 reps", @"Supermans", @"3 sets / 50 reps", @"Bicep Curl", @"3 sets / 20 reps", @"Skip", @"1 min / 3 sets", @"V Sit Ball Twists", @"100 reps", @"Toe Touches", @"100 reps", @"Skip", @"5 mins", @"Jogging", @"15 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga", @"Empty Space", nil];
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Push Ups", @"5 sets / 15 reps", @"Knee Abductions", @"5 sets / 15 reps", @"Plea Squat Upright Row", @"2 sets / 15 reps", @"Hanging Leg Raises", @"2 sets / 10 reps", @"Bicep Curl", @"2 sets / 15 reps", @"Bench Dips", @"2 sets / 15 reps", @"Bicycle Crunch", @"100 reps", @"Toe Touches", @"100 reps", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 6) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 15 reps", @"Jump Squat", @"3 sets / 15 reps", @"Deadlift", @"3 sets / 15 reps", @"Skater Lunges", @"3 sets / 15 reps", @"Plea Squat Upright Row", @"2 sets / 15 reps", @"V Sit Ball Twists", @"100 reps", @"Hanging Leg Raises", @"3 sets / 10 reps", @"Plank", @"45 secs / 5 sets", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"4 sets / 20 reps", @"Toe Touches", @"2 sets / 50 reps", @"Deadlift", @"3 sets / 20 reps", @"Hanging Raises", @"3 sets / 20 reps", @"Bench Press", @"3 sets / 15 reps", @"Bent Over Dumbbell Row", @"3 sets / 15 reps", @"Standing Shoulder Press", @"3 sets / 15 reps", @"Burpees", @"3 sets / 20 reps", @"Skip", @"5 mins", @"Jogging", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"3 sets / 15 reps", @"Mountain Climbers", @"3 sets / 100 reps", @"Standing Shoulder Press", @"3 sets / 15 reps", @"Bent Lateral Raises", @"3 sets / 15 reps", @"Bent Over Dumbbell Row", @"3 sets / 15 reps", @"Supermans", @"3 sets / 50 reps", @"Bicep Curl", @"3 sets / 20 reps", @"Skip", @"1 min / 3 sets", @"V Sit Ball Twists", @"100 reps", @"Toe Touches", @"100 reps", @"Skip", @"5 mins", @"Jogging", @"15 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga", @"Empty Space", nil];
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Push Ups", @"5 sets / 15 reps", @"Knee Abductions", @"5 sets / 15 reps", @"Plea Squat Upright Row", @"2 sets / 15 reps", @"Hanging Leg Raises", @"2 sets / 10 reps", @"Bicep Curl", @"2 sets / 15 reps", @"Bench Dips", @"2 sets / 15 reps", @"Bicycle Crunch", @"100 reps", @"Toe Touches", @"100 reps", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 5){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Sports Activity", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 7) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 15 reps", @"Jump Squat", @"3 sets / 15 reps", @"Deadlift", @"3 sets / 15 reps", @"Skater Lunges", @"3 sets / 15 reps", @"Plea Squat Upright Row", @"2 sets / 15 reps", @"V Sit Ball Twists", @"100 reps", @"Hanging Leg Raises", @"3 sets / 10 reps", @"Plank", @"45 secs / 5 sets", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc]
                                            initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"3 sets / 15 reps", @"Mountain Climbers", @"3 sets / 100 reps", @"Standing Shoulder Press", @"3 sets / 15 reps", @"Bent Lateral Raises", @"3 sets / 15 reps", @"Bent Over Dumbbell Row", @"3 sets / 15 reps", @"Supermans", @"3 sets / 50 reps", @"Bicep Curl", @"3 sets / 20 reps", @"Skip", @"1 min / 3 sets", @"V Sit Ball Twists", @"100 reps", @"Toe Touches", @"100 reps", @"Skip", @"5 mins", @"Jogging", @"15 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc]
                                            initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"2 sets / 20 reps", @"Toe Touches", @"2 sets / 50 reps", @"Deadlift", @"3 sets / 20 reps", @"Hanging Raises", @"3 sets / 20 reps", @"Bench Press", @"3 sets / 15 reps", @"Bent Over Dumbbell Row", @"3 sets / 15 reps", @"Standing Shoulder Press", @"3 sets / 15 reps", @"Burpees", @"3 sets / 20 reps", @"Skip", @"5 mins", @"Jogging", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga", @"Empty Space", nil];
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Push Ups", @"5 sets / 15 reps", @"Knee Abductions", @"5 sets / 15 reps", @"Plea Squat Upright Row", @"2 sets / 15 reps", @"Hanging Leg Raises", @"2 sets / 10 reps", @"Bicep Curl", @"2 sets / 15 reps", @"Bench Dips", @"2 sets / 15 reps", @"Bicycle Crunch", @"100 reps", @"Toe Touches", @"100 reps", @"Bike", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
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
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"5 sets / 12 reps",  @"Deadlift", @"3 sets / 12 reps", @"Bench Press", @"3 sets / 12 reps", @"Bent Over Barbell Row", @"3 sets / 12 reps", @"Standing Shoulder Press", @"3 sets / 12 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 2) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 12 reps", @"Bench Press", @"3 sets / 12 reps", @"Wide Grip Lateral Pull Down", @"3 sets / 10 reps",  @"Narrow Grip Pull Up", @"3 sets / 10 reps", @"Hanging Leg Raises", @"3 sets / 20 reps", @"Bicep Curl", @"4 sets / 8 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
                
            }
            else if (day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Deadlift", @"3 sets / 12 reps", @"Bent Over Barbell Row", @"3 sets / 12 reps", @"Standing Shoulder Press", @"3 sets / 12 reps", @"Bench Dips", @"3 sets / 13 reps", @"Sit Ups", @"3 sets / 15 reps", @"Side Plank", @"30 secs / 3 sets", @"Jogging",@"10 mins", nil];
            }
        }
        else if(totalNumberOfDays == 3) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"3 sets / 8 reps", @"Bench Press", @"3 sets / 8 reps", @"Leg Press", @"3 sets / 15 reps", @"Weighted Chest Fly", @"3 sets / 20 reps", @"Hanging Leg Raises", @"3 sets / 10 reps", @"Side Plank", @"30 secs / 3 sets", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Wide Grip Lateral Pull Down", @"3 sets / 10 reps", @"Bent Over Barbell Row", @"3 sets / 12 reps", @"Standing Shoulder Press", @"3 sets / 10 reps", @"Bent Lateral Raises", @"3 sets / 10 reps", @"Standing Shrug", @"3 sets / 10 reps", @"Dumbbell Drop", @"3 sets / 10 reps", @"Supermans", @"100 reps", @"Toe Touches", @"100 reps", @"Side Plank", @"60 secs / 5 sets", @"Jogging",@"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
                
            }
            else if (day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Deadlift", @"3 sets / 8 reps", @"Skater Lunges", @"3 sets / 15 reps", @"Ball Roll Ins", @"3 sets / 10 reps", @"Calf Raises", @"3 sets / 20 reps", @"Ez Bar Curl", @"3 sets / 15 reps", @"Tricep Rope Pull Down", @"100 reps", @"Knee Abductions", @"100 reps", @"Bicycle Crunch",@"100 reps", @"Rowing", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 4) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space",  @"Squat", @"5 sets / 12 reps", @"Bench Press", @"5 sets / 5 reps", @"Bent Over Barbell Row", @"5 sets / 5 reps", @"Hanging Leg Raises", @"3 sets / 10 reps", @"Bicep Curl", @"4 sets / 10 reps", @"Ab Roller", @"30 reps", @"Toe Touches", @"100 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Deadlift", @"5 sets / 12 reps", @"Wide Grip Pull Up", @"3 sets / 10 reps", @"Standing Shoulder Press", @"3 sets / 10 reps", @"Bent Lateral Raises", @"3 sets / 15 reps", @"Tricep Rope Pull Down", @"3 sets / 15 reps", @"Supermans", @"100 reps",  @"Toe Touches", @"100 reps", @"Jogging",@"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"4 sets / 10 reps", @"Lunges", @"3 sets / 20 reps", @"Leg Press", @"2 sets / 15 reps",  @"Calf Raises", @"3 sets / 20 reps", @"Weighted Crunch On Ball", @"3 sets / 20 reps", @"Side Plank", @"30 secs / 3 sets", @"Rowing", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"3 sets / 10 reps", @"Single Arm Bent Over Row", @"3 sets / 10 reps", @"Standing Dumbbell Shoulder Press", @"3 sets / 10 reps", @"Power Shrug", @"100 reps", @"Supermans", @"100 reps", @"Bike",@"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 5) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space",  @"Squat", @"5 sets / 12 reps", @"Bench Press", @"5 sets / 5 reps", @"Bent Over Barbell Row", @"5 sets / 5 reps", @"Hanging Leg Raises", @"3 sets / 10 reps", @"Bicep Curl", @"4 sets / 10 reps", @"Ab Roller", @"30 reps", @"Toe Touches", @"100 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Deadlift", @"5 sets / 12 reps", @"Wide Grip Pull Up", @"3 sets / 10 reps", @"Standing Shoulder Press", @"3 sets / 10 reps", @"Bent Lateral Raises", @"3 sets / 15 reps", @"Tricep Rope Pull Down", @"3 sets / 15 reps", @"Supermans", @"100 reps",  @"Toe Touches", @"100 reps", @"Jogging",@"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"4 sets / 10 reps", @"Lunges", @"3 sets / 20 reps", @"Leg Press", @"2 sets / 15 reps",  @"Calf Raises", @"3 sets / 20 reps", @"Weighted Crunch On Ball", @"3 sets / 20 reps", @"Side Plank", @"30 secs / 3 sets", @"Rowing", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"3 sets / 10 reps", @"Single Arm Bent Over Row", @"3 sets / 10 reps", @"Standing Dumbbell Shoulder Press", @"3 sets / 10 reps", @"Power Shrug", @"100 reps", @"Supermans", @"100 reps", @"Bike",@"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 4){
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Yoga", @"Empty Space", nil];
            }
        }
        else if(totalNumberOfDays == 6) {
            if (day == 0) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space",  @"Squat", @"5 sets / 12 reps", @"Bench Press", @"5 sets / 5 reps", @"Bent Over Barbell Row", @"5 sets / 5 reps", @"Hanging Leg Raises", @"3 sets / 10 reps", @"Bicep Curl", @"4 sets / 10 reps", @"Ab Roller", @"30 reps", @"Toe Touches", @"100 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Deadlift", @"5 sets / 12 reps", @"Wide Grip Pull Up", @"3 sets / 10 reps", @"Standing Shoulder Press", @"3 sets / 10 reps", @"Bent Lateral Raises", @"3 sets / 15 reps", @"Tricep Rope Pull Down", @"3 sets / 15 reps", @"Supermans", @"100 reps",  @"Toe Touches", @"100 reps", @"Jogging",@"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"4 sets / 10 reps", @"Lunges", @"3 sets / 20 reps", @"Leg Press", @"2 sets / 15 reps",  @"Calf Raises", @"3 sets / 20 reps", @"Weighted Crunch On Ball", @"3 sets / 20 reps", @"Side Plank", @"30 secs / 3 sets", @"Rowing", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"3 sets / 10 reps", @"Single Arm Bent Over Row", @"3 sets / 10 reps", @"Standing Dumbbell Shoulder Press", @"3 sets / 10 reps", @"Power Shrug", @"100 reps", @"Supermans", @"100 reps", @"Bike",@"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
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
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space",  @"Squat", @"5 sets / 12 reps", @"Bench Press", @"5 sets / 5 reps", @"Bent Over Barbell Row", @"5 sets / 5 reps", @"Hanging Leg Raises", @"3 sets / 10 reps", @"Bicep Curl", @"4 sets / 10 reps", @"Ab Roller", @"30 reps", @"Toe Touches", @"100 reps", @"Bike", @"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 1) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Deadlift", @"5 sets / 12 reps", @"Wide Grip Pull Up", @"3 sets / 10 reps", @"Standing Shoulder Press", @"3 sets / 10 reps", @"Bent Lateral Raises", @"3 sets / 15 reps", @"Tricep Rope Pull Down", @"3 sets / 15 reps", @"Supermans", @"100 reps",  @"Toe Touches", @"100 reps", @"Jogging",@"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 2) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Squat", @"4 sets / 10 reps", @"Lunges", @"3 sets / 20 reps", @"Leg Press", @"2 sets / 15 reps",  @"Calf Raises", @"3 sets / 20 reps", @"Weighted Crunch On Ball", @"3 sets / 20 reps", @"Side Plank", @"30 secs / 3 sets", @"Rowing", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
            }
            else if(day == 3) {
                workoutArray             = [[NSMutableArray alloc] initWithObjects:@"Jogging",@"5 mins",@"Foam Roll", @"Empty Space", @"Incline Bench Press", @"3 sets / 10 reps", @"Single Arm Bent Over Row", @"3 sets / 10 reps", @"Standing Dumbbell Shoulder Press", @"3 sets / 10 reps", @"Power Shrug", @"100 reps", @"Supermans", @"100 reps", @"Bike",@"10 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space", nil];
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
            workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Hanging Leg Raises", @"4 sets / 10 reps", @"Ab Roller", @"30 reps", @"Bicycle Crunch", @"100 sets", @"Toe Touches", @"100 reps", @"Plank", @"30 secs / 3 sets", @"Side Plank", @"30 secs / 3 sets", @"Weighted Crunch On Ball", @"3 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            
        }
        else if(totalNumberOfDays == 2) {
            if (day == 0) { // Abs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Hanging Leg Raises", @"4 sets / 10 reps", @"Ab Roller", @"30 reps", @"Bicycle Crunch", @"100 sets", @"Toe Touches", @"100 reps", @"Plank", @"30 secs / 3 sets", @"Side Plank", @"30 secs / 3 sets", @"Weighted Crunch On Ball", @"3 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
                
            }
            else if (day == 1) { // Legs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Squat", @"2 sets / 15 reps", @"Skater Lunges", @"2 sets / 15 reps", @"Deadlift", @"2 sets / 15 reps", @"Leg Press", @"2 sets / 15 reps", @"Calf Raises", @"2 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
        }
        else if(totalNumberOfDays == 3) {
            if (day == 0) { // Abs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Hanging Leg Raises", @"4 sets / 10 reps", @"Ab Roller", @"30 reps", @"Bicycle Crunch", @"100 sets", @"Toe Touches", @"100 reps", @"Plank", @"30 secs / 3 sets", @"Side Plank", @"30 secs / 3 sets", @"Weighted Crunch On Ball", @"3 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
                
            }
            else if (day == 1) { // Legs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Squat", @"2 sets / 15 reps", @"Skater Lunges", @"2 sets / 15 reps", @"Deadlift", @"2 sets / 15 reps", @"Leg Press", @"2 sets / 15 reps", @"Calf Raises", @"2 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if (day == 2) { // Chest
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Incline Bench Press", @"3 sets / 15 reps", @"Push Ups", @"3 sets / 15 reps", @"Weighted Chest Fly", @"3 sets / 15 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
        }
        else if(totalNumberOfDays == 4) {
            if (day == 0) { // Abs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Hanging Leg Raises", @"4 sets / 10 reps", @"Ab Roller", @"30 reps", @"Bicycle Crunch", @"100 sets", @"Toe Touches", @"100 reps", @"Plank", @"30 secs / 3 sets", @"Side Plank", @"30 secs / 3 sets", @"Weighted Crunch On Ball", @"3 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
                
            }
            else if (day == 1) { // Legs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Squat", @"5 sets / 15 reps", @"Skater Lunges", @"2 sets / 15 reps", @"Deadlift", @"5 sets / 15 reps", @"Leg Press", @"3 sets / 15 reps", @"Calf Raises", @"5 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if (day == 2) { // Chest
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Incline Bench Press", @"5 sets / 15 reps", @"Push Ups", @"3 sets / 15 reps", @"Weighted Chest Fly", @"3 sets / 15 reps",@"Bench Press", @"3 sets / 15 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 3) { // Back
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Wide Grip Pull Up", @"3 sets / 10 reps", @"Bent Over Dumbbell Row", @"3 sets / 12 reps", @"Upright Row", @"3 sets / 12 reps", @"Deadlift", @"3 sets / 10 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
        }
        else if(totalNumberOfDays == 5) {
            if (day == 0) { // Abs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Hanging Leg Raises", @"4 sets / 10 reps", @"Ab Roller", @"30 reps", @"Bicycle Crunch", @"100 sets", @"Toe Touches", @"100 reps", @"Plank", @"30 secs / 3 sets", @"Side Plank", @"30 secs / 3 sets", @"Weighted Crunch On Ball", @"3 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
                
            }
            else if (day == 1) { // Legs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Squat", @"5 sets / 15 reps", @"Skater Lunges", @"2 sets / 15 reps", @"Deadlift", @"4 sets / 15 reps", @"Leg Press", @"3 sets / 15 reps", @"Calf Raises", @"5 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if (day == 2) { // Chest
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Incline Bench Press", @"5 sets / 15 reps", @"Push Ups", @"3 sets / 15 reps", @"Weighted Chest Fly", @"3 sets / 15 reps", @"Bench Press", @"3 sets / 15 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 3) { // Back
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Wide Grip Pull Up", @"3 sets / 10 reps", @"Bent Over Dumbbell Row", @"3 sets / 12 reps", @"Upright Row", @"3 sets / 12 reps", @"Deadlift", @"3 sets / 10 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 4) {  // Shoulders
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Standing Shoulder Press", @"3 sets / 15 reps", @"Bent Lateral Raises", @"3 sets / 15 reps", @"Dumbbell Drop", @"3 sets / 15 reps", @"Front Raises", @"3 sets / 30 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
        }
        else if(totalNumberOfDays == 6) {
            if (day == 0) { // Abs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Hanging Leg Raises", @"4 sets / 10 reps", @"Ab Roller", @"30 reps", @"Bicycle Crunch", @"100 sets", @"Toe Touches", @"100 reps", @"Plank", @"30 secs / 3 sets", @"Side Plank", @"30 secs / 3 sets", @"Weighted Crunch On Ball", @"3 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
                
            }
            else if (day == 1) { // Legs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Squat", @"5 sets / 15 reps", @"Skater Lunges", @"2 sets / 15 reps", @"Deadlift", @"2 sets / 15 reps", @"Leg Press", @"3 sets / 15 reps", @"Calf Raises", @"5 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if (day == 2) { // Chest
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Incline Bench Press", @"5 sets / 15 reps", @"Push Ups", @"3 sets / 15 reps", @"Weighted Chest Fly", @"3 sets / 15 reps", @"Bench Press", @"3 sets / 15 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 3) { // Back
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Wide Grip Pull Up", @"3 sets / 10 reps", @"Bent Over Dumbbell Row", @"3 sets / 12 reps", @"Upright Row", @"3 sets / 12 reps", @"Deadlift", @"3 sets / 10 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 4) {  // Shoulders
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Standing Shoulder Press", @"3 sets / 15 reps", @"Bent Lateral Raises", @"3 sets / 15 reps", @"Dumbbell Drop", @"3 sets / 15 reps", @"Front Raises", @"3 sets / 30 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 5) { // Arms
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Ez Bar Curl", @"3 sets / 15 reps", @"Dumbbell Skull Crushers", @"3 sets / 15 reps", @"Preacher Curl", @"3 sets / 15 reps", @"Tricep Rope Pull Down", @"3 sets / 15 reps", @"Concentration Curl", @"3 sets / 10 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
        }
        else if(totalNumberOfDays == 7) {
            if (day == 0) { // Abs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Hanging Leg Raises", @"4 sets / 10 reps", @"Ab Roller", @"30 reps", @"Bicycle Crunch", @"100 sets", @"Toe Touches", @"100 reps", @"Plank", @"30 secs / 3 sets", @"Side Plank", @"30 secs / 3 sets", @"Weighted Crunch On Ball", @"3 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
                
            }
            else if (day == 1) { // Legs
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Squat", @"5 sets / 15 reps", @"Skater Lunges", @"2 sets / 15 reps", @"Deadlift", @"4 sets / 15 reps", @"Leg Press", @"3 sets / 15 reps", @"Calf Raises", @"5 sets / 20 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if (day == 2) { // Chest
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Incline Bench Press", @"5 sets / 15 reps", @"Push Ups", @"3 sets / 15 reps", @"Weighted Chest Fly", @"3 sets / 15 reps", @"Bench Press", @"3 sets / 15 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 3) { // Back
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Wide Grip Pull Up", @"3 sets / 10 reps", @"Bent Over Dumbbell Row", @"3 sets / 12 reps", @"Upright Row", @"3 sets / 12 reps", @"Deadlift", @"3 sets / 10 reps", @"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 4) {  // Shoulders
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Standing Shoulder Press", @"3 sets / 15 reps", @"Bent Lateral Raises", @"3 sets / 15 reps", @"Dumbbell Drop", @"3 sets / 15 reps", @"Front Raises", @"3 sets / 30 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 5) { // Arms
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Jogging", @"5 mins", @"Foam Roll", @"Empty Space", @"Ez Bar Curl", @"3 sets / 15 reps", @"Dumbbell Skull Crushers", @"3 sets / 15 reps", @"Preacher Curl", @"3 sets / 15 reps", @"Tricep Rope Pull Down", @"3 sets / 15 reps", @"Concentration Curl", @"3 sets / 10 reps", @"Jogging", @"Empty Space", @"Foam Roll", @"Empty Space", @"Stretch", @"Empty Space",  nil];
            }
            else if(day == 6){
                workoutArray                  = [[NSMutableArray alloc] initWithObjects:@"Sports Activity", @"Empty Space", nil];
            }
        }
    }
    return workoutArray;
}

@end
