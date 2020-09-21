//
//  CommentVC.m
//  getgood
//
//  Created by Bhargav Mistri on 27/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "CommentVC.h"
#import "AddCommentVC.h"
#import "CommentCell.h"
#import "Comment.h"
#import "Temp.h"

@import Firebase;
@import FirebaseDatabase;

@interface CommentVC ()
@end

@implementation CommentVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.tblView setDelegate:self];
    [self.tblView setDataSource:self];
    
    [Temp setThreadData:self.ObjThread];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.lblTitle.text = self.ObjThread.title;
    [self registerNibForCustomCell];
    
    CGSize labelSize = CGSizeMake(self.view.frame.size.width - 16, FLT_MAX);
    CGSize size = [self.ObjThread.getgood_description sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:labelSize lineBreakMode:NSLineBreakByWordWrapping];
    self.constantHeight.constant = size.height;
    [self.lblDescription setText:self.ObjThread.getgood_description];
    
    [self.view layoutSubviews];
    arrComment = [[NSMutableArray alloc] init];

    [RestClient getCommentList:self.ObjThread.id reference:@"" callback:^(bool result, NSDictionary *data) {
        if(!result)
            return ;
        
        NSArray* arComments = [data objectForKey:@"comments"];
        
        for(int i = 0; i < arComments.count; i++)
        {
            GetGood_Comment* comment = [[GetGood_Comment alloc] initWithDictionary:[arComments objectAtIndex:i]];
            
            [arrComment addObject:comment];
            
        }
        
        [self.tblView reloadData];
        
        for(int i = 0; i < arrComment.count; i++)
        {
            GetGood_Comment* comment = [arrComment objectAtIndex:i];
            [RestClient getCommentList:@"" reference:comment.id callback:^(bool result, NSDictionary *data) {
                if(self == nil)
                    return;
                
                NSArray* arComments = [data objectForKey:@"comments"];
                
                NSMutableArray* arTemp = [[NSMutableArray alloc] init];
                comment.replies = [[NSMutableArray alloc] init];
                for(int i = 0; i < arComments.count; i++)
                {
                    GetGood_Comment* comment = [[GetGood_Comment alloc] initWithDictionary:[arComments objectAtIndex:i]];
                    
                    [arTemp addObject: comment];
                    
                }
                
                if(arTemp.count == 0)
                    return;
                
                
                if(arTemp.count == comment.replies.count)
                    return;
                
                comment.replies = arTemp;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.tblView reloadData];
                });
                
            }];
        }
    }];
}

