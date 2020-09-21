//
//  HomeController.m
//  getgood
//
//  Created by Md Aminuzzaman on 11/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "UIKit.h"
#import "AppData.h"
#import "HomeController.h"
#import "ColorConstants.h"
#import "ChatListController.h"
#import "LoginController.h"
#import "AppDelegate.h"
#import "ForumListVC.h"
#import "HomeProfileController.h"
#import "GroupListViewController.h"

@import Firebase;
@import FirebaseAuth;

@interface HomeController ()

@end

@implementation HomeController
{
    BOOL isReload;
}

- (void)viewDidLoad
{
   [super viewDidLoad];   
    
    sidePanel.hidden = YES;
 
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [AppData profile].avatar_url]];
    
    [imageProfile sd_setImageWithURL:url];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionShowMenu:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [menuButton addGestureRecognizer:tapGestureRecognizer];
    menuButton.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionChatList:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageChat addGestureRecognizer:tapGestureRecognizer];
    imageChat.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionForumList:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageForum addGestureRecognizer:tapGestureRecognizer];
    imageForum.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionGroupList:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageGroup addGestureRecognizer:tapGestureRecognizer];
    imageGroup.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTerms:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [labelTermsOfService addGestureRecognizer:tapGestureRecognizer];
    labelTermsOfService.userInteractionEnabled = YES;
    
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionFeedback:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [labelFeedback addGestureRecognizer:tapGestureRecognizer];
    labelFeedback.userInteractionEnabled = YES;
    
    
    
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionHideMenu:)];
    tapper.numberOfTapsRequired  = 1;
    [menuBackView addGestureRecognizer:tapper];
    
    imageProfile.layer.cornerRadius = imageProfile.frame.size.width / 2;
    imageProfile.clipsToBounds = YES;
    labelUserName.text = [AppData profile].name;
    
    self.buttonBarView.shouldCellsFillAvailableWidth = YES;
    self.isProgressiveIndicator = NO;
    
    [self.buttonBarView setSelectedBarHeight:4.0f];
    self.buttonBarView.selectedBar.backgroundColor = [UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f];
    //self.buttonBarView.backgroundColor = UIColorFromRGB(0x66338f);
    
    self.changeCurrentIndexProgressiveBlock = ^void(XLButtonBarViewCell *oldCell, XLButtonBarViewCell *newCell, CGFloat progressPercentage, BOOL changeCurrentIndex, BOOL animated)
    {
        if (changeCurrentIndex)
        {
            [oldCell.label setTextColor:[UIColor colorWithWhite:1 alpha:0.6]];
            [newCell.label setTextColor:[UIColor whiteColor]];
            
            if (animated)
            {
                [UIView animateWithDuration:0.1
                                 animations:^()
                 {
                     newCell.transform = CGAffineTransformMakeScale(1.0, 1.0);
                     oldCell.transform = CGAffineTransformMakeScale(0.8, 0.8);
                     
                 }
                 completion:nil];
            }
            else
            {
                newCell.transform = CGAffineTransformMakeScale(1.0, 1.0);
                oldCell.transform = CGAffineTransformMakeScale(0.8, 0.8);
            }
        }
    };
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:@"Notification" object:nil];
    
    [OverwatchService getOverwatchState:[AppData profile].blizzard_id listener :^(NSDictionary *dictionary) {
        NSString *ranking = @"0";
        
        NSString* strServer = @"us";
        
        @try {
            strServer = [[[AppData profile].server componentsSeparatedByString:@"/"] objectAtIndex:1];
        }
        @catch (NSException * e) {
            strServer = @"user";
        }
        
        int rank_ = 0;
        @try
        {
            ranking = [[[[[ dictionary objectForKey:@"us"] objectForKey: @"stats"] objectForKey:@"competitive"] objectForKey:@"overall_stats"] objectForKey:@"comprank"];
            
            rank_ = [ranking intValue];
        }
        @catch(NSException* ex)
        {
            
        }
        
        if([AppData profile] == nil)
            return ;
        
        [AppData profile].overwatch_rank = rank_;
        [RestClient updateProfile:^(bool result, NSDictionary *data) {
            
        }];
        
    }];
    
    [OverwatchService getLolState];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self updateBadge];
    
