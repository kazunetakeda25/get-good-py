//
//  LoginController.h
//  getgood
//
//  Created by Md Aminuzzaman on 11/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@import Firebase;
@import FirebaseAuth;

@interface LoginController : UIViewController
{
    IBOutlet UILabel *labelSignUp;
    IBOutlet UILabel *labelForgotPassword;
    
    IBOutlet UITextField *textEmailField;
    IBOutlet UITextField *textPasswordField;
    
    IBOutlet UIButton *buttonLogin;
}

- (IBAction)actionLogin:(id)sender;

- (void)actionSignUp:(UITapGestureRecognizer *)tapGesture;

-(void) gotoHomeScreen:(FIRUser *) user;

@end
