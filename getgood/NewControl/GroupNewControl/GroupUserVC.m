//
//  GroupUserVC.m
//  getgood
//
//  Created by Bhargav Mistri on 28/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "GroupUserVC.h"
#import "GroupUserProfileCell.h"
#import "AppData.h"
#import "UIView+Borders.h"
#import "GroupRateViewController.h"

@import Firebase;
@import FirebaseDatabase;

@interface GroupUserVC (){
    
    NSMutableArray *ArrUserProfile;
    
}

@end

@implementation GroupUserVC
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
    
    [self UpdateUI:nil];    
    
    [Temp setOnGroupChat:NO];
}

-(void)UpdateUI: (NSNotification*) notification
{
    ArrUserProfile = [[NSMutableArray alloc] init];

    [RestClient getUsersWithIDs:parentVC.ObjGroup.users callback:^(bool result, NSDictionary *data) {
        if(!result)
            return;
        
        ArrUserProfile = [[NSMutableArray alloc] init];
        
        NSArray *arUsers = [data objectForKey:@"users"];
        for(int i = 0; i < arUsers.count; i++)
        {
            NSDictionary* dictUser = [arUsers objectAtIndex:i];
            
            User* user = [[User alloc] initWithDictionary:dictUser];
            
            [ArrUserProfile addObject:user];
        }
        
        [ArrUserProfile addObject:Temp.groupData.owner];
        [tblView reloadData];
    }];
}

-(void)registerNibForCustomCell{
    
    UINib *GroupUserCell=[UINib nibWithNibName:@"GroupUserProfileCell" bundle:nil];
    [tblView registerNib:GroupUserCell forCellReuseIdentifier:@"GroupUserProfileCell"];
}
-(NSInteger) tableView:(UITableView *) theTableView numberOfRowsInSection:(NSInteger) section
{
    return ArrUserProfile.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 168.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"GroupUserProfileCell";
    GroupUserProfileCell *cell = (GroupUserProfileCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    User *ObjProfile = [ArrUserProfile objectAtIndex:indexPath.row];
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
            
            for(int j = i ; j < 5 ; ++j)
            {
                switch (j)
                {
                    case 0:
                        [cell.HeroImage1  setHidden:YES];
                        break;
                    case 1:
                        [cell.HeroImage2  setHidden:YES];
                        break;
                    case 2:
                        [cell.HeroImage3  setHidden:YES];
                        break;
                    case 3:
                        [cell.HeroImage4  setHidden:YES];
                        break;
                    case 4:
                        [cell.HeroImage5  setHidden:YES];
                        break;
                        
                    default:
                        break;
                }
            }
        }
        
        cell.PlayerRating.value = ObjProfile.player_rating;
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
            
            for(int j = i ; j < 5 ; ++j)
            {
                switch (j)
                {
                    case 0:
                        [cell.HeroImage1  setHidden:YES];
                        break;
                    case 1:
                        [cell.HeroImage2  setHidden:YES];
                        break;
                    case 2:
                        [cell.HeroImage3  setHidden:YES];
                        break;
                    case 3:
                        [cell.HeroImage4  setHidden:YES];
                        break;
                    case 4:
                        [cell.HeroImage5  setHidden:YES];
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
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", ObjProfile.avatar_url]];
    [cell.ImageLogo addBottomBorderWithHeight:3.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
    [cell.ImageLogo sd_setImageWithURL:url];
    
    if([[Temp groupData].owner.id isEqualToString:[AppData profile].id])
    {
        if([ObjProfile.id isEqualToString:[AppData profile].id])
        {
            [cell.lblKick setHidden:YES];
        }
        else
        {
            [cell.lblKick setHidden:NO];
        }
    }
    else
    {
        [cell.lblKick setHidden:YES];
    }
    
    if([ObjProfile.id isEqualToString:[AppData profile].id])
    {
        [cell.lblRateUser setHidden:YES];
    }
    else
    {
        [cell.lblRateUser setHighlighted:NO];
    }
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kick:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [cell.lblKick addGestureRecognizer:tapGestureRecognizer];
    cell.lblKick.userInteractionEnabled = YES;
    tapGestureRecognizer.view.tag = indexPath.row;
    
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rateUser:)];
    tapGestureRecognizer1.numberOfTapsRequired = 1;
    [cell.lblRateUser addGestureRecognizer:tapGestureRecognizer1];
    cell.lblRateUser.userInteractionEnabled = YES;
    tapGestureRecognizer1.view.tag = indexPath.row;
    
    

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)kick:(UITapGestureRecognizer *)recognizer
{
    
    User *profile = [ArrUserProfile objectAtIndex:recognizer.view.tag];
    
    GetGood_Group *objGroup = [Temp groupData];
    
    [RestClient kick:objGroup.id user:profile.id callback:^(bool result, NSDictionary *data) {
        if(!result)
            return ;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateGroupDetails" object:nil];
        [RestClient sendNotification:[NSString stringWithFormat:@"%@ kicked you.", [AppData profile].name] user_id:profile.id];
        
        [parentVC checkRole];
    }];
}

- (void)rateUser:(UITapGestureRecognizer *)recognizer
{
    User *profile = [ArrUserProfile objectAtIndex:recognizer.view.tag];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    GroupRateViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"GroupRateViewController"];
    controller.profile = profile;
    [self.parentVC.navigationController pushViewController:controller animated:YES];
}



@end
