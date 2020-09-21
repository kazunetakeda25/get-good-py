//
//  GroupPendingVC.m
//  getgood
//
//  Created by Bhargav Mistri on 28/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "GroupPendingVC.h"
#import "GroupPendingCell.h"
#import "Temp.h"
#import "UIView+Borders.h"
@import Firebase;
@import FirebaseDatabase;

@interface GroupPendingVC (){
    
    NSMutableArray *ArrPending;
}

@end
@implementation GroupPendingVC
@synthesize parentVC;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self registerNibForCustomCell];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateUI:) name:@"UpdateGroupDetails" object:nil];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self UpdateUI: nil];
    
    [Temp setOnGroupChat:NO];
}

-(void)UpdateUI: (NSNotification*) notification{
    
    ArrPending = [[NSMutableArray alloc] init];
    
    [RestClient getUsersWithIDs:parentVC.ObjGroup.pending_users callback:^(bool result, NSDictionary *data) {
        if(!result)
            return;
        
        ArrPending = [[NSMutableArray alloc] init];
        
        NSArray *arUsers = [data objectForKey:@"users"];
        for(int i = 0; i < arUsers.count; i++)
        {
            NSDictionary* dictUser = [arUsers objectAtIndex:i];
            
            User* user = [[User alloc] initWithDictionary:dictUser];
            
            [ArrPending addObject:user];
        }
        
        [tblView reloadData];
    }];
}

-(void)registerNibForCustomCell{
    
    UINib *GroupUserCell=[UINib nibWithNibName:@"GroupPendingCell" bundle:nil];
    [tblView registerNib:GroupUserCell forCellReuseIdentifier:@"GroupPendingCell"];
}

