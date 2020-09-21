//
//  ProfileTitleEditController.m
//  getgood
//
//  Created by Md Aminuzzaman on 29/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "ProfileTitleEditController.h"
#import "OWLoginViewController.h"
#import "LOLLoginViewController.h"
#import <ActionSheetPicker_3_0/ActionSheetPicker.h>
#import "DataArrays.h"

@interface ProfileTitleEditController ()
{
}

@end

@implementation ProfileTitleEditController
@synthesize strGameID;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_tvUserName setText:[AppData profile].name];
    [_tvDescription setText:[AppData profile].getgood_description];
    
    if([AppData profile].blizzard_id.length != 0)
    {
        [_btnSetup setHidden:YES];
    }
    else
    {
        [_btnSetup setHidden:NO];
    }
    
    strGameID = [AppData profile].blizzard_id;
    
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
    
    [RestClient checkGameID:strGameID callback:^(bool result, NSDictionary *data) {
        [UIKit dismissDialog];
        if(!result)
        {
            [UIKit showInformation:self message:@"Game ID already taken"];
            return ;
        }
        
        [UIKit showLoading];
        [RestClient checkName:_tvUserName.text callback:^(bool result, NSDictionary *data) {
            [UIKit dismissDialog];
            
            if(!result)
            {
                [UIKit showInformation:self message:@"Username already taken"];
                return ;
            }
            
            [AppData profile].blizzard_id = strGameID;
            [AppData profile].name = _tvUserName.text;
            [AppData profile].server = self.strServer;
            [AppData profile].getgood_description = _tvDescription.text;
            [AppData profile].overwatch_rank = self.overwatchRank;
            
            [RestClient updateProfile:^(bool result, NSDictionary *data) {
                
            }];
            
            [self.navigationController popViewControllerAnimated:YES];
        }];

    }];

}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onOWSetup:(id)sender {
    
    if([[AppData profile] blizzard_id].length)
    {
        return;
    }

    [UIKit showConfirm:self message:@"Each Overwatch account can only be linked to one GetGoodApp account. Once linked, the Overwatch account cannot be re-link to another GetGood account." yesHandler:^(UIAlertAction *action) {


        NSArray *servers = [NSArray arrayWithObjects:@"us", @"eu", @"kr", nil];
        NSArray *colors = [NSArray arrayWithObjects:@"Americas", @"Europe", @"Asia", nil];

        [ActionSheetStringPicker showPickerWithTitle:@"Select your region"
                                                rows:colors
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {

                                               self.strServer = servers[selectedIndex];

                                               UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];

                                               OWLoginViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_ow_setup_controller"];
                                               controller.parent = self;
                                               [self.navigationController pushViewController:controller animated:YES];

                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:sender];
    }];
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    
//    LoLLoginViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_lol_setup_controller"];
//    controller.parent = self;
//    
//    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(strGameID.length)
    {
        [_btnSetup setTitle:strGameID forState:UIControlStateNormal];
        [_btnSetup setHidden:NO];
    }
}

 -(void) getOverwatchHeroes
{
    [UIKit showLoading];
    [RestClient checkGameID:strGameID callback:^(bool result, NSDictionary *data) {
        [UIKit dismissDialog];
        if(!result)
        {
            [UIKit showInformation:self message:@"Game ID already taken"];
            return ;
        }
        
        [UIKit showLoading];
        [OverwatchService getOverwatchState:strGameID listener :^(NSDictionary *dictionary) {
            NSString *ranking = @"0";
            
            NSArray* arComponenets = [[AppData profile].server componentsSeparatedByString:@"/"];
            if(arComponenets.count < 2)
            {
                return ;
                
            }
            
            NSString* strServer = [arComponenets objectAtIndex:1];
            ranking = [[[[[ dictionary objectForKey:strServer] objectForKey: @"stats"] objectForKey:@"competitive"] objectForKey:@"overall_stats"] objectForKey:@"comprank"];
            
            @try
            {
                self.overwatchRank = [ranking intValue];
            }
            @catch (NSException* ex)
            {
                self.overwatchRank = 0;
            }
            
            
            [UIKit dismissDialog];
        }];
    }];

}

@end
