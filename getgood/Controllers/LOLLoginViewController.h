//
//  OWLoginViewController.h
//  getgood
//
//  Created by Dan on 16/03/2018.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoLProfileTitleEditController.h"
@interface LoLLoginViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *vWeb;
@property (nonatomic, strong) LoLProfileTitleEditController* parent;
@end
