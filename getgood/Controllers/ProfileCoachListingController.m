//
//  ProfileCoachListingController.m
//  getgood
//
//  Created by Md Aminuzzaman on 25/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "Utils.h"
#import "AppData.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "CoachDetailController.h"
#import "ProfileCoachListingController.h"

@interface ProfileCoachListingController ()
{
    NSMutableArray *arrLessons;
}

@end

@implementation ProfileCoachListingController
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
    
    arrLessons = [[NSMutableArray alloc] init];
    if(strUserID == nil)
    {
        strUserID = [AppData profile].id;
    }
    
    [RestClient getLessonsWithUserID:strUserID callback:^(bool result, NSDictionary *data) {
        
        arrLessons = [[NSMutableArray alloc] init];
        NSArray* arTemp = [data objectForKey:@"lessons"];
        
        for(int i = 0; i < arTemp.count; i++)
        {
            GetGood_Lesson* lesson = [[GetGood_Lesson alloc] initWithDictionary:[arTemp objectAtIndex:i]];
            
            [arrLessons addObject:lesson];
        }
        
        [tableView reloadData];
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
    return arrLessons.count;
}

-(UITableViewCell *) tableView:(UITableView *) theTableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    CoachListingTableViewCell *cell = (CoachListingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CoachListingTableViewCell"];
    
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CoachListingTableViewCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    
    [cell.imageThumbView setImage:nil];
    GetGood_Lesson *lesson = [arrLessons objectAtIndex:indexPath.row];
    
//    if([Utils checkDateAvailability:lesson.featured] == YES)
//    {
//        [cell.imageFeaturedView setHidden:NO];
//    }
//    else
//    {
//        [cell.imageFeaturedView setHidden:YES];
//    }
    
    cell.labelTitle.text = lesson.title;
    cell.labelCoachNameView.text = lesson.owner.name;
    cell.labelDescriptionView.text = lesson.getgood_description;
    cell.ratingCoachView.value = lesson.owner.coach_rating;
    
    [cell.imageRankView setImage:[UIImage imageNamed:[Utils getRankAvatar:lesson.owner.overwatch_rank ]]];
    
    cell.labelPriceView.text = [NSString stringWithFormat:@"$%.02f/hr",lesson.price];
    [cell.imageThumbView setImage:nil];
    
    [cell.imageHeroOneView setImage:nil];
    [cell.imageHeroTwoView setImage:nil];
    [cell.imageHeroThreeView setImage:nil];
    [cell.imageHeroFourView setImage:nil];
    [cell.imageHeroFiveView setImage:nil];
    
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
        
        
        
        for(int j = i ; j < 5 ; ++j)
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
    
    [cell.imageThumbView sd_setImageWithURL:url];
    
  
    if([Temp getGameMode] == Overwatch)
    {
        if(lesson.owner.overwatch_rank != 0)
        {
            [cell.imageRankView setImage: [UIImage imageNamed:[Utils getRankAvatar:lesson.owner.overwatch_rank ]]];
            cell.labelGameRankingView.text = [NSString stringWithFormat:@"%d",lesson.owner.overwatch_rank];
        }
        else
            cell.labelGameRankingView.text = @"---";
        
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
    }
    

    [cell layoutSubviews];
    
    NSLog(@"%f", cell.frame.size.width);
    cell.borderedView.frame = CGRectMake(0, 0, tableView.frame.size.width, cell.frame.size.height - 5);
    [cell.borderedView layoutSubviews];
    [cell.borderedView redraw];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    GetGood_Lesson *lesson = [arrLessons objectAtIndex:indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    CoachDetailController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sid_coach_detail_controller"];
    
    [Temp setLessonData:lesson];
    
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - XLPagerTabStripViewControllerDelegate

-(NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"Coach Listing";
}

-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f];
}

@end

@implementation CoachListingTableViewCell

@end

