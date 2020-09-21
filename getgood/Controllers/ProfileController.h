//
//  ProfileController.h
//  getgood
//
//  Created by MD Aminuzzaman on 1/13/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedLabel.h"
#import "BorderedImageView.h"
#import "HCSStarRatingView.h"
#import "XLPagerTabStripViewController.h"
#import "XLButtonBarPagerTabStripViewController.h"
#import "UIImageView+WebCache.h"
#import "SexyTooltip.h"

@interface ProfileController : XLButtonBarPagerTabStripViewController
{
    IBOutlet XLButtonBarView *tabController;
    
    IBOutlet UIImageView *imageBack;
    
    IBOutlet UILabel *labelFollow;
    
    IBOutlet UILabel *labelName;
    
    IBOutlet UILabel *labelInGameRating;
    
    IBOutlet UILabel *labelCoachRatingCount;
    
    IBOutlet HCSStarRatingView *ratingCoach;
    
    IBOutlet UILabel *labelCoachRating;
    
    IBOutlet UILabel *labelTraineeRatingCount;
    
    IBOutlet HCSStarRatingView *ratingTrainee;
    
    IBOutlet UILabel *labelTraineeRating;
    
    IBOutlet UILabel *labelPlayerRatingCount;
    
    IBOutlet HCSStarRatingView *ratingPlayer;
    
    IBOutlet UILabel *labelPlayerRating;
    
    IBOutlet UILabel *labelDateJoined;
    
    IBOutlet UILabel *labelGameId;
    
    IBOutlet UILabel *labelServer;
    
    IBOutlet RoundedLabel *labelFollowers;
    
    IBOutlet RoundedLabel *labelFollowings;
    
    IBOutlet UIImageView *imageHeroOne;
    
    IBOutlet UIImageView *imageHeroTwo;
    
    IBOutlet UIImageView *imageHeroThree;
    
    IBOutlet UIImageView *imageHeroFour;
    
    IBOutlet UIImageView *imageHeroFive;
    
    __weak IBOutlet UIImageView *ivPlatform;
    IBOutlet BorderedImageView *imageProfile;
    
    IBOutlet UILabel *labelPlayerCoin;
    
    IBOutlet UILabel *labelCoachCoin;
    
    IBOutlet UILabel *labelDescriptions;
    
    IBOutlet UILabel *labelHeroCaptions;
    
    IBOutlet UIView *viewGameAccount;
    
    IBOutlet UIView *viewCoachRating;
    
    IBOutlet UIView *viewTraineeRating;
    
    IBOutlet UIView *viewPlayerRating;
}

@property (nonatomic,strong) User *profile;

@end
