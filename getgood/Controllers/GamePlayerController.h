//
//  Header.h
//  getgood
//
//  Created by Md Aminuzzaman on 25/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedLabel.h"
#import "HCSStarRatingView.h"
#import "XLPagerTabStripViewController.h"
#import "BorderedView.h"
#import "RestClient.h"
#import "GetGood_Dialog.h"
#import "UIKit.h"
#import "GameController.h"

@interface GamePlayerController : UIViewController <XLPagerTabStripChildItem,UICollectionViewDelegate>
{
    IBOutlet UICollectionView *collectionView;
    NSMutableArray *arrDataCopy;
    
    NSInteger SelectSortBy;
    NSInteger SelectAvalibility;
    
    NSMutableArray* arUsers;
    
}

@property (nonatomic, strong) GameController *vcParent;

@property (nonatomic, assign) BOOL bLoading;
@property (nonatomic, assign) BOOL bFinish;
@property (nonatomic, assign) int nPage;

- (void) update;

@end

@interface GamePlayerCollectionCell : UICollectionViewCell
{
    
}

@property (nonatomic,strong) IBOutlet UILabel *labelNameView;

@property (nonatomic,strong) IBOutlet UIImageView *imageFeaturedView;

@property (nonatomic,strong) IBOutlet UIImageView *imageAvatarView;

@property (nonatomic,strong) IBOutlet UIImageView *imageRankView;

@property (nonatomic,strong) IBOutlet UILabel *labelOverwatchId;

@property (nonatomic,strong) IBOutlet UILabel *labelServerView;

@property (nonatomic,strong) IBOutlet UILabel *labelRatingCountView;
@property (weak, nonatomic) IBOutlet BorderedView *borderView;


@property (weak, nonatomic) IBOutlet HCSStarRatingView *ratingCoachView;

@property (nonatomic,strong) IBOutlet UIImageView *imageHeroOne;

@property (nonatomic,strong) IBOutlet UIImageView *imageHeroTwo;


@property (nonatomic,strong) IBOutlet UIImageView *imageHeroThree;


@property (nonatomic,strong) IBOutlet UIImageView *imageHeroFour;


@property (nonatomic,strong) IBOutlet UIImageView *imageHeroFive;

//@property (nonatomic,strong) IBOutlet RoundedLabel *labelChatView;
@property (nonatomic,strong) IBOutlet UIButton *btnChatView;
@property (weak, nonatomic) IBOutlet UIImageView *ivReady;
@property (weak, nonatomic) IBOutlet UIImageView *ivPlatform;

@end


