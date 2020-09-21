//
//  PlayerRateHelpController.m
//  getgood
//
//  Created by MD Aminuzzaman on 1/8/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "PlayerRateHelpController.h"

@interface PlayerRateHelpController ()
{
}
@end

@implementation PlayerRateHelpController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];

}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionBack:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageBack addGestureRecognizer:tapGestureRecognizer];
    imageBack.userInteractionEnabled = YES;
    
    [self.vScroll setContentSize:self.vContent.frame.size];
}

- (void)actionBack:(UITapGestureRecognizer *)tapGesture
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end





