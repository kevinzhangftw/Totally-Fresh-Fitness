//
//  ServerGateway.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-02.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import "TFNGateway.h"
#import "Database.h"
#import "LoginViewController.h"
#import "RootViewController.h"
#import "NSMutableArray+Homepage_Data.h"
#import <AVFoundation/AVFoundation.h>
#import "NSMutableArray+Music_Data.h"
#import "NSString+Music_Mix.h"

@interface NSURLRequest ( DummyInterface )
+ ( BOOL ) allowsAnyHTTPSCertificateForHost : ( NSString * ) host;
+ ( void ) setAllowsAnyHTTPSCertificate : ( BOOL ) allow forHost : ( NSString * ) host;
@end

@implementation TFNGateway
@synthesize audioPlayer;

// Web Server URL for sending user registration details
static NSString *m_passwordRecoveryWebLink      = @"http://totalfitness.com/sendPasswordToUser.php";
// Web Server URL for getting food recipes 
NSString *m_foodRecipes                         = @"";
// Web Server URL for getting home page images and text
static NSString *m_homePageImagesAndText        = @"http://total-fitnessandnutrition.com/TotalFitnessAndNutritionApp/HomePage/homepageTextandImage.json";
// 8 Music tracks login
static NSString *m_musicTracksLogin     = @"";

// Get play token to play music from 8 tracks
static NSString *m_playTokenURL     = @"http://8tracks.com/sets/new.json?";
// Music play token
static NSString *m_musicPlayToken   = @"";
// Music mix id
static NSString *m_musicMixId       = @"";
// Get Music Source to play
static NSString *m_musicSourceURL   = @"http://8tracks.com/sets/";

// Database class object
Database *m_database;
// LoginViewController class object
LoginViewController *m_loginViewController;
// RootViewController class object
RootViewController *m_rootViewController;

// The data to be sent
NSString *m_post;
// The NSASCIIStringEncoded data
NSData *m_postData;
// The length of the data to be sent
NSString *m_postLength;
// The URL to which the data is sent
NSURL *m_url;
// The URL request
NSMutableURLRequest *m_theRequest;
// The url connection
NSURLConnection *m_theConnection;

// Check which method was called
NSString *checkMethod;

// Music Restful URL array
NSMutableArray *m_restfulURLArray;
// Music Name array
NSMutableArray *m_musicNameArray;
// Big Cover URLS array
NSMutableArray *m_bigCoverURLSArray;
// Small Cover URLS array
NSMutableArray *m_smallCoverURLSArray;
// Description array
NSMutableArray *m_descriptionArray;
// Mix id array
NSMutableArray *m_mixIDSArray;
// Like count array
NSMutableArray *m_likeCountArray;
// Play count array
NSMutableArray *m_playCountArray;
// Tag List Array
NSMutableArray *m_tagListArray;
// Mix url
static NSString *m_mixURLString;

@synthesize receivedData;
@synthesize receivedDataString;

/*
 Singleton ServerGateway object
 */
+ (TFNGateway *)sharedInstance {
	static TFNGateway *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [self alloc];
    });
	return globalInstance;
}

/*
 Send url request and receive data from server
 */
- ( void ) sendRequestAndReceiveData
{
    // Support HTTP pipelining to reduce latency in case of multiple requests.
    //    [ m_theRequest setHTTPShouldUsePipelining:YES ];
//    m_theRequest    = [ NSMutableURLRequest requestWithURL : m_url ];
    m_theRequest        = [[NSMutableURLRequest alloc] initWithURL:m_url];
    [ m_theRequest setHTTPMethod : @"POST" ];
    [ m_theRequest setValue : m_postLength forHTTPHeaderField : @"Content-Length" ];
    [ m_theRequest setHTTPBody : m_postData ];
    m_theConnection = [ [ NSURLConnection alloc ] initWithRequest : m_theRequest delegate : self ];
    if ( m_theConnection ) {
        self.receivedData = [ NSMutableData data ];
    }
    else {
        
    }
}

/*
 Send password to the email address
 */
- (void)sendPasswordToUser:(NSString *)email;
{
    if (checkMethod) {
        checkMethod = @"";
    }
    checkMethod     = @"Send Password to User";
    
    if (!m_database) {
        m_database  = [Database alloc];
    }
    
    m_post          = [ [ NSString alloc ] initWithFormat : @"email=%@&password=%@", email, [ m_database getPassword:email ] ];
    m_postData      = [ m_post dataUsingEncoding : NSASCIIStringEncoding allowLossyConversion : YES ];
    m_postLength    = [ NSString stringWithFormat : @"%lu", (unsigned long)[ m_postData length ] ];
    
    m_url           = [ NSURL URLWithString:m_passwordRecoveryWebLink ];
    
    [ self sendRequestAndReceiveData ];
}

