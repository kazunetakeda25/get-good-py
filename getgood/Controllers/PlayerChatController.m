//
//  PlayerChatController.m
//  getgood
//
//  Created by MD Aminuzzaman on 1/17/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "Temp.h"
#import "Utils.h"
#import "UIKit.h"
#import "AppData.h"
#import "ChatMessage.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "PlayerChatController.h"
#import "UIImageView+WebCache.h"
#import "PlayerSelfMessageCell.h"
#import "PlayerPartnerMessageCell.h"
#import "PlayerInformationMessageCell.h"
#import "DataArrays.h"

@import ActionSheetPicker_3_0;
@import Firebase;
@import FirebaseDatabase;

@interface PlayerChatController () <UITextFieldDelegate>
{
    GetGood_Dialog *dialog;
    NSString *strBlockUserId;
    User *userProfile;
    FIRDatabaseReference *mDatabase;
    NSMutableArray *groupListArray;
    NSMutableArray *chatMessageArray;
    NSTimer *timer;
    
    int tick;
}

@property (strong, nonatomic) NSTimer * searchTimer;

@end

@implementation PlayerChatController
@synthesize ProfileContainer, btnShow, containerHeight, headerHeight, ivBlock;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initController];
    //[tableView reloadData];
    
    groupListArray =[[NSMutableArray alloc] init];
    groupListArray = [AppData groupList];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];

    [self.view addGestureRecognizer:tap];
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Type your message here ..." attributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }];
    textFieldMessage.attributedPlaceholder = str;
    textFieldMessage.borderStyle = UITextBorderStyleNone;
    
    [self refreshDialog];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    textFieldMessage.delegate = self;
    [textFieldMessage addTarget:self
                       action:@selector(textFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];
}

// reset the search timer whenever the text field changes
-(void)textFieldDidChange :(UITextField *)textField{
    [RestClient sendSilentNotification:userProfile.id dialogID:dialog.id];    
}


- (void)keyboardDidShow: (NSNotification *) notif{
    // Do something here
    CGRect rect = [[notif.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self animateTextField:textFieldMessage height:rect.size.height up:YES];
}

- (void)keyboardDidHide: (NSNotification *) notif{
    CGRect rect = [[notif.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self animateTextField:textFieldMessage height:rect.size.height up:NO];
}
- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
- (void) refreshDialog
{
    int last = 0;
    if(chatMessageArray.count > 0)
    {
        GetGood_Message* message = [chatMessageArray objectAtIndex:chatMessageArray.count - 1];
        last = [message.id intValue];
    }
    [RestClient getDialog:dialog.id message_id:last callback:^(bool result, NSDictionary *data) {
        if(!result)
            return ;
        
        GetGood_Dialog* dlgTemp = [[GetGood_Dialog alloc] initWithDictionary:[data objectForKey:@"dialog"]];
        dialog = dlgTemp;
        
        [Utils setDialogChecked:dialog.id timestamp:dialog.timestamp];
        [self updateStateUI];
        
        NSArray* arTempMessages = [data objectForKey:@"messages"];
        
        for(int i = 0; i < arTempMessages.count; i++)
        {
            GetGood_Message* message = [[GetGood_Message alloc] initWithDictionary:[arTempMessages objectAtIndex:i]];
            
            [chatMessageArray addObject:message];
        }
        
        [tableView reloadData];
        
        containerHeight.constant = 138;
        [btnShow setHidden:YES];
        
        [self.view layoutSubviews];
        if(chatMessageArray.count != 0)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:chatMessageArray.count - 1 inSection:0];
            [tableView scrollToRowAtIndexPath:indexPath                                    atScrollPosition:UITableViewScrollPositionBottom
                                     animated:NO];
        }
    }];
}


