//
//  CoachRateDisplayController.h
//  getgood
//
//  Created by Md Aminuzzaman on 11/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "RestClient.h"
#import "GetGood_CoachRate.h"

@interface CoachRateDisplayController : UIViewController  <UITableViewDelegate>
{
    IBOutlet UIImageView *imageHelp;
    
    IBOutlet UITableView *commentTableView;
    
    IBOutlet UILabel *labelReviewPoint;
    IBOutlet UILabel *labelReviewCount;
    
    IBOutlet HCSStarRatingView *ratingCoachView;
    IBOutlet HCSStarRatingView *ratingCompetencyView;
    IBOutlet HCSStarRatingView *ratingCommunicationView;
    IBOutlet HCSStarRatingView *ratingFlexibilityView;
    IBOutlet HCSStarRatingView *ratingAttitudeView;
}

@property (nonatomic,strong) NSString *userId;

@end

@interface CoachCommentTableViewCell : UITableViewCell
{
    
}

@property (nonatomic,strong) IBOutlet UILabel *labelNote;

@property (weak, nonatomic) IBOutlet HCSStarRatingView *ratingCompetency;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *ratingCommunication;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *ratingFlexibility;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *ratingAttitude;
@property (nonatomic,strong) IBOutlet UILabel *labelUserName;
@property (nonatomic,strong) IBOutlet HCSStarRatingView *ratingView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rateHeight;

@end
