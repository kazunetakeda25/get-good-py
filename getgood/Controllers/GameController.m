
//
//  GameController.m
//  getgood
//
//  Created by Md Aminuzzaman on 22/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "GameController.h"
#import "ServerController.h"
#import "CategoryController.h"
#import "SortAndFilterController.h"
#import "GamePlayerController.h"
#import "GameGroupController.h"
#import "GameCoachController.h"
#import "HomeProfileController.h"
#import "ForumListVC.h"

@interface GameController ()

@end

@implementation GameController
{
    GameCoachController* coachController;
    GameGroupController* groupController;
    GamePlayerController* playerController;
    BOOL isReload;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionServer:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [_lblServer addGestureRecognizer:tapGestureRecognizer];
    _lblServer.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionCategory:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [_lblCategory addGestureRecognizer:tapGestureRecognizer];
    _lblCategory.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionFilter:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [_lblSortFilter addGestureRecognizer:tapGestureRecognizer];
    _lblSortFilter.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionChatList:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [_ivChatList addGestureRecognizer:tapGestureRecognizer];
    _ivChatList.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionGroupList:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [_ivGroupList addGestureRecognizer:tapGestureRecognizer];
    _ivGroupList.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionForumList:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [_ivForum addGestureRecognizer:tapGestureRecognizer];
    _ivForum.userInteractionEnabled = YES;
    
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
    
    [self.txtSearch setDelegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:@"Notification" object:nil];
    
    [self setDelegate:self];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateBadge];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self updateBadge];    
    [self updateGuideUI];
}

- (void)actionForumList:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ForumListVC *controller = [storyboard instantiateViewControllerWithIdentifier:@"ForumListVC"];
    [self.navigationController pushViewController:controller animated:YES];
    
    NSString* prefix = @"";
    
    if([Temp getGameMode] == Overwatch)
    {
        prefix = @"";
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        prefix = @"lol_";
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%@forum", prefix]];
}

- (void) updateGuideUI
{
    NSString* prefix = @"";
    
    if([Temp getGameMode] == Overwatch)
    {
        prefix = @"";
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        prefix = @"lol_";
    }
    
    if(![[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@forum", prefix]] boolValue])
    {
        [_ivForum setImage:[UIImage imageNamed:@"glow_forum"]];
    }
    else
    {
        [_ivForum setImage:[UIImage imageNamed:@"forum"]];
    }
}


- (void) receivedNotification:(NSNotification*) notification
{
    [self updateBadge];
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

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    if([Temp currentTab] == 0)
    {
        [playerController update];
    }
    else if([Temp currentTab] == 1)
    {
        [groupController update];
    }
    else if([Temp currentTab] == 2)
    {
        [coachController update];
    }
    
    return NO;
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)actionServer:(UITapGestureRecognizer *)tapGesture
{
    if(Temp.currentTab == 4)
        return;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController* controller;
    if([Temp getGameMode] == Overwatch)
    {
        controller = [storyboard instantiateViewControllerWithIdentifier:@"ServerController"];
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        controller = [storyboard instantiateViewControllerWithIdentifier:@"LolServerController"];
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)actionCategory:(UITapGestureRecognizer *)tapGesture
{
    if(Temp.currentTab == 4)
        return;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController* controller;
    if([Temp getGameMode] == Overwatch)
    {
        controller = [storyboard instantiateViewControllerWithIdentifier:@"CategoryController"];
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        controller = [storyboard instantiateViewControllerWithIdentifier:@"LolFilterCategoryController"];
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)actionChatList:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    ChatListController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sid_chat_list_controller"];
    
    //controller.userId = [AppData userProfile].userId;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)actionGroupList:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    GroupListViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"GroupListViewController"];
    [self.navigationController pushViewController:controller animated:YES];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"forum"];
}

- (void)actionFilter:(UITapGestureRecognizer *)tapGesture
{
    if(Temp.currentTab == 4)
        return;
    
    if([Temp currentTab] == 0)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        SortAndFilterController *controller = [storyboard instantiateViewControllerWithIdentifier:@"SortAndFilterController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if([Temp currentTab] == 1)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        GroupSortViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"GroupSortViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if([Temp currentTab] == 2)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        CoachSortViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"CoachSortViewController"];
        [self.navigationController pushViewController:controller animated:YES];

    }
}

#pragma mark - XLPagerTabStripViewControllerDataSource

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    // create child view controllers that will be managed by XLPagerTabStripViewController
    
    NSString * storyboardName = @"Main";
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    
    /*UIViewController * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"sid_game_coach_controller"];
    UIViewController * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"sid_game_player_controller"];
    UIViewController * vc3 = [storyboard instantiateViewControllerWithIdentifier:@"sid_game_group_controller"];*/
    
    HomeProfileController * vcProfile = (HomeProfileController*)[storyboard instantiateViewControllerWithIdentifier:@"sid_hm_profile_controller"];
//    vc3.homeController = self;
    
    GamePlayerController * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"sid_game_player_controller"];
    vc1.vcParent = self;
    
    GameGroupController * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"sid_game_group_controller"];
    vc2.vcParent = self;
    
    GameCoachController * vc3 = [storyboard instantiateViewControllerWithIdentifier:@"sid_game_coach_controller"];
    vc3.vcParent = self;
    
    playerController = vc1;
    groupController = vc2;
    coachController = vc3;
    
    if (!isReload)
    {
        return @[vcProfile, vc1, vc2, vc3];
    }
    
    NSMutableArray * childViewControllers = [NSMutableArray arrayWithObjects:vc1, vc2, vc3, nil];
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

-(void)pagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
          updateIndicatorFromIndex:(NSInteger)fromIndex
                           toIndex:(NSInteger)toIndex
{
     if(toIndex == 0)
     {
         [playerController update];
     }
    else if(toIndex == 1)
    {
        [groupController update];
    }
    else
    {
        [coachController update];
    }
}

-(void)pagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
          updateIndicatorFromIndex:(NSInteger)fromIndex
                           toIndex:(NSInteger)toIndex
            withProgressPercentage:(CGFloat)progressPercentage
                   indexWasChanged:(BOOL)indexWasChanged
{
    int a;
    a = 0;
}
@end


