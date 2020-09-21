//
//  TraineeRateViewController.m
//  getgood
//
//  Created by Dan on 20/04/2018.
//  Copyright © 2018 PH. All rights reserved.
//

#import "TraineeRateViewController.h"
#import "UIKit.h"
#import "AppData.h"

@interface TraineeRateViewController ()

@end

@implementation TraineeRateViewController

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onRate:(id)sender {
    
    if([self.txtReview.text length] == 0)
    {
        [UIKit showInformation:self message:@"Please fill note"];
        return;
    }
    [UIKit showYesNo:self message:@"Are you sure to leave this rate?" yesHandler:^(UIAlertAction *action) {
        
        NSString* strNote = self.txtReview.text;
        [RestClient postTraineeReview:self.profile.id comment:strNote general:self.traineeRate.value callback:^(bool result, NSDictionary *data) {
            if(!result)
                return ;
            
            [RestClient sendNotification:[NSString stringWithFormat:@"%@ has just rated you!", [AppData profile].name] user_id:self.profile.id];
            
            [self.navigationController popViewControllerAnimated:YES];
            [_vcParent updateReviewState];
        }];
        
    } cancelHandler:^(UIAlertAction *action) {
        
    }];
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) help:(UITapGestureRecognizer*) recognizer
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
