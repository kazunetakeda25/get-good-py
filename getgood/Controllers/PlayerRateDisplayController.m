//
//  PlayerRateDisplayController.m
//  getgood
//
//  Created by Md Aminuzzaman on 11/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

@import Firebase;
@import FirebaseDatabase;

#import "PlayerRateHelpController.h"
#import "PlayerRateDisplayController.h"

@interface PlayerRateDisplayController ()
{
    NSMutableArray *summaryRatingPointArray;
    NSMutableArray *summaryRatingTitleArray;
    
    NSMutableArray *commentRatingArray;
}

@end

@implementation PlayerRateDisplayController

@synthesize userId;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    summaryRatingPointArray = [[NSMutableArray alloc] init];
    
    summaryRatingTitleArray = [NSMutableArray arrayWithObjects:
                          @"Leader",
                          @"Cooperative",
                          @"Good Communication",
                          @"Sportsmanship",
                          @"MVP",
                          @"Flex Player",
                          @"Good Hero Competency",
                          @"Good Ultimate Usage",
                          @"Abusive Chat",
                          @"Griefing",
                          @"Spam",
                          @"No Communication",
                          @"Un-Cooperative",
                          @"Trickling In",
                          @"Poor Hero Competency",
                          @"Bad Ultimate Usage",
                          @"Overextending",
                          nil];
    
    
    [summaryRatingPointArray addObject:[NSNumber numberWithInt:0]];
    [summaryRatingPointArray addObject:[NSNumber numberWithInt:0]];
    [summaryRatingPointArray addObject:[NSNumber numberWithInt:0]];
    [summaryRatingPointArray addObject:[NSNumber numberWithInt:0]];
    [summaryRatingPointArray addObject:[NSNumber numberWithInt:0]];
    [summaryRatingPointArray addObject:[NSNumber numberWithInt:0]];
    [summaryRatingPointArray addObject:[NSNumber numberWithInt:0]];
    [summaryRatingPointArray addObject:[NSNumber numberWithInt:0]];
    [summaryRatingPointArray addObject:[NSNumber numberWithInt:0]];
    [summaryRatingPointArray addObject:[NSNumber numberWithInt:0]];
    [summaryRatingPointArray addObject:[NSNumber numberWithInt:0]];
    [summaryRatingPointArray addObject:[NSNumber numberWithInt:0]];
    [summaryRatingPointArray addObject:[NSNumber numberWithInt:0]];
    [summaryRatingPointArray addObject:[NSNumber numberWithInt:0]];
    [summaryRatingPointArray addObject:[NSNumber numberWithInt:0]];
    [summaryRatingPointArray addObject:[NSNumber numberWithInt:0]];
    [summaryRatingPointArray addObject:[NSNumber numberWithInt:0]];
    
    commentRatingArray = [[NSMutableArray alloc] init];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionHelp:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageHelp addGestureRecognizer:tapGestureRecognizer];
    imageHelp.userInteractionEnabled = YES;
    
    [self loadRatingData];
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)actionHelp:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    PlayerRateHelpController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_player_rating_help"];
    
    [self.navigationController pushViewController:controller animated:YES];
}


