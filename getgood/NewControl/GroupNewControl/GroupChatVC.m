//
//  GroupChatVC.m
//  getgood
//
//  Created by Bhargav Mistri on 28/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "GroupChatVC.h"
#import "GroupSelfMessageCell.h"
#import "GroupPartnerCell.h"
#import "Temp.h"
#import "Utils.h"
#import "UIKit.h"
#import "AppData.h"
#import "GroupChatMessage.h"

@import Firebase;
@import FirebaseDatabase;

@interface GroupChatVC () {
    
    FIRDatabaseReference *mDatabase;
    GetGood_Group *TempGroup;
    NSMutableArray *chatMessageArray;

}

@end
@implementation GroupChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerNibForCustomCell];
    
    TempGroup = [[GetGood_Group alloc] init];
    TempGroup = [Temp groupData];
  
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionSubmit:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageViewSend addGestureRecognizer:tapGestureRecognizer];
    imageViewSend.userInteractionEnabled = YES;
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Type your message here ..." attributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }];
    textFieldMessage.attributedPlaceholder = str;
    textFieldMessage.borderStyle = UITextBorderStyleNone;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateUI:) name:@"UpdateGroupDetails" object:nil];
    
}

-(void)registerNibForCustomCell{
    
    UINib *GroupSelfMessageCell=[UINib nibWithNibName:@"GroupSelfMessageCell" bundle:nil];
    [tblView registerNib:GroupSelfMessageCell forCellReuseIdentifier:@"GroupSelfMessageCell"];
    
    UINib *GroupPartnerCell=[UINib nibWithNibName:@"GroupPartnerCell" bundle:nil];
    [tblView registerNib:GroupPartnerCell forCellReuseIdentifier:@"GroupPartnerCell"];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self UpdateUI:nil];
    
    [Temp setOnGroupChat:YES];
}

-(void)UpdateUI: (NSNotification*) notification{
    
    chatMessageArray = [[NSMutableArray alloc] init];
    
    [RestClient getGroupMessages:[Temp groupData].id callback:^(bool result, NSDictionary *data) {
        if(!result)
            return;
        
        chatMessageArray = [[NSMutableArray alloc] init];
        
        NSArray *arMessages = [data objectForKey:@"messages"];
        for(int i = 0; i < arMessages.count; i++)
        {
            NSDictionary* dictMessage = [arMessages objectAtIndex:i];
            
            GetGood_Message* message = [[GetGood_Message alloc] initWithDictionary:dictMessage];
            
            [chatMessageArray addObject:message];
        }
        
        [tblView reloadData];
        
        if(chatMessageArray.count != 0)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:chatMessageArray.count - 1 inSection:0];
            [tblView scrollToRowAtIndexPath:indexPath                                    atScrollPosition:UITableViewScrollPositionBottom
                                     animated:NO];
        }
        
    }];
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
    return chatMessageArray.count;
}

-(UITableViewCell *) tableView:(UITableView *) theTableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    GetGood_Message *message = [chatMessageArray objectAtIndex:indexPath.row];
    
        GroupSelfMessageCell *cell = (GroupSelfMessageCell *)[tblView dequeueReusableCellWithIdentifier:@"GroupSelfMessageCell"];
        
        cell.imageUser.layer.cornerRadius = cell.imageUser.frame.size.width / 2;
        cell.imageUser.clipsToBounds = YES;
        cell.labelMessageView.text = message.message;
        cell.labelName.text = message.name;
        
        if (message.timestamp == nil ) {
            
            cell.labelDateView.text = @"";
            
        }else{
            NSString *date = [Temp getDateFromTimeInterval:message.timestamp  dateFormat:@"dd MMM yyyy HH:mm:ss"];
            cell.labelDateView.text = date;
        }
    
        return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
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

    
    const int movementDistance = -130; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)actionSubmit:(UITapGestureRecognizer *)tapGesture
{
    if(textFieldMessage.text.length == 0)
    {
        return;
    }
    
    [RestClient sendMessage:[Temp groupData].id message:textFieldMessage.text type:@"10" callback:^(bool result, NSDictionary *data) {
        
        GetGood_Message* message = [[GetGood_Message alloc] initWithDictionary:[data objectForKey:@"message"]];
        
        
        [chatMessageArray addObject:message];
        
        NSArray* arUsers = [[Temp groupData].users componentsSeparatedByString:@":"];
        for(int i = 0; i < arUsers.count; i++)
        {
            NSString* strUserID = [arUsers objectAtIndex:i];
            
            if(!strUserID.length)
            {
                continue;
            }
            if([strUserID isEqualToString:[AppData profile].id])
            {
                continue;
            }
            
            [RestClient sendNotification:[NSString stringWithFormat:@"%@ sent you a message.", [AppData profile].name] user_id:strUserID];
        }
        
        if(![[Temp groupData].owner_id isEqualToString:[AppData profile].id])
        {
            [RestClient sendNotification:[NSString stringWithFormat:@"%@ sent you a message.", [AppData profile].name] user_id:[Temp groupData].owner_id];
        }
        [tblView reloadData];
        
        if(chatMessageArray.count != 0)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:chatMessageArray.count - 1 inSection:0];
            [tblView scrollToRowAtIndexPath:indexPath                                    atScrollPosition:UITableViewScrollPositionBottom
                                     animated:NO];
        }
        
    }];
    [textFieldMessage setText:@""];
}

-(void)GetChatFromFireBase{
    
    chatMessageArray = [[NSMutableArray alloc] init];
    
    [[[[mDatabase child:@"group"] child:TempGroup.id] child:@"msg"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
      
         for ( FIRDataSnapshot *child in snapshot.children )
         {
             NSLog(@"value = %@",child.value);
             
             GroupChatMessage *message = [[GroupChatMessage alloc] initWithDictionary:child.value];
             [chatMessageArray addObject:message];
             
         }
        
        [tblView reloadData];
        if(chatMessageArray.count == 0)
        {
            return ;
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:chatMessageArray.count - 1 inSection:0];
        [tblView scrollToRowAtIndexPath:indexPath                                    atScrollPosition:UITableViewScrollPositionBottom
                                 animated:NO];
         
     }];

}


@end
