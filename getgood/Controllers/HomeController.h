//
//  HomeController.h
//  getgood
//
//  Created by Md Aminuzzaman on 11/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "XLPagerTabStripViewController.h"
#import "XLButtonBarPagerTabStripViewController.h"
#import "UIImageView+WebCache.h"
#import "SexyTooltip.h"
#import "OverwatchService.h"

@interface HomeController : XLButtonBarPagerTabStripViewController
{
    
    IBOutlet UIImageView *imageForum;
    
    IBOutlet UIImageView *imageMenu;

    IBOutlet UIView *sidePanel;

    IBOutlet UIImageView *menuButton;
    
    IBOutlet UIView *menuBackView;
    
    IBOutlet UIImageView *imageProfile;
    
    IBOutlet UIImageView *imageChat;
    
    __weak IBOutlet UIImageView *imageGroup;
    //IBOutlet UILabel *labelSignOut;
    IBOutlet UILabel *labelUserName;
    IBOutlet UILabel *labelTermsOfService;
    __weak IBOutlet UILabel *labelFeedback;
    
    IBOutlet UIButton *btnSignOut;
}
@property (weak, nonatomic) IBOutlet UIView *anchorView;
@property (weak, nonatomic) IBOutlet UIView *groupUnread;
@property (weak, nonatomic) IBOutlet UIView *dialogUnread;

@property (nonatomic, strong) SexyTooltip* greetingsTooltip;
@end