-(void) loadRatingData
{
    
    
    [RestClient getPlayerReview:userId callback:^(bool result, NSDictionary *data) {
        if(!result)
            return ;
        commentRatingArray = [[NSMutableArray alloc] init];
        NSArray* arRates = [data objectForKey:@"ratings"];
        
        float general = 0.0f;
        
        for(int i = 0; i < arRates.count; i++)
        {
            GetGood_PlayerRate* rate = [[GetGood_PlayerRate alloc] initWithDictionary:[arRates objectAtIndex:i]];
            
            [commentRatingArray addObject:rate];
        }
        
        
        for(int i = 0; i < commentRatingArray.count; i++)
        {
            GetGood_PlayerRate* rate = [commentRatingArray objectAtIndex:i];
            
            
            if(rate.leader  == 1)
            {
                int valueInc = [[summaryRatingPointArray objectAtIndex:0] intValue] + 1;
                
                NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
                
                [summaryRatingPointArray replaceObjectAtIndex:0 withObject:numberValue];
            }
            if(rate.cooperative  == 1)
            {
                int valueInc = [[summaryRatingPointArray objectAtIndex:1] intValue] + 1;
                
                NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
                
                [summaryRatingPointArray replaceObjectAtIndex:1 withObject:numberValue];
            }
            if(rate.good_communication  == 1)
            {
                int valueInc = [[summaryRatingPointArray objectAtIndex:2] intValue] + 1;
                
                NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
                
                [summaryRatingPointArray replaceObjectAtIndex:2 withObject:numberValue];
            }
            if(rate.sportsmanship  == 1)
            {
                int valueInc = [[summaryRatingPointArray objectAtIndex:3] intValue] + 1;
                
                NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
                
                [summaryRatingPointArray replaceObjectAtIndex:3 withObject:numberValue];
            }
            if(rate.mvp  == 1)
            {
                int valueInc = [[summaryRatingPointArray objectAtIndex:4] intValue] + 1;
                
                NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
                
                [summaryRatingPointArray replaceObjectAtIndex:4 withObject:numberValue];
            }
            if(rate.flex_player  == 1)
            {
                int valueInc = [[summaryRatingPointArray objectAtIndex:5] intValue] + 1;
                
                NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
                
                [summaryRatingPointArray replaceObjectAtIndex:5 withObject:numberValue];
            }
            if(rate.good_hero_competency  == 1)
            {
                int valueInc = [[summaryRatingPointArray objectAtIndex:6] intValue] + 1;
                
                NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
                
                [summaryRatingPointArray replaceObjectAtIndex:6 withObject:numberValue];
            }
            if(rate.good_ultimate_usage  == 1)
            {
                int valueInc = [[summaryRatingPointArray objectAtIndex:7] intValue] + 1;
                
                NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
                
                [summaryRatingPointArray replaceObjectAtIndex:7 withObject:numberValue];
            }
            if(rate.abusive_chat  == 1)
            {
                int valueInc = [[summaryRatingPointArray objectAtIndex:8] intValue] + 1;
                
                NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
                
                [summaryRatingPointArray replaceObjectAtIndex:8 withObject:numberValue];
            }
            if(rate.griefing  == 1)
            {
                int valueInc = [[summaryRatingPointArray objectAtIndex:9] intValue] + 1;
                
                NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
                
                [summaryRatingPointArray replaceObjectAtIndex:9 withObject:numberValue];
            }
            if(rate.spam  == 1)
            {
                int valueInc = [[summaryRatingPointArray objectAtIndex:10] intValue] + 1;
                
                NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
                
                [summaryRatingPointArray replaceObjectAtIndex:10 withObject:numberValue];
            }
            if(rate.no_communication  == 1)
            {
                int valueInc = [[summaryRatingPointArray objectAtIndex:11] intValue] + 1;
                
                NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
                
                [summaryRatingPointArray replaceObjectAtIndex:11 withObject:numberValue];
            }
            if(rate.un_cooperative  == 1)
            {
                int valueInc = [[summaryRatingPointArray objectAtIndex:12] intValue] + 1;
                
                NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
                
                [summaryRatingPointArray replaceObjectAtIndex:12 withObject:numberValue];
            }
            if(rate.trickling_in  == 1)
            {
                int valueInc = [[summaryRatingPointArray objectAtIndex:13] intValue] + 1;
                
                NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
                
                [summaryRatingPointArray replaceObjectAtIndex:13 withObject:numberValue];
            }
            if(rate.poor_hero_competency  == 1)
            {
                int valueInc = [[summaryRatingPointArray objectAtIndex:14] intValue] + 1;
                
                NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
                
                [summaryRatingPointArray replaceObjectAtIndex:14 withObject:numberValue];
            }
            if(rate.bad_ultimate_usage  == 1)
            {
                int valueInc = [[summaryRatingPointArray objectAtIndex:15] intValue] + 1;
                
                NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
                
                [summaryRatingPointArray replaceObjectAtIndex:15 withObject:numberValue];
            }
            if(rate.overextending  == 1)
            {
                int valueInc = [[summaryRatingPointArray objectAtIndex:16] intValue] + 1;
                
                NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
                
                [summaryRatingPointArray replaceObjectAtIndex:16 withObject:numberValue];
            }
        }
        
        if(arRates.count != 0)
        {
            general /= arRates.count;
        }
        
        
        
        [commentTableView reloadData];
        [summaryTableView reloadData];
    }];
    
    [RestClient readProfile:userId callback:^(bool result, NSDictionary *data) {
        if(!result)
            return ;
        
        User* userProfile = [[User alloc] initWithDictionary:[data objectForKey:@"profile"]];
        
        labelReviewCount.hidden = NO;
        
        labelReviewCount.text = [NSString stringWithFormat:@"(%ld reviews)",(long)userProfile.player_review_count ];
        labelReviewPoint.text = [NSString stringWithFormat:@"(%.02f)",userProfile.player_rating ];
        
        ratingPlayerView.value = userProfile.player_rating;
    }];
//
//    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
//
//    [[[ref child:@"profile"] child:self.userId]
//     observeSingleEventOfType:FIRDataEventTypeValue
//     withBlock:^(FIRDataSnapshot *_Nonnull snapshot)
//     {
//         UserProfile *userProfile = [[UserProfile alloc] initWithDictionary:snapshot.value];
//
//         [ratingPlayerView setValue: [userProfile.playerReview integerValue]];
//
//         labelReviewCount.text = [NSString stringWithFormat:@"(%ld reviews)",(long)[userProfile.playerReviewCount integerValue]];
//         labelReviewPoint.text = [NSString stringWithFormat:@"(%.2f)",[userProfile.playerReview floatValue]];
//     }];
//
//    [[[[ref child:@"profile"] child:self.userId]
//      child:@"PlayerReviews"]
//     observeSingleEventOfType:FIRDataEventTypeValue
//     withBlock:^(FIRDataSnapshot *_Nonnull snapshot)
//     {
//         if(![snapshot.value isEqual:[NSNull null]])
//             return;
//
//
//         for(FIRDataSnapshot *shot in snapshot.children)
//         {
//             PlayerRate *rate = [[PlayerRate alloc] initWithDictionary:shot.value];
//
//             [commentRatingArray addObject:rate];
//
//             if([rate.teamLeader integerValue] == 1)
//             {
//                 int valueInc = [[summaryRatingPointArray objectAtIndex:0] intValue] + 1;
//
//                 NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
//
//                 [summaryRatingPointArray replaceObjectAtIndex:0 withObject:numberValue];
//             }
//             if([rate.cooperativePlayer integerValue] == 1)
//             {
//                 int valueInc = [[summaryRatingPointArray objectAtIndex:1] intValue] + 1;
//
//                 NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
//
//                 [summaryRatingPointArray replaceObjectAtIndex:1 withObject:numberValue];
//             }
//             if([rate.goodCommunication integerValue] == 1)
//             {
//                 int valueInc = [[summaryRatingPointArray objectAtIndex:2] intValue] + 1;
//
//                 NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
//
//                 [summaryRatingPointArray replaceObjectAtIndex:2 withObject:numberValue];
//             }
//             if([rate.sportsmanShip integerValue] == 1)
//             {
//                 int valueInc = [[summaryRatingPointArray objectAtIndex:3] intValue] + 1;
//
//                 NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
//
//                 [summaryRatingPointArray replaceObjectAtIndex:3 withObject:numberValue];
//             }
//             if([rate.mVP integerValue] == 1)
//             {
//                 int valueInc = [[summaryRatingPointArray objectAtIndex:4] intValue] + 1;
//
//                 NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
//
//                 [summaryRatingPointArray replaceObjectAtIndex:4 withObject:numberValue];
//             }
//             if([rate.flexPlayer integerValue] == 1)
//             {
//                 int valueInc = [[summaryRatingPointArray objectAtIndex:5] intValue] + 1;
//
//                 NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
//
//                 [summaryRatingPointArray replaceObjectAtIndex:5 withObject:numberValue];
//             }
//             if([rate.goodHeroCompetency integerValue] == 1)
//             {
//                 int valueInc = [[summaryRatingPointArray objectAtIndex:6] intValue] + 1;
//
//                 NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
//
//                 [summaryRatingPointArray replaceObjectAtIndex:6 withObject:numberValue];
//             }
//             if([rate.goodUltimateUsage integerValue] == 1)
//             {
//                 int valueInc = [[summaryRatingPointArray objectAtIndex:7] intValue] + 1;
//
//                 NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
//
//                 [summaryRatingPointArray replaceObjectAtIndex:7 withObject:numberValue];
//             }
//             if([rate.abusiveChat integerValue] == 1)
//             {
//                 int valueInc = [[summaryRatingPointArray objectAtIndex:8] intValue] + 1;
//
//                 NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
//
//                 [summaryRatingPointArray replaceObjectAtIndex:8 withObject:numberValue];
//             }
//             if([rate.griefingAndInactivity integerValue] == 1)
//             {
//                 int valueInc = [[summaryRatingPointArray objectAtIndex:9] intValue] + 1;
//
//                 NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
//
//                 [summaryRatingPointArray replaceObjectAtIndex:9 withObject:numberValue];
//             }
//             if([rate.spam integerValue] == 1)
//             {
//                 int valueInc = [[summaryRatingPointArray objectAtIndex:10] intValue] + 1;
//
//                 NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
//
//                 [summaryRatingPointArray replaceObjectAtIndex:10 withObject:numberValue];
//             }
//             if([rate.noCommunication integerValue] == 1)
//             {
//                 int valueInc = [[summaryRatingPointArray objectAtIndex:11] intValue] + 1;
//
//                 NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
//
//                 [summaryRatingPointArray replaceObjectAtIndex:11 withObject:numberValue];
//             }
//             if([rate.unCooperativePlayer integerValue] == 1)
//             {
//                 int valueInc = [[summaryRatingPointArray objectAtIndex:12] intValue] + 1;
//
//                 NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
//
//                 [summaryRatingPointArray replaceObjectAtIndex:12 withObject:numberValue];
//             }
//             if([rate.tricklingIn integerValue] == 1)
//             {
//                 int valueInc = [[summaryRatingPointArray objectAtIndex:13] intValue] + 1;
//
//                 NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
//
//                 [summaryRatingPointArray replaceObjectAtIndex:13 withObject:numberValue];
//             }
//             if([rate.poorHeroCompetency integerValue] == 1)
//             {
//                 int valueInc = [[summaryRatingPointArray objectAtIndex:14] intValue] + 1;
//
//                 NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
//
//                 [summaryRatingPointArray replaceObjectAtIndex:14 withObject:numberValue];
//             }
//             if([rate.badUltimateUsage integerValue] == 1)
//             {
//                 int valueInc = [[summaryRatingPointArray objectAtIndex:15] intValue] + 1;
//
//                 NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
//
//                 [summaryRatingPointArray replaceObjectAtIndex:15 withObject:numberValue];
//             }
//             if([rate.overextending integerValue] == 1)
//             {
//                 int valueInc = [[summaryRatingPointArray objectAtIndex:16] intValue] + 1;
//
//                 NSNumber *numberValue = [NSNumber numberWithInt:valueInc];
//
//                 [summaryRatingPointArray replaceObjectAtIndex:16 withObject:numberValue];
//             }
//         }
//
//         [commentTableView reloadData];
//     }];
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:false];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if(theTableView == summaryTableView)
        return summaryRatingTitleArray.count;
    else if(theTableView == commentTableView)
        return commentRatingArray.count;
    else
        return 0;
}

