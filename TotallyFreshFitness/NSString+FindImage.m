//
//  NSString+FindImage.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-13.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import "NSString+FindImage.h"

@implementation NSString (FindImage)

/*
 Find the right image for the cell
 */
+ (NSString *)findImageForMealPlan:(NSString *)possibleImageName
{
    // image name to be set
    NSString *imageName                  = @"";
    // to check if the image exist
    UIImage *cellImage;
    // underscore for for image name concatination
    NSString *underscore                 = @"_";
    
    // Check and if left bracket exist seperate it from the possible image name, if not seperate by comma
    NSArray *imageStringArray            = [possibleImageName componentsSeparatedByString:@","];
    // Image names contain "underscore" instead of whitespace
    imageName                            = [[[imageStringArray objectAtIndex:0] stringByReplacingOccurrencesOfString:@" " withString:underscore] lowercaseString];
    

    // Remove whitespace at the end
    imageName                            =
    [imageName stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    imageName                            = [NSString removeWhiteSpaceBeforeFirstWord:imageName];
    
    // Name of the textLabel should also be the name of the image
    cellImage                            = [UIImage imageNamed:imageName];
    
    if (cellImage) {
        return imageName;
    }
    else if(!cellImage) {
        return imageName                 = @"No Image";
    }

    return imageName;
}

+ (UIImage *)imageWithFilename:(NSString *)filename
{
    NSString *path;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	path = [paths[0] stringByAppendingPathComponent:@""];
	path = [path stringByAppendingPathComponent:filename];
    
    return [UIImage imageWithContentsOfFile:path];
}

// Find the right image for the cell for workout
+ (NSString *)findImageForWorkout:(NSString *)possibleImageName
{
    // Add gender to the image name
    possibleImageName           = [NSString stringWithFormat:@"%@ %@", possibleImageName, [NSString getGenderOfUser]];
    // make the strings lowercase to match image names
    possibleImageName           = [possibleImageName lowercaseString];
    NSString *imageName         = [possibleImageName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    imageName                   = [[NSString stringWithFormat:@"%@_thumb.png",imageName] lowercaseString];
    //UIImage *cellImage          = [UIImage imageNamed:imageName];
    UIImage *cellImage = [self imageWithFilename:imageName];
    
    if (cellImage) {
        return imageName;
    }
    else {
        return imageName        = @"No Image";
    }
}

// Find the right image for the cell for workout
+ (NSString *)findImageForWorkoutSub:(NSString *)possibleImageName
{
    // Add gender to the image name
    possibleImageName         = [NSString stringWithFormat:@"%@ %@", possibleImageName, [NSString getGenderOfUser]];
    // make the strings lowercase to match image names
    possibleImageName           = [possibleImageName lowercaseString];
    NSString *imageName         = [possibleImageName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    imageName                   = [[NSString stringWithFormat:@"%@_thumb",imageName] lowercaseString];
    //UIImage *cellImage          = [UIImage imageNamed:imageName];
    UIImage *cellImage = [self imageWithFilename:imageName];
    
    if (cellImage) {
        return imageName;
    }
    else {
        return imageName        = @"No Image";
    }
}

/*
 Remove space before the first word
 */
+ (NSString *)removeWhiteSpaceBeforeFirstWord:(NSString *)text
{
    // trim the whitespace before the first character
    NSCharacterSet *whitespace                      = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    text                                            = [text stringByTrimmingCharactersInSet:whitespace];
    return text;
}

@end
