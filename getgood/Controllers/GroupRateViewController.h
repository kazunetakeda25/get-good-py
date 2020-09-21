//
//  GroupRateViewController.h
//  getgood
//
//  Created by Dan on 18/04/2018.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedCornerView.h"
#import "BorderedImageView.h"
#import "HCSStarRatingView.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "RestClient.h"
#import "UIKit.h"
#import "Utils.h"

@interface GroupRateViewController : UIViewController <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *content;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vTeamLeader;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vCooperativePlayer;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vGoodCommunication;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vSportsmanship;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vMVP;
@property (weak, nonatomic) IBOutlet UIImageView *help;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vFlexPlayer;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vGoodHeroCompetency;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vGoodUltimateUsage;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vAbusiveChat;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vGriefingAndInactivity;
@property (weak, nonatomic) IBOutlet UITextView *vReview;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vSpam;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vNoCommunication;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vUnCooperativePlayer;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vTricklingIn;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vPoorHeroCompetency;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vBadUltimateUsage;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vOverextending;
@property (weak, nonatomic) IBOutlet BorderedImageView *ivAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblServer;
@property (weak, nonatomic) IBOutlet UILabel *lblGameRating;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *rating;
@property (weak, nonatomic) IBOutlet UIImageView *ivHero1;
@property (weak, nonatomic) IBOutlet UIImageView *ivHero2;
@property (weak, nonatomic) IBOutlet UIImageView *ivHero3;
@property (weak, nonatomic) IBOutlet UIImageView *ivHero4;
@property (weak, nonatomic) IBOutlet UIImageView *ivHero5;
@property (weak, nonatomic) IBOutlet UIImageView *ivPlatform;

@property (nonatomic, strong) User* profile;
@end
