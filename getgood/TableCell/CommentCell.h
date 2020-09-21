//
//  CommentCell.h
//  getgood
//
//  Created by Bhargav Mistri on 27/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedCornerView.h"

@interface CommentCell : UITableViewCell <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIImageView *imgLogo;
@property (strong, nonatomic) IBOutlet UILabel *lblComment;
@property (weak, nonatomic) IBOutlet UIView *likePanel;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet UIView *likeInformation;
@property (weak, nonatomic) IBOutlet UIView *dislikeInformation;
@property (weak, nonatomic) IBOutlet UILabel *tvLikeCount;
@property (weak, nonatomic) IBOutlet UILabel *tvDislikeCount;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vLike;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vDislike;
@property (weak, nonatomic) IBOutlet RoundedCornerView *vReply;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *likeWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dislikeWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *likeButtonWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dislikeButtonWidth;

@end
