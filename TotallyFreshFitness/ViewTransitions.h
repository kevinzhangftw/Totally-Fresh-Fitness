//
//  Transitions.h
//  Total Fitness & Nutrition
//
//  This interface contains methods handles the transition animations on
//  the views.
//  It handles different kind of transitions like transition from right,
//  left, bottom, top and also animate to appear and disappear.
//
//  Created by Namgyal Damdul on 2012-08-27.
//  Copyright (c) 2012 Total Fitness And Nutrition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewTransitions : NSObject
{
    CATransition *transition;
}

@property(nonatomic, retain) CATransition *transition;

// Animate view transition from the right to left
- ( void ) performTransitionFromRight:( UIView * )view;
// Animate view transition from the left to right
- ( void ) performTransitionFromLeft:( UIView * )view;
// Animate view transition to appear
- ( void ) performTransitionAppear:( UIView * )view;
// Animate view transition to disappear
- ( void ) performTransitionDisappear:( UIView * )view;
// Animate view transition from top to bottom
- ( void ) performTransitionFromTop:( UIView * )view;
// Animate view transition from bottom to top
- ( void ) performTransitionFromBottom:( UIView * )view;
// View transition to allow text input above keyboard
- (void) setViewMovedUp:(BOOL)movedUp View:(UIView *)view;
// Animate the view transition to appear for moving images
- ( void ) performTransitionAppearForMovingImages : ( UIView * ) view;

// Singleton ViewTransitions object
+ (ViewTransitions *)sharedInstance;

@end
