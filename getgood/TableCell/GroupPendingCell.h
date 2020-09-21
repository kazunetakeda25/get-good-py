//
//  GroupPendingCell.h
//  getgood
//
//  Created by Bhargav Mistri on 28/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

@interface GroupPendingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *ImageLogo;
@property (strong, nonatomic) IBOutlet UILabel *lblName;

@property (strong, nonatomic) IBOutlet UILabel *lblGroupID;
@property (strong, nonatomic) IBOutlet UILabel *lblServerName;

@property (strong, nonatomic) IBOutlet UIImageView *HeroImage1;
@property (strong, nonatomic) IBOutlet UIImageView *HeroImage2;
@property (strong, nonatomic) IBOutlet UIImageView *HeroImage3;
@property (strong, nonatomic) IBOutlet UIImageView *HeroImage4;
@property (strong, nonatomic) IBOutlet UIImageView *HeroImage5;

@property (weak, nonatomic) IBOutlet HCSStarRatingView *PlayerRating;
@property (weak, nonatomic) IBOutlet UIImageView *ivPlatform;


@property (strong, nonatomic) IBOutlet UILabel *lblAccept;
@property (weak, nonatomic) IBOutlet UIImageView *ivRank;
@property (weak, nonatomic) IBOutlet UILabel *lblRanking;

@end