-(void) initController
{
    lblInvite.hidden = YES;
    lblAccept.hidden = YES;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionSubmit:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageViewSend addGestureRecognizer:tapGestureRecognizer];
    imageViewSend.userInteractionEnabled = YES;

    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionBack:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageBack addGestureRecognizer:tapGestureRecognizer];
    imageBack.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(InviteClick:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [lblInvite addGestureRecognizer:tapGestureRecognizer];
    lblInvite.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AcceptClick:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [lblAccept addGestureRecognizer:tapGestureRecognizer];
    lblAccept.userInteractionEnabled = YES;
    
    
    textFieldMessage.returnKeyType = UIReturnKeyDone;
    textFieldMessage.delegate = self;
    
    tableView.estimatedRowHeight = 500.0f;
    tableView.rowHeight = UITableViewAutomaticDimension;
   
    [self registerNibForCustomCell];
    
//    [UIKit showLoading];
    dialog = [Temp dialogData];
    
    [self setChecked];
    
    chatMessageArray = [[NSMutableArray alloc] init];
    mDatabase = [[FIRDatabase database] reference];
    NSString *strId = dialog.holder_id;
    
    if([dialog.holder_id isEqualToString:[AppData profile].id])
    {
        strId = dialog.rec_id;
    }
    
    [RestClient readProfile:strId callback:^(bool result, NSDictionary *data) {
//        [UIKit dismissDialog];
       if(!result)
       {
           [self.navigationController popViewControllerAnimated:YES];
           return;
       }
        
        userProfile = [[User alloc] initWithDictionary:[data objectForKey:@"profile"]];
        [self viewUserProfile:userProfile];
        
        [self updateStateUI];
    }];
}
- (IBAction)onShow:(id)sender {
    containerHeight.constant = 138;
    [btnShow setHidden:YES];
}
- (IBAction)onHide:(id)sender {
    containerHeight.constant = 0;
    [btnShow setHidden:NO];
}

- (void) receivedNotification:(NSNotification*) notification
{
    [self refreshDialog];
}

- (void) typingNotifications:(NSNotification*) notification
{
    if(![[((NSDictionary*)notification.object) objectForKey:@"dialog"] isEqualToString:dialog.id])
    {
        return;
    }
    
    [self refreshTypingState: (NSDictionary*)notification.object];
}

- (void) refreshTypingState: (NSDictionary*) userInfo
{
    [self.lbTyping setText:[NSString stringWithFormat:@"%@ is typing ...", [userInfo objectForKey:@"name"]]];
    
    self.lbTyping.hidden = NO;
    
    tick = 0;
    if(timer != nil)
    {
        [timer invalidate];
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(hideTyping) userInfo:nil repeats:YES];
    
    [timer fire];
}

- (void) hideTyping
{
    if(tick == 0)
    {
        tick ++;
        return;
    }
    else if(tick == 1)
    {
        self.lbTyping.hidden = YES;
        if(timer != nil)
        {
            [timer invalidate];
            tick = 0;
        }
    }

}

-(BOOL)CheckifCoach{
    
    if (!dialog.inviter_id.length) {
        return NO;
    }

    if ([dialog.inviter_id isEqualToString:[AppData profile].id]) {

        return YES;
    }

    return NO;
}

-(void)dismissKeyboard
{
    //    [textEmailField resignFirstResponder];
    //    [textPasswordField resignFirstResponder];
    //    [self animateTextField:nil up:NO];
    [self.view endEditing:YES];
}


-(void)updateStateUI{
    
    lblInvite.hidden = YES;
    lblAccept.hidden = YES;
    headerHeight.constant = 0;

    if ([dialog.state isEqualToString:@"0"]) {

        //Invite visible
        headerHeight.constant = 46;
        lblInvite.hidden = NO;


    }else if ([dialog.state isEqualToString:@"5"]){

        if ([self CheckifCoach] == NO) {

             //accept visible
            lblAccept.hidden = NO;
            headerHeight.constant = 46;
        }
    }

    if (![dialog.block_id isEqualToString:@"-1"]) {

        [ivBlock setImage:[UIImage imageNamed:@"unblock"]];
        if (![dialog.block_id isEqualToString: [AppData profile].id]) {

            [ivBlock setImage:nil];
        }

    }else{
        [ivBlock setImage:[UIImage imageNamed:@"block"]];
    }

//    if(!userProfile.blizzard_id.length || ![AppData profile].blizzard_id.length)
//    {
//        headerHeight.constant = 0;
//    }
    
    [self.view layoutIfNeeded];
    [self.view updateConstraintsIfNeeded];
}

