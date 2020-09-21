//
//  CoachSortViewController.h
//  getgood
//
//  Created by Dan on 5/16/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoachSortOneCell.h"
#import "Temp.h"

@interface CoachSortViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
{
    NSInteger SelectSortBy;
    NSInteger SelectAvalibility;
    
    NSString *CoachRatingMin;
    NSString *CoachRatingMax;
    
    NSString *GameRatingMin;
    NSString *GameRatingMax;
    
    NSString *PriceMin;
    NSString *PriceMax;
    
    UILabel* lbCoachRatingMin;
    UILabel* lbCoachRatingMax;
    UILabel* lbGameRatingMin;
    UILabel* lbGameRatingMax;
    UILabel* lbPriceMin;
    UILabel* lbPriceMax;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