//    if(![AppData profile].blizzard_id.length)
//    {
//        if(self.greetingsTooltip)
//        {
//            [self.greetingsTooltip dismiss];
//        }
//        
//        NSAttributedString* attrString = [[NSAttributedString alloc] initWithString:@"Link to your overwatch account"];
//        
//        self.greetingsTooltip = [[SexyTooltip alloc] initWithAttributedString:attrString
//                                                                          sizedToView:self.view
//                                                                          withPadding:UIEdgeInsetsMake(10, 5, 10, 5)
//                                                                            andMargin:UIEdgeInsetsMake(20, 20, 20, 20)];
//        
//        [self.greetingsTooltip presentFromView:self.anchorView
//                                   inView:self.view
//                               withMargin:10
//                                 animated:YES];
//    }

}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self updateGuideUI];
}

- (void) receivedNotification:(NSNotification*) notification
{
//    [self updateBadge];
}

- (void) updateBadge
{
    [self.dialogUnread setHidden:YES];
    [self.groupUnread setHidden:YES];
    
    [RestClient getLastDialogTimestamp:^(bool result, NSDictionary *data) {
        if(!result)
            return ;
        
        int nTimestamp = 0;
        
        @try
        {
            nTimestamp = [[data objectForKey:@"timestamp"] intValue];
        }
        @catch(NSException* ex)
        {
            return;
        }
        
        NSArray* arAllKeys = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys];
        
        int localStamp = 0;
        for(int i = 0; i < arAllKeys.count; i++)
        {
            NSString* key = [arAllKeys objectAtIndex:i] ;
            if([[arAllKeys objectAtIndex:i] containsString:@"dialog_"])
            {
                int timestamp = [[NSUserDefaults standardUserDefaults] integerForKey:key];
                if (timestamp > localStamp)
                {
                    localStamp = timestamp;
                }
            }
        }
        
        if(localStamp < nTimestamp)
        {
            [self.dialogUnread setHidden:NO];
        }

    }];
    
    
    [RestClient getLastGroupTimestamp:^(bool result, NSDictionary *data) {
        if(!result)
            return ;
        
        int nTimestamp = 0;
        
        @try
        {
            nTimestamp = [[data objectForKey:@"timestamp"] intValue];
        }
        @catch(NSException* ex)
        {
            return;
        }
        
        NSArray* arAllKeys = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] allKeys];
        
        int localStamp = 0;
        for(int i = 0; i < arAllKeys.count; i++)
        {
            NSString* key = [arAllKeys objectAtIndex:i] ;
            if([[arAllKeys objectAtIndex:i] containsString:@"group_"])
            {
                int timestamp = [[NSUserDefaults standardUserDefaults] integerForKey:key];
                if (timestamp > localStamp)
                {
                    localStamp = timestamp;
                }
            }
        }
        
        if(localStamp < nTimestamp)
        {
            [self.groupUnread setHidden:NO];
        }
        
    }];
}

- (void) updateGuideUI
{
    if(![[[NSUserDefaults standardUserDefaults] objectForKey:@"forum"] boolValue])
    {
        [imageForum setImage:[UIImage imageNamed:@"glow_forum"]];
    }
    else
    {
        [imageForum setImage:[UIImage imageNamed:@"forum"]];
    }
}

- (void)actionShowMenu:(UITapGestureRecognizer *)tapGesture
{
    sidePanel.hidden = NO;
    
    [menuBackView setHidden:NO];
    [UIView transitionWithView:sidePanel duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^
     {
         CGRect screenRect = [[UIScreen mainScreen] bounds];
         CGFloat screenWidth = screenRect.size.width;
         
         CGRect frame = sidePanel.frame;
         frame.origin.x = screenWidth - sidePanel.frame.size.width;
         sidePanel.frame = frame;
         
     }
    completion:nil];
   
}

