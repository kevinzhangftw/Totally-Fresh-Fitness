//
//  NSMutableArray+Music_Data.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 1/21/2014.
//  Copyright (c) 2014 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Music_Data)

+ (void)setMusicName:(NSMutableArray *)musicNameArray;
+ (NSMutableArray *)getMusicNames;
+ (void)setBigCoverURLs:(NSMutableArray *)coverURLSArray;
+ (NSMutableArray *)getBigCoverURLs;
+ (void)setSmallCoverURLs:(NSMutableArray *)coverURLSArray;
+ (NSMutableArray *)getSmallCoverURLs;
+ (void)setDescriptions:(NSMutableArray *)descriptionsArray;
+ (NSMutableArray *)getDescriptions;
+ (void)setMusicID:(NSMutableArray *)musicIDsArray;
+ (NSMutableArray *)getMusicIDS;
+ (void)setLikeCount:(NSMutableArray *)likeCount;
+(NSMutableArray *)getLikeCount;
+ (void)setPlayCount:(NSMutableArray *)playCount;
+(NSMutableArray *)getPlayCount;
+ (void)setTagList:(NSMutableArray *)tagListArray;
+(NSMutableArray *)getTagList;
+ (void)setRestfulURL:(NSMutableArray *)resultfulURLArray;
+(NSMutableArray *)getRestfulURL;

@end
