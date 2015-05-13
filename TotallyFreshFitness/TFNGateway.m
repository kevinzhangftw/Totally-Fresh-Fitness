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

@interface TFNGateway ()
@property (strong, nonatomic) RootViewController *m_rootViewController;
@property (strong, nonatomic)LoginViewController *m_loginViewController;
// Database object
@property (strong, nonatomic)Database *m_database;
// The data to be sent
@property (strong, nonatomic)NSString *m_post;
// The NSASCIIStringEncoded data
@property (strong, nonatomic)NSData *m_postData;
// The length of the data to be sent
@property (strong, nonatomic)NSString *m_postLength;
// The URL to which the data is sent
@property (strong, nonatomic)NSURL *m_url;
// The URL request
@property (strong, nonatomic)NSMutableURLRequest *m_theRequest;
// The url connection
@property (strong, nonatomic)NSURLConnection *m_theConnection;

// Check which method was called
@property (strong, nonatomic)NSString *checkMethod;

// Music Restful URL array
@property (strong, nonatomic)NSMutableArray *m_restfulURLArray;
// Music Name array
@property (strong, nonatomic)NSMutableArray *m_musicNameArray;
// Big Cover URLS array
@property (strong, nonatomic)NSMutableArray *m_bigCoverURLSArray;
// Small Cover URLS array
@property (strong, nonatomic)NSMutableArray *m_smallCoverURLSArray;
// Description array
@property (strong, nonatomic)NSMutableArray *m_descriptionArray;
// Mix id array
@property (strong, nonatomic)NSMutableArray *m_mixIDSArray;
// Like count array
@property (strong, nonatomic)NSMutableArray *m_likeCountArray;
// Play count array
@property (strong, nonatomic)NSMutableArray *m_playCountArray;
// Tag List Array
@property (strong, nonatomic)NSMutableArray *m_tagListArray;
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
    self.m_theRequest        = [[NSMutableURLRequest alloc] initWithURL:self.m_url];
    [ self.m_theRequest setHTTPMethod : @"POST" ];
    [ self.m_theRequest setValue : self.m_postLength forHTTPHeaderField : @"Content-Length" ];
    [ self.m_theRequest setHTTPBody : self.m_postData ];
    self.m_theConnection = [ [ NSURLConnection alloc ] initWithRequest : self.m_theRequest delegate : self ];
    if ( self.m_theConnection ) {
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
    if (self.checkMethod) {
        self.checkMethod = @"";
    }
    self.checkMethod     = @"Send Password to User";
    
    if (!self.m_database) {
        self.m_database  = [Database alloc];
    }
    
    self.m_post          = [ [ NSString alloc ] initWithFormat : @"email=%@&password=%@", email, [ self.m_database getPassword:email ] ];
    self.m_postData      = [ self.m_post dataUsingEncoding : NSASCIIStringEncoding allowLossyConversion : YES ];
    self.m_postLength    = [ NSString stringWithFormat : @"%lu", (unsigned long)[ self.m_postData length ] ];
    
    self.m_url           = [ NSURL URLWithString:m_passwordRecoveryWebLink ];
    
    [ self sendRequestAndReceiveData ];
}

/*
 Get food recipes from web server
 */