-(UITableViewCell *) tableView:(UITableView *) theTableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(theTableView == summaryTableView)
    {
        NSString *summaryString = [summaryRatingTitleArray objectAtIndex:indexPath.row];
        
        NSNumber *point = [summaryRatingPointArray objectAtIndex:indexPath.row];
        
        SummaryTableViewCell *cell = (SummaryTableViewCell *)[theTableView dequeueReusableCellWithIdentifier:@"SummaryTableViewCell"];
        
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SummaryTableViewCell" owner:self options:nil];
            
            cell = [nib objectAtIndex:0];
        }
        
        cell.labelTitle.text = summaryString;
        cell.labelRatePoint.text = [NSString stringWithFormat:@"(%ld)",(long)[point integerValue]];
        
        return cell;
    }
    else
    {
        GetGood_PlayerRate *rating = [commentRatingArray objectAtIndex:indexPath.row];
        
        CommentTableViewCell *cell = (CommentTableViewCell *)[theTableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell"];
        
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommentTableViewCell" owner:self options:nil];
            
            cell = [nib objectAtIndex:0];
        }
        
        cell.labelNote.text = rating.comment;
        
        CGSize constraint = CGSizeMake(theTableView.frame.size.width - 16, CGFLOAT_MAX);
        CGSize size;
        UIFont *font = [UIFont fontWithName:@"Poppins-Regular" size:13.0f];
        
        NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
        CGSize boundingBox = [rating.comment boundingRectWithSize:constraint
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:@{NSFontAttributeName:font}
                                                          context:context].size;
        
        size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
        [cell.labelNote setFrame:CGRectMake(cell.labelNote.frame.origin.x, cell.labelNote.frame.origin.y, cell.labelNote.frame.size.width, boundingBox.height)];
        cell.labelUserName.text = rating.name;
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView != summaryTableView)
    {
        GetGood_PlayerRate *rating = [commentRatingArray objectAtIndex:indexPath.row];
        
        CGSize constraint = CGSizeMake(tableView.frame.size.width - 16, CGFLOAT_MAX);
        CGSize size;
        UIFont *font = [UIFont fontWithName:@"Poppins-Regular" size:13.0f];
        
        NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
        CGSize boundingBox = [rating.comment boundingRectWithSize:constraint
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:@{NSFontAttributeName:font}
                                                      context:context].size;
        
        size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
        
        return size.height + 55.0f;
    }
    
    return 35.0f;
}

@end

@implementation SummaryTableViewCell

@end

@implementation CommentTableViewCell

@end

