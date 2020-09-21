//
//  GroupChatVC.h
//  getgood
//
//  Created by Bhargav Mistri on 28/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"
#import "GetGood_Group.h"
#import "RestClient.h"
#import "GetGood_Message.h"

@interface GroupChatVC : UIViewController <UITableViewDelegate>{
    
    IBOutlet UITableView *tblView;
    IBOutlet UITextField *textFieldMessage;
    IBOutlet UIImageView *imageViewSend;
    
}

@end