- (void)getFoodRecipesFromWebServer:(NSString *)foodName;
{
    if (self.checkMethod) {
        self.checkMethod = @"";
    }
    self.checkMethod     = @"Food Recipes";
    
    if (!self.m_database) {
        self.m_database  = [Database alloc];
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
    self.m_post                              = [ [ NSString alloc ] initWithFormat : @"food=%@", foodName];
    self.m_postData                          = [ self.m_post dataUsingEncoding : NSASCIIStringEncoding allowLossyConversion : YES ];
    self.m_postLength                        = [ NSString stringWithFormat : @"%lu",(unsigned long)[ self.m_postData length ] ];
        
    self.m_url                               = [ NSURL URLWithString:m_foodRecipes   ];
    [ self sendRequestAndReceiveData ];
}

/*
 Get home page images and text from web server
 */
- (void)getHomePageImagesAndTextFromWebServer
{
    if (self.checkMethod) {
        self.checkMethod                     = @"";
    }
    self.checkMethod                         = @"Home Page";

    self.m_post                              = nil;
    self.m_postData                          = [ self.m_post dataUsingEncoding : NSASCIIStringEncoding allowLossyConversion : YES ];
    self.m_postLength                        = [ NSString stringWithFormat : @"%lu", (unsigned long)[ self.m_postData length ] ];
    self.m_url                               = [NSURL URLWithString:m_homePageImagesAndText];
    [self sendRequestAndReceiveData];
}

/*
 Get Music token from 8tracks.com
 */
- (void)getMusicToken:(NSString *)musicMixesURL
{
    m_mixURLString      = musicMixesURL;
    
    if (self.checkMethod) {
        self.checkMethod                     = @"";
    }
    
    self.checkMethod                         = @"Music Token";
    
    self.m_post                              = @"api_key=1c185d80fd6b4583ebfd328c0bbf3d84f62979ae";
    self.m_postData                          = [ self.m_post dataUsingEncoding : NSASCIIStringEncoding allowLossyConversion : YES ];
    self.m_postLength                        = [ NSString stringWithFormat : @"%lu",(unsigned long)[ self.m_postData length ] ];
    self.m_url                               = [NSURL URLWithString:m_playTokenURL];
    [self sendRequestAndReceiveData];
}

- (void)initializeMusicDataArrays
{
    self.m_restfulURLArray       = [[NSMutableArray alloc] init];
    self.m_musicNameArray        = [[NSMutableArray alloc] init];
    self.m_bigCoverURLSArray        = [[NSMutableArray alloc] init];
    self.m_smallCoverURLSArray        = [[NSMutableArray alloc] init];
    self.m_descriptionArray        = [[NSMutableArray alloc] init];
    self.m_mixIDSArray        = [[NSMutableArray alloc] init];
    self.m_likeCountArray        = [[NSMutableArray alloc] init];
    self.m_playCountArray        = [[NSMutableArray alloc] init];
    self.m_tagListArray      = [[NSMutableArray alloc] init];
}

/*
 Get Music token from 8tracks.com
 */
- (void)getMusicMixes:(NSString *)musicMixesURL
{
    [self initializeMusicDataArrays];
    if (self.checkMethod) {
        self.checkMethod                     = @"";
    }
    
    self.checkMethod                         = @"Music Mix";
    
    self.m_post                              = @"api_key=1c185d80fd6b4583ebfd328c0bbf3d84f62979ae";
    self.m_postData                          = [ self.m_post dataUsingEncoding : NSASCIIStringEncoding allowLossyConversion : YES ];
    self.m_postLength                        = [ NSString stringWithFormat : @"%lu",(unsigned long)[ self.m_postData length ] ];
    self.m_url                               = [NSURL URLWithString:musicMixesURL];
    [self sendRequestAndReceiveData];
}

/*
 Get Music tracks from 8tracks.com
 */
- (void)getMusicTracksFromTracks:(NSString *)musicMixId
{
    if (self.checkMethod) {
        self.checkMethod                     = @"";
    }

    self.checkMethod                         = @"Music Tracks";
    
    m_musicSourceURL        = [NSString stringWithFormat:@"http://8tracks.com/sets/%@/play.json?mix_id=%@?api_key=1c185d80fd6b4583ebfd328c0bbf3d84f62979ae", m_musicPlayToken, musicMixId];
    self.m_url                               = [NSURL URLWithString:m_musicSourceURL];
    [self sendRequestAndReceiveData];
}

/*
 Get Next Music tracks from 8tracks.com
 */
- (void)getNextMusicFromTracks:(NSString *)musicMixId
{
    if (self.checkMethod) {
        self.checkMethod                     = @"";
    }
    
    self.checkMethod                         = @"Next Music";
    
    m_musicSourceURL        = [NSString stringWithFormat:@"http://8tracks.com/sets/%@/next.json?mix_id=%@?api_key=1c185d80fd6b4583ebfd328c0bbf3d84f62979ae", m_musicPlayToken, musicMixId];
    self.m_url                               = [NSURL URLWithString:m_musicSourceURL];
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

    if ([self.checkMethod isEqualToString:@"Send Password to User"]) {
        if (!self.m_loginViewController) {
            self.m_loginViewController       = [LoginViewController sharedInstance];
        }
        // Push the message to the login view
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.m_loginViewController displayMessage:message];
        });
    }
    else if ([self.checkMethod isEqualToString:@"Home Page"]) {
        if (!self.m_rootViewController) {
            self.m_rootViewController        = [RootViewController sharedInstance];
        }
        
        [self.m_rootViewController displayMessage:message];
    }
    else if ([self.checkMethod isEqualToString:@"Music Tracks"]) {
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
    if ([self.checkMethod isEqualToString:@"Send Password to User"]) {
        if (!self.m_loginViewController) {
            self.m_loginViewController       = [LoginViewController sharedInstance];
        }
        // Push the message to the login view
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.m_loginViewController displayMessage:receivedDataString];
        });
    }
    
    if ( [ self.checkMethod isEqualToString:@"Food Recipes" ] ) { // For this version, this should never be true
        NSError *error;
        // Data received in json format
        NSDictionary *dictionary         = [ NSJSONSerialization JSONObjectWithData : self.receivedData options : kNilOptions error : &error ];
        
        if ( !dictionary ) {
            NSLog( @"The data received is : %@", error );
        } else {
            
            NSString *status;
            if (!self.m_database) {
                self.m_database          = [Database alloc];
            }
            
            if (([dictionary objectForKey : @"Title"] != NULL) && ([[dictionary objectForKey : @"Title"] length] != 0)) {
                if (([dictionary objectForKey : @"Image"] != NULL) && ([[dictionary objectForKey : @"Image"] length] != 0)) {
                    if (([dictionary objectForKey : @"Ingredients"] != NULL) && ([[dictionary objectForKey : @"Ingredients"] length]!= 0)) {
                        if (([dictionary objectForKey : @"Directions"] != NULL) && ([[dictionary objectForKey : @"Directions"] length] != 0)) {
                            status  = [self.m_database insertIntoFoodRecipesTitle:[dictionary objectForKey : @"Title"] Image:[dictionary objectForKey : @"Image"] Ingredients:[dictionary objectForKey : @"Ingredients"] Directions:[dictionary objectForKey : @"Directions"]];
                        }
                    }
                }
            }
        }
        //Post a notification to update food recipes list
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Food Recipes Notification" object:nil];
    }
    else if([self.checkMethod isEqualToString:@"Home Page"]) {
        //        NSString *homePageString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSError *error;
        // Data received in json format
        NSMutableArray *arrayOfDictionaries         = [ NSJSONSerialization JSONObjectWithData : self.receivedData options : kNilOptions error : &error ];
        [NSMutableArray setHomePageData:arrayOfDictionaries];
        //Post a notification to update food recipes list
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Home Page Notification" object:nil];
    }
    else if ([self.checkMethod isEqualToString:@"Music Token"]) {
        [self retrieveMusicToken];
    }
    else if([self.checkMethod isEqualToString:@"Music Mix"]) {
        [self getMusicMixDetails];
    }
    else if ([self.checkMethod isEqualToString:@"Music Tracks"] || [self.checkMethod isEqualToString:@"Next Music"]) {
        [self getSelectedMusicSourceFrom8Tracks];
    }
}

