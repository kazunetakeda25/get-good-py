//
//  ForgotPasswordController.m
//  getgood
//
//  Created by Md Aminuzzaman on 25/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "UIKit.h"
#import "AppData.h"
#import "SVProgressHUD.h"
#import "HomeController.h"
#import "OverwatchService.h"
#import "ForgotPasswordController.h"
#import "PlayerRateDisplayController.h"

@import Firebase;
@import FirebaseAuth;
@import FirebaseDatabase;

@interface ForgotPasswordController ()

@end

@implementation ForgotPasswordController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionBack:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageBack addGestureRecognizer:tapGestureRecognizer];
    imageBack.userInteractionEnabled = YES;
}


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:false];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)actionSubmit:(id)sender
{
    if(textEmailField.text.length == 0)
    {
        [UIKit showInformation:self message:@"Please enter email address."];
        return;
    }
    
    [UIKit showLoading];
    
    [RestClient forgotPassword:textEmailField.text callback:^(bool result, NSDictionary *data) {
        
        [UIKit dismissDialog];
        
        if(result)
        {
            [UIKit showInformation:self message:@"Reset link has sent to your mail."];
        }
        else
        {
            [UIKit showInformation:self message:@"No such mail registered. Please try sign up."];
        }
    }];
}

@end


