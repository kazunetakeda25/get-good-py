//
//  CoachDetailsController.h
//  getgood
//
//  Created by Md Aminuzzaman on 26/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedLabel.h"
#import "HCSStarRatingView.h"
#import "ChatController.h"
#import "Temp.h"
#import "UIKit.h"
#import "GetGood_Lesson.h"
#import "RestClient.h"
#import "LessonCreateController.h"
#import "ProfileController.h"
#import "CoachRateDisplayController.h"

@interface CoachDetailController : UIViewController <UICollectionViewDelegate>
{
    IBOutlet UIImageView *imageCoach;
    
    IBOutlet UILabel *labelName;
    IBOutlet RoundedLabel *labelCoach;
    IBOutlet UILabel *labelDescription;
    IBOutlet UILabel *labelServer;
    IBOutlet UILabel *labelPrice;
    
    __weak IBOutlet UIImageView *ivGameRanking;
    IBOutlet UILabel *labelCoachRating;
    
    IBOutlet HCSStarRatingView *ratingCoach;
    IBOutlet UICollectionView  *collectionCoachVideo;
    
    IBOutlet UIImageView *imageBack;
    
    IBOutlet UIImageView *imageEdit;
    
    __weak IBOutlet UIImageView *ivPlatform;
    IBOutlet UIImageView *imageDelete;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descHeight;

@property (nonatomic,strong)  GetGood_Lesson *lessonViewModel;

@end

@interface CoachDetailVideoCell : UICollectionViewCell
{
    
}

@property (nonatomic,strong) IBOutlet UIImageView *imageThumb;

@end

