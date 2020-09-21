//
//  ProfileCoachListingController.h
//  getgood
//
//  Created by Md Aminuzzaman on 25/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "XLPagerTabStripViewController.h"
#import "BorderedView.h"
#import "RestClient.h"
#import "GetGood_Group.h"
#import "Temp.h"
#import "GroupDetailsController.h"

@interface ProfileGroupListingController : UIViewController <XLPagerTabStripChildItem,UICollectionViewDelegate, UICollectionViewDataSource>
{
    IBOutlet UICollectionView *collectionView;
}

@property (nonatomic, strong) NSString *strUserID;
@end

@interface ProfileGroupListingCell : UICollectionViewCell
{
    
}

@property (weak, nonatomic) IBOutlet BorderedView *borderedView;

@property (nonatomic,strong) IBOutlet UILabel *labelLeaderView;
@property (nonatomic,strong) IBOutlet UILabel *labelTitle;
@property (nonatomic,strong) IBOutlet UILabel *labelAverageGameRating;
@property (nonatomic,strong) IBOutlet UILabel *labelGameRating;

@property (nonatomic,strong) IBOutlet UILabel *labelPlayerJoined;
@property (nonatomic,strong) IBOutlet UILabel *labelServerView;

@property (nonatomic,strong) IBOutlet HCSStarRatingView *ratingPlayerView;

@property (nonatomic,strong) IBOutlet UIImageView *imageRank;
@property (nonatomic,strong) IBOutlet UIImageView *imageAverageRank;

@property (nonatomic,strong) IBOutlet UIImageView *imageHeroOne;
@property (nonatomic,strong) IBOutlet UIImageView *imageHeroTwo;
@property (nonatomic,strong) IBOutlet UIImageView *imageHeroThree;
@property (nonatomic,strong) IBOutlet UIImageView *imageHeroFour;
@property (nonatomic,strong) IBOutlet UIImageView *imageHeroFive;
@property (weak, nonatomic) IBOutlet UIImageView *ivPlatform;

@end

