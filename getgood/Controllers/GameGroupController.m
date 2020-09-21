//
//  ProfileGroupListingController.m
//  getgood
//
//  Created by Md Aminuzzaman on 25/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

@import Firebase;
@import FirebaseDatabase;

#import "UIKit.h"
#import "Utils.h"
#import "AppData.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "GameGroupController.h"
#import "GroupDetailsController.h"
#import "DataArrays.h"
#import "CreateGroupController.h"
#import "Temp.h"

@interface GameGroupController ()
{
    NSMutableArray *arrGroup;
    NSMutableArray *arrPlayers;
    NSArray *arrCategory;
    NSMutableArray *arrDataCopy;
    NSString* prefix;
}
@end

@implementation GameGroupController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.bLoading = NO;
//    self.nPage = 0;
//    self.bFinish = NO;
//    [self loadData];
//    arGroups = [[NSMutableArray alloc] init];
//    
//    [collectionView setScrollsToTop:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void) loadData
{
    prefix = @"";
    if([Temp getGameMode] == Overwatch)
    {
        prefix = @"";
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        prefix = @"lol_";
    }
    
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    int SelectAvalibility = -1;
    
    if([defult objectForKey:[NSString stringWithFormat:@"sort2_%@online", prefix]] != nil)
    {
        SelectAvalibility = [[defult valueForKey:[NSString stringWithFormat:@"sort2_%@online", prefix]] integerValue];
    }
    int SelectSortBy = [[defult valueForKey:[NSString stringWithFormat:@"sort2_%@general", prefix]] integerValue];
    
    NSString* playerMinimumR = [defult valueForKey:[NSString stringWithFormat:@"sort2_%@PlayerRatingMin", prefix]];
    NSString* playerMaximumR = [defult valueForKey:[NSString stringWithFormat:@"sort2_%@PlayerRatingMax", prefix]];
    
    NSString* gameMinimumR = [defult valueForKey:[NSString stringWithFormat:@"sort2_%@GameRatingMin", prefix]];
    NSString* gameMaximumR = [defult valueForKey:[NSString stringWithFormat:@"sort2_%@GameRatingMax", prefix]];
    
    if(!playerMaximumR.length)
    {
        playerMaximumR = @"-1";
    }
    if(!gameMinimumR.length)
    {
        gameMinimumR = @"-1";
    }
    if(!gameMaximumR.length)
    {
        gameMaximumR = @"-1";
    }
    if(!playerMinimumR.length)
    {
        playerMinimumR = @"-1";
    }
    
    
    NSString* sort = @"";
    if(SelectSortBy == 0)
    {
        sort = @"popular";
    }
    else if(SelectSortBy == 1)
    {
        sort = @"relevance";
    }
    else if(SelectSortBy == 2)
    {
        sort = @"player_rating_low";
    }
    else if(SelectSortBy == 3)
    {
        sort = @"player_rating_high";
    }
    else if(SelectSortBy == 4)
    {
        sort = @"game_rating_low";
    }
    else if(SelectSortBy == 5)
    {
        sort = @"game_rating_high";
    }
    
    int nServer =[[defult valueForKey:[NSString stringWithFormat:@"%@server", prefix]] intValue];
    int nPlatform =[[defult valueForKey:[NSString stringWithFormat:@"%@platform", prefix]] intValue];
    
    BOOL bCheckRole = [defult boolForKey:[NSString stringWithFormat:@"%@category_group_role", prefix]];
    NSString* strCategory = [defult objectForKey:[NSString stringWithFormat:@"%@category_group", prefix]];
    
    NSString* strServer = @"";
    NSString* strPlatform = @"";
    
    if([Temp getGameMode] == Overwatch)
    {
        strServer = [[DataArrays serverValue] objectAtIndex:nServer];
        strPlatform = [[DataArrays platformValue] objectAtIndex:nPlatform];
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        strServer = [[DataArrays lolFilterServerValues] objectAtIndex:nServer];
    }
    
    if(!bCheckRole)
    {
        strCategory = [Utils getHeroString:strCategory];
    }
    else
    {
        strCategory = [Utils getRoleString:strCategory];
    }
    
    if(!strCategory.length)
    {
        strCategory = @"";
    }
    
    [RestClient getGroups:self.nPage sort:sort playerRatingMax:[playerMaximumR floatValue] playerRatingMin:[playerMinimumR floatValue] gameRatingMax:gameMaximumR  gameRatingMin:gameMinimumR  server:strServer platform:strPlatform online:SelectAvalibility category:strCategory keyword:self.vcParent.txtSearch.text callback:^(bool result, NSDictionary *data) {
        if(!result)
            return ;
        
        self.bLoading = NO;
        
        NSArray* arTemp = [data objectForKey:@"groups"];
        
        if(arTemp.count == 0)
        {
            self.bFinish = YES;
            [collectionView reloadData];
            return;
        }
        
        for(int i = 0; i < arTemp.count; i++)
        {
            GetGood_Group* user = [[GetGood_Group alloc] initWithDictionary:[arTemp objectAtIndex:i]];
            
            [arGroups addObject:user];
        }
        
        [collectionView reloadData];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [Temp setCurrentTab:1];
    
    if([Temp needReload])
    {
        self.bLoading = NO;
        self.nPage = 0;
        self.bFinish = NO;
        arGroups = [[NSMutableArray alloc] init];
        [collectionView setScrollsToTop:YES];
        [self loadData];        
        
        [Temp setNeedReload:NO];
    }
    else
    {
//        arGroups = [[NSMutableArray alloc] init];
//        [collectionView setScrollsToTop:YES];
//        [collectionView reloadData];
    }
    
    
}
- (IBAction)onReady:(id)sender {
    [RestClient getMyGroups:^(bool result, NSDictionary *data) {
        NSMutableArray* arTemp = [data objectForKey:@"groups"];
        NSMutableArray* _arGroups = [[NSMutableArray alloc] init];
        NSMutableArray* arGroupTitles = [[NSMutableArray alloc] init];
        
        for(int i = 0; i < arTemp.count; i++)
        {
            GetGood_Group* group = [[GetGood_Group alloc] initWithDictionary:[arTemp objectAtIndex:i]];
            
            [_arGroups addObject:group];
            [arGroupTitles addObject:group.title];
        }
        
        if(arGroupTitles.count == 0)
        {
            return ;
        }
        
        [ActionSheetStringPicker showPickerWithTitle:@"Select a group to be ready" rows:arGroupTitles initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
                                               //           NSLog(@"Picker: %@, Index: %ld, value: %@",picker, (long)selectedIndex, selectedValue);
                                               
                                               GetGood_Group *objGroup = [_arGroups objectAtIndex:selectedIndex];

                                               for(int i = 0 ; i < arGroups.count; i++)
                                               {
                                                   if([((GetGood_Group*)[arGroups objectAtIndex:i]).id isEqualToString:objGroup.id])
                                                   {
                                                       
                                                       
//                                                       [RestClient updateGroup:((GetGood_Group*)[arGroups objectAtIndex:i]).id title:((GetGood_Group*)[arGroups objectAtIndex:i]).title description:((GetGood_Group*)[arGroups objectAtIndex:i]).getgood_description hero:((GetGood_Group*)[arGroups objectAtIndex:i]).hero ready:((GetGood_Group*)[arGroups objectAtIndex:i]).ready callback:^(bool result, NSDictionary *data) {
//
//                                                       }];
                                                       
                                                       [RestClient readyGroup:((GetGood_Group*)[arGroups objectAtIndex:i]).id callback:^(bool result, NSDictionary *data) {
                                                           
                                                           NSString *strTimestasmp = [[data objectForKey:@"timestamp"] stringValue];
                                                           
                                                           ((GetGood_Group*)[arGroups objectAtIndex:i]).ready = strTimestasmp;
                                                           
                                                           
                                                           [collectionView reloadData];
                                                       }];
                                                       
                                                       break;
                                                   }
                                               }
                                               
                                           }cancelBlock:^(ActionSheetStringPicker *picker) {
                                               
                                               NSLog(@"Block Picker Canceled");
                                           }
                                              origin:btnReady];
    }];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arGroups.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/2 - 6 , 176);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GameGroupCell *cell = (GameGroupCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"GameGroupCell" forIndexPath:indexPath];
    
    GetGood_Group *group = [arGroups objectAtIndex:indexPath.item];
    
    
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
    
    int nTimeDelta = [[Utils getTimeStamp] intValue] - readyTime;
    
    if(nTimeDelta < ReadyDuration)
    {
        [cell.ivReady setHidden:NO];
        [UIView animateKeyframesWithDuration:0.8f delay:0.0 options:UIViewKeyframeAnimationOptionAutoreverse | UIViewKeyframeAnimationOptionRepeat animations:^{
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
                cell.ivReady.alpha = 1.0f;
            }];
            [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
                cell.ivReady.alpha = 0.0f;
            }];
        } completion:nil];
        
        
        double delayInSeconds = ReadyDuration - nTimeDelta;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //code to be executed on the main queue after delay
            [cell.ivReady.layer removeAllAnimations];
        });
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
        if(group.owner.lol_server.length)
        {
            cell.labelServerView.text = [Utils getLolServerName:group.owner.lol_server];
            [cell.ivPlatform setImage:[UIImage imageNamed:@"pc"]];
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
    GetGood_Group *group = [arGroups objectAtIndex:indexPath.item];
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


- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == arGroups.count-1)  {
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

/*
-(UITableViewCell *) tableView:(UITableView *) theTableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
   GameGroupCell *cell = (GameGroupCell *)[tableView dequeueReusableCellWithIdentifier:@"GameGroupCell"];
    
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GameGroupCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    
    cell.labelNameView.text = @"Dan's Group";
    cell.labelLeaderView.text = @"Wang Dan";
    cell.labelInGameRatingView.text = @"2744";
    cell.labelPlayerRatingView.starNumber = 2;
    cell.labelServerView.text = @"Europe";
    cell.labelLookingForView.text = @"2744";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
}*/

- (IBAction)btnGroupCreateClick:(id)sender {
    
//    if(![AppData profile].blizzard_id.length)
//    {
//        [UIKit showInformation:self message:@"Please link your overwatch account."];
//        return;
//    }
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    CreateGroupController *controller = [storyboard instantiateViewControllerWithIdentifier:@"CreateGroupController"];
    [self.navigationController pushViewController:controller animated:YES];
    
}


#pragma mark - XLPagerTabStripViewControllerDelegate

-(NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"Groups";
}

-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f];
}

- (void) update
{
    self.bLoading = NO;
    self.nPage = 0;
    self.bFinish = NO;
    [self loadData];
    arGroups = [[NSMutableArray alloc] init];
    
    [collectionView setScrollsToTop:YES];
}
@end

@implementation GameGroupCell

@end



