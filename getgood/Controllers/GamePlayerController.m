//
//  ProfileCoachListingController.m
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
#import "ProfileController.h"
#import "GamePlayerController.h"
#import "PlayerChatController.h"
#import "Temp.h"
#import "UIImageView+WebCache.h"
#import "DataArrays.h"

@interface GamePlayerController ()
{
    NSMutableArray *arrPlayers;
    NSArray *arrCategory;
    NSMutableArray *arrGroup;
    
    NSString* prefix;
}

@end
@implementation GamePlayerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [collectionView setDelegate:self];
    
    self.bLoading = NO;
    self.nPage = 0;
    self.bFinish = NO;
    [self loadData];
    arUsers = [[NSMutableArray alloc] init];
    
    [collectionView setScrollsToTop:YES];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [Temp setCurrentTab:0];
    
    if([Temp needReload])
    {
        self.bLoading = NO;
        self.nPage = 0;
        self.bFinish = NO;
        [self loadData];
        arUsers = [[NSMutableArray alloc] init];
        
        [collectionView setScrollsToTop:YES];
        
        [Temp setNeedReload:NO];
    }
    else
    {
//        arUsers = [[NSMutableArray alloc] init];
//        
//        [collectionView setScrollsToTop:YES];
//        [collectionView reloadData];
    }
    
}

