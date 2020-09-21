//
//  UIKit.m
//  getgood
//
//  Created by Md Aminuzzaman on 26/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "UIKit.h"
#import "SVProgressHUD.h"

@implementation UIKit

+(void) showDialog :(UIViewController *) controller titleMessage:(NSString *) title message: (NSString *) msg buttonText: (NSString *) bText
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:msg
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:bText
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    
    [alertController addAction:actionOk];
    
    [controller presentViewController:alertController animated:YES completion:nil];
}

+(void) showInformation :(UIViewController *) controller message: (NSString *) msg
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Get Good"
                                                                             message:msg
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    
    [alertController addAction:actionOk];
    
    [controller presentViewController:alertController animated:YES completion:nil];
}

+(void) showYesNo :(UIViewController *) controller message: (NSString *) msg yesHandler:(void (^)(UIAlertAction *action)) yHandler cancelHandler:(void (^)(UIAlertAction *action)) cHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Get Good"
                                                                             message:msg
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Yes"
                                                       style:UIAlertActionStyleDefault
                                                     handler:yHandler];
    
    [alertController addAction:actionOk];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                       style:UIAlertActionStyleDefault
                                                     handler:cHandler];
    
    [alertController addAction:actionCancel];
    
    [controller presentViewController:alertController animated:YES completion:nil];
}

+(void) showConfirm :(UIViewController *) controller message: (NSString *) msg yesHandler:(void (^)(UIAlertAction *action)) yHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Get Good"
                                                                             message:msg
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Confirm"
                                                       style:UIAlertActionStyleDefault
                                                     handler:yHandler];
    
    [alertController addAction:actionOk];
    
    
    [controller presentViewController:alertController animated:YES completion:nil];
}


+(void) showGotIt :(UIViewController *) controller message: (NSString *) msg yesHandler:(void (^)(UIAlertAction *action)) yHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Get Good"
                                                                             message:msg
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Got it"
                                                       style:UIAlertActionStyleDefault
                                                     handler:yHandler];
    
    [alertController addAction:actionOk];
    
    
    [controller presentViewController:alertController animated:YES completion:nil];
}

+(void) showLoading
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [SVProgressHUD show];
        
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    });
}

+(void) dismissDialog
{
    dispatch_async(dispatch_get_main_queue(), ^{
//        if ([SVProgressHUD isVisible])
        {
            [SVProgressHUD dismiss];
        }
    });
}

@end
