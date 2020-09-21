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
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "GameCoachController.h"
#import "LessonCreateController.h"
#import "CoachDetailController.h"
#import "DataArrays.h"

#import "UIImageView+WebCache.h"

@interface GameCoachController ()
{
    NSMutableArray *arrLessons;
    NSArray *arrCategory;
    NSMutableArray *arrGroup;
    NSMutableArray *arrDataCopy;
    NSString* prefix;
}

@end

@implementation GameCoachController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.bLoading = NO;
//    self.nPage = 0;
//    self.bFinish = NO;
//    [self loadData];
//    arLessons = [[NSMutableArray alloc] init];
//    [tableView reloadData];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [Temp setCurrentTab:2];
    
    if([Temp needReload])
    {
        self.bLoading = NO;
        self.nPage = 0;
        self.bFinish = NO;
        [self loadData];
        arLessons = [[NSMutableArray alloc] init];
        [tableView reloadData];
        
        [Temp setNeedReload:NO];
    }
    else
    {
//        arLessons = [[NSMutableArray alloc] init];
//        [tableView reloadData];
    }
    
}

- (void) loadData
{
    prefix = @"";
    if([Temp getGameMode] ==  Overwatch)
    {
        prefix = @"";
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        prefix = @"lol_";
    }
    
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    
    int SelectAvalibility = -1;
    if([defult objectForKey:[NSString stringWithFormat:@"sort_%@online", prefix]] != nil)
    {
        SelectAvalibility = [[defult valueForKey:[NSString stringWithFormat:@"sort_%@online", prefix]] integerValue];
    }
    int SelectSortBy = [[defult valueForKey:[NSString stringWithFormat:@"sort_%@general", prefix]] integerValue];
    
    NSString* coachMinimumR = [defult valueForKey:[NSString stringWithFormat:@"sort_%@CoachRatingMin", prefix]];
    NSString* coachMaximumR = [defult valueForKey:[NSString stringWithFormat:@"sort_%@CoachRatingMax", prefix]];
    
    NSString* gameMinimumR = [defult valueForKey:[NSString stringWithFormat:@"sort_%@GameRatingMin", prefix]];
    NSString* gameMaximumR = [defult valueForKey:[NSString stringWithFormat:@"sort_%@GameRatingMax", prefix]];
    
    NSString* priceMinR = [defult valueForKey:[NSString stringWithFormat:@"sort_%@PriceMin", prefix]];
    NSString* PriceMaxR = [defult valueForKey:[NSString stringWithFormat:@"sort_%@PriceMax", prefix]];
    
    if(!coachMinimumR.length)
    {
        coachMinimumR = @"-1";
    }
    if(!gameMinimumR.length)
    {
        gameMinimumR = @"-1";
    }
    if(!gameMaximumR.length)
    {
        gameMaximumR = @"-1";
    }
    if(!coachMaximumR.length)
    {
        coachMaximumR = @"-1";
    }
    if(!priceMinR.length)
    {
        priceMinR = @"-1";
    }
    if(!PriceMaxR.length)
    {
        PriceMaxR = @"-1";
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
        sort = @"coach_rating_low";
    }
    else if(SelectSortBy == 3)
    {
        sort = @"coach_rating_high";
    }
    else if(SelectSortBy == 4)
    {
        sort = @"game_rating_low";
    }
    else if(SelectSortBy == 5)
    {
        sort = @"game_rating_high";
    }
    else if(SelectSortBy == 6)
    {
        sort = @"price_low";
    }
    else if(SelectSortBy == 7)
    {
        sort = @"price_high";
    }
    
    int nServer =[[defult valueForKey:[NSString stringWithFormat:@"%@server", prefix]] intValue];
    int nPlatform =[[defult valueForKey:[NSString stringWithFormat:@"%@platform", prefix]] intValue];
    
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
    BOOL bCheckRole = [defult boolForKey:[NSString stringWithFormat:@"%@category_coach_role", prefix]];
    NSString* strCategory = [defult objectForKey:[NSString stringWithFormat:@"%@category_coach", prefix]];
    
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
    
    
    [RestClient getLessons:self.nPage sort:sort coachRatingMax:[coachMaximumR floatValue] coachRatingMin:[coachMinimumR floatValue] gameRatingMax:gameMaximumR gameRatingMin:gameMinimumR priceMax:[PriceMaxR floatValue] priceMin:[priceMinR floatValue] server:strServer platform:strPlatform online:SelectAvalibility category:strCategory keyword:self.vcParent.txtSearch.text callback:^(bool result, NSDictionary *data) {
        if(!result)
            return ;
        
        self.bLoading = NO;
        
        NSArray* arTemp = [data objectForKey:@"lessons"];
        
        if(arTemp.count == 0)
        {
            self.bFinish = YES;
            [tableView reloadData];
            return;
        }
        
        for(int i = 0; i < arTemp.count; i++)
        {
            GetGood_Lesson* user = [[GetGood_Lesson alloc] initWithDictionary:[arTemp objectAtIndex:i]];
            
            [arLessons addObject:user];
        }
        
        [tableView reloadData];
    }];
}

