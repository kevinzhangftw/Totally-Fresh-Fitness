//
//  NSString+Music_Mix.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 1/23/2014.
//  Copyright (c) 2014 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Music_Mix)

+ (void)setMusicMixURL:(NSString *)musicMixURL;
+ (NSString *)getMusicMixURL;
+ (void)setSelectedMusicId:(NSString *)selectedMusicId;
+ (NSString *)getSelectedMusicId;
+ (void)setMusicSourceURL:(NSString *)sourceURL;
+(NSString *)getMusicSourceURL;
+ (void)setSelectedMusicTitle:(NSString *)selectedMusicTitle;
+ (NSString *)getSelectedMusicTitle;
+ (void)setSelectedMusicRestfulURL:(NSString *)selectedMusicRestfulURL;
+ (NSString *)getSelectedMusicRestfulURL;
+ (void)setMusicBigCoverURL:(NSString *)coverURL;
+ (NSString *)getMusicBigCoverURL;
@end