/*
 Get food recipes from web server
 */
- (void)getFoodRecipesFromWebServer:(NSString *)foodName;
{
    if (checkMethod) {
        checkMethod = @"";
    }
    checkMethod     = @"Food Recipes";
    
    if (!m_database) {
        m_database  = [Database alloc];
    }
    
    if (m_foodRecipes) {
        m_foodRecipes                   = @"";
    }
    m_foodRecipes                       = @"http://total-fitnessandnutrition.com/TotalFitnessAndNutritionApp/FoodRecipes/";
    
    // make it lowercase
    foodName                            = [foodName lowercaseString];
    // Add this at end of every link
    NSString *phpFile                   = @"_food_recipes.php";
    
     NSString *foodRecipesLink          = @"";
    foodRecipesLink                     = [NSString stringWithFormat:@"%@%@",foodName,phpFile];
    m_foodRecipes                       = [NSString stringWithFormat:@"%@%@",m_foodRecipes,foodRecipesLink];
    m_post                              = [ [ NSString alloc ] initWithFormat : @"food=%@", foodName];
    m_postData                          = [ m_post dataUsingEncoding : NSASCIIStringEncoding allowLossyConversion : YES ];
    m_postLength                        = [ NSString stringWithFormat : @"%lu",(unsigned long)[ m_postData length ] ];
        
    m_url                               = [ NSURL URLWithString:m_foodRecipes   ];
    [ self sendRequestAndReceiveData ];
}

/*
 Get home page images and text from web server
 */
- (void)getHomePageImagesAndTextFromWebServer
{
    if (checkMethod) {
        checkMethod                     = @"";
    }
    checkMethod                         = @"Home Page";

    m_post                              = nil;
    m_postData                          = [ m_post dataUsingEncoding : NSASCIIStringEncoding allowLossyConversion : YES ];
    m_postLength                        = [ NSString stringWithFormat : @"%lu", (unsigned long)[ m_postData length ] ];
    m_url                               = [NSURL URLWithString:m_homePageImagesAndText];
    [self sendRequestAndReceiveData];
}

/*
 Get Music token from 8tracks.com
 */
- (void)getMusicToken:(NSString *)musicMixesURL
{
    m_mixURLString      = musicMixesURL;
    
    if (checkMethod) {
        checkMethod                     = @"";
    }
    
    checkMethod                         = @"Music Token";
    
    m_post                              = @"api_key=1c185d80fd6b4583ebfd328c0bbf3d84f62979ae";
    m_postData                          = [ m_post dataUsingEncoding : NSASCIIStringEncoding allowLossyConversion : YES ];
    m_postLength                        = [ NSString stringWithFormat : @"%lu",(unsigned long)[ m_postData length ] ];
    m_url                               = [NSURL URLWithString:m_playTokenURL];
    [self sendRequestAndReceiveData];
}

- (void)initializeMusicDataArrays
{
    m_restfulURLArray       = [[NSMutableArray alloc] init];
    m_musicNameArray        = [[NSMutableArray alloc] init];
    m_bigCoverURLSArray        = [[NSMutableArray alloc] init];
    m_smallCoverURLSArray        = [[NSMutableArray alloc] init];
    m_descriptionArray        = [[NSMutableArray alloc] init];
    m_mixIDSArray        = [[NSMutableArray alloc] init];
    m_likeCountArray        = [[NSMutableArray alloc] init];
    m_playCountArray        = [[NSMutableArray alloc] init];
    m_tagListArray      = [[NSMutableArray alloc] init];
}

/*
 Get Music token from 8tracks.com
 */
- (void)getMusicMixes:(NSString *)musicMixesURL
{
    [self initializeMusicDataArrays];
    if (checkMethod) {
        checkMethod                     = @"";
    }
    
    checkMethod                         = @"Music Mix";
    
    m_post                              = @"api_key=1c185d80fd6b4583ebfd328c0bbf3d84f62979ae";
    m_postData                          = [ m_post dataUsingEncoding : NSASCIIStringEncoding allowLossyConversion : YES ];
    m_postLength                        = [ NSString stringWithFormat : @"%lu",(unsigned long)[ m_postData length ] ];
    m_url                               = [NSURL URLWithString:musicMixesURL];
    [self sendRequestAndReceiveData];
}

/*
 Get Music tracks from 8tracks.com
 */
