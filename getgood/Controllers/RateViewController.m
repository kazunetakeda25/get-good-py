//
//  RateViewController.m
//  getgood
//
//  Created by Dan on 20/04/2018.
//  Copyright © 2018 PH. All rights reserved.
//

#import "RateViewController.h"
#import "CoachRateHelpController.h"
#import "UIKit.h"
#import "AppData.h"

@interface RateViewController ()

@end

@implementation RateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(help:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.help addGestureRecognizer:tapGestureRecognizer];
    self.help.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (void) help:(UITapGestureRecognizer*) recognizer
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    CoachRateHelpController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_coach_rating_help"];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onRate:(id)sender {
    if([self.tvReview.text length] == 0)
    {
        [UIKit showInformation:self message:@"Please fill note"];
        return;
    }
    
    [UIKit showYesNo:self message:@"Are you sure to leave this rate?" yesHandler:^(UIAlertAction *action) {
        NSString* strNote = self.tvReview.text;
        
        
        [RestClient postCoachReview:self.profile.id comment:strNote competency:(int)self.vCompetency.value communication:(int)self.vCommunication.value flexibility:(int)self.vFlexibility.value attitude:(int)self.vAttitude.value callback:^(bool result, NSDictionary *data) {
            if(!result)
                return ;
            
            [RestClient sendNotification:[NSString stringWithFormat:@"%@ has just rated you!", [AppData profile].name] user_id:self.profile.id];
            
            [self.navigationController popViewControllerAnimated:YES];
            [_vcParent updateReviewState];
        }];
    } cancelHandler:^(UIAlertAction *action) {
        
    }];
}

@end
