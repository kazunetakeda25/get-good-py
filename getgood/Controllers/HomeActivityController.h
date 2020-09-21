//
//  HomeActivityController.h
//  getgood
//
//  Created by Md Aminuzzaman on 21/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"
#import "RestClient.h"

@interface HomeActivityController : UIViewController <XLPagerTabStripChildItem,UITableViewDelegate>
{
    IBOutlet UITableView *tableView;
}
@property (weak, nonatomic) IBOutlet UILabel *lblNoActivities;

@end

@interface BrowseActivityCell : UITableViewCell
{
    
}

@property (nonatomic,strong) IBOutlet UILabel *labelNameView;

@end

