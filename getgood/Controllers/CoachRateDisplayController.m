//
//  PlayerRateDisplayController.m
//  getgood
//
//  Created by Md Aminuzzaman on 11/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

@import Firebase;
@import FirebaseDatabase;

#import "Utils.h"
#import "CoachRateHelpController.h"
#import "CoachRateDisplayController.h"

@interface CoachRateDisplayController ()
{
    NSMutableArray *commentRatingArray;
    int nPos;
}
@end

@implementation CoachRateDisplayController

@synthesize userId;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:false];
    
    
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initUI
{
    commentRatingArray = [[NSMutableArray alloc] init];
    nPos = -1;
    
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionHelp:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageHelp addGestureRecognizer:tapGestureRecognizer];
    imageHelp.userInteractionEnabled = YES;
    
    if([Utils isVisited:@"coach_rate"])
        [imageHelp setImage:[UIImage imageNamed:@"glow_help"]];
    else
        [imageHelp setImage:[UIImage imageNamed:@"help"]];
    
    [self loadRatingData];
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)actionHelp:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    CoachRateHelpController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_coach_rating_help"];
    
    [self.navigationController pushViewController:controller animated:YES];
}

-(void) loadRatingData
{
    [RestClient getCoachReview:userId callback:^(bool result, NSDictionary *data) {
       if(!result)
           return ;
        commentRatingArray = [[NSMutableArray alloc] init];
        NSArray* arRates = [data objectForKey:@"ratings"];
        
        float attitude = 0.0f;
        float competency = 0.0f;
        float communication = 0.0f;
        float flexibility = 0.0f;
        
        for(int i = 0; i < arRates.count; i++)
        {
            GetGood_CoachRate* rate = [[GetGood_CoachRate alloc] initWithDictionary:[arRates objectAtIndex:i]];
            
            [commentRatingArray addObject:rate];
            
            attitude += rate.attitude;
            competency += rate.competency;
            communication += rate.communication;
            flexibility += rate.flexibility;
        }
        
        if(arRates.count != 0)
        {
            attitude /= arRates.count;
            competency /= arRates.count;
            communication /= arRates.count;
            flexibility /= arRates.count;
        }
        
        [ratingAttitudeView setValue:attitude];
        [ratingCompetencyView setValue:competency];
        [ratingCommunicationView setValue:communication];
        [ratingFlexibilityView setValue:flexibility];
        
        [commentTableView reloadData];
    }];
    
    [RestClient readProfile:userId callback:^(bool result, NSDictionary *data) {
        if(!result)
            return ;
        
        User* userProfile = [[User alloc] initWithDictionary:[data objectForKey:@"profile"]];
        
        labelReviewCount.hidden = NO;
        
        if([Temp getGameMode] == Overwatch)
        {
            labelReviewCount.text = [NSString stringWithFormat:@"(%ld reviews)",(long)userProfile.coach_review_count ];
            labelReviewPoint.text = [NSString stringWithFormat:@"(%.2f)",userProfile.coach_rating ];
            
            [ratingCoachView setValue:userProfile.coach_rating ];
        }
        else if([Temp getGameMode] == LeagueOfLegends)
        {
            labelReviewCount.text = [NSString stringWithFormat:@"(%ld reviews)",(long)userProfile.lol_coach_review_count ];
            labelReviewPoint.text = [NSString stringWithFormat:@"(%.2f)",userProfile.lol_coach_rating ];
            
            [ratingCoachView setValue:userProfile.lol_coach_rating ];
        }
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
    return commentRatingArray.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 83.0f;
    
    
    GetGood_CoachRate *rating = [commentRatingArray objectAtIndex:indexPath.row];

    CGSize constraint = CGSizeMake(tableView.frame.size.width - 32, CGFLOAT_MAX);
    CGSize size;
    UIFont *font = [UIFont fontWithName:@"Poppins-Regular" size:14.0f];

    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [rating.comment boundingRectWithSize:constraint
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:@{NSFontAttributeName:font}
                                                      context:context].size;

    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));

    height += size.height;
    if(nPos == indexPath.row)
    {
        height += 94.0f;
    }
    
    return height;
}

-(UITableViewCell *) tableView:(UITableView *) theTableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    GetGood_CoachRate *rating = [commentRatingArray objectAtIndex:indexPath.row];
        
    CoachCommentTableViewCell *cell = (CoachCommentTableViewCell *)[theTableView dequeueReusableCellWithIdentifier:@"CoachCommentTableViewCell"];
        
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CoachCommentTableViewCell" owner:self options:nil];
            
        cell = [nib objectAtIndex:0];
    }
        
    cell.labelNote.text = rating.comment;
    
    float attitude = rating.attitude ;
    float communication = rating.communication ;
    float flexibility = rating.flexibility ;
    float competency = rating.competency ;
    
    float avg = (attitude + communication + flexibility + competency) / 4;
    
    cell.ratingView.value = avg;
    cell.labelUserName.text = rating.name;
    
    CGSize constraint = CGSizeMake(theTableView.frame.size.width - 32, CGFLOAT_MAX);
    CGSize size;
    UIFont *font = [UIFont fontWithName:@"Poppins-Regular" size:14.0f];
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [rating.comment boundingRectWithSize:constraint
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:@{NSFontAttributeName:font}
                                                      context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    cell.commentHeight.constant = size.height;
    if(indexPath.row == nPos)
    {
        cell.rateHeight.constant = 88.0f;
    }
    else
    {
        cell.rateHeight.constant = 0.0f;
    }

    cell.ratingCompetency.value = rating.competency;
    cell.ratingCommunication.value = rating.communication;
    cell.ratingFlexibility.value = rating.flexibility;
    cell.ratingAttitude.value = rating.attitude;
    
    [cell layoutSubviews];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(nPos == indexPath.row)
    {
        nPos = -1;
    }
    else
    {
        nPos = indexPath.row;
    }
    
    [tableView reloadData];
}

@end


@implementation CoachCommentTableViewCell

@end


