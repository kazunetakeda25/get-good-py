//
//  CoachRateHelpController.m
//  getgood
//
//  Created by MD Aminuzzaman on 1/8/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "CoachRateHelpController.h"

@interface CoachRateHelpController ()
{
}
@end

@implementation CoachRateHelpController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:false];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initUI
{

}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end




