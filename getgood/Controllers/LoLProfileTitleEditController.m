//
//  ProfileTitleEditController.m
//  getgood
//
//  Created by Md Aminuzzaman on 29/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "LoLProfileTitleEditController.h"
#import "OWLoginViewController.h"
#import "LOLLoginViewController.h"
#import <ActionSheetPicker_3_0/ActionSheetPicker.h>
#import "DataArrays.h"
#import "UIKit.h"

@interface LoLProfileTitleEditController ()
{
}

@end

@implementation LoLProfileTitleEditController
@synthesize strGameID;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_tvUserName setText:[AppData profile].name];
    [_tvDescription setText:[AppData profile].lol_description];
    
    if([AppData profile].lol_id.length != 0)
    {
        [_btnSetup setHidden:YES];
    }
    else
    {
        [_btnSetup setHidden:NO];
    }
    
    strGameID = [AppData profile].lol_id;
    
    if(strGameID.length)
    {
        [_btnSetup setTitle:strGameID forState:UIControlStateNormal];
        [_btnSetup setHidden:NO];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard
{
    //    [textEmailField resignFirstResponder];
    //    [textPasswordField resignFirstResponder];
    //    [self animateTextField:nil up:NO];
    [self.view endEditing:YES];
}

- (IBAction)onUpdate:(id)sender {
    if([_tvUserName.text length] == 0)
        return;
    
    [UIKit showLoading];
    [RestClient checkName:_tvUserName.text callback:^(bool result, NSDictionary *data) {
        [UIKit dismissDialog];
        
        if(!result)
        {
            [UIKit showInformation:self message:@"Username already taken"];
            return ;
        }
        
        [AppData profile].lol_id = strGameID;
        [AppData profile].name = _tvUserName.text;
        [AppData profile].lol_server = self.strServer;
        [AppData profile].lol_description = _tvDescription.text;
        
        [RestClient updateLoLProfile:^(bool result, NSDictionary *data) {
            
        }];
        
        [OverwatchService getLolState];
        
        [self.navigationController popViewControllerAnimated:YES];
    }];

}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onOWSetup:(id)sender {
    
    if([[AppData profile] lol_id].length)
    {
        return;
    }

    [UIKit showConfirm:self message:@"Each League of Legends account can only be linked to one GetGoodApp account. Once linked, the League of Legends account cannot be re-link to another GetGood account." yesHandler:^(UIAlertAction *action) {

        
        
        NSArray *servers = [DataArrays lolServerValues];
        NSArray *colors = [DataArrays lolServerNames];
        
        [ActionSheetStringPicker showPickerWithTitle:@"Select your region"
                                                rows:colors
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
                                               self.strServer = servers[selectedIndex];
                                               
                                               UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                               
                                               LoLLoginViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_lol_setup_controller"];
                                               controller.parent = self;
                                               
                                               [self.navigationController pushViewController:controller animated:YES];
                                               
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:sender];
        
        

    }];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}

 -(void) getOverwatchHeroes
{
    [UIKit showLoading];
    [RestClient checkLoLGameID:strGameID callback:^(bool result, NSDictionary *data) {
        if(!result)
        {
            [UIKit showInformation:self message:@"Game ID already taken"];
            strGameID = @"";
            self.strServer = @"";
            
            return ;
        }
        
        if(strGameID.length)
        {
            [_btnSetup setTitle:strGameID forState:UIControlStateNormal];
            [_btnSetup setHidden:NO];
        }
        
        
        [UIKit dismissDialog];
        
    }];
}

@end
