//
//  NSMutableArray+Music_Data.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 1/21/2014.
//  Copyright (c) 2014 Total Fitness and Nutrition. All rights reserved.
//

#import "NSMutableArray+Music_Data.h"

static NSMutableArray *m_musicNameArray;
static NSMutableArray *m_bigCoverURLSArray;
static NSMutableArray *m_smallCoverURLSArray;
static NSMutableArray *m_descriptionsArray;
static NSMutableArray *m_musicIDSArray;
static NSMutableArray *m_likeCount;
static NSMutableArray *m_playCount;
static NSMutableArray *m_tagListArray;
static NSMutableArray *m_musicRestfulURLSArray;

@implementation NSMutableArray (Music_Data)

+ (void)setMusicName:(NSMutableArray *)musicNameArray
{
    m_musicNameArray        = musicNameArray;
}

+ (NSMutableArray *)getMusicNames
{
    return m_musicNameArray;
}

+ (void)setBigCoverURLs:(NSMutableArray *)bigCoverURLSArray
{
    m_bigCoverURLSArray        = bigCoverURLSArray;
}

+ (NSMutableArray *)getBigCoverURLs
{
    return m_bigCoverURLSArray;
}

+ (void)setSmallCoverURLs:(NSMutableArray *)smallCoverURLSArray
{
    m_smallCoverURLSArray        = smallCoverURLSArray;
}

+ (NSMutableArray *)getSmallCoverURLs
{
    return m_smallCoverURLSArray;
}

+ (void)setDescriptions:(NSMutableArray *)descriptionsArray
{
    m_descriptionsArray     = descriptionsArray;
}

+ (NSMutableArray *)getDescriptions
{
    return m_descriptionsArray;
}

+ (void)setMusicID:(NSMutableArray *)musicIDSArray
{
    m_musicIDSArray     = musicIDSArray;
}

+ (NSMutableArray *)getMusicIDS
{
    return m_musicIDSArray;
}

+ (void)setLikeCount:(NSMutableArray *)likeCount
{
    m_likeCount     = likeCount;
}

+ (NSMutableArray *)getLikeCount
{
    return m_likeCount;
}

+ (void)setPlayCount:(NSMutableArray *)playCount
{
    m_playCount     = playCount;
}

+ (NSMutableArray *)getPlayCount
{
    return m_playCount;
}

+ (void)setTagList:(NSMutableArray *)tagListArray
{
    m_tagListArray      = tagListArray;
}

+ (NSMutableArray *)getTagList
{
    return m_tagListArray;
}

+ (void)setRestfulURL:(NSMutableArray *)resultfulURLArray
{
    m_musicRestfulURLSArray      = resultfulURLArray;
}

+ (NSMutableArray *)getRestfulURL
{
    return m_musicRestfulURLSArray;
}

@end
