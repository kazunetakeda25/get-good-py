//
//  FeedbackViewController.m
//  getgood
//
//  Created by Dan on 10/2/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "FeedbackViewController.h"
#import "RestClient.h"

@interface FeedbackViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tfFeedback;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onPostFeedback:(id)sender {
    if(self.tfFeedback.text.length)
    {
        [RestClient sendFeedback:self.tfFeedback.text callback:^(bool result, NSDictionary *data) {
            
        }];
    }
    
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

@end
