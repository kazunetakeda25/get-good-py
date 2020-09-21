//
//  ProfileController.m
//  getgood
//
//  Created by MD Aminuzzaman on 1/13/18.
//  Copyright © 2018 PH. All rights reserved.
//

@import Firebase;
@import FirebaseDatabase;

#import "UIKit.h"
#import "Utils.h"
#import "Follow.h"
#import "AppData.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "ColorConstants.h"
#import "ProfileController.h"
#import "ProfileFollowerController.h"
#import "CoachRateDisplayController.h"
#import "PlayerRateDisplayController.h"
#import "TraineeRateDisplayController.h"

#import "ProfileCoachListingController.h"
#import "ProfileGroupListingController.h"


@interface ProfileController ()
{
    BOOL isReload;
}


@end

@implementation ProfileController

@synthesize profile;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //[self moveToViewControllerAtIndex:1];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self initUI];
}

-(void) initUI
{
    [self.buttonBarView setSelectedBarHeight:1.0f];
    self.buttonBarView.selectedBar.backgroundColor = [UIColor orangeColor];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionShowCoachRatingDetails:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [viewCoachRating addGestureRecognizer:tapGestureRecognizer];
    viewCoachRating.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionBack:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageBack addGestureRecognizer:tapGestureRecognizer];
    imageBack.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionShowTraineeRatingDetails:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [viewTraineeRating addGestureRecognizer:tapGestureRecognizer];
    viewTraineeRating.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionShowPlayerRatingDetails:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [viewPlayerRating addGestureRecognizer:tapGestureRecognizer];
    viewPlayerRating.userInteractionEnabled = YES;
    
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionProfileFollower:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [labelFollowers addGestureRecognizer:tapGestureRecognizer];
    labelFollowers.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionProfileFollowing:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [labelFollowings addGestureRecognizer:tapGestureRecognizer];
    labelFollowings.userInteractionEnabled = YES;
    
    self.buttonBarView.shouldCellsFillAvailableWidth = YES;
    self.isProgressiveIndicator = NO;
    
    [self.buttonBarView setSelectedBarHeight:4.0f];
    self.buttonBarView.selectedBar.backgroundColor = [UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f];
    
    self.changeCurrentIndexProgressiveBlock = ^void(XLButtonBarViewCell *oldCell, XLButtonBarViewCell *newCell, CGFloat progressPercentage, BOOL changeCurrentIndex, BOOL animated)
    {
        if (changeCurrentIndex)
        {
            [oldCell.label setTextColor:[UIColor colorWithWhite:1 alpha:0.6]];
            [newCell.label setTextColor:[UIColor whiteColor]];
            
            if (animated)
            {
                [UIView animateWithDuration:0.1
                                 animations:^()
                 {
                     newCell.transform = CGAffineTransformMakeScale(1.0, 1.0);
                     oldCell.transform = CGAffineTransformMakeScale(0.8, 0.8);
                     
                 }
                                 completion:nil];
            }
            else
            {
                newCell.transform = CGAffineTransformMakeScale(1.0, 1.0);
                oldCell.transform = CGAffineTransformMakeScale(0.8, 0.8);
            }
        }
    };
    
    
    if([Utils isVisited:@"hero"])
    {
        labelHeroCaptions.textColor = UIColorFromRGB(0x7f060027);
    }
    else
    {
        labelHeroCaptions.textColor = UIColorFromRGB(0x7f05002d);
    }
    
    [self feedUI];
}



