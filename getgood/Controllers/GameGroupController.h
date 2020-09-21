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
#import "GetGood_Group.h"
#import "ActionSheetStringPicker.h"
#import "RoundButton.h"
#import "GameController.h"

@interface GameGroupController : UIViewController <XLPagerTabStripChildItem,UICollectionViewDelegate>
{
    IBOutlet UICollectionView *collectionView;
    
    NSInteger SelectSortBy;
    NSInteger SelectAvalibility;
    
    NSMutableArray *arGroups;
    
    __weak IBOutlet RoundButton *btnReady;
}

@property (nonatomic, strong) GameController *vcParent;

@property (nonatomic, assign) BOOL bLoading;
@property (nonatomic, assign) BOOL bFinish;
@property (nonatomic, assign) int nPage;

- (void) update;

@end

@interface GameGroupCell : UICollectionViewCell
{
    
}

@property (nonatomic,strong) IBOutlet UILabel *labelNameView;
@property (weak, nonatomic) IBOutlet UIImageView *ivReady;

@property (weak, nonatomic) IBOutlet UIImageView *ivNewMessage;
@property (weak, nonatomic) IBOutlet BorderedView *borderedView;
@property (nonatomic,strong) IBOutlet UILabel *labelLeaderView;
@property (nonatomic,strong) IBOutlet HCSStarRatingView *labelPlayerRatingView;
@property (nonatomic,strong) IBOutlet UILabel *labelInGameRatingView;
@property (nonatomic,strong) IBOutlet UILabel *labelPlayerJoinedView;


@property (nonatomic,strong) IBOutlet UILabel *labelServerView;

@property (nonatomic,strong) IBOutlet HCSStarRatingView *ratingPlayerView;

@property (nonatomic,strong) IBOutlet UIImageView *imageRankView;

@property (nonatomic,strong) IBOutlet UIImageView *imageHeroOneView;

@property (nonatomic,strong) IBOutlet UIImageView *imageHeroTwoView;

@property (nonatomic,strong) IBOutlet UIImageView *imageHeroThreeView;

@property (nonatomic,strong) IBOutlet UIImageView *imageHeroFourView;

@property (nonatomic,strong) IBOutlet UIImageView *imageHeroFiveView;
@property (weak, nonatomic) IBOutlet UIImageView *ivPlatform;

@end


