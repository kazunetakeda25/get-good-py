//
//  AddCommentVC.m
//  getgood
//
//  Created by Bhargav Mistri on 27/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "AddCommentVC.h"
#import "UIToolbar+KeyboardAdditions.h"
#import "AppData.h"
#import "UIKit.h"
#import "Comment.h"
#import "Temp.h"

@import Firebase;
@import FirebaseDatabase;

@interface AddCommentVC () <UITextViewDelegate>

@end

@implementation AddCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionBack:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.BackImage addGestureRecognizer:tapGestureRecognizer];
    self.BackImage.userInteractionEnabled = YES;
    
    UIToolbar *toolbar = [UIToolbar doneToolbarWithTarget:self action:@selector(didPressKeyboardDoneButton:)];
    self.TextView.inputAccessoryView = toolbar;
    [self.TextView setReturnKeyType:UIReturnKeyDone];
    self.TextView.text = @"Description";
    self.TextView.textColor = [UIColor lightGrayColor];
    self.TextView.delegate = self;
    
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView.textColor == [UIColor lightGrayColor]) {
        textView.text = @"";
        textView.textColor = [UIColor whiteColor];
    }
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(self.TextView.text.length == 0){
        self.TextView.textColor = [UIColor lightGrayColor];
        self.TextView.text =@"Description";
        [self.TextView resignFirstResponder];
    }
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [self.TextView resignFirstResponder];
        if(self.TextView.text.length == 0){
            self.TextView.textColor = [UIColor lightGrayColor];
            self.TextView.text = @"Description";
            [self.TextView resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}

- (void)didPressKeyboardDoneButton:(id)sender
{
    [self.view endEditing:YES];
}

- (void)actionBack:(UITapGestureRecognizer *)tapGesture
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSString *) randomStringWithLength: (int) len {
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

- (IBAction)btnDoneClick:(id)sender {
    
    if (self.TextView.text.length == 0) {
        
        [UIKit showInformation:self message:@"Please fill all fields!"];
        return;
        
    }else{

        
        Comment *comment;
        
        if(self.Reference == nil)
        {
            [RestClient addComment:self.TextView.text thread:[Temp threadData].id reference:@"-1" callback:^(bool result, NSDictionary *data) {
                if(!result)
                    return ;
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else
        {
            [RestClient addComment:self.TextView.text thread:@"-1" reference:self.Reference callback:^(bool result, NSDictionary *data) {
                if(!result)
                    return ;
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        
        
    }
}

@end
