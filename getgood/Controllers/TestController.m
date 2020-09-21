//
//  TestController.m
//  getgood
//
//  Created by Md Aminuzzaman on 11/8/17.
//  Copyright © 2017 PH. All rights reserved.
//


@import Firebase;
@import FirebaseAuth;
@import FirebaseDatabase;

#import "TestController.h"
#import "AppData.h"

@interface TestController ()

@end

@implementation TestController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    
    
    
    //self.childViewControllers.lastObject;
    
    //[[[[ref child:@"lesson"] child:@"SUJ06YYA85LW82UONC" ] child:@"Profile"] setValue:@{@"UserID":@"1234"}];
    
    [self testFirebaseLogin];
}

-(void) testFirebaseLogin
{
    
}

-(void) testFirebaseSignUp
{
    [[FIRAuth auth] createUserWithEmail:@"rminc0102@gmail.com"
                               password:@"aarm0102"
                             completion:^(FIRUser *_Nullable user, NSError *_Nullable error)
    {
         if (error)
         {
             NSLog(@"%@",error.localizedDescription);
             return;
         }
         
         NSLog(@"%@ created",user.email);
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

