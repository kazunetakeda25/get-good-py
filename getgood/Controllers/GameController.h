//
//  GameController.h
//  getgood
//
//  Created by Md Aminuzzaman on 22/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "XLPagerTabStripViewController.h"
#import "XLButtonBarPagerTabStripViewController.h"
#import "GroupSortViewController.h"
#import "CoachSortViewController.h"
#import "RoundedTextField.h"
#import "GroupListViewController.h"
#import "ChatListController.h"

@interface GameController : XLButtonBarPagerTabStripViewController <UITextFieldDelegate, XLPagerTabStripViewControllerDelegate>
{
}
@property (weak, nonatomic) IBOutlet UILabel *lblServer;
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblSortFilter;
@property (weak, nonatomic) IBOutlet RoundedTextField *txtSearch;
@property (weak, nonatomic) IBOutlet UIView *groupUnread;
@property (weak, nonatomic) IBOutlet UIView *dialogUnread;
@property (weak, nonatomic) IBOutlet UIImageView *ivChatList;
@property (weak, nonatomic) IBOutlet UIImageView *ivGroupList;
@property (weak, nonatomic) IBOutlet UIImageView *ivForum;

@end