- (void)actionBack:(UITapGestureRecognizer *)tapGesture
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) feedUI
{
    //UserProfile *profile = [AppData userProfile];
    

    
    labelName.text = profile.name;
    labelDateJoined.text = profile.join_date;
    
//    if( [profile.coachCoin integerValue] == 1 )
//    {
//        labelCoachCoin.text = @"1";
//    }
//    else
//    {
//        labelCoachCoin.text = @"0";
//    }
//
//    labelPlayerCoin.text = [NSString stringWithFormat:@"%@",profile.playerCoin];
    
    if([Temp getGameMode] == Overwatch)
    {

        if(profile.getgood_description.length)
        {
            labelDescriptions.hidden = NO;
            labelDescriptions.text = profile.getgood_description;
        }
        else
        {
            labelDescriptions.hidden = YES;
        }
        
        if(profile.blizzard_id != nil)
        {
            viewGameAccount.hidden = NO;
            labelGameId.text = profile.blizzard_id;
            
            if(profile.overwatch_heroes.length)
            {
                NSArray* arHr = [profile.overwatch_heroes componentsSeparatedByString: @" "];
                
                int i = 0;
                for(i = 0; i < [arHr count] ; ++i)
                {
                    switch (i)
                    {
                        case 0:
                            [imageHeroOne setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                            break;
                        case 1:
                            [imageHeroTwo setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                            break;
                        case 2:
                            [imageHeroThree setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                            break;
                        case 3:
                            [imageHeroFour setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                            break;
                        case 4:
                            [imageHeroFive setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                            break;
                            
                        default:
                            break;
                    }
                }
                
                for(int j = i ; j < 5 ; ++j)
                {
                    switch (i)
                    {
                        case 0:
                            [imageHeroOne setHidden:YES];
                            break;
                        case 1:
                            [imageHeroTwo setHidden:YES];
                            break;
                        case 2:
                            [imageHeroThree setHidden:YES];
                            break;
                        case 3:
                            [imageHeroFour setHidden:YES];
                            break;
                        case 4:
                            [imageHeroFive setHidden:YES];
                            break;
                            
                        default:
                            break;
                    }
                }
                
                if(profile.server != nil)
                {
                    if([profile.server isEqualToString:@"us"])
                        labelServer.text = @"Americas";
                    else if([profile.server isEqualToString:@"eu"])
                        labelServer.text = @"Europe";
                    else if([profile.server isEqualToString:@"kr"])
                        labelServer.text = @"Asia";
                }
                else
                {
                    labelServer.hidden = YES;
                }
                
                if(profile.overwatch_rank != 0)
                {
                    labelInGameRating.text = [NSString stringWithFormat:@"In-Game Rating (%d)",profile.overwatch_rank];
                }
                else
                    labelInGameRating.text = [NSString stringWithFormat:@"In-Game Rating (---)"];
            }
        }
        else
        {
            labelInGameRating.hidden = YES;
            viewGameAccount.hidden = YES;
        }
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", profile.avatar_url]];
        [imageProfile sd_setImageWithURL:url];
        
        labelCoachRatingCount.text = [NSString stringWithFormat:@"Coach Rating (%d Reviews)",profile.coach_review_count];
        
        labelTraineeRatingCount.text = [NSString stringWithFormat:@"Trainee Rating (%d Reviews)",profile.trainee_review_count];
        
        labelPlayerRatingCount.text = [NSString stringWithFormat:@"Player Rating (%d Reviews)",profile.player_review_count];
        
        ratingCoach.value = profile.coach_rating ;
        ratingPlayer.value = profile.player_rating ;
        ratingTrainee.value = profile.trainee_rating ;
        
        labelCoachRating.text = [NSString stringWithFormat:@"%.2f",profile.coach_rating];
        
        labelTraineeRating.text = [NSString stringWithFormat:@"%.2f",profile.trainee_rating];
        
        labelPlayerRating.text = [NSString stringWithFormat:@"%.2f",profile.player_rating];
        
        
        if([profile.server containsString:@"us"])
        {
            labelServer.text = @"Americas";
        }
        else if([profile.server containsString:@"eu"])
        {
            labelServer.text = @"Europe";
        }
        else if([profile.server containsString:@"kr"])
        {
            labelServer.text = @"Asia";
        }
        
        if([profile.server containsString:@"pc"])
        {
            [ivPlatform setImage:[UIImage imageNamed:@"pc"]];
        }
        else if([profile.server containsString:@"xbox"])
        {
            [ivPlatform setImage:[UIImage imageNamed:@"xbox"]];
        }
        else if([profile.server containsString:@"ps4"])
        {
            [ivPlatform setImage:[UIImage imageNamed:@"ps4"]];
        }
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {

        if(profile.lol_description.length)
        {
            labelDescriptions.hidden = NO;
            labelDescriptions.text = profile.lol_description;
        }
        else
        {
            labelDescriptions.hidden = YES;
        }
        
        if(profile.lol_id.length)
        {
            viewGameAccount.hidden = NO;
            labelGameId.text = profile.lol_id;
            
            if(profile.lol_heroes.length)
            {
                NSArray* arHr = [profile.lol_heroes componentsSeparatedByString: @" "];
                
                int i = 0;
                for(i = 0; i < [arHr count] ; ++i)
                {
                    switch (i)
                    {
                        case 0:
                            [imageHeroOne setImage:[UIImage imageNamed:[arHr objectAtIndex:i]]];
                            break;
                        case 1:
                            [imageHeroTwo setImage:[UIImage imageNamed:[arHr objectAtIndex:i]]];
                            break;
                        case 2:
                            [imageHeroThree setImage:[UIImage imageNamed:[arHr objectAtIndex:i]]];
                            break;
                        case 3:
                            [imageHeroFour setImage:[UIImage imageNamed:[arHr objectAtIndex:i]]];
                            break;
                        case 4:
                            [imageHeroFive setImage:[UIImage imageNamed:[arHr objectAtIndex:i]]];
                            break;
                            
                        default:
                            break;
                    }
                }
                
                for(int j = i ; j < 5 ; ++j)
                {
                    switch (i)
                    {
                        case 0:
                            [imageHeroOne setHidden:YES];
                            break;
                        case 1:
                            [imageHeroTwo setHidden:YES];
                            break;
                        case 2:
                            [imageHeroThree setHidden:YES];
                            break;
                        case 3:
                            [imageHeroFour setHidden:YES];
                            break;
                        case 4:
                            [imageHeroFive setHidden:YES];
                            break;
                            
                        default:
                            break;
                    }
                }
                
                if(profile.lol_server.length)
                {
                    [labelServer setText:[Utils getLolServerName:profile.lol_server]];
                }
                else
                {
                    labelServer.hidden = YES;
                }
                
                if(profile.lol_rank.length)
                {
                    labelInGameRating.text = [NSString stringWithFormat:@"In-Game Rating (%@)",profile.lol_rank];
                }
                else
                    labelInGameRating.text = [NSString stringWithFormat:@"In-Game Rating (---)"];
            }
        }
        else
        {
            labelInGameRating.hidden = YES;
            viewGameAccount.hidden = YES;
        }
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", profile.avatar_url]];
        [imageProfile sd_setImageWithURL:url];
        
        labelCoachRatingCount.text = [NSString stringWithFormat:@"Coach Rating (%d Reviews)",profile.lol_coach_review_count];
        
        labelTraineeRatingCount.text = [NSString stringWithFormat:@"Trainee Rating (%d Reviews)",profile.lol_trainee_review_count];
        
        labelPlayerRatingCount.text = [NSString stringWithFormat:@"Player Rating (%d Reviews)",profile.lol_player_review_count];
        
        ratingCoach.value = profile.lol_coach_rating ;
        ratingPlayer.value = profile.lol_player_rating ;
        ratingTrainee.value = profile.lol_trainee_rating ;
        
        labelCoachRating.text = [NSString stringWithFormat:@"%.2f",profile.lol_coach_rating];
        
        labelTraineeRating.text = [NSString stringWithFormat:@"%.2f",profile.lol_trainee_rating];
        
        labelPlayerRating.text = [NSString stringWithFormat:@"%.2f",profile.lol_player_rating];
        
        [ivPlatform setImage:[UIImage imageNamed:@"pc"]];
        [labelServer setText:[Utils getLolServerName:profile.lol_server]];
    }
    
}

-(void) updateFollowUI
{

}


- (void)uploadSuccess:(FIRStorageMetadata *) metadata storagePath: (NSString *) storagePath
{
    NSLog(@"Upload Succeeded!");
    
    [[NSUserDefaults standardUserDefaults] setObject:storagePath forKey:@"storagePath"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


-(void) updateProfile
{
    //[[Temp context] refreshProfile];
}

- (void)actionShowCoachRatingDetails:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    CoachRateDisplayController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_coach_rating"];
    
    controller.userId = profile.id;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)actionProfileFollower:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    ProfileFollowerController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_profile_follower_controller"];
    
    controller.viewType = VIEW_FOLLOWER_TYPE;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)actionProfileFollowing:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    ProfileFollowerController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_profile_follower_controller"];
    
    controller.viewType = VIEW_FOLLOWING_TYPE;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)actionShowTraineeRatingDetails:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    TraineeRateDisplayController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_trainee_rating"];
    
    controller.userId = profile.id;
    
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)actionCoinInfo:(UITapGestureRecognizer *)tapGesture
{
    
}


- (void)actionShowPlayerRatingDetails:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    PlayerRateDisplayController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_player_rating"];
    
    controller.userId = profile.id;
    
    [self.navigationController pushViewController:controller animated:YES];
}


-(void) updateServer:(NSString *) server
{
}

#pragma mark - XLPagerTabStripViewControllerDataSource

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    // create child view controllers that will be managed by XLPagerTabStripViewController
    
    NSString * storyboardName = @"Main";
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    ProfileCoachListingController * vc1 = (ProfileCoachListingController*)[storyboard instantiateViewControllerWithIdentifier:@"sb_id_profile_coach_listing"];
    
    vc1.strUserID = profile.id;
    
    ProfileGroupListingController * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_profile_group_listing"];
    vc2.strUserID = profile.id;
    
    if (!isReload)
    {
        return @[vc2,vc1];
    }
    
    NSMutableArray * childViewControllers = [NSMutableArray arrayWithObjects:vc1, nil];
    NSUInteger count = [childViewControllers count];
    
    for (NSUInteger i = 0; i < count; ++i)
    {
        // Select a random element between i and end of array to swap with.
        NSUInteger nElements = count - i;
        NSUInteger n = (arc4random() % nElements) + i;
        [childViewControllers exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    NSUInteger nItems = 1 + (rand() % 8);
    
    return [childViewControllers subarrayWithRange:NSMakeRange(0, nItems)];
}

-(void)reloadPagerTabStripView
{
    isReload = YES;
    self.isProgressiveIndicator  = (rand() % 2 == 0);
    self.isElasticIndicatorLimit = (rand() % 2 == 0);
    
    [super reloadPagerTabStripView];
}

- (void)pagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController didMoveToIndex:(NSInteger)toIndex
{
    
}

@end

