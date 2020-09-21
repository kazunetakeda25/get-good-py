//
//  DescriptionController.m
//  getgood
//
//  Created by Dan on 04/04/2018.
//  Copyright © 2018 PH. All rights reserved.
//

#import "DescriptionController.h"

@interface DescriptionController ()

@end

@implementation DescriptionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tfDescription.text = self.strDesc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onUpdate:(id)sender {
    [_delegate onDescriptionEntered:[_tfDescription text]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
