//
//  CreateThreadVC.h
//  getgood
//
//  Created by Bhargav Mistri on 26/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestClient.h"
#import "BorderedView.h"

@interface CreateThreadVC : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imageBack;

@property (strong, nonatomic) IBOutlet UITextField *txtTopic;

@property (strong, nonatomic) IBOutlet UITextView *txtDescription;
@property (weak, nonatomic) IBOutlet BorderedView *vContainer;

@end