- (IBAction)onReady:(id)sender {
    [RestClient getMyLessons:^(bool result, NSDictionary *data) {
        NSMutableArray* arTemp = [data objectForKey:@"lessons"];
        NSMutableArray* _arLessons = [[NSMutableArray alloc] init];
        NSMutableArray* arLessonTitles = [[NSMutableArray alloc] init];
        
        for(int i = 0; i < arTemp.count; i++)
        {
            GetGood_Lesson* lesson = [[GetGood_Lesson alloc] initWithDictionary:[arTemp objectAtIndex:i]];
            
            [_arLessons addObject:lesson];
            [arLessonTitles addObject:lesson.title];
        }
        
        if(arLessonTitles.count == 0)
        {
            return ;
        }
        
        [ActionSheetStringPicker showPickerWithTitle:@"Select a group to be ready" rows:arLessonTitles initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
                                               //           NSLog(@"Picker: %@, Index: %ld, value: %@",picker, (long)selectedIndex, selectedValue);
                                               
                                               GetGood_Lesson *objGroup = [_arLessons objectAtIndex:selectedIndex];
                                               
                                               for(int i = 0 ; i < arLessons.count; i++)
                                               {
                                                   if([((GetGood_Lesson*)[arLessons objectAtIndex:i]).id isEqualToString:objGroup.id])
                                                   {
                                                       
                                                       [RestClient readyLesson:((GetGood_Lesson*)[arLessons objectAtIndex:i]).id callback:^(bool result, NSDictionary *data) {
                                                           
                                                           NSString *strTimestasmp = [[data objectForKey:@"timestamp"] stringValue];
                                                           ((GetGood_Lesson*)[arLessons objectAtIndex:i]).ready = strTimestasmp;
                                                           
                                                           
                                                           CGPoint contentOffset = tableView.contentOffset;
                                                           [tableView reloadData];
                                                           [tableView layoutIfNeeded];
                                                           [tableView setContentOffset:contentOffset];
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


-(NSInteger) tableView:(UITableView *) theTableView numberOfRowsInSection:(NSInteger) section
{
    return arLessons.count;
}

-(UITableViewCell *) tableView:(UITableView *) theTableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    GameCoachCollectionCell *cell = (GameCoachCollectionCell *)[tableView dequeueReusableCellWithIdentifier:@"GameCoachCollectionCell"];
    
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CoachListingTableViewCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    
    GetGood_Lesson *lesson = [arLessons objectAtIndex:indexPath.row];
    
    cell.labelTitle.text = lesson.title;
    cell.labelCoachNameView.text = lesson.owner.name;
    cell.labelDescriptionView.text = lesson.getgood_description;
    

    int readyTime = 0;
    
    @try
    {
        readyTime = [lesson.ready intValue];
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
    
    cell.labelPriceView.text = [NSString stringWithFormat:@"$%.01f/hr",lesson.price];
    

    if(lesson.hero != nil)
    {
        NSArray* arHr = [lesson.hero componentsSeparatedByString: @" "];
        
        int i = 0;
        if([Temp getGameMode] == Overwatch)
        {
            
            for(i = 0; i < [arHr count] ; i++)
            {
                switch (i)
                {
                    case 0:
                        [cell.imageHeroOneView setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 1:
                        [cell.imageHeroTwoView setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 2:
                        [cell.imageHeroThreeView setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 3:
                        [cell.imageHeroFourView setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 4:
                        [cell.imageHeroFiveView setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                        
                    default:
                        break;
                }
            }
        }
        else if([Temp getGameMode] == LeagueOfLegends)
        {
            
            for(i = 0; i < [arHr count] ; i++)
            {
                switch (i)
                {
                    case 0:
                        [cell.imageHeroOneView setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 1:
                        [cell.imageHeroTwoView setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 2:
                        [cell.imageHeroThreeView setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 3:
                        [cell.imageHeroFourView setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 4:
                        [cell.imageHeroFiveView setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                        
                    default:
                        break;
                }
            }
        }
        
        for(int j = i ; j < 5 ; j++)
        {
            switch (j)
            {
                case 0:
                    [cell.imageHeroOneView setHidden:YES];
                    break;
                case 1:
                    [cell.imageHeroTwoView setHidden:YES];
                    break;
                case 2:
                    [cell.imageHeroThreeView setHidden:YES];
                    break;
                case 3:
                    [cell.imageHeroFourView setHidden:YES];
                    break;
                case 4:
                    [cell.imageHeroFiveView setHidden:YES];
                    break;
                    
                default:
                    break;
            }
        }
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", lesson.thumb_url]];
    

    [cell.imageThumbView sd_setImageWithURL:url
                            placeholderImage:nil
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         
         cell.imageThumbView.image = image;
         
     }];
    
    
    if([Temp getGameMode] == Overwatch)
    {
        if(lesson.owner.overwatch_rank != 0)
        {
            [cell.imageRankView setImage: [UIImage imageNamed:[Utils getRankAvatar:lesson.owner.overwatch_rank ]]];
            cell.labelGameRankingView.text = [NSString stringWithFormat:@"%d",lesson.owner.overwatch_rank];
        }
        else
            cell.labelGameRankingView.text = @"---";
        
        cell.ratingCoachView.value = lesson.owner.coach_rating;
        if(lesson.owner.coach_review_count != 0)
        {
            [cell.tvCount setText:[NSString stringWithFormat:@"%d review(s)", lesson.owner.coach_review_count]];
        }
        else
        {
            [cell.tvCount setText:@"(---)"];
        }
        

    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        if(lesson.owner.lol_rank.length)
        {
            [cell.imageRankView setImage:[UIImage imageNamed: [Utils getLolRankAvatar:lesson.owner.lol_rank]]];
            cell.labelGameRankingView.text = [NSString stringWithFormat:@"%@",lesson.owner.lol_rank];
        }
        else
            cell.labelGameRankingView.text = @"---";
        
        cell.ratingCoachView.value = lesson.owner.lol_coach_rating;
        if(lesson.owner.lol_coach_review_count != 0)
        {
            [cell.tvCount setText:[NSString stringWithFormat:@"%d review(s)", lesson.owner.lol_coach_review_count]];
        }
        else
        {
            [cell.tvCount setText:@"(---)"];
        }
        
    }
    

    
    [cell layoutSubviews];
    
    cell.borderedView.frame = CGRectMake(0, 0, tableView.frame.size.width, cell.frame.size.height - 3);
    [cell.borderedView redraw];
    return cell;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    
    if (indexPath.row == arLessons.count-1)  {
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    GetGood_Lesson *lesson = [arLessons objectAtIndex:indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    CoachDetailController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sid_coach_detail_controller"];
    
    [Temp setLessonData:lesson];
    
    [self.navigationController pushViewController:controller animated:YES];
}

-(IBAction) actionCreateLesson:(id) sender
{
//    if(![AppData profile].blizzard_id.length)
//    {
//        [UIKit showInformation:self message:@"Please link your overwatch account."];
//        return;
//    }
    
    [RestClient getMyLessons:^(bool result, NSDictionary *data) {
        if(!result)
            return ;
        
        NSArray* arLessons = [data objectForKey:@"lessons"];
        if(arLessons.count > 4)
        {
            [UIKit showInformation:self message:@"You have only exceeded max lesson count."];
            return;
        }        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        LessonCreateController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sid_create_lesson_controller"];
        [self.navigationController pushViewController:controller animated:YES];
    }];
    
}

#pragma mark - XLPagerTabStripViewControllerDelegate

-(NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"Coaches";
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
    arLessons = [[NSMutableArray alloc] init];
    [tableView reloadData];
}
@end

@implementation GameCoachCollectionCell

@end