- (void) loadData
{
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
    
    if([defult objectForKey:[NSString stringWithFormat:@"sort1_%@online", prefix]] != nil)
    {
        SelectAvalibility = [[defult valueForKey:[NSString stringWithFormat:@"sort1_%@online", prefix]] integerValue];
    }
    
    int SelectSortBy = [[defult valueForKey:[NSString stringWithFormat:@"sort1_%@general", prefix]] integerValue];
    
    NSString* playerMinimumR = [defult valueForKey:[NSString stringWithFormat:@"sort1_%@PlayerRatingMin", prefix]];
    NSString* playerMaximumR = [defult valueForKey:[NSString stringWithFormat:@"sort1_%@PlayerRatingMax", prefix]];
    
    NSString* gameMinimumR = [defult valueForKey:[NSString stringWithFormat:@"sort1_%@GameRatingMin", prefix]];
    NSString* gameMaximumR = [defult valueForKey:[NSString stringWithFormat:@"sort1_%@GameRatingMax", prefix]];
    
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
    
    BOOL bCheckRole = [defult boolForKey:[NSString stringWithFormat:@"%@category_player_role", prefix]];
    NSString* strCategory = [defult objectForKey:[NSString stringWithFormat:@"%@category_player", prefix]];
    
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
    
    [RestClient getPlayers:self.nPage sort:sort playerRatingMax:[playerMaximumR floatValue] playerRatingMin:[playerMinimumR floatValue] gameRatingMax:gameMaximumR gameRatingMin:gameMinimumR server:strServer platform:strPlatform online:SelectAvalibility category:strCategory keyword:self.vcParent.txtSearch.text callback:^(bool result, NSDictionary *data) {
                if(!result)
                    return ;
        
                self.bLoading = NO;
        
                NSArray* arTemp = [data objectForKey:@"users"];
        
                if(arTemp.count == 0)
                {
                    self.bFinish = YES;
                    [collectionView reloadData];
                    return;
                }
        
                for(int i = 0; i < arTemp.count; i++)
                {
                    User* user = [[User alloc] initWithDictionary:[arTemp objectAtIndex:i]];
        
                    [arUsers addObject:user];
                }
        
                [collectionView reloadData];
    }];
    
}

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == arUsers.count-1)  {
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/2 - 6 , 224);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arUsers count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GamePlayerCollectionCell *cell = (GamePlayerCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"GamePlayerCell" forIndexPath:indexPath];
    
    User *profile = [arUsers objectAtIndex:indexPath.row];
    
    cell.labelNameView.text = profile.name;
    NSString *strImg = [NSString stringWithFormat:@"%@",profile.avatar_url];
    cell.imageAvatarView.image = [UIImage imageNamed:@"avatar"];
    [cell.imageAvatarView sd_setImageWithURL:[NSURL URLWithString:strImg]
                            placeholderImage:[UIImage imageNamed:strImg]
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         if(image != nil)
             cell.imageAvatarView.image = image;
         else
             cell.imageAvatarView.image = [UIImage imageNamed:@"avatar"];
         
     }];
    
    int readyTime = 0;
    
    @try
    {
        if([Temp getGameMode] == Overwatch)
        {
            readyTime = [profile.ready intValue];
        }
        else if([Temp getGameMode] == LeagueOfLegends)
        {
            readyTime = [profile.lol_ready intValue];
        }
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
        cell.labelServerView.text = @"Europe";
        cell.imageRankView.image = [UIImage imageNamed:[Utils getRankAvatar:profile.overwatch_rank ]];
        cell.imageRankView.userInteractionEnabled = NO;
        
        if(profile.player_review_count != 0){
            cell.labelRatingCountView.text = [NSString stringWithFormat:@"(%d)",profile.player_review_count];
        }else{
            cell.labelRatingCountView.text = @"(0)";
        }
        
        
        cell.labelServerView.text = @"";
        [cell.ivPlatform setImage:nil];
        
        if(profile.server.length)
        {
            if([profile.server containsString:@"us"])
            {
                cell.labelServerView.text = @"Americas";
            }
            else if([profile.server containsString:@"eu"])
            {
                cell.labelServerView.text = @"Europe";
            }
            else if([profile.server containsString:@"kr"])
            {
                cell.labelServerView.text = @"Asia";
            }
            if([profile.server containsString:@"pc"])
            {
                [cell.ivPlatform setImage:[UIImage imageNamed:@"pc"]];
            }
            else if([profile.server containsString:@"xbox"])
            {
                [cell.ivPlatform setImage:[UIImage imageNamed:@"xbox"]];
            }
            else if([profile.server containsString:@"ps4"])
            {
                [cell.ivPlatform setImage:[UIImage imageNamed:@"ps4"]];
            }
        }
        
        [cell.imageHeroOne setImage:nil];
        [cell.imageHeroTwo setImage:nil];
        [cell.imageHeroThree setImage:nil];
        [cell.imageHeroFour setImage:nil];
        [cell.imageHeroFive setImage:nil];
        
        if(profile.overwatch_heroes != nil && profile.overwatch_heroes.length != 0)
        {
            NSArray* arHr = [profile.overwatch_heroes componentsSeparatedByString: @" "];
            //        NSLog(@"%@",arHr);
            
            int i = 0;
            for(i = 0; i < [arHr count] ; i++)
            {
                switch (i)
                {
                    case 0:
                        [cell.imageHeroOne setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 1:
                        [cell.imageHeroTwo setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 2:
                        [cell.imageHeroThree setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 3:
                        [cell.imageHeroFour setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 4:
                        [cell.imageHeroFive setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                        
                    default:
                        break;
                }
            }
        }
        
        if(profile.overwatch_rank  != 0)
            cell.labelOverwatchId.text = [NSString stringWithFormat:@"%d",profile.overwatch_rank];
        else
            cell.labelOverwatchId.text = @"...";
        
        cell.ratingCoachView.value = profile.player_rating;
        [cell.ratingCoachView setUserInteractionEnabled:NO];
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        cell.imageRankView.image = [UIImage imageNamed:[Utils getLolRankAvatar:profile.lol_rank ]];
        cell.imageRankView.userInteractionEnabled = NO;
        if(profile.player_review_count != 0){
            cell.labelRatingCountView.text = [NSString stringWithFormat:@"(%d)",profile.lol_player_review_count];
        }else{
            cell.labelRatingCountView.text = @"(0)";
        }
        
        [cell.ivPlatform setImage:[UIImage imageNamed:@"pc"]];
        cell.labelServerView.text = @"All";
        cell.labelServerView.text = [Utils getLolServerName:profile.lol_server];
        
        [cell.imageHeroOne setImage:nil];
        [cell.imageHeroTwo setImage:nil];
        [cell.imageHeroThree setImage:nil];
        [cell.imageHeroFour setImage:nil];
        [cell.imageHeroFive setImage:nil];
        
        if(profile.lol_heroes != nil && profile.lol_heroes.length != 0)
        {
            NSArray* arHr = [profile.lol_heroes componentsSeparatedByString: @" "];
            //        NSLog(@"%@",arHr);
            
            int i = 0;
            for(i = 0; i < [arHr count] ; i++)
            {
                switch (i)
                {
                    case 0:
                        [cell.imageHeroOne setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 1:
                        [cell.imageHeroTwo setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 2:
                        [cell.imageHeroThree setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 3:
                        [cell.imageHeroFour setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 4:
                        [cell.imageHeroFive setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                        
                    default:
                        break;
                }
            }
        }
        
        if(profile.lol_rank.length)
            cell.labelOverwatchId.text = profile.lol_rank;
        else
            cell.labelOverwatchId.text = @"...";
        
        cell.ratingCoachView.value = profile.lol_player_rating;
        [cell.ratingCoachView setUserInteractionEnabled:NO];
    }

   
    [cell.btnChatView setTag:indexPath.row];
    
    if([[AppData profile].id isEqualToString:profile.id])
    {
        //cell.labelChatView.hidden = YES;
        cell.btnChatView.hidden = YES;
    }
    else{
        //cell.labelChatView.hidden = NO;
        cell.btnChatView.hidden = NO;
        
        [cell.btnChatView.layer setCornerRadius:10.5];
        [cell.btnChatView.layer setBorderColor:[UIColor whiteColor].CGColor];
        [cell.btnChatView.layer setBorderWidth:1.0];
        [cell.btnChatView addTarget:self action:@selector(onTapChatButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
//    if([Utils checkDateAvailability:profile.featured])
//        cell.imageFeaturedView.hidden = NO;
//    else
        cell.imageFeaturedView.hidden = YES;

    [cell layoutSubviews];
    
    cell.borderView.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    
    [cell.borderView redraw];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    User *profile = [arUsers objectAtIndex:indexPath.row];
    
    if(profile == nil)
        return;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ProfileController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sid_profile_controller"];
    controller.profile = profile;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - On Tap Player Chat Button
- (void)onTapChatButton:(UIButton *)btnChat {
    
    User *profile = [arUsers objectAtIndex:btnChat.tag];
    [UIKit showLoading];
    
    [RestClient createDialog:@"1" reference:@"" receiver:profile.id callback:^(bool result, NSDictionary *data) {
            [UIKit dismissDialog];
            if(!result)
                return;
            GetGood_Dialog* dialog = [[GetGood_Dialog alloc] initWithDictionary:[data objectForKey:@"dialog"]];
        
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            PlayerChatController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sid_player_chat_controller"];
            [Temp setDialogData:dialog];
            [self.navigationController pushViewController:controller animated:YES];
    }];
    
}

#pragma mark - XLPagerTabStripViewControllerDelegate

-(NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"Players";
}

-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f];
}
- (IBAction)onReady:(id)sender {
    
    if([Temp getGameMode] == Overwatch)
    {
        [AppData profile].ready = [Utils getTimeStamp];
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        [AppData profile].lol_ready = [Utils getTimeStamp];
    }
    
    [RestClient readyProfile:^(bool result, NSDictionary *data) {
        NSString* strTimestamp = [[data objectForKey:@"timestamp"] stringValue];
        
        for(int i = 0; i < arUsers.count; i++)
        {
            if([((User*)[arUsers objectAtIndex:i]).id isEqualToString:[AppData profile].id])
            {
                if([Temp getGameMode] == Overwatch)
                {
                    (((User*)[arUsers objectAtIndex:i]).ready = strTimestamp);
                }
                else if([Temp getGameMode] == LeagueOfLegends)
                {
                    (((User*)[arUsers objectAtIndex:i]).lol_ready = strTimestamp);
                }
                
                break;
            }
        }
        
        [collectionView reloadData];
    }];
}

- (void) update
{
    self.bLoading = NO;
    self.nPage = 0;
    self.bFinish = NO;
    [self loadData];
    arUsers = [[NSMutableArray alloc] init];
    
    [collectionView setScrollsToTop:YES];
}

@end

@implementation GamePlayerCollectionCell
@end