- (void)getMusicTracksFromTracks:(NSString *)musicMixId
{
    if (checkMethod) {
        checkMethod                     = @"";
    }

    checkMethod                         = @"Music Tracks";
    
    m_musicSourceURL        = [NSString stringWithFormat:@"http://8tracks.com/sets/%@/play.json?mix_id=%@?api_key=1c185d80fd6b4583ebfd328c0bbf3d84f62979ae", m_musicPlayToken, musicMixId];
    m_url                               = [NSURL URLWithString:m_musicSourceURL];
    [self sendRequestAndReceiveData];
}

/*
 Get Next Music tracks from 8tracks.com
 */
- (void)getNextMusicFromTracks:(NSString *)musicMixId
{
    if (checkMethod) {
        checkMethod                     = @"";
    }
    
    checkMethod                         = @"Next Music";
    
    m_musicSourceURL        = [NSString stringWithFormat:@"http://8tracks.com/sets/%@/next.json?mix_id=%@?api_key=1c185d80fd6b4583ebfd328c0bbf3d84f62979ae", m_musicPlayToken, musicMixId];
    m_url                               = [NSURL URLWithString:m_musicSourceURL];
    [self sendRequestAndReceiveData];
}


/*
 Retrieve music token
 */
- (void)retrieveMusicToken
{
    NSError *error;
    // Data received in json format
    NSDictionary *musicTokenDictionary         = [ NSJSONSerialization JSONObjectWithData : self.receivedData options : kNilOptions error : &error ];
    m_musicPlayToken        = [musicTokenDictionary objectForKey:@"play_token"];
    if (m_musicPlayToken) {
        [self getMusicMixes:m_mixURLString];
    }
}

/*
 Get Music mix details to display the data
 */
- (void)getMusicMixDetails
{
    NSError *error;
    // Data received in json format
    NSDictionary *musicMixDictionary         = [ NSJSONSerialization JSONObjectWithData : self.receivedData options : kNilOptions error : &error ];
    NSArray *mixes       = [musicMixDictionary objectForKey:@"mixes"];
    [self setMusicTrackDetails:mixes];
    
    //Post a notification for music mixe details
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Music Mix Notification" object:nil];
}

/*
 Get music source file required to play for the selected music
 */
- (NSString *)getSelectedMusicSourceFrom8Tracks
{
    NSString *musicSourceUrl        = @"";
    NSError *error;
    // Data received in json format
    NSDictionary *musicTracksDictionary         = [ NSJSONSerialization JSONObjectWithData : self.receivedData options : NSJSONReadingMutableContainers error : &error ];
    NSDictionary *set       = [musicTracksDictionary objectForKey:@"set"];
    NSDictionary *track     = [set objectForKey:@"track"];
    musicSourceUrl       = [track objectForKey:@"url"];
    [NSString setMusicSourceURL:musicSourceUrl];
    
    NSURL *soundURL = [NSURL URLWithString:musicSourceUrl];
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:soundURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:avAsset];
    audioPlayer = [AVPlayer playerWithPlayerItem:playerItem];
    [audioPlayer play];

    //Post a notification for music tracks list
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Music Source Notification" object:nil];
    return musicSourceUrl;
}

- ( void ) connection : ( NSURLConnection * ) connection didReceiveResponse : ( NSURLResponse * ) response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [ self.receivedData setLength:0 ];
    
}

- ( void ) connection : ( NSURLConnection * ) connection didReceiveData : ( NSData * ) data
{
    receivedDataString              = [ [ NSString alloc ] initWithData : data encoding : NSASCIIStringEncoding ];
    
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [ self.receivedData appendData:data ];
}

- ( void ) connection : ( NSURLConnection * ) connection didFailWithError : ( NSError * ) error
{
    // inform the user on error
    NSString *message       = @"Internet connection failed";

    if ([checkMethod isEqualToString:@"Send Password to User"]) {
        if (!m_loginViewController) {
            m_loginViewController       = [LoginViewController sharedInstance];
        }
        // Push the message to the login view
        dispatch_async(dispatch_get_main_queue(), ^{
            [m_loginViewController displayMessage:message];
        });
    }
    else if ([checkMethod isEqualToString:@"Home Page"]) {
        if (!m_rootViewController) {
            m_rootViewController        = [RootViewController sharedInstance];
        }
        
        [m_rootViewController displayMessage:message];
    }
    else if ([checkMethod isEqualToString:@"Music Tracks"]) {
        NSLog(@"Music Track Error Loading");
    }
}

