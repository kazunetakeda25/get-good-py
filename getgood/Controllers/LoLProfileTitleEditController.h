//
//  ProfileTitleEditController.h
//  getgood
//
//  Created by Md Aminuzzaman on 29/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedTextField.h"
#import "OverwatchService.h"
#import "RestClient.h"
#import "Utils.h"

@interface LoLProfileTitleEditController : UIViewController
{
    IBOutlet UIButton *updateButton;
}

@property (nonatomic, strong) NSString* strGameID;
@property (nonatomic, assign) int lolRank;
@property (nonatomic, strong) NSString* strServer;

@property (weak, nonatomic) IBOutlet RoundedTextField *tvUserName;
@property (weak, nonatomic) IBOutlet UITextView *tvDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnSetup;

- (IBAction)actionUpdate:(id)sender;

- (void) getOverwatchHeroes;
@end





