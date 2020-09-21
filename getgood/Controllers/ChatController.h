//
//  ChatController.h
//  getgood
//
//  Created by Md Aminuzzaman on 23/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

@interface ChatController : UIViewController <UITableViewDelegate>
{
    
    IBOutlet UIImageView *imageBack;
    
    IBOutlet UILabel *labelName;
    IBOutlet UILabel *labelServer;
    
    IBOutlet HCSStarRatingView *ratingUserView;
    
    IBOutlet UILabel *labelOverwatchId;
    
    IBOutlet UIImageView *imageUser;
    IBOutlet UITableView *tableView;
    
    IBOutlet UIImageView *imageViewHeroOne;
    IBOutlet UIImageView *imageViewHeroTwo;
    IBOutlet UIImageView *imageViewHeroThree;
    IBOutlet UIImageView *imageViewHeroFour;
    IBOutlet UIImageView *imageViewHeroFive;
    IBOutlet UITextField *textFieldMessage;
    IBOutlet UIImageView *imageViewSend;
    
    __weak IBOutlet UIImageView *ivPlatform;
    IBOutlet UILabel *lblOffer;
    IBOutlet UIView *HeaderView;
    IBOutlet UILabel *lblAccept;
    IBOutlet UILabel *lblRate;
    
    __weak IBOutlet UILabel *labelIngameRating;
    __weak IBOutlet UILabel *labelRating;
}
@property (weak, nonatomic) IBOutlet UIView *ProfileContainer;
@property (weak, nonatomic) IBOutlet UIButton *btnShow;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeight;
@property (weak, nonatomic) IBOutlet UIImageView *ivBlock;
@property (weak, nonatomic) IBOutlet UILabel *lbTyping;


- (void) updateReviewState;

@end



