//
//  GroupUserVC.h
//  getgood
//
//  Created by Bhargav Mistri on 28/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"
#import "Temp.h"
#import "RestClient.h"
#import "GroupDetailsController.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "Utils.h"

@interface GroupUserVC : UIViewController <UITableViewDelegate>{
    
    IBOutlet UITableView *tblView;
    
}

@property (nonatomic, strong) GroupDetailsController* parentVC;

@end
