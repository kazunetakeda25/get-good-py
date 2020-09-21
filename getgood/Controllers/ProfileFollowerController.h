//
//  ProfileFollowerController.h
//  getgood
//
//  Created by Md Aminuzzaman on 30/11/17.
//  Copyright © 2017 PH. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

#define VIEW_FOLLOWER_TYPE 0
#define VIEW_FOLLOWING_TYPE 1

@interface ProfileFollowerController : UIViewController <UITableViewDelegate>
{
    IBOutlet UITableView *tableView;
    IBOutlet UIImageView *imageBack;
}

@property (nonatomic,assign) int viewType;

@end

@interface ProfileFollowerCell : UITableViewCell
{
    
}

@property (nonatomic,strong) IBOutlet UIImageView *imageUser;
@property (nonatomic,strong) IBOutlet UILabel *labelNameView;
@property (nonatomic,strong) IBOutlet UILabel *labelServer;
@property (nonatomic,strong) IBOutlet UILabel *labelGameId;
@property (nonatomic,strong) IBOutlet UIImageView *imageHeroOne;
@property (nonatomic,strong) IBOutlet UIImageView *imageHeroTwo;
@property (nonatomic,strong) IBOutlet UIImageView *imageHeroThree;
@property (nonatomic,strong) IBOutlet UIImageView *imageHeroFour;
@property (nonatomic,strong) IBOutlet UIImageView *imageHeroFive;
@property (nonatomic,strong) IBOutlet HCSStarRatingView *ratingPlayerView;
@property (nonatomic,strong) IBOutlet UILabel *labelInGameRating;
@end