-(NSInteger) tableView:(UITableView *) theTableView numberOfRowsInSection:(NSInteger) section
{
    return ArrPending.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 162.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"GroupPendingCell";
    GroupPendingCell *cell = (GroupPendingCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    User *ObjProfile = [ArrPending objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", ObjProfile.avatar_url]];
    [cell.ImageLogo sd_setImageWithURL:url];
    cell.lblName.text = ObjProfile.name;
    
    if([Temp getGameMode] == Overwatch)
    {
        cell.lblGroupID.text = ObjProfile.blizzard_id;
        cell.lblServerName.text = @"";
        [cell.ivPlatform setImage:nil];
        
        if(ObjProfile.server.length)
        {
            if([ObjProfile.server containsString:@"us"])
            {
                cell.lblServerName.text = @"Americas";
            }
            else if([ObjProfile.server containsString:@"eu"])
            {
                cell.lblServerName.text = @"Europe";
            }
            else if([ObjProfile.server containsString:@"kr"])
            {
                cell.lblServerName.text = @"Asia";
            }
            if([ObjProfile.server containsString:@"pc"])
            {
                [cell.ivPlatform setImage:[UIImage imageNamed:@"pc"]];
            }
            else if([ObjProfile.server containsString:@"xbox"])
            {
                [cell.ivPlatform setImage:[UIImage imageNamed:@"xbox"]];
            }
            else if([ObjProfile.server containsString:@"ps4"])
            {
                [cell.ivPlatform setImage:[UIImage imageNamed:@"ps4"]];
            }
        }
        
        
        if(ObjProfile.overwatch_heroes.length)
        {
            NSArray* arHr = [ObjProfile.overwatch_heroes componentsSeparatedByString: @" "];
            
            int i = 0;
            
            [cell.HeroImage1 setImage:[UIImage imageNamed:@""]];
            [cell.HeroImage2 setImage:[UIImage imageNamed:@""]];
            [cell.HeroImage3 setImage:[UIImage imageNamed:@""]];
            [cell.HeroImage4 setImage:[UIImage imageNamed:@""]];
            [cell.HeroImage5 setImage:[UIImage imageNamed:@""]];
            
            for(i = 0; i < [arHr count] ; ++i)
            {
                switch (i)
                {
                    case 0:
                        [cell.HeroImage1 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 1:
                        [cell.HeroImage2 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 2:
                        [cell.HeroImage3 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 3:
                        [cell.HeroImage4 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 4:
                        [cell.HeroImage5 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                        
                    default:
                        break;
                }
            }
            
        }
        
        cell.PlayerRating.value = ObjProfile.overwatch_rank;
        [cell.ivRank setImage: nil];
        
        [cell.ivRank setImage:[UIImage imageNamed:[Utils getRankAvatar:ObjProfile.overwatch_rank]]];
        
        if(ObjProfile.overwatch_rank != 0)
        {
            cell.lblRanking.text = [NSString stringWithFormat:@"%d", ObjProfile.overwatch_rank];
        }
        else
        {
            cell.lblRanking.text = @"";
        }
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        cell.lblGroupID.text = ObjProfile.lol_id;
        cell.lblServerName.text = @"";
        [cell.ivPlatform setImage:[UIImage imageNamed:@"pc"]];
        [cell.lblServerName setText:[Utils getLolServerName:ObjProfile.lol_server]];
        
        if(ObjProfile.lol_heroes.length)
        {
            NSArray* arHr = [ObjProfile.lol_heroes componentsSeparatedByString: @" "];
            
            int i = 0;
            
            [cell.HeroImage1 setImage:[UIImage imageNamed:@""]];
            [cell.HeroImage2 setImage:[UIImage imageNamed:@""]];
            [cell.HeroImage3 setImage:[UIImage imageNamed:@""]];
            [cell.HeroImage4 setImage:[UIImage imageNamed:@""]];
            [cell.HeroImage5 setImage:[UIImage imageNamed:@""]];
            
            for(i = 0; i < [arHr count] ; ++i)
            {
                switch (i)
                {
                    case 0:
                        [cell.HeroImage1 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 1:
                        [cell.HeroImage2 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 2:
                        [cell.HeroImage3 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 3:
                        [cell.HeroImage4 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 4:
                        [cell.HeroImage5 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                        
                    default:
                        break;
                }
            }
            
        }
        
        cell.PlayerRating.value = ObjProfile.lol_player_rating;
        
        [cell.ivRank setImage: nil];
        [cell.ivRank setImage:[UIImage imageNamed:[Utils getLolRankAvatar:ObjProfile.lol_rank]]];
        
        if(ObjProfile.lol_rank.length)
        {
            cell.lblRanking.text = ObjProfile.lol_rank;
        }
        else
        {
            cell.lblRanking.text = @"";
        }
    }
    

     //cell.PlayerRating.value = [ObjGroup.profile. floatValue];
    
    
   UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
   tapGestureRecognizer.numberOfTapsRequired = 1;
   [cell.lblAccept addGestureRecognizer:tapGestureRecognizer];
   cell.lblAccept.userInteractionEnabled = YES;
   tapGestureRecognizer.view.tag = indexPath.row;
    
    if([[Temp groupData].owner_id isEqualToString:[AppData profile].id])
    {
        [cell.lblAccept setHidden:NO];
    }
    else
    {
        [cell.lblAccept setHidden:YES];
    }
    
    [cell.ImageLogo addBottomBorderWithHeight:3.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];


    cell.selectionStyle = UITableViewCellSelectionStyleNone;

//    [cell.backView addTopBorderWithHeight:1.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
//    [cell.backView addLeftBorderWithWidth:1.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
//    [cell.backView addRightBorderWithWidth:1.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
//    [cell.backView addBottomBorderWithHeight:3.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
//    [cell layoutSubviews];
//    [cell layoutIfNeeded];
//    [cell.backView layoutIfNeeded];
   return cell;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [UIKit showLoading];
    GetGood_Group *objGroup = [Temp groupData];
    User *profile = [ArrPending objectAtIndex:recognizer.view.tag];
    
    [RestClient joinUserGroup:objGroup.id user:profile.id callback:^(bool result, NSDictionary *data) {
        
        [UIKit dismissDialog];
        if(!result)
            return ;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateGroupDetails" object:nil];
        [RestClient sendNotification:[NSString stringWithFormat:@"%@ accepted you.", [AppData profile].name] user_id:profile.id];
        
        [parentVC checkRole];
    }];
}

@end
