//
//  GroupPendingVC.h
//  getgood
//
//  Created by Bhargav Mistri on 28/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"
#import "Utils.h"
#import "UIKit.h"
#import "AppData.h"
#import "RestClient.h"
#import "GroupDetailsController.h"
#import "User.h"
#import "UIImageView+WebCache.h"

@interface GroupPendingVC : UIViewController <UITableViewDelegate>{
    
    
    IBOutlet UITableView *tblView;
    
}

@property (nonatomic, strong) GroupDetailsController* parentVC;
@end