-(void)viewUserProfile:(User *)profile{
    
    NSString *strImg = [NSString stringWithFormat:@"%@",profile.avatar_url];
    [imageUser sd_setImageWithURL:[NSURL URLWithString:strImg]
                 placeholderImage:[UIImage imageNamed:@"avatar"]
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         imageUser.image = image;
     }];
    
    labelName.text = profile.name;
    
    if([Temp getGameMode] == Overwatch)
    {

        labelServer.text = @"";
        [ivPlatform setImage:nil];
        
        if(profile.server.length)
        {
            if([profile.server containsString:@"us"])
            {
                labelServer.text = @"Americas";
            }
            else if([profile.server containsString:@"eu"])
            {
                labelServer.text = @"Europe";
            }
            else if([profile.server containsString:@"kr"])
            {
                labelServer.text = @"Asia";
            }
            if([profile.server containsString:@"pc"])
            {
                [ivPlatform setImage:[UIImage imageNamed:@"pc"]];
            }
            else if([profile.server containsString:@"xbox"])
            {
                [ivPlatform setImage:[UIImage imageNamed:@"xbox"]];
            }
            else if([profile.server containsString:@"ps4"])
            {
                [ivPlatform setImage:[UIImage imageNamed:@"ps4"]];
            }
        }
        
        if(profile.overwatch_rank != 0)
        {
            labelGameRating.text = [NSString stringWithFormat:@"%d", profile.overwatch_rank];
        }
        else
        {
            labelGameRating.text = @"...";
        }
        
        
        [ratingUserView setValue:profile.player_rating];
        
        if(profile.overwatch_heroes.length)
        {
            NSArray* arHr = [profile.overwatch_heroes componentsSeparatedByString: @" "];
            NSLog(@"%@",arHr);
            
            int i = 0;
            for(i = 0; i < [arHr count] ; ++i)
            {
                switch (i)
                {
                    case 0:
                        [imageViewHeroOne setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 1:
                        [imageViewHeroTwo setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 2:
                        [imageViewHeroThree setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 3:
                        [imageViewHeroFour setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 4:
                        [imageViewHeroFive setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                        
                    default:
                        break;
                }
            }
            
            for(int j = i ; j < 5 ; ++j)
            {
                switch (i)
                {
                    case 0:
                        [imageViewHeroOne setHidden:YES];
                        break;
                    case 1:
                        [imageViewHeroTwo setHidden:YES];
                        break;
                    case 2:
                        [imageViewHeroThree setHidden:YES];
                        break;
                    case 3:
                        [imageViewHeroFour setHidden:YES];
                        break;
                    case 4:
                        [imageViewHeroFive setHidden:YES];
                        break;
                        
                    default:
                        break;
                }
            }
        }
    }
    else if([Temp getGameMode] ==  LeagueOfLegends)
    {

        labelServer.text = [Utils getLolServerName:profile.lol_server];
        [ivPlatform setImage:[UIImage imageNamed:@"pc"]];
        
        if(profile.lol_rank.length)
        {
            labelGameRating.text = profile.lol_rank;
        }
        else
        {
            labelGameRating.text = @"...";
        }
                
        [ratingUserView setValue:profile.lol_player_rating];
        
        if(profile.lol_heroes.length)
        {
            NSArray* arHr = [profile.lol_heroes componentsSeparatedByString: @" "];
            NSLog(@"%@",arHr);
            
            int i = 0;
            for(i = 0; i < [arHr count] ; ++i)
            {
                switch (i)
                {
                    case 0:
                        [imageViewHeroOne setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 1:
                        [imageViewHeroTwo setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 2:
                        [imageViewHeroThree setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 3:
                        [imageViewHeroFour setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 4:
                        [imageViewHeroFive setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                        
                    default:
                        break;
                }
            }
            
            for(int j = i ; j < 5 ; ++j)
            {
                switch (i)
                {
                    case 0:
                        [imageViewHeroOne setHidden:YES];
                        break;
                    case 1:
                        [imageViewHeroTwo setHidden:YES];
                        break;
                    case 2:
                        [imageViewHeroThree setHidden:YES];
                        break;
                    case 3:
                        [imageViewHeroFour setHidden:YES];
                        break;
                    case 4:
                        [imageViewHeroFive setHidden:YES];
                        break;
                        
                    default:
                        break;
                }
            }
        }
    }
    
    
    containerHeight.constant = 138;
    [btnShow setHidden:YES];
    
    
    if(chatMessageArray.count != 0)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:chatMessageArray.count - 1 inSection:0];
        [tableView scrollToRowAtIndexPath:indexPath                                    atScrollPosition:UITableViewScrollPositionBottom
                                 animated:NO];
    }
    
}


- (void)InviteClick:(UITapGestureRecognizer *)tapGesture
{
    
    if(![dialog.block_id isEqualToString:@"-1"])
        return;
    
    
    if(!userProfile.blizzard_id.length)
    {
        [UIKit showInformation:self message:@"Opponent user didn't connect overwatch account."];
        return;
    }
    
    [RestClient getGroupsWithUserID:[AppData profile].id callback:^(bool result, NSDictionary *data) {
            if(!result)
                return;
        
        NSMutableArray* arTemp = [data objectForKey:@"groups"];
        NSMutableArray* _arTitles = [[NSMutableArray alloc] init];
        NSMutableArray* _arGroups = [[NSMutableArray alloc] init];
        
        for(int i = 0; i < arTemp.count; i++)
        {
            NSDictionary* dict = [arTemp objectAtIndex:i];
            GetGood_Group* group = [[GetGood_Group alloc] initWithDictionary:dict];
            
            [_arGroups addObject:group];
            [_arTitles addObject:group.title];
        }
        
        if(_arGroups.count == 0)
            return;
        
        [ActionSheetStringPicker showPickerWithTitle:@"Select Group" rows:_arTitles initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
                                               //           NSLog(@"Picker: %@, Index: %ld, value: %@",picker, (long)selectedIndex, selectedValue);
                                               
                                               GetGood_Group *objGroup = [_arGroups objectAtIndex:selectedIndex];
                                               dialog.reference_id = objGroup.id;
                                               dialog.inviter_id = [AppData profile].id;
                                               dialog.state = @"5";
                                               
                                               [RestClient updateDialog:dialog.id state:dialog.state inviter_id:dialog.inviter_id block_id:dialog.block_id reference_id:dialog.reference_id callback:^(bool result, NSDictionary *data) {
                                                   [RestClient sendNotification:[NSString stringWithFormat:@"%@ invited you to %@.", [AppData profile].name, objGroup.title] user_id:userProfile.id];
                                               }];
                                               
                                               [self updateStateUI];
                                               
                                               [self sendInvite];
                                           }cancelBlock:^(ActionSheetStringPicker *picker) {
                                               
                                               NSLog(@"Block Picker Canceled");
                                           }
                                              origin:lblInvite];
    }];
    
}


- (void)AcceptClick:(UITapGestureRecognizer *)tapGesture
{
    
    if(![dialog.block_id isEqualToString:@"-1"])
        return;
    
    if(!dialog.reference_id.length)
    {
        return;
    }
    
    [RestClient joinGroup:dialog.reference_id callback:^(bool result, NSDictionary *data) {
        
        if(!result)
            return;
        
        dialog.reference_id = @"-1";
        dialog.inviter_id = @"-1";
        dialog.state = @"0";

        [RestClient updateDialog:dialog.id state:dialog.state inviter_id:dialog.inviter_id block_id:dialog.block_id reference_id:dialog.reference_id callback:^(bool result, NSDictionary *data) {
            [RestClient sendNotification:[NSString stringWithFormat:@"%@ accepted your invitation", [AppData profile].name] user_id:userProfile.id];

        }];
        
        [self updateStateUI];
        
        [self sendAccept];
    }];
}

- (void) sendAccept
{
    [RestClient sendMessage:dialog.id message:@"" type:@"6" callback:^(bool result, NSDictionary *data) {
        GetGood_Message* message = [[GetGood_Message alloc] initWithDictionary:[data objectForKey:@"message"]];
        
        [Utils setDialogChecked:dialog.id timestamp:message.timestamp];
        [chatMessageArray addObject:message];
        [tableView reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:chatMessageArray.count - 1 inSection:0];
        [tableView scrollToRowAtIndexPath:indexPath                                    atScrollPosition:UITableViewScrollPositionBottom
                                 animated:NO];
    }];
}


- (void) sendInvite
{
    [RestClient sendMessage:dialog.id message:@"" type:@"5" callback:^(bool result, NSDictionary *data) {
        GetGood_Message* message = [[GetGood_Message alloc] initWithDictionary:[data objectForKey:@"message"]];
        
        [Utils setDialogChecked:dialog.id timestamp:message.timestamp];
        [chatMessageArray addObject:message];
        [tableView reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:chatMessageArray.count - 1 inSection:0];
        [tableView scrollToRowAtIndexPath:indexPath                                    atScrollPosition:UITableViewScrollPositionBottom
                                 animated:NO];
    }];
}


- (IBAction)onBlock:(id)sender {
    if(![dialog.block_id isEqualToString:@"-1"] && ![dialog.block_id isEqualToString:[AppData profile].id])
        return;
    
    if([dialog.block_id isEqualToString:@"-1"])
    {
        dialog.block_id = [AppData profile].id;
    }
    else
    {
        dialog.block_id = @"-1";
    }
    
    [RestClient updateDialog:dialog.id state:dialog.state inviter_id:dialog.inviter_id block_id:dialog.block_id reference_id:dialog.reference_id callback:^(bool result, NSDictionary *data) {
        NSString *strMessage;
        NSString *strCode;
        if([dialog.block_id isEqualToString:@"-1"])
        {
            strMessage = [NSString stringWithFormat:@"%@ unblocked you.", [AppData profile].name];
            strCode = @"8";
        }
        else
        {
            strMessage = [NSString stringWithFormat:@"%@ blocked you.", [AppData profile].name];
            strCode = @"7";
        }
        
        [RestClient sendMessage:dialog.id message:@"" type:strCode callback:^(bool result, NSDictionary *data) {
            GetGood_Message* message = [[GetGood_Message alloc] initWithDictionary:[data objectForKey:@"message"]];
            
            [Utils setDialogChecked:dialog.id timestamp:message.timestamp];
            [chatMessageArray addObject:message];
            [tableView reloadData];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:chatMessageArray.count - 1 inSection:0];
            [tableView scrollToRowAtIndexPath:indexPath                                    atScrollPosition:UITableViewScrollPositionBottom
                                     animated:NO];
        }];
        
        [RestClient sendNotification:strMessage user_id:userProfile.id];
    }];
    
    [self updateStateUI];
}

-(void) initUI
{
    
}

-(void) setChecked
{
//    [Utils setDialogChecked:dialog];
}

- (void)actionSubmit:(UITapGestureRecognizer *)tapGesture
{
    if(textFieldMessage.text.length == 0)
    {
        return;
    }
    
    if(![dialog.block_id isEqualToString:@"-1"])
        return;
    
    [RestClient sendMessage:dialog.id message:textFieldMessage.text type:@"0" callback:^(bool result, NSDictionary *data) {
        
        GetGood_Message* message = [[GetGood_Message alloc] initWithDictionary:[data objectForKey:@"message"]];
        
        [Utils setDialogChecked:dialog.id timestamp:message.timestamp];
        [chatMessageArray addObject:message];
        [RestClient sendNotification:[NSString stringWithFormat:@"%@ sent you a message.", [AppData profile].name] user_id:userProfile.id];
        [tableView reloadData];
        
        if(chatMessageArray.count != 0)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:chatMessageArray.count - 1 inSection:0];
            [tableView scrollToRowAtIndexPath:indexPath                                    atScrollPosition:UITableViewScrollPositionBottom
                                     animated:NO];
        }
        
    }];
    [textFieldMessage setText:@""];
    
}

-(void)registerNibForCustomCell{
    
    UINib *nibPlayerSelfCell=[UINib nibWithNibName:@"PlayerSelfMessageCell" bundle:nil];
    [tableView registerNib:nibPlayerSelfCell forCellReuseIdentifier:@"PlayerSelfMessageCell"];
    
    UINib *nibPlayerPartnerCell=[UINib nibWithNibName:@"PlayerPartnerMessageCell" bundle:nil];
    [tableView registerNib:nibPlayerPartnerCell forCellReuseIdentifier:@"PlayerPartnerMessageCell"];
    
    UINib *nibPlayerInformationCell=[UINib nibWithNibName:@"PlayerInformationMessageCell" bundle:nil];
    [tableView registerNib:nibPlayerInformationCell forCellReuseIdentifier:@"PlayerInformationMessageCell"];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:@"Notification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(typingNotifications:) name:@"TypingNotification" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}

-(NSInteger) tableView:(UITableView *) theTableView numberOfRowsInSection:(NSInteger) section
{
    return chatMessageArray.count;
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(UITableViewCell *) tableView:(UITableView *) theTableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    GetGood_Message *message = [chatMessageArray objectAtIndex:indexPath.row];
   
    NSLog(@"%@",message.type);

    if ([message.type isEqualToString:@"0"]) {

        if ([message.user_id isEqual:[AppData profile].id]) {

            PlayerSelfMessageCell *cell = (PlayerSelfMessageCell *)[tableView dequeueReusableCellWithIdentifier:@"PlayerSelfMessageCell"];

            cell.imageUser.layer.cornerRadius = cell.imageUser.frame.size.width / 2;
            cell.imageUser.clipsToBounds = YES;
            cell.tvMessage.text = message.message;

            if (message.timestamp == nil ) {

                cell.labelDateView.text = @"";

            }else{
                NSString *date = [Temp getDateFromTimeInterval:message.timestamp  dateFormat:@"dd MMM yyyy HH:mm:ss"];
                cell.labelDateView.text = date;
            }

            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [AppData profile].avatar_url]];

            [cell.imageUser sd_setImageWithURL:url];
            return cell;


        }else{

            PlayerPartnerMessageCell *cell = (PlayerPartnerMessageCell *)[tableView dequeueReusableCellWithIdentifier:@"PlayerPartnerMessageCell"];

            cell.tvMessage.text = message.message;
            cell.imageUser.layer.cornerRadius = cell.imageUser.frame.size.width / 2;
            cell.imageUser.clipsToBounds = YES;

            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", userProfile.avatar_url]];

            [cell.imageUser sd_setImageWithURL:url];
            if (message.timestamp == nil) {

                cell.labelDateView.text = @"";

            }else{

                NSString *date = [Temp getDateFromTimeInterval:message.timestamp dateFormat:@"dd MMM yyyy HH:mm:ss"];
                cell.labelDateView.text = date;
            }


            return cell;
        }

    }else{

         PlayerInformationMessageCell *cell = (PlayerInformationMessageCell *)[tableView dequeueReusableCellWithIdentifier:@"PlayerInformationMessageCell"];


        if ([message.user_id isEqual:[AppData profile].id]) {

            NSArray *array =  [DataArrays PlayerChatSelfInfromation];

            //Offer
            if ([message.type isEqualToString:@"1"]) {

              cell.labelMessageView.text = [array objectAtIndex:0];

            //Accepted
            }else if ([message.type isEqualToString:@"2"]){

             cell.labelMessageView.text = [array objectAtIndex:1];

            //Blocked
            }else if ([message.type isEqualToString:@"7"]){

             cell.labelMessageView.text = [array objectAtIndex:2];

            //UnBlocked
            }else if ([message.type isEqualToString:@"8"]){

              cell.labelMessageView.text = [array objectAtIndex:3];

            //OfferedCoin
            }else if ([message.type isEqualToString:@"9"]){

             cell.labelMessageView.text = [array objectAtIndex:4];

            //Invite
            }else if ([message.type isEqualToString:@"5"]){

             cell.labelMessageView.text = [array objectAtIndex:5];

            //GroupAccepted
            }else if ([message.type isEqualToString:@"6"]){

              cell.labelMessageView.text = [array objectAtIndex:6];

           }



        }else{


            NSArray *array =  [DataArrays PlayerChatPatnerInfromation];
            cell.labelMessageView.text = [array objectAtIndex:1];

            //Offer
            if ([message.type isEqualToString:@"1"]) {

                cell.labelMessageView.text = [array objectAtIndex:0];

                //Accepted
            }else if ([message.type isEqualToString:@"2"]){

                cell.labelMessageView.text = [array objectAtIndex:1];

                //Blocked
            }else if ([message.type isEqualToString:@"7"]){

                cell.labelMessageView.text = [array objectAtIndex:2];

                //UnBlocked
            }else if ([message.type isEqualToString:@"8"]){

                cell.labelMessageView.text = [array objectAtIndex:3];

                //OfferedCoin
            }else if ([message.type isEqualToString:@"9"]){

                cell.labelMessageView.text = [array objectAtIndex:4];

            //Invite
            }else if ([message.type isEqualToString:@"5"]){

             cell.labelMessageView.text = [array objectAtIndex:5];

           //GroupAccepted
           }else if ([message.type isEqualToString:@"6"]){

            cell.labelMessageView.text = [array objectAtIndex:6];

         }

        }
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{

}

-(void)animateTextField:(UITextField*)textField height:(CGFloat) height up:(BOOL)up
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

/*
 - (BOOL)textFieldShouldReturn:(UITextField*)aTextField
 {
 [aTextField resignFirstResponder];
 return YES;
 }*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end



