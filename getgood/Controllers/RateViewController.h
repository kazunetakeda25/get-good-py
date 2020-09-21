//
//  RateViewController.h
//  getgood
//
//  Created by Dan on 20/04/2018.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "RestClient.h"
#import "ChatController.h"

@interface RateViewController : UIViewController

@property (weak, nonatomic) IBOutlet HCSStarRatingView *vCompetency;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *vCommunication;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *vFlexibility;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *vAttitude;
@property (weak, nonatomic) IBOutlet UITextView *tvReview;
@property (weak, nonatomic) IBOutlet UIImageView *help;


@property (nonatomic, strong) User* profile;
@property (nonatomic, strong) ChatController* vcParent;
@end
