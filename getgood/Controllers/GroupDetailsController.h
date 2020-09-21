//
//  GroupDetailsController.h
//  getgood
//
//  Created by MD Aminuzzaman on 1/16/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedLabel.h"
#import "GetGood_Group.h"
#import "Utils.h"
#import "DataArrays.h"

@interface GroupDetailsController : UIViewController
{
    IBOutlet UIImageView *imageBack;
    
    IBOutlet UILabel *lblName;
    IBOutlet UILabel *lblDescription;
    IBOutlet UILabel *lblLeader;
    
    IBOutlet UIImageView *heroImage1;
    IBOutlet UIImageView *heroImage2;
    IBOutlet UIImageView *heroImage3;
    
    IBOutlet UIImageView *heroImage4;
    IBOutlet UIImageView *heroImage5;
    
    IBOutlet UILabel *lblServer;
    
    __weak IBOutlet UIImageView *ivPlatform;
}
@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet UIView *content;

@property (weak, nonatomic) IBOutlet UIView *vPending;
@property (weak, nonatomic) IBOutlet UIView *vUsers;
@property (weak, nonatomic) IBOutlet UIView *vGroupChat;
@property (weak, nonatomic) IBOutlet UIButton *btnPending;
@property (weak, nonatomic) IBOutlet UIButton *btnUsers;
@property (weak, nonatomic) IBOutlet UIButton *btnGroupChat;
@property (weak, nonatomic) IBOutlet UIImageView *btnLeave;
@property (weak, nonatomic) IBOutlet UIImageView *btnEdit;
@property (weak, nonatomic) IBOutlet UIImageView *btnDelete;
@property (weak, nonatomic) IBOutlet RoundedLabel *btnChat;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *PendingWidth;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ApplyWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LeaveWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *EditWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *DeleteWidth;
@property (nonatomic,strong) GetGood_Group *ObjGroup;
@property (nonatomic, assign) int nRole;
@property (nonatomic, assign) int nCurrentTab;

@property (weak, nonatomic) IBOutlet UIView *vPendingBack;
@property (weak, nonatomic) IBOutlet UIView *vUsersBack;
@property (weak, nonatomic) IBOutlet UIView *vGroupChatBack;
@property (weak, nonatomic) IBOutlet UIButton *btnUp;
@property (weak, nonatomic) IBOutlet UIButton *btnDown;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *profileHeight;

@property (nonatomic,strong) UIViewController *subController;

- (void) checkRole;

@end


