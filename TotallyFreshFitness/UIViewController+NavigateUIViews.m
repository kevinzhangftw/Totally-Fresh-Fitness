//
//  UIViewController+NavigateUIViews.m
//  Total Fitness And Nutrition
//
//  Created by Namgyal Damdul on 2012-11-18.
//  Copyright (c) 2012 Total Fitness and Nutrition. All rights reserved.
//

#import "UIViewController+NavigateUIViews.h"
#import "ViewTransitions.h"
#import "AppDelegate.h"


@implementation UIViewController (NavigateUIViews)



/*
 Move to destination view from current view
 */
- (void)moveToView:(UIView *)destinationView FromCurrentView:(UIView *)currentView ByRefreshing:(id)instanceObject;
{
  //HAX
//    if (!m_transition) {
//        m_transition                = [[ViewTransitions alloc] init];
//    }
//    
//    [m_transition performTransitionDisappear:currentView];
//    
//    if (currentView.superview == destinationView) { // if the desitnation view is the superview
//        [m_transition performTransitionFromRight:currentView.superview];
//        [currentView removeFromSuperview];
//        //  call the class object's viewwillappear to fresh the view
//        [instanceObject viewWillAppear:YES];
//    }
//    else if(currentView.superview.superview   ==  destinationView) { // if the desitination view is the superview of superview
//        [m_transition performTransitionFromRight:currentView.superview.superview];
//        [currentView.superview removeFromSuperview];
//        [currentView removeFromSuperview];
//        //  call the class object's viewwillappear to fresh the view
//        [instanceObject viewWillAppear:YES];
//    }
//    else if(currentView.superview.superview.superview   ==  destinationView) { // if the desitination view is the superview of superview of superview
//        [m_transition performTransitionFromRight:currentView.superview.superview.superview];
//        [currentView.superview.superview removeFromSuperview];
//        [currentView.superview removeFromSuperview];
//        [currentView removeFromSuperview];
//        //  call the class object's viewwillappear to fresh the view
//        [instanceObject viewWillAppear:YES];
//    }
//    else if(currentView.superview.superview.superview.superview   ==  destinationView) { // if the desitination view is the superview of superview of superview of superview
//        [m_transition performTransitionFromRight:currentView.superview.superview.superview.superview];
//        [currentView.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview removeFromSuperview];
//        [currentView.superview removeFromSuperview];
//        [currentView removeFromSuperview];
//        //  call the class object's viewwillappear to fresh the view
//        [instanceObject viewWillAppear:YES];
//    }
//    else if(currentView.superview.superview.superview.superview.superview   ==  destinationView) { // if the desitination view is the superview of superview of superview of superview
//        [m_transition performTransitionFromRight:currentView.superview.superview.superview.superview.superview];
//        [currentView.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview removeFromSuperview];
//        [currentView.superview removeFromSuperview];
//        [currentView removeFromSuperview];
//        //  call the class object's viewwillappear to fresh the view
//        [instanceObject viewWillAppear:YES];
//    }
//    else if(currentView.superview.superview.superview.superview.superview.superview   ==  destinationView) { // if the desitination view is the superview of superview of superview of superview
//        [m_transition performTransitionFromRight:currentView.superview.superview.superview.superview.superview.superview];
//        [currentView.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview removeFromSuperview];
//        [currentView.superview removeFromSuperview];
//        [currentView removeFromSuperview];
//        //  call the class object's viewwillappear to fresh the view
//        [instanceObject viewWillAppear:YES];
//    }
//    else if(currentView.superview.superview.superview.superview.superview.superview.superview   ==  destinationView) { // if the desitination view is the superview of superview of superview of superview
//        [m_transition performTransitionFromRight:currentView.superview.superview.superview.superview.superview.superview.superview];
//        [currentView.superview.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview removeFromSuperview];
//        [currentView.superview removeFromSuperview];
//        [currentView removeFromSuperview];
//        //  call the class object's viewwillappear to fresh the view
//        [instanceObject viewWillAppear:YES];
//    }
//    else if(currentView.superview.superview.superview.superview.superview.superview.superview.superview   ==  destinationView) { // if the desitination view is the superview of superview of superview of superview
//        [m_transition performTransitionFromRight:currentView.superview.superview.superview.superview.superview.superview.superview.superview];
//        [currentView.superview.superview.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview removeFromSuperview];
//        [currentView.superview removeFromSuperview];
//        [currentView removeFromSuperview];
//        //  call the class object's viewwillappear to fresh the view
//        [instanceObject viewWillAppear:YES];
//    }
//    else if(currentView.superview.superview.superview.superview.superview.superview.superview.superview.superview   ==  destinationView) { // if the desitination view is the superview of superview of superview of superview
//        [m_transition performTransitionFromRight:currentView.superview.superview.superview.superview.superview.superview.superview.superview.superview];
//        [currentView.superview.superview.superview.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview removeFromSuperview];
//        [currentView.superview removeFromSuperview];
//        [currentView removeFromSuperview];
//        //  call the class object's viewwillappear to fresh the view
//        [instanceObject viewWillAppear:YES];
//    }
//    else if(currentView.superview.superview.superview.superview.superview.superview.superview.superview.superview.superview   ==  destinationView) { // if the desitination view is the superview of superview of superview of superview
//        [m_transition performTransitionFromRight:currentView.superview.superview.superview.superview.superview.superview.superview.superview.superview.superview];
//        [currentView.superview.superview.superview.superview.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview removeFromSuperview];
//        [currentView.superview removeFromSuperview];
//        [currentView removeFromSuperview];
//        //  call the class object's viewwillappear to fresh the view
//        [instanceObject viewWillAppear:YES];
//    }
//    else if(currentView.superview.superview.superview.superview.superview.superview.superview.superview.superview.superview.superview   ==  destinationView) { // if the desitination view is the superview of superview of superview of superview
//        [m_transition performTransitionFromRight:currentView.superview.superview.superview.superview.superview.superview.superview.superview.superview.superview.superview];
//        [currentView.superview.superview.superview.superview.superview.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview.superview removeFromSuperview];
//        [currentView.superview.superview removeFromSuperview];
//        [currentView.superview removeFromSuperview];
//        [currentView removeFromSuperview];
//        //  call the class object's viewwillappear to fresh the view
//        [instanceObject viewWillAppear:YES];
//    }
//    else { // if the desitination view not a superview
//        [m_transition performTransitionFromLeft:destinationView];
//        [currentView addSubview:destinationView];
//    }
//    
//    destinationView.hidden    = NO;
}

@end
