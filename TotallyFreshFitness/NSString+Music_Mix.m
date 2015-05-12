//
//  NSString+Music_Mix.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 1/23/2014.
//  Copyright (c) 2014 Total Fitness and Nutrition. All rights reserved.
//

#import "NSString+Music_Mix.h"

static NSString *m_musixMixURL;
static NSString *m_selectedMusicId;
static NSString *m_musicSourceURL;
static NSString *m_selectedMusicTitle;
static NSString *m_musicBigCoverURL;
static NSString *m_selectedMusicRestfulURL;

@implementation NSString (Music_Mix)

+ (void)setMusicMixURL:(NSString *)musicMixURL
{
    m_musixMixURL       = musicMixURL;
}

+ (NSString *)getMusicMixURL
{
    return m_musixMixURL;
}

+ (void)setSelectedMusicId:(NSString *)selectedMusicId
{
    m_selectedMusicId       = selectedMusicId;
}

+ (NSString *)getSelectedMusicId
{
    return m_selectedMusicId;
}

+ (void)setMusicSourceURL:(NSString *)sourceURL
{
    m_musicSourceURL        = sourceURL;
}

+(NSString *)getMusicSourceURL
{
    return m_musicSourceURL;
}

+ (void)setSelectedMusicTitle:(NSString *)selectedMusicTitle
{
    m_selectedMusicTitle        = selectedMusicTitle;
}

+ (NSString *)getSelectedMusicTitle
{
    return m_selectedMusicTitle;
}

+ (void)setMusicBigCoverURL:(NSString *)coverURL
{
    m_musicBigCoverURL        = coverURL;
}

+(NSString *)getMusicBigCoverURL
{
    return m_musicBigCoverURL;
}

+ (void)setSelectedMusicRestfulURL:(NSString *)selectedMusicRestfulURL
{
    m_selectedMusicRestfulURL       = selectedMusicRestfulURL;
}

+ (NSString *)getSelectedMusicRestfulURL
{
    return m_selectedMusicRestfulURL;
}

@end
