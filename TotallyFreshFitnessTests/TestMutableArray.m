//
//  TestMutableArray.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 11/24/2013.
//  Copyright (c) 2013 Total Fitness and Nutrition. All rights reserved.
//

#import "TestMutableArray.h"
#import "BeginnerWorkoutSelection.h"
#import "IntermediateWorkoutSelection.h"
#import "AdvancedWorkoutSelection.h"
@implementation TestMutableArray

BeginnerWorkoutSelection *m_beginnerWorkoutSelection;
IntermediateWorkoutSelection *m_intermediateWorkoutSelection;
AdvancedWorkoutSelection *m_advancedWorkoutSelection;
NSMutableArray *m_beginnerWorkoutSelectionArray;
NSMutableArray *m_intermediateWorkoutSelectionArray;
NSMutableArray *m_advancedWorkoutSelectionArray;

- (void)testMutableArrays
{
//    m_intermediateWorkoutSelection = [IntermediateWorkoutSelection sharedInstance];
//    
//    int maxDays = 7;
//    for (int totalDays = 1; totalDays <= maxDays; totalDays++) {
//        for (int i = 0; i < totalDays; i++) {
//            m_intermediateWorkoutSelectionArray     = [NSMutableArray mutableArrayObject];
//            m_intermediateWorkoutSelectionArray     = [m_intermediateWorkoutSelection intermediateWorkoutGoal:@"SHRED FAT" WithTheDay:i ForTotalWorkOutDays:totalDays];
//            NSLog(@"m_intermediateWorkoutSelectionArray %d", [m_intermediateWorkoutSelectionArray count]);
//            NSLog(@"m_intermediateWorkoutSelectionArray is shred fat for %d day %d %@", totalDays, i, m_intermediateWorkoutSelectionArray);
//            m_intermediateWorkoutSelectionArray     = [NSMutableArray mutableArrayObject];
//            m_intermediateWorkoutSelectionArray     = [m_intermediateWorkoutSelection intermediateWorkoutGoal:@"GET TONED" WithTheDay:i ForTotalWorkOutDays:totalDays];
//            NSLog(@"m_intermediateWorkoutSelectionArray %d", [m_intermediateWorkoutSelectionArray count]);
//            NSLog(@"m_intermediateWorkoutSelectionArray is get toned  %d day %d %@", totalDays, i,  m_intermediateWorkoutSelectionArray);
//            m_intermediateWorkoutSelectionArray     = [NSMutableArray mutableArrayObject];
//            m_intermediateWorkoutSelectionArray     = [m_intermediateWorkoutSelection intermediateWorkoutGoal:@"BUILD MUSCLE MASS" WithTheDay:i ForTotalWorkOutDays:totalDays];
//            NSLog(@"m_intermediateWorkoutSelectionArray %d", [m_intermediateWorkoutSelectionArray count]);
//            NSLog(@"m_intermediateWorkoutSelectionArray is BUILD MUSCLE MASS %d day %d, %@", totalDays, i, m_intermediateWorkoutSelectionArray);
//            m_intermediateWorkoutSelectionArray     = [NSMutableArray mutableArrayObject];
//            m_intermediateWorkoutSelectionArray     = [m_intermediateWorkoutSelection intermediateWorkoutGoal:@"MUSCLE ISOLATION" WithTheDay:i ForTotalWorkOutDays:totalDays];
//            NSLog(@"m_intermediateWorkoutSelectionArray %d", [m_intermediateWorkoutSelectionArray count]);
//            NSLog(@"m_intermediateWorkoutSelectionArray is MUSCLE ISOLATION  %d, day %d, %@", totalDays, i, m_intermediateWorkoutSelectionArray);
//        }
//    }
//    
//    m_beginnerWorkoutSelection          = [BeginnerWorkoutSelection sharedInstance];
//    int maxDays = 7;
//    for (int totalDays = 1; totalDays <= maxDays; totalDays++) {
//        for (int i = 0; i < totalDays; i++) {
//            m_beginnerWorkoutSelectionArray     = [NSMutableArray mutableArrayObject];
//            m_beginnerWorkoutSelectionArray     = [m_beginnerWorkoutSelection beginnerWorkoutGoal:@"SHRED FAT" WithTheDay:i ForTotalWorkOutDays:totalDays];
//            NSLog(@"m_beginnerWorkoutSelectionArray %d", [m_beginnerWorkoutSelectionArray count]);
////            NSLog(@"m_beginnerWorkoutSelectionArray is shred fat for %d day %d %@", totalDays, i, m_beginnerWorkoutSelectionArray);
//            m_intermediateWorkoutSelectionArray     = [NSMutableArray mutableArrayObject];
//            m_beginnerWorkoutSelectionArray     = [m_beginnerWorkoutSelection beginnerWorkoutGoal:@"GET TONED" WithTheDay:i ForTotalWorkOutDays:totalDays];
//            NSLog(@"m_beginnerWorkoutSelectionArray %d", [m_beginnerWorkoutSelectionArray count]);
////            NSLog(@"m_beginnerWorkoutSelectionArray is get toned  %d day %d %@", totalDays, i,  m_beginnerWorkoutSelectionArray);
//            m_beginnerWorkoutSelectionArray     = [NSMutableArray mutableArrayObject];
//            m_beginnerWorkoutSelectionArray     = [m_beginnerWorkoutSelection beginnerWorkoutGoal:@"BUILD MUSCLE MASS" WithTheDay:i ForTotalWorkOutDays:totalDays];
//            NSLog(@"m_beginnerWorkoutSelectionArray %d", [m_beginnerWorkoutSelectionArray count]);
////            NSLog(@"m_beginnerWorkoutSelectionArray is BUILD MUSCLE MASS %d day %d, %@", totalDays, i, m_beginnerWorkoutSelectionArray);
//            m_beginnerWorkoutSelectionArray     = [NSMutableArray mutableArrayObject];
//            m_beginnerWorkoutSelectionArray     = [m_beginnerWorkoutSelection beginnerWorkoutGoal:@"MUSCLE ISOLATION" WithTheDay:i ForTotalWorkOutDays:totalDays];
//            NSLog(@"m_beginnerWorkoutSelectionArray %d", [m_beginnerWorkoutSelectionArray count]);
////            NSLog(@"m_beginnerWorkoutSelectionArray is MUSCLE ISOLATION  %d, day %d, %@", totalDays, i, m_beginnerWorkoutSelectionArray);
//        }
//    }
//    
//    m_advancedWorkoutSelection          = [AdvancedWorkoutSelection sharedInstance];
//    int maxDays = 7;
//    for (int totalDays = 1; totalDays <= maxDays; totalDays++) {
//        for (int i = 0; i < totalDays; i++) {
//            m_advancedWorkoutSelectionArray     = [NSMutableArray mutableArrayObject];
//            m_advancedWorkoutSelectionArray     = [m_advancedWorkoutSelection advancedWorkoutGoal:@"SHRED FAT" WithTheDay:i ForTotalWorkOutDays:totalDays];
//            NSLog(@"[m_advancedWorkoutSelectionArray count] %d", [m_advancedWorkoutSelectionArray count]);
//            NSLog(@"m_advancedWorkoutSelectionArray is shred fat for %d day %d %@", totalDays, i, m_advancedWorkoutSelectionArray);
//            m_advancedWorkoutSelectionArray     = [NSMutableArray mutableArrayObject];
//            m_advancedWorkoutSelectionArray     = [m_advancedWorkoutSelection advancedWorkoutGoal:@"GET TONED" WithTheDay:i ForTotalWorkOutDays:totalDays];
//            NSLog(@"[m_advancedWorkoutSelectionArray count] %d", [m_advancedWorkoutSelectionArray count]);
//            NSLog(@"m_advancedWorkoutSelectionArray is get toned  %d day %d %@", totalDays, i,  m_advancedWorkoutSelectionArray);
//            m_advancedWorkoutSelectionArray     = [NSMutableArray mutableArrayObject];
//            m_advancedWorkoutSelectionArray     = [m_advancedWorkoutSelection advancedWorkoutGoal:@"BUILD MUSCLE MASS" WithTheDay:i ForTotalWorkOutDays:totalDays];
//            NSLog(@"[m_advancedWorkoutSelectionArray count] %d", [m_advancedWorkoutSelectionArray count]);
//            NSLog(@"m_advancedWorkoutSelectionArray is BUILD MUSCLE MASS %d day %d, %@", totalDays, i, m_advancedWorkoutSelectionArray);
//            m_advancedWorkoutSelectionArray     = [NSMutableArray mutableArrayObject];
//            m_advancedWorkoutSelectionArray     = [m_advancedWorkoutSelection advancedWorkoutGoal:@"MUSCLE ISOLATION" WithTheDay:i ForTotalWorkOutDays:totalDays];
//            NSLog(@"[m_advancedWorkoutSelectionArray count] %d", [m_advancedWorkoutSelectionArray count]);
//            NSLog(@"m_advancedWorkoutSelectionArray is MUSCLE ISOLATION  %d, day %d, %@", totalDays, i, m_advancedWorkoutSelectionArray);
//        }
//    }
}

@end
