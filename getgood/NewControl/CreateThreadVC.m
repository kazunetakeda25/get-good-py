//
//  CreateThreadVC.m
//  getgood
//
//  Created by Bhargav Mistri on 26/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "CreateThreadVC.h"
#import "UIToolbar+KeyboardAdditions.h"
#import "AppData.h"
#import "UIKit.h"
#import "Thread.h"


@import Firebase;
@import FirebaseDatabase;

@interface CreateThreadVC () <UITextViewDelegate>
@end

@implementation CreateThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionBack:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.imageBack addGestureRecognizer:tapGestureRecognizer];
    self.imageBack.userInteractionEnabled = YES;
    
    UIColor *color = [UIColor grayColor];
    self.txtTopic.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Topic"
                                           attributes:@{NSForegroundColorAttributeName:color}];
    
    
    
    
    UIToolbar *toolbar = [UIToolbar doneToolbarWithTarget:self action:@selector(didPressKeyboardDoneButton:)];
    self.txtDescription.inputAccessoryView = toolbar;
    self.txtTopic.inputAccessoryView = toolbar;
    
    [self.txtDescription setReturnKeyType:UIReturnKeyDone];
    self.txtDescription.text = @"Description";
    self.txtDescription.textColor = [UIColor lightGrayColor];
    self.txtDescription.delegate = self;
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.vContainer redraw];
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView.textColor == [UIColor lightGrayColor]) {
        textView.text = @"";
        textView.textColor = [UIColor whiteColor];
    }
    return YES;
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(self.txtDescription.text.length == 0){
        self.txtDescription.textColor = [UIColor lightGrayColor];
        self.txtDescription.text =@"Description";
        [self.txtDescription resignFirstResponder];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [self.txtDescription resignFirstResponder];
        if(self.txtDescription.text.length == 0){
            self.txtDescription.textColor = [UIColor lightGrayColor];
            self.txtDescription.text = @"Description";
            [self.txtDescription resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}

- (void)didPressKeyboardDoneButton:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)btnDoneClick:(id)sender {
    
    
    if (_txtTopic.text.length == 0 || _txtDescription.text.length == 0) {
        
        [UIKit showInformation:self message:@"Please fill all fields!"];
        return;
        
    }else{        
        [RestClient createThread:_txtTopic.text description:_txtDescription.text callback:^(bool result, NSDictionary *data) {
            if(!result)
                return ;
            
            
            [self.navigationController popViewControllerAnimated:YES];
        }];        
    }

    
}

@end
