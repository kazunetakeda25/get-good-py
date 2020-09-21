//
//  ChatListController.m
//  getgood
//
//  Created by Md Aminuzzaman on 22/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "Temp.h"
#import "UIKit.h"
#import "Utils.h"
#import "AppData.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "ChatListController.h"
#import "PlayerChatController.h"
#import "Temp.h"

@import Firebase;
@import FirebaseDatabase;

@interface ChatListController ()
{
    NSMutableArray *chatListArray;
}

@end

@implementation ChatListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    //
}

-(void) initActivityData
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionBack:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageBack addGestureRecognizer:tapGestureRecognizer];
    imageBack.userInteractionEnabled = YES;
    
    chatListArray = [[NSMutableArray alloc] init];
    
    
//    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
//
//    [[[ref child:@"dialog"] queryOrderedByChild:@"Time"]
//     observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *_Nonnull snapshot)
//     {
//         [UIKit dismissDialog];
//
//         for(FIRDataSnapshot *shot in snapshot.children)
//         {
//             Dialog *dialog = [[Dialog alloc] initWithDictionary:shot.value];
//
//             if([self checkIfDialogExists:dialog])
//                [chatListArray addObject:dialog];
//         }
//
//         chatListArray = [[[chatListArray reverseObjectEnumerator] allObjects] mutableCopy];
//
//         if([chatListArray count] == 0)
//         {
//             tableView.hidden = YES;
//             labelNoItem.hidden = NO;
//         }
//
//         [AppData userDefaultSetObject:@"chat_unread" forKey:@"0"];
//
//         [tableView reloadData];
//     }];
    
    [RestClient getDialogList:^(bool result, NSDictionary *data) {

       if(!result)
           return ;
        
        chatListArray = [[NSMutableArray alloc] init];
        NSArray* arTemp = [data objectForKey:@"dialogs"];
        
        for(int i = 0; i < arTemp.count; i++)
        {
            GetGood_Dialog* dialog = [[GetGood_Dialog alloc] initWithDictionary:[arTemp objectAtIndex:i]];
            
            [chatListArray addObject:dialog];
        }
        
        [tableView reloadData];
    }];
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)actionBack:(UITapGestureRecognizer *)tapGesture
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self initActivityData];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger) tableView:(UITableView *) theTableView numberOfRowsInSection:(NSInteger) section
{
    return chatListArray.count;
}

-(UITableViewCell *) tableView:(UITableView *) theTableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    GetGood_Dialog *dialog = [chatListArray objectAtIndex:indexPath.row];

    ChatListCell *cell = (ChatListCell *)[tableView dequeueReusableCellWithIdentifier:@"ChatListCell"];
    
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatListCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    
    cell.imageUser.layer.cornerRadius = cell.imageUser.frame.size.width / 2;
    cell.imageUser.clipsToBounds = YES;
    
    if([dialog.block_id isEqualToString:@"-1"])
    {
        cell.imageBlock.hidden = YES;
    }
    else
    {
        cell.imageBlock.hidden = NO;
    }
    
       
    BOOL bNewMessage = [Utils checkIfNewMessage:dialog];

    if(bNewMessage)
        cell.imageNew.hidden = NO;
    else
        cell.imageNew.hidden = YES;
    
    
    NSString *userId = @"";
    
    if([dialog.holder_id isEqualToString:[AppData profile].id])
    {
        userId = dialog.rec_id;
    }
    else
    {
        userId = dialog.holder_id;
    }
    
    if([dialog.type isEqualToString:@"1"])
    {
        [RestClient readProfile:userId callback:^(bool result, NSDictionary *data) {
            if(!result)
            {
                return;
            }
            
            User* userProfile = [[User alloc] initWithDictionary:[data objectForKey:@"profile"]];
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", userProfile.avatar_url]];
            [cell.imageUser sd_setImageWithURL:url];
            [cell.labelNameView setText:[NSString stringWithFormat:@"%@ (Player)", userProfile.name]];
        }];
    }
    else if([dialog.type isEqualToString:@"2"])
    {
        [RestClient readProfile:userId callback:^(bool result, NSDictionary *data) {
            if(!result)
            {
                return;
            }
            
            User* userProfile = [[User alloc] initWithDictionary:[data objectForKey:@"profile"]];
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", userProfile.avatar_url]];
            [cell.imageUser sd_setImageWithURL:url];
            [cell.labelNameView setText:[NSString stringWithFormat:@"%@ (Lesson)", userProfile.name]];
            
            [RestClient getLessonWithID:dialog.reference_id callback:^(bool result, NSDictionary *data1) {
                if(!result)
                {
                    return ;
                }
                
                GetGood_Lesson* lesson = [[GetGood_Lesson alloc] initWithDictionary:[data1 objectForKey:@"lesson"]];
                
                [cell.labelNameView setText:[NSString stringWithFormat:@"%@ (Lesson: %@)", userProfile.name, lesson.title]];
            }];
        }];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    GetGood_Dialog *dialog = [chatListArray objectAtIndex:indexPath.row];
    
    if([dialog.type isEqualToString:@"1"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        PlayerChatController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sid_player_chat_controller"];
        
//        GetGood_Dialog* dialog = [chatListArray objectAtIndex:indexPath.row];
//        if(dialog.)
        [Temp setDialogData:[chatListArray objectAtIndex:indexPath.row]];
        
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if([dialog.type isEqualToString:@"2"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        ChatController *controller = [storyboard instantiateViewControllerWithIdentifier:@"ChatController"];
        
        [Temp setDialogData:dialog];
        
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end

@implementation ChatListCell

@end

