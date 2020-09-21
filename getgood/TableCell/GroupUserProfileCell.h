//
//  GroupUserProfileCell.h
//  getgood
//
//  Created by Bhargav Mistri on 28/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

@interface GroupUserProfileCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UIImageView *ImageLogo;
@property (strong, nonatomic) IBOutlet UILabel *lblName;

@property (strong, nonatomic) IBOutlet UILabel *lblGroupID;
@property (strong, nonatomic) IBOutlet UILabel *lblServerName;

@property (strong, nonatomic) IBOutlet UIImageView *HeroImage1;
@property (strong, nonatomic) IBOutlet UIImageView *HeroImage2;
@property (strong, nonatomic) IBOutlet UIImageView *HeroImage3;
@property (strong, nonatomic) IBOutlet UIImageView *HeroImage4;
@property (strong, nonatomic) IBOutlet UIImageView *HeroImage5;

@property (weak, nonatomic) IBOutlet HCSStarRatingView *PlayerRating;


@property (weak, nonatomic) IBOutlet UILabel *lblKick;
@property (weak, nonatomic) IBOutlet UILabel *lblRateUser;
@property (weak, nonatomic) IBOutlet UIImageView *ivRank;
@property (weak, nonatomic) IBOutlet UILabel *lblRanking;
@property (weak, nonatomic) IBOutlet UIImageView *ivPlatform;

@end
