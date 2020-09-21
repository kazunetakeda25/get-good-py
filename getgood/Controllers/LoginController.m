//
//  LoginController.m
//  getgood
//
//  Created by Md Aminuzzaman on 11/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "UIKit.h"
#import "AppData.h"
#import "SVProgressHUD.h"
#import "HomeController.h"
#import "LoginController.h"
#import "SignUpController.h"
#import "RoundedTextField.h"
#import "OverwatchService.h"
#import "ForgotPasswordController.h"
#import "PlayerRateDisplayController.h"
#import "Utils.h"

@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //[[FIRAuth auth] signOut:nil];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionSignUp:)];

    tapGestureRecognizer.numberOfTapsRequired = 1;
    [labelSignUp addGestureRecognizer:tapGestureRecognizer];
    labelSignUp.userInteractionEnabled = YES;

    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionForgotPassword:)];

    tapGestureRecognizer.numberOfTapsRequired = 1;
    [labelForgotPassword addGestureRecognizer:tapGestureRecognizer];
    labelForgotPassword.userInteractionEnabled = YES;
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (void)actionSignUp:(UITapGestureRecognizer *)tapGesture
{
    UILabel *labelTapped = (UILabel *)tapGesture.view;
    
    NSLog(@"Tag:%ld",(long)labelTapped.tag);
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    SignUpController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_sign_up_controller"];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)actionForgotPassword:(UITapGestureRecognizer *)tapGesture
{
    UILabel *labelTapped = (UILabel *)tapGesture.view;
    
    NSLog(@"Tag:%ld",(long)labelTapped.tag);
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    ForgotPasswordController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_forgot_password"];
    
    [self.navigationController pushViewController:controller animated:YES];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString* token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    for (UIView *i in self.view.subviews){
        if([i tag] == 1)
        {
            [i setHidden:YES];
        }
    }
    
    if(token != nil)
    {
        [RestClient getProfile:^(bool result, NSDictionary *data) {
            
            if(result)
            {
                User* user = [[User alloc] initWithDictionary:[data objectForKey:@"profile"]];
                
                [AppData setProfile:user];
                [AppData setToken:token];
                
                [self gotoHomeScreen];
                NSString *fcmToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"push_token"];
                if (fcmToken != nil) {
                    [RestClient updatePushToken:fcmToken callback:^(bool result, NSDictionary *data) {
                        
                    }];
                }
            }
            else
            {
                for (UIView *i in self.view.subviews){
                    if([i tag] == 1)
                    {
                        [i setHidden:NO];
                    }
                }
            }
        }];
    }
    else
    {
        for (UIView *i in self.view.subviews){
            if([i tag] == 1)
            {
                [i setHidden:NO];
            }
        }
    }

}

-(IBAction)actionLogin:(id)sender
{
    
    [self.view endEditing:YES];
    if(textEmailField.text.length == 0 || textPasswordField.text.length == 0)
        return;
    
    [UIKit showLoading];
    [RestClient login:textEmailField.text password:textPasswordField.text callback:^(bool result, NSDictionary *data) {
        [UIKit dismissDialog];
        if(!result)
        {
            [UIKit showInformation:self message:@"Invalid email or password."];
            return;
        }
        
        User* user = [[User alloc] initWithDictionary:[data objectForKey:@"user"]];
        
        if(!user.verified)
        {
            [UIKit showYesNo:self message:@"Please check your mail and verify. Resend verify email?" yesHandler:^(UIAlertAction *action) {
                [UIKit showLoading];
                [RestClient verify:user.email callback:^(bool result, NSDictionary *data) {
                    [UIKit dismissDialog];
                    [UIKit showInformation:self message:@"Verification email sent to your email address. Please check your spam folder if you cannot find it in your inbox."];
                }];
            } cancelHandler:^(UIAlertAction *action) {
                
            }];
            
            return;            
        }
        
        [AppData setProfile:user];
        [AppData setToken:[data objectForKey:@"token"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:[data objectForKey:@"token"] forKey:@"token"];
        
        [self gotoHomeScreen];
        
    }];
}

- (void) gotoHomeScreen
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    HomeController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_home_controller"];
    
    //controller.userId = [AppData userProfile].userId;
    
    [UIKit dismissDialog];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    if(up)
    {
        if(self.view.frame.origin.y < -10)
            return;
    }
    else
    {
        if(self.view.frame.origin.y > -10)
            return;
    }

    
    const int movementDistance = -130; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isKindOfClass:[RoundedTextField class]]) {
        UITextField *nextField = [(RoundedTextField *)textField nextField];
        
        if (nextField)
        {
            dispatch_async(dispatch_get_main_queue(), ^
            {
                [nextField becomeFirstResponder];
            });
        }
        else {
            [textField resignFirstResponder];
        }
    }
    
    return YES;
}

@end