- (void)actionTerms:(UITapGestureRecognizer *)tapGesture
{
    [menuBackView setHidden:YES];
    [UIView transitionWithView:sidePanel duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^
     {
         CGRect screenRect = [[UIScreen mainScreen] bounds];
         CGFloat screenWidth = screenRect.size.width;
         
         CGRect frame = sidePanel.frame;
         frame.origin.x = screenWidth + sidePanel.frame.size.width;
         sidePanel.frame = frame;
         
     }
                    completion:nil];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_terms_controller"];
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (void)actionFeedback:(UITapGestureRecognizer *)tapGesture
{
    [menuBackView setHidden:YES];
    [UIView transitionWithView:sidePanel duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^
     {
         CGRect screenRect = [[UIScreen mainScreen] bounds];
         CGFloat screenWidth = screenRect.size.width;
         
         CGRect frame = sidePanel.frame;
         frame.origin.x = screenWidth + sidePanel.frame.size.width;
         sidePanel.frame = frame;
         
     }
                    completion:nil];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sid_create_feedback_controller"];
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (void)actionHideMenu:(UITapGestureRecognizer *)tapGesture
{
    if(tapGesture.state == UIGestureRecognizerStateEnded)
    {
        [menuBackView setHidden:YES];
        [UIView transitionWithView:sidePanel duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^
         {
             CGRect screenRect = [[UIScreen mainScreen] bounds];
             CGFloat screenWidth = screenRect.size.width;
             
             CGRect frame = sidePanel.frame;
             frame.origin.x = screenWidth + sidePanel.frame.size.width;
             sidePanel.frame = frame;
             
         }
                        completion:nil];
    }
}

- (void)actionGroupList:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    GroupListViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"GroupListViewController"];
    [self.navigationController pushViewController:controller animated:YES];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"forum"];
}

- (void)actionForumList:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ForumListVC *controller = [storyboard instantiateViewControllerWithIdentifier:@"ForumListVC"];
    [self.navigationController pushViewController:controller animated:YES];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"forum"];
}

- (void)actionChatList:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    ChatListController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sid_chat_list_controller"];
    
    //controller.userId = [AppData userProfile].userId;
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - XLPagerTabStripViewControllerDataSource

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    // create child view controllers that will be managed by XLPagerTabStripViewController
    NSString * storyboardName = @"Main";
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"sid_hm_browse_controller"];
    
    UIViewController * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"sid_hm_activity_controller"];
    
    HomeProfileController * vc3 = (HomeProfileController*)[storyboard instantiateViewControllerWithIdentifier:@"sid_hm_profile_controller"];
    vc3.homeController = self;
    if (!isReload)
    {
        return @[vc1, vc2];
    }
    
    NSMutableArray * childViewControllers = [NSMutableArray arrayWithObjects:vc1, vc2, nil];
    NSUInteger count = [childViewControllers count];
    
    for (NSUInteger i = 0; i < count; ++i)
    {
        // Select a random element between i and end of array to swap with.
        NSUInteger nElements = count - i;
        NSUInteger n = (arc4random() % nElements) + i;
        [childViewControllers exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    NSUInteger nItems = 1 + (rand() % 8);
    
    return [childViewControllers subarrayWithRange:NSMakeRange(0, nItems)];
}

-(void)reloadPagerTabStripView
{
    isReload = YES;
    self.isProgressiveIndicator  = (rand() % 2 == 0);
    self.isElasticIndicatorLimit = (rand() % 2 == 0);
    
    [super reloadPagerTabStripView];
}

- (void)pagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController didMoveToIndex:(NSInteger)toIndex
{
    
}


#pragma mark - On Tap SignOut

- (IBAction)onTapSignOut:(id)sender {
    
    //[UIKit showLoading:@"Sign Out..."];
    [RestClient logout];
    
    [AppData setProfile:nil];
    [AppData setToken:nil];
    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"push_token"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end

