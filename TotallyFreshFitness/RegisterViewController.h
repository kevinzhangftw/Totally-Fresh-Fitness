//
//  RegisterViewController.h
//  Total Fitness And Nutrition
//
//  Created by Harveer Parmar on 2014-04-19.
//  Copyright (c) 2014 Total Fitness and Nutrition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChimpKit.h"


@interface RegisterViewController : UIViewController <UITextFieldDelegate>{
    // If objects moved
    BOOL objectsMoved;
}


+(RegisterViewController *)sharedInstance;
@property (strong, nonatomic) IBOutlet UITextView *termsAndConditionTextView;

@end
