//
//  TraineeRateDisplayController.h
//  getgood
//
//  Created by Md Aminuzzaman on 11/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "RestClient.h"
#import "GetGood_TraineeRate.h"

@interface TraineeRateDisplayController : UIViewController<UITableViewDelegate>
{
    
    IBOutlet UITableView *commentTableView;
    
    IBOutlet UILabel *labelReviewPoint;
    IBOutlet UILabel *labelReviewCount;
    
    IBOutlet HCSStarRatingView *ratingTraineeView;
    
}

@property (nonatomic,strong) NSString *userId;

@end

@interface TraineeCommentTableViewCell : UITableViewCell
{
    
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentHeight;

@property (nonatomic,strong) IBOutlet UILabel *labelNote;

@property (nonatomic,strong) IBOutlet UILabel *labelUserName;
@property (nonatomic,strong) IBOutlet HCSStarRatingView *ratingView;
@end