- ( void ) connectionDidFinishLoading : ( NSURLConnection * ) connection
{
    // do something with the data

    if ( receivedDataString ) {
        receivedDataString              = @"";
    }
    receivedDataString = [ [ NSString alloc ] initWithData : receivedData encoding : NSASCIIStringEncoding ];
    if ([checkMethod isEqualToString:@"Send Password to User"]) {
        if (!m_loginViewController) {
            m_loginViewController       = [LoginViewController sharedInstance];
        }
        // Push the message to the login view
        dispatch_async(dispatch_get_main_queue(), ^{
            [m_loginViewController displayMessage:receivedDataString];
        });
    }
    
    if ( [ checkMethod isEqualToString:@"Food Recipes" ] ) { // For this version, this should never be true
        NSError *error;
        // Data received in json format
        NSDictionary *dictionary         = [ NSJSONSerialization JSONObjectWithData : self.receivedData options : kNilOptions error : &error ];
        
        if ( !dictionary ) {
            NSLog( @"The data received is : %@", error );
        } else {
            
            NSString *status;
            if (!m_database) {
                m_database          = [Database alloc];
            }
            
            if (([dictionary objectForKey : @"Title"] != NULL) && ([[dictionary objectForKey : @"Title"] length] != 0)) {
                if (([dictionary objectForKey : @"Image"] != NULL) && ([[dictionary objectForKey : @"Image"] length] != 0)) {
                    if (([dictionary objectForKey : @"Ingredients"] != NULL) && ([[dictionary objectForKey : @"Ingredients"] length]!= 0)) {
                        if (([dictionary objectForKey : @"Directions"] != NULL) && ([[dictionary objectForKey : @"Directions"] length] != 0)) {
                            status  = [m_database insertIntoFoodRecipesTitle:[dictionary objectForKey : @"Title"] Image:[dictionary objectForKey : @"Image"] Ingredients:[dictionary objectForKey : @"Ingredients"] Directions:[dictionary objectForKey : @"Directions"]];
                        }
                    }
                }
            }
        }
        //Post a notification to update food recipes list
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Food Recipes Notification" object:nil];
    }
    else if([checkMethod isEqualToString:@"Home Page"]) {
        //        NSString *homePageString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSError *error;
        // Data received in json format
        NSMutableArray *arrayOfDictionaries         = [ NSJSONSerialization JSONObjectWithData : self.receivedData options : kNilOptions error : &error ];
        [NSMutableArray setHomePageData:arrayOfDictionaries];
        //Post a notification to update food recipes list
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Home Page Notification" object:nil];
    }
    else if ([checkMethod isEqualToString:@"Music Token"]) {
        [self retrieveMusicToken];
    }
    else if([checkMethod isEqualToString:@"Music Mix"]) {
        [self getMusicMixDetails];
    }
    else if ([checkMethod isEqualToString:@"Music Tracks"] || [checkMethod isEqualToString:@"Next Music"]) {
        [self getSelectedMusicSourceFrom8Tracks];
    }
}

- (void)setMusicTrackDetails:(NSArray *)mixes
{
    for (NSDictionary *mixItem in mixes) {
        [m_restfulURLArray addObject:[mixItem objectForKey:@"restful_url"]];
        [m_musicNameArray addObject:[mixItem objectForKey:@"name"]];
        NSDictionary *coverDictionary    = [mixItem objectForKey:@"cover_urls"];
        [m_bigCoverURLSArray addObject:[NSString stringWithFormat:@"%@", [coverDictionary objectForKey:@"max1024"]]];
        [m_smallCoverURLSArray addObject:[NSString stringWithFormat:@"%@", [coverDictionary objectForKey:@"max200"]]];
        [m_descriptionArray addObject:[NSString stringWithFormat:@"%@", [mixItem objectForKey:@"description"]]];
        [m_mixIDSArray addObject:[NSString stringWithFormat:@"%@", [mixItem objectForKey:@"id"]]];
        [m_likeCountArray addObject:[mixItem objectForKey:@"likes_count"]];
        [m_playCountArray addObject:[mixItem objectForKey:@"plays_count"]];
        [m_tagListArray addObject:[mixItem objectForKey:@"tag_list_cache"]];
    }
    [NSMutableArray setRestfulURL:m_restfulURLArray];
    [NSMutableArray setMusicName:m_musicNameArray];
    [NSMutableArray setBigCoverURLs:m_bigCoverURLSArray];
    [NSMutableArray setSmallCoverURLs:m_smallCoverURLSArray];
    [NSMutableArray setDescriptions:m_descriptionArray];
    [NSMutableArray setMusicID:m_mixIDSArray];
    [NSMutableArray setLikeCount:m_likeCountArray];
    [NSMutableArray setPlayCount:m_playCountArray];
    [NSMutableArray setTagList:m_tagListArray];
}

@end
