//
//  HomeProfileController.h
//  getgood
//
//  Created by Md Aminuzzaman on 21/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedLabel.h"
#import "BorderedImageView.h"
#import "HCSStarRatingView.h"
#import "HeroSelectionController.h"
#import "ServerSelectionController.h"
#import "XLPagerTabStripViewController.h"
#import "XLButtonBarPagerTabStripViewController.h"
#import "HomeController.h"
#import "RSKImageCropViewController.h"
#import "SexyTooltip.h"
#import "LoLProfileTitleEditController.h"
#import "LolCategoryController.h"

@interface HomeProfileController :  XLButtonBarPagerTabStripViewController <XLPagerTabStripChildItem,ServerSelectionControllerDelegate,HeroSelectionControllerDelegate,RSKImageCropViewControllerDelegate, RSKImageCropViewControllerDataSource>
{
    IBOutlet XLButtonBarView *tabController;
    
    IBOutlet UILabel *labelName;
    
    IBOutlet UILabel *labelInGameRating;
    
    IBOutlet UIImageView *imageEditProfile;
    
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
    
    IBOutlet BorderedImageView *imageProfile;
    
    IBOutlet UILabel *labelPlayerCoin;
    
    IBOutlet UILabel *labelCoachCoin;
    
    IBOutlet UILabel *labelDescriptions;
    
    IBOutlet UILabel *labelHeroCaptions;
    
    IBOutlet UIView *viewGameAccount;
    
    IBOutlet UIView *viewCoachRating;
    
    IBOutlet UIView *viewTraineeRating;
    
    IBOutlet UIView *viewPlayerRating;
    
    IBOutlet UIView *viewServerSelection;
    
    IBOutlet UIView *viewHeroSelection;
    
    __weak IBOutlet UIImageView *ivPlatform;
    IBOutlet UIView *viewCoinInfo;
    __weak IBOutlet NSLayoutConstraint *platformWidth;
}

@property (nonatomic, strong) HomeController* homeController;

@property (nonatomic, strong) SexyTooltip* greetingsTooltip;
@end