- (void)setMusicTrackDetails:(NSArray *)mixes
{
    for (NSDictionary *mixItem in mixes) {
        [self.m_restfulURLArray addObject:[mixItem objectForKey:@"restful_url"]];
        [self.m_musicNameArray addObject:[mixItem objectForKey:@"name"]];
        NSDictionary *coverDictionary    = [mixItem objectForKey:@"cover_urls"];
        [self.m_bigCoverURLSArray addObject:[NSString stringWithFormat:@"%@", [coverDictionary objectForKey:@"max1024"]]];
        [self.m_smallCoverURLSArray addObject:[NSString stringWithFormat:@"%@", [coverDictionary objectForKey:@"max200"]]];
        [self.m_descriptionArray addObject:[NSString stringWithFormat:@"%@", [mixItem objectForKey:@"description"]]];
        [self.m_mixIDSArray addObject:[NSString stringWithFormat:@"%@", [mixItem objectForKey:@"id"]]];
        [self.m_likeCountArray addObject:[mixItem objectForKey:@"likes_count"]];
        [self.m_playCountArray addObject:[mixItem objectForKey:@"plays_count"]];
        [self.m_tagListArray addObject:[mixItem objectForKey:@"tag_list_cache"]];
    }
    [NSMutableArray setRestfulURL:self.m_restfulURLArray];
    [NSMutableArray setMusicName:self.m_musicNameArray];
    [NSMutableArray setBigCoverURLs:self.m_bigCoverURLSArray];
    [NSMutableArray setSmallCoverURLs:self.m_smallCoverURLSArray];
    [NSMutableArray setDescriptions:self.m_descriptionArray];
    [NSMutableArray setMusicID:self.m_mixIDSArray];
    [NSMutableArray setLikeCount:self.m_likeCountArray];
    [NSMutableArray setPlayCount:self.m_playCountArray];
    [NSMutableArray setTagList:self.m_tagListArray];
}

@end
