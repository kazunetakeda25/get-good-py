//
//  PlayerRateDisplayController.m
//  getgood
//
//  Created by Md Aminuzzaman on 11/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

@import Firebase;
@import FirebaseDatabase;

#import "TraineeRateDisplayController.h"

@interface TraineeRateDisplayController ()
{
    NSMutableArray *commentRatingArray;
}
@end

@implementation TraineeRateDisplayController

@synthesize userId;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    commentRatingArray = [[NSMutableArray alloc] init];
    
    
    [self loadRatingData];
}

- (void)actionBack:(UITapGestureRecognizer *)tapGesture
{
    [self.navigationController popViewControllerAnimated:YES];
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
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) loadRatingData
{
    
    [RestClient getTraineeReview:userId callback:^(bool result, NSDictionary *data) {
        if(!result)
            return ;
        commentRatingArray = [[NSMutableArray alloc] init];
        NSArray* arRates = [data objectForKey:@"ratings"];
        
        float general = 0.0f;
        
        for(int i = 0; i < arRates.count; i++)
        {
            GetGood_TraineeRate* rate = [[GetGood_TraineeRate alloc] initWithDictionary:[arRates objectAtIndex:i]];
            
            [commentRatingArray addObject:rate];
            
            general += rate.general;
        }
        
        if(arRates.count != 0)
        {
            general /= arRates.count;
        }
        
        [commentTableView reloadData];
    }];
    
    [RestClient readProfile:userId callback:^(bool result, NSDictionary *data) {
        if(!result)
            return ;
        
        User* userProfile = [[User alloc] initWithDictionary:[data objectForKey:@"profile"]];
        
        labelReviewCount.hidden = NO;
        
        labelReviewCount.text = [NSString stringWithFormat:@"(%ld reviews)",(long)userProfile.trainee_review_count ];
        labelReviewPoint.text = [NSString stringWithFormat:@"(%.2f)",userProfile.trainee_rating ];
        
        [ratingTraineeView setValue:userProfile.trainee_rating ];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GetGood_TraineeRate *rating = [commentRatingArray objectAtIndex:indexPath.row];
    
    CGSize constraint = CGSizeMake(tableView.frame.size.width - 32, CGFLOAT_MAX);
    CGSize size;
    UIFont *font = [UIFont fontWithName:@"Poppins-Regular" size:14.0f];
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [rating.comment boundingRectWithSize:constraint
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:@{NSFontAttributeName:font}
                                                      context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return 90 + size.height;
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

-(UITableViewCell *) tableView:(UITableView *) theTableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    GetGood_TraineeRate *rating = [commentRatingArray objectAtIndex:indexPath.row];
    
    TraineeCommentTableViewCell *cell = (TraineeCommentTableViewCell *)[theTableView dequeueReusableCellWithIdentifier:@"TraineeCommentTableViewCell"];
    
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TraineeCommentTableViewCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    
    cell.labelNote.text = rating.comment;
    
  
    cell.ratingView.value = rating.general ;
    
    cell.labelUserName.text = rating.name;
    
    CGSize constraint = CGSizeMake(theTableView.frame.size.width - 32, CGFLOAT_MAX);
    CGSize size;
    UIFont *font = [UIFont fontWithName:@"Poppins-Regular" size:15.0f];
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [rating.comment boundingRectWithSize:constraint
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:@{NSFontAttributeName:font}
                                                      context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    cell.commentHeight.constant = size.height +10;
    
    [cell layoutSubviews];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
}

@end


@implementation TraineeCommentTableViewCell

@end


