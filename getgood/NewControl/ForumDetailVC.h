//
//  ForumDetailVC.h
//  getgood
//
//  Created by Bhargav Mistri on 27/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForumDetailVC : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imageBack;
@property (strong, nonatomic) IBOutlet UITableView *tblView;

@property (strong,nonatomic) NSString *Description;

@end