-(void)registerNibForCustomCell{
    
    UINib *CommentCell1=[UINib nibWithNibName:@"CommentReply" bundle:nil];
    [self.tblView registerNib:CommentCell1 forCellReuseIdentifier:@"CommentReply"];
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrComment.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    GetGood_Comment *objComment =[arrComment objectAtIndex:section];

    return [objComment.replies count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView *cell1 = [[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil] objectAtIndex:0];
    
    CommentCell* cell = (CommentCell*) cell1;
    
    GetGood_Comment *objComment =[arrComment objectAtIndex:section];
    
    cell.lblComment.text = objComment.comment;
    [cell.lblComment sizeToFit];
    cell.selectionStyle = NO;
    
    cell.lblName.text = objComment.name;
    
    cell.imgLogo.layer.cornerRadius = cell.imgLogo.frame.size.width / 2;
    cell.imgLogo.clipsToBounds = YES;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(like:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [cell.vLike addGestureRecognizer:tapGestureRecognizer];
    cell.vLike.userInteractionEnabled = YES;
    tapGestureRecognizer.view.tag = section;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dislike:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [cell.vDislike addGestureRecognizer:tapGestureRecognizer];
    cell.vDislike.userInteractionEnabled = YES;
    tapGestureRecognizer.view.tag = section;
    
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reply:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [cell.vReply addGestureRecognizer:tapGestureRecognizer];
    cell.vReply.userInteractionEnabled = YES;
    tapGestureRecognizer.view.tag = section;
    
    [cell.likePanel setHidden:YES];

    [cell.imgLogo sd_setImageWithURL:[NSURL URLWithString:objComment.avatar_url]];

    [RestClient getLikes:objComment.id callback:^(bool result, NSDictionary *data) {
        if(!result)
            return ;
        
        if(![objComment.owner_id isEqualToString:[AppData profile].id])
        {
            [cell.likePanel setHidden:NO];
        }
        
        
        int nCount = 0;
        
        BOOL bContains = NO;
        BOOL bLiked = NO;
        NSArray* arTemp = [data objectForKey:@"likes"];
        for(int i = 0; i < arTemp.count; i++)
        {
            GetGood_Like* like = [[GetGood_Like alloc] initWithDictionary:[arTemp objectAtIndex:i]];
            
            if([like.data isEqualToString:@"1"])
            {
                nCount ++;
            }
            else
            {
                nCount --;
            }
            
            if([like.user_id isEqualToString:[AppData profile].id])
            {
                bContains = YES;
                bLiked = YES;
            }
        }
        
        [cell.tvLikeCount setText:[NSString stringWithFormat:@"%d", nCount]];
        [cell.tvDislikeCount setText:[NSString stringWithFormat:@"%d", nCount]];
        
        if(nCount > 0)
        {
            cell.likeWidth.constant = 45;
            cell.dislikeWidth.constant = 0;
        }
        else if(nCount < 0)
        {
            cell.likeWidth.constant = 0;
            cell.dislikeWidth.constant = 45;
        }
        else
        {
            cell.likeWidth.constant = 0;
            cell.dislikeWidth.constant = 0;
        }
        
        if(bContains)
        {
            if(bLiked)
            {
                cell.likeButtonWidth.constant = 0;
                cell.dislikeButtonWidth.constant = 30;
            }
            else
            {
                cell.likeButtonWidth.constant = 30;
                cell.dislikeButtonWidth.constant = 0;
            }
        }
        
        if([objComment.owner_id isEqualToString:[AppData profile].id])
        {
            [cell.likePanel setHidden:YES];
        }
        else
        {
            [cell.likePanel setHidden:NO];
        }
        
    }];
    
//    [[[ref child:@"profile"] child:userId]
//     observeSingleEventOfType:FIRDataEventTypeValue
//     withBlock:^(FIRDataSnapshot *_Nonnull snapshot)
//     {
//         UserProfile *userProfile = [[UserProfile alloc] initWithDictionary:snapshot.value];
//
//         NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", userProfile.avatarUrl]];
//
//         NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//             if (data) {
//                 UIImage *image = [UIImage imageWithData:data];
//                 if (image) {
//                     dispatch_async(dispatch_get_main_queue(), ^
//                                    {
//                                        cell.imgLogo.image = image;
//                                    });
//                 }
//             }
//         }];
//
//         [task resume];
//
//     }];
//
//    [Like loadLikes:objComment.ID callback:^(NSMutableArray *arLikes) {
//        int nCount = 0;
//
//        BOOL bContains = NO;
//        BOOL bLiked = NO;
//
//        for(int i = 0 ; i < arLikes.count; i++)
//        {
//            Like *like = [arLikes objectAtIndex:i];
//
//            if([like.Like boolValue])
//            {
//                nCount ++;
//            }
//            else
//            {
//                nCount --;
//            }
//
//            if([like.UserID isEqualToString:[AppData userProfile].userId])
//            {
//                bContains = YES;
//                bLiked = [like.Like boolValue];
//            }
//        }
//
//        [cell.tvLikeCount setText:[NSString stringWithFormat:@"%d", nCount]];
//        [cell.tvDislikeCount setText:[NSString stringWithFormat:@"%d", nCount]];
//
//        if(nCount > 0)
//        {
//            cell.likeWidth.constant = 45;
//            cell.dislikeWidth.constant = 0;
//        }
//        else if(nCount < 0)
//        {
//            cell.likeWidth.constant = 0;
//            cell.dislikeWidth.constant = 45;
//        }
//        else
//        {
//            cell.likeWidth.constant = 0;
//            cell.dislikeWidth.constant = 0;
//        }
//
//        if(bContains)
//        {
//            if(bLiked)
//            {
//                cell.likeButtonWidth.constant = 0;
//                cell.dislikeButtonWidth.constant = 30;
//            }
//            else
//            {
//                cell.likeButtonWidth.constant = 30;
//                cell.dislikeButtonWidth.constant = 0;
//            }
//        }
//
//        if([objComment.UserID isEqualToString:[AppData userProfile].userId])
//        {
//            [cell.likePanel setHidden:YES];
//        }
//        else
//        {
//            [cell.likePanel setHidden:NO];
//        }
//    }];
    return cell;
    
}

- (void)like:(UITapGestureRecognizer *)recognizer
{
    GetGood_Comment *comment = [arrComment objectAtIndex:recognizer.view.tag];

    [RestClient addLike:comment.id like:@"1" callback:^(bool result, NSDictionary *data) {
        if(!result)
            return ;
        
        [self.tblView reloadData];
    }];
}
- (void)reply:(UITapGestureRecognizer *)recognizer
{
    GetGood_Comment *comment = [arrComment objectAtIndex:recognizer.view.tag];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    AddCommentVC *controller = [storyboard instantiateViewControllerWithIdentifier:@"AddCommentVC"];
    controller.Reference = comment.id;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)dislike:(UITapGestureRecognizer *)recognizer
{
    GetGood_Comment *comment = [arrComment objectAtIndex:recognizer.view.tag];
    
    [RestClient addLike:comment.id like:@"0" callback:^(bool result, NSDictionary *data) {
        if(!result)
            return ;
        
        [self.tblView reloadData];
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"CommentReply";
    CommentReply *cell = (CommentReply *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    GetGood_Comment *objComment =[arrComment objectAtIndex:[indexPath section]];
    GetGood_Comment* replyComment= [[objComment replies] objectAtIndex:[indexPath row]];
    
    
    [cell.lblTopic setText:replyComment.comment];
    
    cell.imgLogo.layer.cornerRadius = cell.imgLogo.frame.size.width / 2;
    cell.imgLogo.clipsToBounds = YES;
    
    [cell.lblUserName setText:replyComment.name];
    [cell.imgLogo sd_setImageWithURL:[NSURL URLWithString:replyComment.avatar_url]];

    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize labelSize = CGSizeMake(tableView.frame.size.width - 145, FLT_MAX);
    GetGood_Comment *objComment =[arrComment objectAtIndex:indexPath.section];
    GetGood_Comment *replyComment =[objComment.replies objectAtIndex:indexPath.row];
    
    CGSize size = [replyComment.comment sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:labelSize lineBreakMode:NSLineBreakByWordWrapping];
    
    return 40.0f + size.height;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGSize labelSize = CGSizeMake(tableView.frame.size.width - 98, FLT_MAX);
    GetGood_Comment *objComment =[arrComment objectAtIndex:section];

    CGSize size = [objComment.comment sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:labelSize lineBreakMode:NSLineBreakByWordWrapping];
    
    return  (size.height + 70.0f);
}


- (IBAction)btnAddCommentClick:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    AddCommentVC *controller = [storyboard instantiateViewControllerWithIdentifier:@"AddCommentVC"];
    [self.navigationController pushViewController:controller animated:YES];
    
}

@end
