//
//  SignUpController.h
//  getgood
//
//  Created by Md Aminuzzaman on 18/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
@import FirebaseAuth;

#import "DLRadioButton.h"
#import <RSKImageCropper/RSKImageCropper.h>
#import "RestClient.h"
#import "BorderedView.h"

@interface SignUpController : UIViewController <RSKImageCropViewControllerDelegate, RSKImageCropViewControllerDataSource>
{
    IBOutlet UIImageView *imageProfile;
    IBOutlet UIImageView *imageBack;
    
    __weak IBOutlet BorderedView *borderView;
    IBOutlet UILabel *labelLogin;
    
    IBOutlet UITextField *textUserNameField;
    IBOutlet UITextField *textEmailField;
    IBOutlet UITextField *textConfirmPasswordField;
    IBOutlet UITextField *textPasswordField;
    
    IBOutlet UIButton *buttonSignUp;
    IBOutlet UILabel *labelTerms;
    IBOutlet DLRadioButton *radioTermsButton;
}

@property (nonatomic, strong) UIImage* bmpAvatar;
@property (nonatomic, strong) NSString* strAvatar;

- (IBAction)actionSignUp:(id)sender;
- (void) gotoHomeScreen : (FIRUser *) user;
- (void) actionPicker : (UITapGestureRecognizer *)tapGesture;

@end
