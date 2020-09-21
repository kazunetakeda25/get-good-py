//
//  ForumListVC.h
//  getgood
//
//  Created by Bhargav Mistri on 26/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestClient.h"
#import "GetGood_AdminPost.h"
#import "GetGood_Thread.h"


@interface ForumListVC : UIViewController{
    
     NSMutableArray *arrAdminPost;
     NSMutableArray *arrComment;
     NSMutableArray *arrDataCopy;
    
}

@property (strong, nonatomic) IBOutlet UITextField *txtSearch;
@property (strong, nonatomic) IBOutlet UIImageView *imageBack;
@property (strong, nonatomic) IBOutlet UITableView *tblView;

@property (nonatomic, strong) NSString* strKeyword;
@property (nonatomic, assign) int nPage;
@property (nonatomic, assign) BOOL bLoading;
@property (nonatomic, assign) BOOL bFinish;


@end
