//
//  ChatListController.h
//  getgood
//
//  Created by Md Aminuzzaman on 22/12/17.
//  Copyright © 2017 PH. All rights reserved.
//
//
//  HomeActivityController.h
//  getgood
//
//  Created by Md Aminuzzaman on 21/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"
#import "GetGood_Dialog.h"
#import "GetGood_Lesson.h"
#import "ChatController.h"

@interface ChatListController : UIViewController <UITableViewDelegate>
{
    IBOutlet UILabel *labelNoItem;
    IBOutlet UIImageView *imageBack;
    IBOutlet UITableView *tableView;
}

@end

@interface ChatListCell : UITableViewCell
{
    
}

@property (nonatomic,strong) IBOutlet UILabel *labelNameView;
@property (nonatomic,strong) IBOutlet UIImageView *imageNew;
@property (nonatomic,strong) IBOutlet UIImageView *imageUser;
@property (nonatomic,strong) IBOutlet UIImageView *imageBlock;
@end


