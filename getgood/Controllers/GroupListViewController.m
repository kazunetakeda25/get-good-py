//
//  GroupListViewController.m
//  getgood
//
//  Created by Dan on 21/04/2018.
//  Copyright © 2018 PH. All rights reserved.
//

#import "GroupListViewController.h"
#import "GroupDetailsController.h"
#import "AppData.h"
#import "GameGroupController.h"
#import "Utils.h"
#import "Temp.h"

@interface GroupListViewController ()

@end

@implementation GroupListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.vCollectionView setDelegate:self];
    [self.vCollectionView setDataSource:self];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    [self.lbNoGroup setHidden:YES];
    [RestClient getParticipatingGroups:^(bool result, NSDictionary *data) {
        if(!result)
            return ;
        
        self.arrGroup = [[NSMutableArray alloc] init];
        NSArray* arTemp = [data objectForKey:@"groups"];

        for(int i = 0; i < arTemp.count; i++)
        {
            GetGood_Group* user = [[GetGood_Group alloc] initWithDictionary:[arTemp objectAtIndex:i]];
            
            [self.arrGroup addObject:user];
        }
        
        [self.vCollectionView reloadData];
        
        if(self.arrGroup.count == 0)
        {
            [self.lbNoGroup setHidden:NO];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrGroup.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/2 - 16 , 176);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GameGroupCell *cell = (GameGroupCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"GameGroupCell" forIndexPath:indexPath];
    
    GetGood_Group *group = [self.arrGroup objectAtIndex:indexPath.item];
    
    
    int k = 0;
    if(indexPath.item == 1)
    {
        k++;
    }
    cell.labelPlayerJoinedView.text = [NSString stringWithFormat:@"%d Player(s) Joined", [Utils getOccurence:group.users]];
    
    int readyTime = 0;
    
    @try
    {
        readyTime = [group.ready intValue];
    }
    @catch(NSException* ex)
    {
        
    }
    
    BOOL isGroupUpdate = [Utils checkIfGroupUpdate:group];
    
    if(isGroupUpdate)
    {
        [cell.ivNewMessage setHidden:NO];
    }
    else
    {
        [cell.ivNewMessage setHidden:YES];
    }
    

    if([Temp getGameMode] == Overwatch)
    {
        if(group.average_game_rating != 0)
        {
            [cell.imageRankView setHidden:NO];
            [cell.imageRankView setImage: [UIImage imageNamed:[Utils getRankAvatar:group.average_game_rating ]]];
            cell.labelInGameRatingView.text = [NSString stringWithFormat:@"%d",group.average_game_rating];
        }
        else
        {
            [cell.imageRankView setHidden:YES];
            cell.labelInGameRatingView.text = @"---";
        }
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        if(group.average_game_rating != 0)
        {
            [cell.imageRankView setHidden:NO];
            [cell.imageRankView setImage: [UIImage imageNamed:[Utils getLolRankAvatar:
                                                               [[DataArrays lolRanks] objectAtIndex:group.average_game_rating]]]];
            cell.labelInGameRatingView.text = [NSString stringWithFormat:@"%@",[[DataArrays lolRanks] objectAtIndex:group.average_game_rating]];
        }
        else
        {
            [cell.imageRankView setHidden:YES];
            cell.labelInGameRatingView.text = @"---";
        }
    }
    
    
    cell.labelNameView.text = group.title;
    cell.labelLeaderView.text = [NSString stringWithFormat:@"%@%@",@"",group.owner.name];
    
    [cell.ratingPlayerView setValue:group.average_player_rating];
    [cell.ratingPlayerView setUserInteractionEnabled:NO];
    
    
    cell.labelServerView.text = @"";
    [cell.ivPlatform setImage:nil];
    
    if([Temp getGameMode] == Overwatch)
    {

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
        
        if(group.owner.server != nil && group.owner.server.length != 0)
        {
            if([group.owner.server isEqualToString:@"us"])
                cell.labelServerView.text = @"Americas";
            else if([group.owner.server isEqualToString:@"eu"])
                cell.labelServerView.text = @"Europe";
            else if([group.owner.server isEqualToString:@"kr"])
                cell.labelServerView.text = @"Asia";
            
            [cell.labelServerView setHidden:NO];
        }
        else
        {
            [cell.labelServerView setHidden:YES];
        }
        
        if(group.hero != nil)
        {
            NSArray* arHr = [group.hero componentsSeparatedByString:@" "];
            
            if(indexPath.item == 1 && [arHr count] != 4)
            {
                k++;
            }
            int i = 0;
            for(i = 0; i < 5 ; i++)
            {
                switch (i)
                {
                    case 0:
                        if (i >= arHr.count)
                            [cell.imageHeroOneView setImage:nil];
                        else
                            [cell.imageHeroOneView setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 1:
                        if (i >= arHr.count)
                            [cell.imageHeroTwoView setImage:nil];
                        else
                            [cell.imageHeroTwoView setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 2:
                        if (i >= arHr.count)
                            [cell.imageHeroThreeView setImage:nil];
                        else
                            [cell.imageHeroThreeView setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 3:
                        if (i >= arHr.count)
                            [cell.imageHeroFourView setImage:nil];
                        else
                            [cell.imageHeroFourView setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 4:
                        if (i >= arHr.count)
                            [cell.imageHeroFiveView setImage:nil];
                        else
                            [cell.imageHeroFiveView setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                        
                    default:
                        break;
                }
            }
        }
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        cell.labelServerView.text = [Utils getLolServerName:group.owner.lol_server];
        [cell.ivPlatform setImage:[UIImage imageNamed:@"pc"]];
        
        if(group.hero != nil)
        {
            NSArray* arHr = [group.hero componentsSeparatedByString:@" "];
            
            if(indexPath.item == 1 && [arHr count] != 4)
            {
                k++;
            }
            int i = 0;
            for(i = 0; i < 5 ; i++)
            {
                switch (i)
                {
                    case 0:
                        if (i >= arHr.count)
                            [cell.imageHeroOneView setImage:nil];
                        else
                            [cell.imageHeroOneView setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 1:
                        if (i >= arHr.count)
                            [cell.imageHeroTwoView setImage:nil];
                        else
                            [cell.imageHeroTwoView setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 2:
                        if (i >= arHr.count)
                            [cell.imageHeroThreeView setImage:nil];
                        else
                            [cell.imageHeroThreeView setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 3:
                        if (i >= arHr.count)
                            [cell.imageHeroFourView setImage:nil];
                        else
                            [cell.imageHeroFourView setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 4:
                        if (i >= arHr.count)
                            [cell.imageHeroFiveView setImage:nil];
                        else
                            [cell.imageHeroFiveView setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                        
                    default:
                        break;
                }
            }
        }
    }
    
    cell.borderedView.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    [cell.borderedView redraw];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GetGood_Group *group = [self.arrGroup objectAtIndex:indexPath.item];
    [Temp setGroupData:group];
    
    NSUserDefaults *Defult =[NSUserDefaults standardUserDefaults];
    [Defult setObject:group.id forKey:@"Groupid"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    GroupDetailsController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_group_details_controller"];
    
    [self.navigationController pushViewController:controller animated:YES];
}

-(NSInteger) tableView:(UITableView *) theTableView numberOfRowsInSection:(NSInteger) section
{
    return 1;
}

@end
