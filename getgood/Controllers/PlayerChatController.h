//
//  PlayerChatController.h
//  getgood
//
//  Created by MD Aminuzzaman on 1/17/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "UIImageView+WebCache.h"
#import "RestClient.h"
#import "GetGood_Message.h"

@interface PlayerChatController : UIViewController <UITableViewDelegate>
{
    
    IBOutlet UIImageView *imageBack;
    
    IBOutlet UILabel *labelName;
    IBOutlet UILabel *labelServer;
    
    __weak IBOutlet UILabel *labelGameRating;
    IBOutlet HCSStarRatingView *ratingUserView;
    
    IBOutlet UILabel *labelOverwatchId;
    
    IBOutlet UIImageView *imageUser;
    IBOutlet UITableView *tableView;
  
    __weak IBOutlet UIImageView *ivPlatform;
    IBOutlet UIImageView *imageViewHeroOne;
    IBOutlet UIImageView *imageViewHeroTwo;
    IBOutlet UIImageView *imageViewHeroThree;
    IBOutlet UIImageView *imageViewHeroFour;
    IBOutlet UIImageView *imageViewHeroFive;
    IBOutlet UITextField *textFieldMessage;
    IBOutlet UIImageView *imageViewSend;
    
    IBOutlet UILabel *lblInvite;
    IBOutlet UIView *HeaderView;
    IBOutlet UILabel *lblAccept;

}
@property (weak, nonatomic) IBOutlet UIView *ProfileContainer;
@property (weak, nonatomic) IBOutlet UIButton *btnShow;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeight;
@property (weak, nonatomic) IBOutlet UIImageView *ivBlock;
@property (weak, nonatomic) IBOutlet UILabel *lbTyping;

@end

