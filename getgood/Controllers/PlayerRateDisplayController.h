//
//  PlayerRateDisplayController.h
//  getgood
//
//  Created by Md Aminuzzaman on 11/12/17.
//  Copyright © 2017 PH. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "RestClient.h"
#import "GetGood_PlayerRate.h"

@interface PlayerRateDisplayController : UIViewController <UITableViewDelegate>
{
    
    IBOutlet UIImageView *imageHelp;
    
    IBOutlet UITableView *summaryTableView;
    IBOutlet UITableView *commentTableView;
    
    IBOutlet UILabel *labelReviewPoint;
    IBOutlet UILabel *labelReviewCount;
    
    IBOutlet HCSStarRatingView *ratingPlayerView;
}

@property (nonatomic,strong) NSString *userId;

@end

@interface SummaryTableViewCell : UITableViewCell
{
    
}

@property (nonatomic,strong) IBOutlet UILabel *labelTitle;
@property (nonatomic,strong) IBOutlet UILabel *labelRatePoint;

@end

@interface CommentTableViewCell : UITableViewCell
{
    
}

@property (nonatomic,strong) IBOutlet UILabel *labelNote;
@property (nonatomic,strong) IBOutlet UILabel *labelUserName;

@end
