//
//  AddCommentVC.h
//  getgood
//
//  Created by Bhargav Mistri on 27/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestClient.h"

@interface AddCommentVC : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *BackImage;
@property (strong, nonatomic) IBOutlet UITextView *TextView;

@property (strong,nonatomic) NSString *Reference;

@end
