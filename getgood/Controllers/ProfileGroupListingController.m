//
//  ProfileGroupListingController.m
//  getgood
//
//  Created by Md Aminuzzaman on 25/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

@import Firebase;
@import FirebaseDatabase;

#import "Utils.h"
#import "AppData.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "ProfileGroupListingController.h"

@interface ProfileGroupListingController ()
{
    NSMutableArray *arrGroup;
}

@end

@implementation ProfileGroupListingController
@synthesize strUserID;

- (void)viewDidLoad
{
    [super viewDidLoad];
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    arrGroup = [[NSMutableArray alloc] init];
    if(strUserID == nil)
    {
        strUserID = [AppData profile].id;
    }
    
    
    [RestClient getGroupsWithUserID:strUserID callback:^(bool result, NSDictionary *data) {
        arrGroup = [[NSMutableArray alloc] init];
        NSArray* arTemp = [data objectForKey:@"groups"];
        
        for(int i = 0; i < arTemp.count; i++)
        {
            GetGood_Group* group = [[GetGood_Group alloc] initWithDictionary:[arTemp objectAtIndex:i]];
            
            [arrGroup addObject:group];
        }
        
        [collectionView reloadData];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrGroup.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileGroupListingCell *cell = (ProfileGroupListingCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileGroupListingCell" forIndexPath:indexPath];
    
    GetGood_Group *group = [arrGroup objectAtIndex:indexPath.row];
    
    cell.labelPlayerJoined.text = [NSString stringWithFormat:@"%d Player(s) Joined", [Utils getOccurence:group.users]];
    
    
    if([Temp getGameMode] == Overwatch)
    {
        if(group.average_game_rating != 0)
        {
            [cell.imageAverageRank setHidden:NO];
            [cell.imageAverageRank setImage: [UIImage imageNamed:[Utils getRankAvatar:group.average_game_rating ]]];
            cell.labelAverageGameRating.text = [NSString stringWithFormat:@"%d",group.average_game_rating];
        }
        else
        {
            [cell.imageAverageRank setHidden:YES];
            cell.labelAverageGameRating.text = @"---";
        }
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        if(group.average_game_rating != 0)
        {
            [cell.imageAverageRank setHidden:NO];
            [cell.imageAverageRank setImage: [UIImage imageNamed:[Utils getLolRankAvatar:
                                                               [[DataArrays lolRanks] objectAtIndex:group.average_game_rating]]]];
            cell.labelAverageGameRating.text = [NSString stringWithFormat:@"%@",[[DataArrays lolRanks] objectAtIndex:group.average_game_rating]];
        }
        else
        {
            [cell.imageAverageRank setHidden:YES];
            cell.labelAverageGameRating.text = @"---";
        }
    }
    
    cell.labelTitle.text = group.title;
    cell.labelLeaderView.text = [NSString stringWithFormat:@"%@",group.owner.name];
    
    [cell.ratingPlayerView setValue:group.average_player_rating];
    
    int k = 0;
    if(indexPath.item == 1)
    {
        k++;
    }
    if(group.hero != nil)
    {
        NSArray* arHr = [group.hero componentsSeparatedByString:@" "];
        
        if(indexPath.item == 1 && [arHr count] != 4)
        {
            k++;
        }
        int i = 0;
        if([Temp getGameMode] == Overwatch)
        {

            for(i = 0; i < 5 ; i++)
            {
                switch (i)
                {
                    case 0:
                        if (i >= arHr.count)
                            [cell.imageHeroOne setImage:nil];
                        else
                            [cell.imageHeroOne setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 1:
                        if (i >= arHr.count)
                            [cell.imageHeroTwo setImage:nil];
                        else
                            [cell.imageHeroTwo setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 2:
                        if (i >= arHr.count)
                            [cell.imageHeroThree setImage:nil];
                        else
                            [cell.imageHeroThree setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 3:
                        if (i >= arHr.count)
                            [cell.imageHeroFour setImage:nil];
                        else
                            [cell.imageHeroFour setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 4:
                        if (i >= arHr.count)
                            [cell.imageHeroFive setImage:nil];
                        else
                            [cell.imageHeroFive setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                        
                    default:
                        break;
                }
            }
            
            
            cell.labelServerView.text = @"";
            [cell.ivPlatform setImage:nil];
            
            if(group.owner.server.length)
            {
                if([group.owner.server containsString:@"us"])
                {
                    cell.labelServerView.text = @"Americas";
                }
                else if([group.owner.server containsString:@"eu"])
                {
                    cell.labelServerView.text = @"Europe";
                }
                else if([group.owner.server containsString:@"kr"])
                {
                    cell.labelServerView.text = @"Asia";
                }
                if([group.owner.server containsString:@"pc"])
                {
                    [cell.ivPlatform setImage:[UIImage imageNamed:@"pc"]];
                }
                else if([group.owner.server containsString:@"xbox"])
                {
                    [cell.ivPlatform setImage:[UIImage imageNamed:@"xbox"]];
                }
                else if([group.owner.server containsString:@"ps4"])
                {
                    [cell.ivPlatform setImage:[UIImage imageNamed:@"ps4"]];
                }
            }
            
        }
        else if([Temp getGameMode] == LeagueOfLegends)
        {

            for(i = 0; i < 5 ; i++)
            {
                switch (i)
                {
                    case 0:
                        if (i >= arHr.count)
                            [cell.imageHeroOne setImage:nil];
                        else
                            [cell.imageHeroOne setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 1:
                        if (i >= arHr.count)
                            [cell.imageHeroTwo setImage:nil];
                        else
                            [cell.imageHeroTwo setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 2:
                        if (i >= arHr.count)
                            [cell.imageHeroThree setImage:nil];
                        else
                            [cell.imageHeroThree setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 3:
                        if (i >= arHr.count)
                            [cell.imageHeroFour setImage:nil];
                        else
                            [cell.imageHeroFour setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 4:
                        if (i >= arHr.count)
                            [cell.imageHeroFive setImage:nil];
                        else
                            [cell.imageHeroFive setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                        
                    default:
                        break;
                }
            }
            [cell.ivPlatform setImage:[UIImage imageNamed:@"pc"]];
            [cell.labelServerView setText:[Utils getLolServerName:group.owner.lol_server]];            
        }
        //        for(int j = i ; j < 5 ; j++)
        //        {
        //            switch (j)
        //            {
        //                case 0:
        //                    [cell.imageHeroOneView setHidden:YES];
        //                    break;
        //                case 1:
        //                    [cell.imageHeroTwoView setHidden:YES];
        //                    break;
        //                case 2:
        //                    [cell.imageHeroThreeView setHidden:YES];
        //                    break;
        //                case 3:
        //                    [cell.imageHeroFourView setHidden:YES];
        //                    break;
        //                case 4:
        //                    [cell.imageHeroFiveView setHidden:YES];
        //                    break;
        //
        //                default:
        //                    break;
        //            }
        //        }
    }
    
    
    
    
    
    cell.borderedView.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    [cell.borderedView redraw];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GetGood_Group *group = [arrGroup objectAtIndex:indexPath.item];
    [Temp setGroupData:group];
    
    NSUserDefaults *Defult =[NSUserDefaults standardUserDefaults];
    [Defult setObject:group.id forKey:@"Groupid"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    GroupDetailsController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_group_details_controller"];
    
    [self.navigationController pushViewController:controller animated:YES];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/2 - 16 , 176);
}


#pragma mark - XLPagerTabStripViewControllerDelegate

-(NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"Group Listing";
}

-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f];
}

@end

@implementation ProfileGroupListingCell

@end
