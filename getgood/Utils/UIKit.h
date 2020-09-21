//
//  UIKit.h
//  getgood
//
//  Created by Md Aminuzzaman on 26/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIKit : NSObject
{
    
}

+(void) showLoading;

+(void) showDialog :(UIViewController *) controller titleMessage:(NSString *) title message: (NSString *) msg buttonText: (NSString *) bText;

+(void) dismissDialog;

+(void) showYesNo :(UIViewController *) controller message: (NSString *) msg yesHandler:(void (^)(UIAlertAction *action)) yHandler cancelHandler:(void (^)(UIAlertAction *action)) cHandler;
+(void) showConfirm :(UIViewController *) controller message: (NSString *) msg yesHandler:(void (^)(UIAlertAction *action)) yHandler;
+(void) showGotIt :(UIViewController *) controller message: (NSString *) msg yesHandler:(void (^)(UIAlertAction *action)) yHandler;

+(void) showInformation :(UIViewController *) controller message: (NSString *) msg;
@end
