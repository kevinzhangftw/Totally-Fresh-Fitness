//
//  Transitions.m
//  Total Fitness & Nutrition
//
//  Created by Namgyal Damdul on 2012-08-27.
//  Copyright (c) 2012 Total Fitness And Nutrition. All rights reserved.
//
#define kOFFSET_FOR_KEYBOARD 135.0

#import "ViewTransitions.h"

@implementation ViewTransitions

@synthesize transition;

/*
 Singleton ViewTransitions object
 */
+ (ViewTransitions *)sharedInstance {
	static ViewTransitions *globalInstance;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
        globalInstance = [[self alloc] init];
    });
	return globalInstance;
}

/*
    Initialize the transition and prepare it for animation
*/
- ( id ) init
{
    if (self) {
        self = [ super init ];
    }
    self.transition = [ CATransition animation ];
    // Transition should complete in half a second
    [ self.transition setDuration: 0.5 ];
    return self;
}

/*
    Animate the view transition from bottom to top
*/
- ( void ) performTransitionFromBottom : ( UIView * ) view
{
    [ self.transition setType : kCATransitionPush ];
    [ self.transition setSubtype : kCATransitionFromBottom ];
    [ self.transition setTimingFunction : [ CAMediaTimingFunction
                                        functionWithName : kCAMediaTimingFunctionEaseInEaseOut ] ];
    // The nil pointer is also a valid key
    [ [ view layer ] addAnimation : self.transition forKey : nil ];
}

/*
    Animate the view transition from top to bottom
*/
- ( void ) performTransitionFromTop : ( UIView * ) view
{
    [ self.transition setType : kCATransitionPush ];
    [ self.transition setSubtype : kCATransitionFromTop ];
    [ self.transition setTimingFunction : [ CAMediaTimingFunction
                                        functionWithName : kCAMediaTimingFunctionEaseInEaseOut ] ];
    //The nil pointer is also a valid key
    [ [ view layer ] addAnimation : self.transition forKey : nil ];
}

/*
    Animate the view transition from right to left
*/
- ( void ) performTransitionFromRight : ( UIView * ) view
{
    [ self.transition setType : kCATransitionPush ];
    [ self.transition setSubtype : kCATransitionFromRight ];
    [ self.transition setTimingFunction : [ CAMediaTimingFunction
                                        functionWithName : kCAMediaTimingFunctionEaseInEaseOut ] ];
    // The nil pointer is also a valid key
    [ [ view layer ] addAnimation : self.transition forKey:nil ];
}

/*
    Animate the view transition from left to right
*/
- ( void ) performTransitionFromLeft : ( UIView * ) view
{
    [ self.transition setType : kCATransitionPush ];
    [ self.transition setSubtype : kCATransitionFromLeft ];
	self.transition.timingFunction = [ CAMediaTimingFunction
                                      functionWithName : kCAMediaTimingFunctionEaseInEaseOut ];
	self.transition.delegate = self;
    // The nil pointer is also a valid key
    [ [ view layer ] addAnimation : self.transition forKey : nil ];
}

/*
    Animate the view transition to appear
*/
- ( void ) performTransitionAppear : ( UIView * ) view
{
    [ self.transition setType : kCATransitionReveal ];
    [ self.transition setSubtype : kCATransitionFromTop ];
	self.transition.timingFunction = [ CAMediaTimingFunction
                                      functionWithName : kCAMediaTimingFunctionEaseInEaseOut ];
	self.transition.delegate = self;
    // The nil pointer is also a valid key
    [ [ view layer ] addAnimation : self.transition forKey : nil ];
}

/*
    Animate the view transition to disappear
*/
- ( void ) performTransitionDisappear : ( UIView * ) view
{
    [ self.transition setType : kCATransitionFade ];
    [ self.transition setSubtype : kCATransitionFromBottom ];
	self.transition.timingFunction = [ CAMediaTimingFunction
                                      functionWithName : kCAMediaTimingFunctionEaseInEaseOut ];
	self.transition.delegate = self;
    // The nil pointer is also a valid key
    [ [ view layer ] addAnimation : self.transition forKey : nil ];
}

/*
 View transition to allow text input above keyboard
 */
- (void) setViewMovedUp:(BOOL)movedUp View:(UIView *)view
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
    
    CGRect rect = view.frame;
    if (movedUp) {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    view.frame = rect;
    
    [UIView commitAnimations];
}

/*
 Animate the view transition to appear for moving images
 */
- ( void ) performTransitionAppearForMovingImages : ( UIView * ) view
{
    CATransition *transitionMovingImages;
    [ transitionMovingImages setType : kCATransitionReveal ];
    [ transitionMovingImages setSubtype : kCATransitionFromTop ];
	transitionMovingImages.timingFunction  = [ CAMediaTimingFunction
                                      functionWithName : kCAMediaTimingFunctionEaseInEaseOut ];
	transitionMovingImages.delegate        = self;
    transitionMovingImages.duration        = 3.0f;
    // The nil pointer is also a valid key
    [ [ view layer ] addAnimation : transitionMovingImages forKey : nil ];
}

@end
