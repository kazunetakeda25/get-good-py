//
//  GroupSortViewController.h
//  getgood
//
//  Created by Dan on 5/15/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupSortOneCell.h"
#import "Temp.h"

@interface GroupSortViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
{
    NSInteger SelectSortBy;
    NSInteger SelectAvalibility;
    
    NSString *AvgPlayerRatingMin;
    NSString *AvgPlayerRatingMax;
    
    NSString *AvgGameRatingMin;
    NSString *AvgGameRatingMax;
    
    UILabel* lbPlayerMin;
    UILabel* lbPlayerMax;
    UILabel* lbGameMin;
    UILabel* lbGameMax;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
