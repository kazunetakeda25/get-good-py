//
//  GroupDetailsController.m
//  getgood
//
//  Created by MD Aminuzzaman on 1/16/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "AppData.h"
#import "ColorConstants.h"
#import "GroupDetailsController.h"
#import "Temp.h"
#import "UIView+Borders.h"
#import "UIKit.h"
#import "PlayerChatController.h"
#import "CreateGroupController.h"
#import "GroupUserVC.h"
#import "GroupPendingVC.h"

@interface GroupDetailsController ()

@end

@implementation GroupDetailsController
{
    BOOL isReload;
}


@synthesize borderView, content, subController;
@synthesize nRole, nCurrentTab;
@synthesize vPending, vUsers, vGroupChat;
@synthesize vPendingBack, vUsersBack, vGroupChatBack;
@synthesize btnPending, btnUsers, btnGroupChat, btnDown, btnUp;
@synthesize btnEdit, btnLeave, btnDelete;
@synthesize EditWidth, LeaveWidth, DeleteWidth, PendingWidth, ApplyWidth, profileHeight;
@synthesize btnChat;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.ObjGroup = [[GetGood_Group alloc] init];
    self.ObjGroup = [Temp groupData];
    
    lblName.text = self.ObjGroup.title;
    lblDescription.text = self.ObjGroup.description;
    lblLeader.text = self.ObjGroup.owner.name;
    lblServer.text = self.ObjGroup.owner.server;
    
    NSArray *items = [self.ObjGroup.hero componentsSeparatedByString:@" "];
    [self SetHeroImages:items];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tapGestureRecognizer  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionBack:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageBack addGestureRecognizer:tapGestureRecognizer];
    imageBack.userInteractionEnabled = YES;
    
    tapGestureRecognizer  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chatWithLeader:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [btnChat addGestureRecognizer:tapGestureRecognizer];
    btnChat.userInteractionEnabled = YES;
    
    tapGestureRecognizer  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editGroup:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [btnEdit addGestureRecognizer:tapGestureRecognizer];
    btnEdit.userInteractionEnabled = YES;
    
    tapGestureRecognizer  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteGroup:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [btnDelete addGestureRecognizer:tapGestureRecognizer];
    btnDelete.userInteractionEnabled = YES;
    
    
    nRole = -1;
    nCurrentTab = -1;
    PendingWidth.constant = self.view.frame.size.width / 3;
    
    [self initController];
    
    tapGestureRecognizer  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leave:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [btnLeave addGestureRecognizer:tapGestureRecognizer];
    btnLeave.userInteractionEnabled = YES;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)keyboardDidShow: (NSNotification *) notif{
    // Do something here
    CGRect rect = [[notif.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self animateTextField:rect.size.height up:YES];
}

- (void)keyboardDidHide: (NSNotification *) notif{
    CGRect rect = [[notif.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self animateTextField:rect.size.height up:NO];
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (IBAction)onDown:(id)sender {
    profileHeight.constant = 142;
    [btnUp setHidden:NO];
    [btnDown setHidden:YES];
}
- (IBAction)onUp:(id)sender {
    profileHeight.constant = 0;
    [btnUp setHidden:YES];
    [btnDown setHidden:NO];
}

- (void)leave:(UITapGestureRecognizer *)tapGesture
{
    
    [RestClient leaveGroup:self.ObjGroup.id callback:^(bool result, NSDictionary *data) {
        if(!result)
            return;
        
        [self checkRole];
        [RestClient sendNotification:[NSString stringWithFormat:@"%@ left %@.", [AppData profile].name, self.ObjGroup.title] user_id:self.ObjGroup.owner_id];       
        
    }];

}

- (void) initController{
//    [UIKit showLoading:@""];
    
    [self initData];
}

- (void) initData
{
    
    if([self.ObjGroup.owner.id isEqualToString:[AppData profile].id])
    {
        EditWidth.constant = 24;
        DeleteWidth.constant = 24;
        LeaveWidth.constant = 0;
    }
    else
    {
        EditWidth.constant = 0;
        LeaveWidth.constant = 24;
        DeleteWidth.constant = 0;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:@"Notification" object:nil];
}

- (void) receivedNotification:(NSNotification*) notification
{
    [self checkRole];
}

- (void) feedUI
{
    self.ObjGroup = [Temp groupData];
    if(self.ObjGroup.hero.length)
    {
        NSArray *items = [self.ObjGroup.hero componentsSeparatedByString:@" "];
        [self SetHeroImages:items];
    }
    
    lblName.text = self.ObjGroup.title;
    lblDescription.text = self.ObjGroup.getgood_description;
    lblLeader.text = self.ObjGroup.owner.name;
    
    if([Temp getGameMode] == Overwatch)
    {

        lblServer.text = @"";
        [ivPlatform setImage:nil];
        
        if(self.ObjGroup.owner.server.length)
        {
            if([self.ObjGroup.owner.server containsString:@"us"])
            {
                lblServer.text = @"Americas";
            }
            else if([self.ObjGroup.owner.server containsString:@"eu"])
            {
                lblServer.text = @"Europe";
            }
            else if([self.ObjGroup.owner.server containsString:@"kr"])
            {
                lblServer.text = @"Asia";
            }
            if([self.ObjGroup.owner.server containsString:@"pc"])
            {
                [ivPlatform setImage:[UIImage imageNamed:@"pc"]];
            }
            else if([self.ObjGroup.owner.server containsString:@"xbox"])
            {
                [ivPlatform setImage:[UIImage imageNamed:@"xbox"]];
            }
            else if([self.ObjGroup.owner.server containsString:@"ps4"])
            {
                [ivPlatform setImage:[UIImage imageNamed:@"ps4"]];
            }
        }
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        lblServer.text = [Utils getLolServerName:self.ObjGroup.owner.lol_server];
        [ivPlatform setImage:[UIImage imageNamed:@"pc"]];
    }
    
    profileHeight.constant = 142;
    [btnUp setHidden:NO];
    [btnDown setHidden:YES];
}

- (void) checkRole
{    
    [RestClient getGroupWithID:self.ObjGroup.id callback:^(bool result, NSDictionary *data) {
        if(!result)
        {
            [self.navigationController popViewControllerAnimated:YES];
            return ;
        }
        
        self.ObjGroup = [[GetGood_Group alloc] initWithDictionary:[data objectForKey:@"group"]];
        
        [Utils setGroupChecked:self.ObjGroup.id timestamp:self.ObjGroup.timestamp];
        
        NSArray* arUsers = [self.ObjGroup.users componentsSeparatedByString:@":"];
        NSArray* arPendingUsers = [self.ObjGroup.pending_users componentsSeparatedByString:@":"];
        
        int Role = 0;
        if([self.ObjGroup.owner_id isEqualToString:[AppData profile].id])
        {
            Role = 3;
        }
        else if([arUsers containsObject:[AppData profile].id])
        {
            Role = 2;
        }
        else if([arPendingUsers containsObject:[AppData profile].id])
        {
            Role = 1;
        }
        
        [self updateRole:Role];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateGroupDetails" object:nil];
    }];
}

- (void) updateRole: (int) _nRole
{
//    [UIKit dismissDialog];
    
    if(_nRole != nRole)
    {
        [self setTab: 0];
        nRole = _nRole;
        [self updateRoleUI];
    }
    
}
- (IBAction)onApply:(id)sender {
//    if(![AppData profile].blizzard_id.length)
//    {
//        [UIKit showInformation:self message:@"Please register your overwatch account on profile to proceed."];
//        return;
//    }
    
    [RestClient applyGroup:self.ObjGroup.id callback:^(bool result, NSDictionary *data) {
        if(!result)
        {
            return ;
        }
        
        [self checkRole];
        [RestClient sendNotification:[NSString stringWithFormat:@"%@ applied to %@.", [AppData profile].name, self.ObjGroup.title] user_id:self.ObjGroup.owner_id];
    }];
}

- (void) updateRoleUI
{
    switch (nRole) {
        case 0:
            PendingWidth.constant = self.view.frame.size.width - 16;
            ApplyWidth.constant = 0;
            btnChat.hidden = YES;

            ApplyWidth.constant = 40;
            EditWidth.constant = 0;
            DeleteWidth.constant = 0;
            LeaveWidth.constant = 0;

            break;
        case 1:
            PendingWidth.constant = self.view.frame.size.width - 16;
            [self setTab:0];
            btnChat.hidden = NO;

            ApplyWidth.constant = 0;
            EditWidth.constant = 0;
            DeleteWidth.constant = 0;
            LeaveWidth.constant = 24;

            break;
        case 2:
            PendingWidth.constant = 0;
            [self setTab:1];
            btnChat.hidden = YES;
            ApplyWidth.constant = 0;

            EditWidth.constant = 0;
            LeaveWidth.constant = 24;
            DeleteWidth.constant = 0;

            break;

        case 3:

            PendingWidth.constant = (self.view.frame.size.width - 16) / 3;
            btnChat.hidden = YES;
            ApplyWidth.constant = 0;

            EditWidth.constant = 24;
            LeaveWidth.constant = 0;
            DeleteWidth.constant = 24;

            break;

        default:
            break;
    }

    [self.view layoutIfNeeded];
}

- (void) setTab: (int) nTab
{
    if(nTab == nCurrentTab)
    {
        return;
    }
    
    nCurrentTab = nTab;
    
    [self.vPendingBack setHidden:YES];
    [self.vUsersBack setHidden:YES];
    [self.vGroupChatBack setHidden:YES];
    
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    
    switch (nTab) {
        case 0:
            subController = [storyboard instantiateViewControllerWithIdentifier:@"GroupPendingVC"];
            
            ((GroupPendingVC*) subController).parentVC = self;
            [self.vPendingBack setHidden:NO];
            break;
        case 1:
            subController = [storyboard instantiateViewControllerWithIdentifier:@"GroupUserVC"];
            
            ((GroupUserVC*) subController).parentVC = self;
            
            [self.vUsersBack setHidden:NO];
            break;
        case 2:
            subController = [storyboard instantiateViewControllerWithIdentifier:@"GroupChatVC"];
            [self.vGroupChatBack setHidden:NO];
            break;
            
        default:
            break;
    }
    
    for (UIView* view in content.subviews)
    {
        [view removeFromSuperview];
    }
    [subController.view setFrame:CGRectMake(0, 0, content.frame.size.width, content.frame.size.height)];
    [content addSubview:subController.view];
    
}

- (void) checkState
{
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self feedUI];
    [self checkRole];
}

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.borderView layoutIfNeeded];
    [self.borderView addBottomBorderWithHeight:3.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
    [self.borderView addLeftBorderWithWidth:1.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
    [self.borderView addRightBorderWithWidth:1.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
    [self.borderView addTopBorderWithHeight:1.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
    
    
    [self.vPendingBack addBottomBorderWithHeight:3.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
    [self.vUsersBack addBottomBorderWithHeight:3.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
    [self.vGroupChatBack addBottomBorderWithHeight:3.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
    
    
    [self.view layoutIfNeeded];
    [self.vPending layoutIfNeeded];
    [self.vUsers layoutIfNeeded];
    [self.vGroupChat layoutIfNeeded];
    
    [self.vPendingBack layoutIfNeeded];
    [self.vUsersBack layoutIfNeeded];
    [self.vGroupChatBack layoutIfNeeded];
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)SetHeroImages:(NSArray *)arHr{
    
    [heroImage1 setHidden:NO];
    [heroImage2 setHidden:NO];
    [heroImage3 setHidden:NO];
    [heroImage4 setHidden:NO];
    [heroImage5 setHidden:NO];
    
    int i = 0;
    if([Temp getGameMode] == Overwatch)
    {
        for(i = 0; i < [arHr count] ; ++i)
        {
            switch (i)
            {
                case 0:
                    [heroImage1 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                    break;
                case 1:
                    [heroImage2 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                    break;
                case 2:
                    [heroImage3 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                    break;
                case 3:
                    [heroImage4 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                    break;
                case 4:
                    [heroImage5 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                    break;
                    
                default:
                    break;
            }
        }
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        for(i = 0; i < [arHr count] ; ++i)
        {
            switch (i)
            {
                case 0:
                    [heroImage1 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                    break;
                case 1:
                    [heroImage2 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                    break;
                case 2:
                    [heroImage3 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                    break;
                case 3:
                    [heroImage4 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                    break;
                case 4:
                    [heroImage5 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                    break;
                    
                default:
                    break;
            }
        }
    }

    
    for(int j = i ; j < 5 ; j++)
    {
        switch (j)
        {
            case 0:
                [heroImage1 setHidden:YES];
                break;
            case 1:
                [heroImage2 setHidden:YES];
                break;
            case 2:
                [heroImage3 setHidden:YES];
                break;
            case 3:
                [heroImage4 setHidden:YES];
                break;
            case 4:
                [heroImage5 setHidden:YES];
                break;
                
            default:
                break;
        }
    }
}


- (void)actionBack:(UITapGestureRecognizer *)tapGesture
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)editGroup:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    CreateGroupController *controller = [storyboard instantiateViewControllerWithIdentifier:@"CreateGroupController"];
    controller.bEdit = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)deleteGroup:(UITapGestureRecognizer *)tapGesture
{
    [UIKit showConfirm:self message:@"Are yous sure to delete this group?" yesHandler:^(UIAlertAction *action) {
        
        [RestClient deleteGroup:self.ObjGroup.id callback:^(bool result, NSDictionary *data) {
            if(!result)
                return ;
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }];
}

- (void)chatWithLeader:(UITapGestureRecognizer *)tapGesture
{
    
    [RestClient createDialog:@"1" reference:@"" receiver:[Temp groupData].owner_id callback:^(bool result, NSDictionary *data) {
        [UIKit dismissDialog];
        if(!result)
            return;
        GetGood_Dialog* dialog = [[GetGood_Dialog alloc] initWithDictionary:[data objectForKey:@"dialog"]];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        PlayerChatController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sid_player_chat_controller"];
        [Temp setDialogData:dialog];
        [self.navigationController pushViewController:controller animated:YES];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onPending:(id)sender {
    [self setTab:0];
}
- (IBAction)onUsers:(id)sender {
    [self setTab:1];
}
- (IBAction)onGroupChat:(id)sender {
    [self setTab:2];
}

-(void)animateTextField:(CGFloat) height up:(BOOL)up
{
    if(up)
    {
        if(self.view.frame.origin.y < -10)
            return;
    }
    else
    {
        if(self.view.frame.origin.y > -10)
            return;
    }

    
    const int movementDistance = -height; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end


