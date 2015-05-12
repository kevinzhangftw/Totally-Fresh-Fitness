//
//  ServerGateway.h
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-02.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface TFNGateway : NSObject
{
    NSMutableArray *recipesArray;
}
//Data received from server
@property ( nonatomic, retain ) NSMutableData *receivedData;
// String received from the server
@property ( nonatomic, retain ) NSString *receivedDataString;
@property (strong, nonatomic) AVPlayer *audioPlayer;

// Singleton ServerGateway object
+ (TFNGateway *)sharedInstance;

// Send Password to the user
- (void)sendPasswordToUser:(NSString *)email;
// Get food recipes from web server
- (void)getFoodRecipesFromWebServer:(NSString *)foodName;
// Get home page images and text from web server
- (void)getHomePageImagesAndTextFromWebServer;
// Get Music token
- (void)getMusicToken:(NSString *)musicMixesURL;
// Get Music mix details
- (void)getMusicMixes:(NSString *)musicMixesURL;
// Get Music tracks from 8tracks.com
- (void)getMusicTracksFromTracks:(NSString *)musicMixId;
// Get Next Music tracks from 8tracks.com
- (void)getNextMusicFromTracks:(NSString *)musicMixId;
@end
