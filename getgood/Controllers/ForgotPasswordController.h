//
//  ForgotPasswordController.h
//  getgood
//
//  Created by Md Aminuzzaman on 25/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedTextField.h"
#import "RestClient.h"

@import Firebase;
@import FirebaseAuth;

@interface ForgotPasswordController : UIViewController
{
    IBOutlet UIButton *buttonSubmit;
    
    IBOutlet UIImageView *imageBack;
    
    IBOutlet RoundedTextField *textEmailField;
}

- (IBAction)actionSubmit:(id)sender;

@end

