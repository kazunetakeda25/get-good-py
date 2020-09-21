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
#import "GetGood_Lesson.h"
#import "UIImageView+WebCache.h"

@interface ProfileCoachListingController : UIViewController <XLPagerTabStripChildItem,UITableViewDelegate>
{
    IBOutlet UITableView *tableView;
}
@property (nonatomic, strong) NSString *strUserID;
@end

@interface CoachListingTableViewCell : UITableViewCell
{
    
}
@property (weak, nonatomic) IBOutlet BorderedView *borderedView;

@property (nonatomic,strong) IBOutlet UILabel *labelTitle;
@property (nonatomic,strong) IBOutlet UIImageView *imageThumbView;
@property (nonatomic,strong) IBOutlet HCSStarRatingView *ratingCoachView;
@property (nonatomic,strong) IBOutlet UILabel *labelPriceView;
@property (nonatomic,strong) IBOutlet UILabel *labelDescriptionView;

@property (nonatomic,strong) IBOutlet UILabel *labelCoachNameView;

@property (nonatomic,strong) IBOutlet UILabel *labelGameRankingView;

@property (nonatomic,strong) IBOutlet UIImageView *imageFeaturedView;
@property (nonatomic,strong) IBOutlet UIImageView *imageRankView;

@property (nonatomic,strong) IBOutlet UIImageView *imageHeroOneView;
@property (nonatomic,strong) IBOutlet UIImageView *imageHeroTwoView;
@property (nonatomic,strong) IBOutlet UIImageView *imageHeroThreeView;
@property (nonatomic,strong) IBOutlet UIImageView *imageHeroFourView;
@property (nonatomic,strong) IBOutlet UIImageView *imageHeroFiveView;



@end
