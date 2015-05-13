//
//  WorkoutSelection.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-17.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import "WorkoutSelection.h"
#import "BeginnerWorkoutSelection.h"
#import "IntermediateWorkoutSelection.h"
#import "AdvancedWorkoutSelection.h"
#import "Database.h"
@interface WorkoutSelection()
@property (strong, nonatomic)BeginnerWorkoutSelection *m_beginnerWorkoutSelection;
@property (strong, nonatomic)IntermediateWorkoutSelection *m_intermediateWorkoutSelection;
@property (strong, nonatomic)AdvancedWorkoutSelection *m_advancedWorkoutSelection;
@property (strong, nonatomic)Database *m_database;
@end

@implementation WorkoutSelection



/*
 Singleton WorkoutSelection object
 */
+ (WorkoutSelection *)sharedInstance {
	static WorkoutSelection *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 General plist load up
 */
- (NSMutableDictionary *)loadUpPlist:(NSString *)plist
{
    NSMutableDictionary  *plistDictionary;
    // load our data for background image from a plist file
	NSString *path                      = [[NSBundle mainBundle] pathForResource:plist ofType:@"plist"];
	plistDictionary                     = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    return plistDictionary;
}

/*
 Load up workout array
 */
- (NSMutableArray *)workoutGoal:(NSString *)goal WithTheDay:(int)day ForTotalWorkOutDays:(int)totalNumberOfDays;
{
    // Load up the array with data
    NSMutableArray  *workoutArray      = nil;
    
    if (!self.m_database) {
        self.m_database          = [Database alloc];
    }
    NSMutableArray *exerciseLevel            = [self.m_database getExerciseLevel:[NSString getUserEmail]];
    
    if ([[exerciseLevel objectAtIndex:0] isEqualToString:@"BEGINNER"]) {
        if (!self.m_beginnerWorkoutSelection) {
            self.m_beginnerWorkoutSelection       = [BeginnerWorkoutSelection sharedInstance];
        }
        workoutArray         = [self.m_beginnerWorkoutSelection beginnerWorkoutGoal:goal WithTheDay:day ForTotalWorkOutDays:totalNumberOfDays];
    }
    else if([[exerciseLevel objectAtIndex:0]  isEqualToString:@"INTERMEDIATE"]) {
        if (!self.m_intermediateWorkoutSelection) {
            self.m_intermediateWorkoutSelection   = [IntermediateWorkoutSelection sharedInstance];
        }
        workoutArray         = [self.m_intermediateWorkoutSelection intermediateWorkoutGoal:goal WithTheDay:day ForTotalWorkOutDays:totalNumberOfDays];
    }
    else if([[exerciseLevel objectAtIndex:0]  isEqualToString:@"ADVANCED"]) {
        if (!self.m_advancedWorkoutSelection) {
            self.m_advancedWorkoutSelection       = [AdvancedWorkoutSelection sharedInstance];
        }
        workoutArray         = [self.m_advancedWorkoutSelection advancedWorkoutGoal:goal WithTheDay:day ForTotalWorkOutDays:totalNumberOfDays];
    }
    
    return workoutArray;
}

@end
