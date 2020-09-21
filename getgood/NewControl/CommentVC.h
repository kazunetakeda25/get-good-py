//
//  CommentVC.h
//  getgood
//
//  Created by Bhargav Mistri on 27/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Thread.h"
#import "Like.h"
#import "AppData.h"
#import "ForumTopicCell.h"
#import "CommentReply.h"
#import "GetGood_Thread.h"
#import "GetGood_Comment.h"
#import "RestClient.h"
#import "UIImageView+WebCache.h"
#import "GetGood_Like.h"

@interface CommentVC : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
     NSMutableArray *arrComment;
}

@property (strong,nonatomic) GetGood_Thread *ObjThread;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantHeight;

@end
