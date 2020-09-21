//
//  ForumListVC.m
//  getgood
//
//  Created by Bhargav Mistri on 26/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "ForumListVC.h"
#import "CreateThreadVC.h"
#import "ForumCell.h"
#import "ForumTopicCell.h"
#import "AdminPost.h"
#import "ForumDetailVC.h"
#import "Thread.h"
#import "UIImageView+WebCache.h"
#import "AppData.h"
#import "CommentVC.h"
#import "UIToolbar+KeyboardAdditions.h"

@import Firebase;
@import FirebaseDatabase;

@interface ForumListVC ()
@end
@implementation ForumListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionBack:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.imageBack addGestureRecognizer:tapGestureRecognizer];
    self.imageBack.userInteractionEnabled = YES;

    UIToolbar *toolbar = [UIToolbar doneToolbarWithTarget:self action:@selector(didPressKeyboardDoneButton:)];
    self.txtSearch.inputAccessoryView = toolbar;
    [self.txtSearch setReturnKeyType:UIReturnKeyDone];
    
    [self registerNibForCustomCell];    
    [self.txtSearch addTarget:self
                  action:@selector(textFieldDidEndEditing:)
        forControlEvents:UIControlEventEditingDidEnd];

}

- (void) loadData
{
    [RestClient getThreadList:self.nPage keyword:self.strKeyword callback:^(bool result, NSDictionary *data) {
        
        if(!result)
            return ;
        
        self.bLoading = NO;
        
        

        NSArray* arJSONThreads = [data objectForKey:@"threads"];
        
        if(arJSONThreads.count == 0)
        {
            self.bFinish = NO;
            return;
        }
        
        for(int i = 0; i < arJSONThreads.count; i++)
        {
            GetGood_Thread* posts = [[GetGood_Thread alloc] initWithDictionary:[arJSONThreads objectAtIndex:i]];
            
            [arrComment addObject:posts];
        }
        
        [self.tblView reloadData];
    }];
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didPressKeyboardDoneButton:(id)sender
{
    [self.view endEditing:YES];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    self.strKeyword = textField.text;
    
    arrComment  = [[NSMutableArray alloc] init];
    self.bLoading = NO;
    self.bFinish = NO;
    self.nPage = 0;
    
    [self loadData];
    
    return NO;
}

-(void)textFieldDidEndEditing:(UITextField*)textField
{
    self.strKeyword = textField.text;
    
    arrComment  = [[NSMutableArray alloc] init];
    self.bLoading = NO;
    self.bFinish = NO;
    self.nPage = 0;
    
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    
    arrAdminPost = [[NSMutableArray alloc] init];
    arrComment  = [[NSMutableArray alloc] init];
    
    self.strKeyword = @"";
    [RestClient getAdminPost:^(bool result, NSDictionary *data) {
        if(!result)
            return ;
        
        NSArray* arJSONPosts = [data objectForKey:@"posts"];
        
        for(int i = 0; i < arJSONPosts.count; i++)
        {
            GetGood_AdminPost* posts = [[GetGood_AdminPost alloc] initWithDictionary:[arJSONPosts objectAtIndex:i]];
            
            [arrAdminPost addObject:posts];
        }
        
        [self.tblView reloadData];
    }];
    
    self.nPage = 0;
    self.bLoading = NO;
    self.bFinish = NO;
    
    [self loadData];
}

- (void)actionBack:(UITapGestureRecognizer *)tapGesture
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnAddThreadClick:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    CreateThreadVC *controller = [storyboard instantiateViewControllerWithIdentifier:@"CreateThreadVC"];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)registerNibForCustomCell{
    
    UINib *ForumCell=[UINib nibWithNibName:@"ForumCell" bundle:nil];
    [self.tblView registerNib:ForumCell forCellReuseIdentifier:@"ForumCell"];
    
    UINib *ForumTopicCell=[UINib nibWithNibName:@"ForumTopicCell" bundle:nil];
    [self.tblView registerNib:ForumTopicCell forCellReuseIdentifier:@"ForumTopicCell"];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return arrAdminPost.count;
        
    }else{
        
        return arrComment.count;
    }
    
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
         return 40.0f;
        
    }else{
        
         return 60.0f;
    }
    
    return 40.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        static NSString *simpleTableIdentifier = @"ForumCell";
        ForumCell *cell = (ForumCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        GetGood_AdminPost *objAdminPost = [arrAdminPost objectAtIndex:indexPath.row];
        
        cell.lblTitle.text = objAdminPost.title;
        cell.selectionStyle = NO;
        
        return cell;
        
    }else{
        
        static NSString *simpleTableIdentifier = @"ForumTopicCell";
        ForumTopicCell *cell = (ForumTopicCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        GetGood_Thread *objThread = [arrComment objectAtIndex:indexPath.row];
        
        cell.lblUserName.text = objThread.name;
        cell.lblTopic.text = objThread.title;
    
        cell.imgLogo.layer.cornerRadius = cell.imgLogo.frame.size.width /2;
        cell.imgLogo.clipsToBounds = YES;
        
        NSString *strImg = [NSString stringWithFormat:@"%@",objThread.avatar_url];
        [cell.imgLogo sd_setImageWithURL:[NSURL URLWithString:strImg]
                                placeholderImage:[UIImage imageNamed:strImg]
                                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             cell.imgLogo.image = image;
             
         }];
        cell.selectionStyle = NO;
        return cell;
    
    }
    
    return nil;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return;
    
    if (indexPath.row == arrComment.count-1)  {
        if(self.bFinish == YES)
            return;
        
        if(self.bLoading == YES)
            return;
        
        self.bLoading = YES;
        
        self.nPage ++;
        [self loadData];
        
        return;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        GetGood_AdminPost *objAdminPost = [arrAdminPost objectAtIndex:indexPath.row];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ForumDetailVC *controller = [storyboard instantiateViewControllerWithIdentifier:@"ForumDetailVC"];
        controller.Description = objAdminPost.post;
        [self.navigationController pushViewController:controller animated:YES];
        
    }else{
        
        GetGood_Thread *objThread = [arrComment objectAtIndex:indexPath.row];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        CommentVC *controller = [storyboard instantiateViewControllerWithIdentifier:@"CommentVC"];
        controller.ObjThread = objThread;
        [self.navigationController pushViewController:controller animated:YES];
    
    }
    
}
@end
