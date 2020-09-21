//
//  CoachDetailController.m
//  getgood
//
//  Created by Md Aminuzzaman on 26/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "Utils.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "CoachDetailController.h"
#import "AppData.h"
#import "UIImageView+WebCache.h"

@interface CoachDetailController ()
{
    NSMutableArray *videoArray;
}

@end

@implementation CoachDetailController

@synthesize lessonViewModel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    videoArray = [[NSMutableArray alloc] init];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionBack:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageBack addGestureRecognizer:tapGestureRecognizer];
    imageBack.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionEdit:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageEdit addGestureRecognizer:tapGestureRecognizer];
    imageEdit.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionDelete:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageDelete addGestureRecognizer:tapGestureRecognizer];
    imageDelete.userInteractionEnabled = YES;
    
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionProfile:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [labelCoach addGestureRecognizer:tapGestureRecognizer];
    labelCoach.userInteractionEnabled = YES;
    
    [collectionCoachVideo reloadData];
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onCoachRating:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    CoachRateDisplayController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_coach_rating"];
    
    controller.userId = lessonViewModel.owner.id;
    
    [self.navigationController pushViewController:controller animated:YES];
}

-(void) feedUI
{
    lessonViewModel = [Temp lessonData];
    
    
    labelName.text = lessonViewModel.title;
    labelCoach.text = lessonViewModel.owner.name;
    labelDescription.text = lessonViewModel.getgood_description;
    

    
    labelServer.text = @"";
    [ivPlatform setImage:nil];
    
    if([Temp getGameMode] == Overwatch)
    {
        if(lessonViewModel.owner.overwatch_rank != 0)
        {
            [ivGameRanking setHidden:NO];
            [ivGameRanking setImage:[UIImage imageNamed: [Utils getRankAvatar:lessonViewModel.owner.overwatch_rank]]];
            
            //        labelInGameRating.text = [NSString stringWithFormat:@"%d",lessonViewModel.owner.overwatch_rank];
        }
        else
            [ivGameRanking setHidden:YES];

        if(lessonViewModel.owner.server.length)
        {
            if([lessonViewModel.owner.server containsString:@"us"])
            {
                labelServer.text = @"Americas";
            }
            else if([lessonViewModel.owner.server containsString:@"eu"])
            {
                labelServer.text = @"Europe";
            }
            else if([lessonViewModel.owner.server containsString:@"kr"])
            {
                labelServer.text = @"Asia";
            }
            if([lessonViewModel.owner.server containsString:@"pc"])
            {
                [ivPlatform setImage:[UIImage imageNamed:@"pc"]];
            }
            else if([lessonViewModel.owner.server containsString:@"xbox"])
            {
                [ivPlatform setImage:[UIImage imageNamed:@"xbox"]];
            }
            else if([lessonViewModel.owner.server containsString:@"ps4"])
            {
                [ivPlatform setImage:[UIImage imageNamed:@"ps4"]];
            }
        }
        
        
        ratingCoach.value = lessonViewModel.owner.coach_rating;
        labelCoachRating.text = [NSString stringWithFormat:@"(%.2f)",lessonViewModel.owner.coach_rating];
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        
        if(lessonViewModel.owner.lol_rank.length)
        {
            [ivGameRanking setHidden:NO];
            [ivGameRanking setImage:[UIImage imageNamed: [Utils getLolRankAvatar:lessonViewModel.owner.lol_rank]]];
            
            [ivPlatform setImage:[UIImage imageNamed:@"pc"]];
//            labelCoachRating.text = [NSString stringWithFormat:@"%d",lessonViewModel.owner.overwatch_rank];
        }
        else
            [ivGameRanking setHidden:YES];
        
        [labelServer setText:[Utils getLolServerName:lessonViewModel.owner.lol_server]];
        
        
        ratingCoach.value = lessonViewModel.owner.lol_coach_rating;
        labelCoachRating.text = [NSString stringWithFormat:@"(%.2f)",lessonViewModel.owner.lol_coach_rating];
    }
    
    
    labelPrice.text = [NSString stringWithFormat:@"$%.1f/hr",lessonViewModel.price  ];
    
    
    
    NSArray* arVd = [lessonViewModel.videos componentsSeparatedByString: @","];
    videoArray = [[NSMutableArray alloc] init];
    for(int i = 0 ; i < arVd.count ; ++i)
    {
        NSString *string = arVd[i];
        
        NSError *error;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\\s]+"
                                                                               options:nil
                                                                                 error:&error];
        NSString *str2 = [regex stringByReplacingMatchesInString:string
                                                         options:nil
                                                           range:NSMakeRange(0, [string length])
                                                    withTemplate:@""];
        NSLog(@"%@", str2);
       
        
        [videoArray addObject: str2];
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", lessonViewModel.thumb_url]];
    [imageCoach sd_setImageWithURL:url];
    //if([Utils checkDateAvailability:lessonViewModel.featured])
    //    imageViewPromot.hidden = YES;
    
    [collectionCoachVideo reloadData];
    
    if([lessonViewModel.owner.id isEqualToString:[AppData profile].id])
    {
        [imageEdit setHidden:NO];
        [imageDelete setHidden:NO];
        
        self.chatHeight.constant = 0;
    }
    
    CGSize constraint = CGSizeMake(labelDescription.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    UIFont *font = [UIFont fontWithName:@"Poppins-Regular" size:9.0f];
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [lessonViewModel.getgood_description boundingRectWithSize:constraint
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:@{NSFontAttributeName:font}
                                                      context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    self.descHeight.constant = size.height;
    
    [self.view layoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self feedUI];
}


- (void)actionBack:(UITapGestureRecognizer *)tapGesture
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)actionEdit:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LessonCreateController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sid_create_lesson_controller"];
    controller.bEdit = YES;
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)actionDelete:(UITapGestureRecognizer *)tapGesture
{
    [UIKit showLoading];
    [RestClient deleteLesson:lessonViewModel.id callback:^(bool result, NSDictionary *data) {
        [UIKit dismissDialog];
        
        if(!result)
            return ;
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)actionProfile:(UITapGestureRecognizer *)tapGesture
{
    if(lessonViewModel.owner == nil)
        return;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ProfileController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sid_profile_controller"];
    controller.profile = lessonViewModel.owner;
    [self.navigationController pushViewController:controller animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return videoArray.count;
}

- (IBAction)onChat:(id)sender {

    [RestClient createDialog:@"2" reference:lessonViewModel.id receiver:lessonViewModel.owner_id callback:^(bool result, NSDictionary *data) {
        if(!result)
            return;
        GetGood_Dialog* dialog = [[GetGood_Dialog alloc] initWithDictionary:[data objectForKey:@"dialog"]];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        ChatController *controller = [storyboard instantiateViewControllerWithIdentifier:@"ChatController"];
        
        [Temp setDialogData:dialog];
        
        [self.navigationController pushViewController:controller animated:YES];

    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/2 - 14 , 140);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CoachDetailVideoCell *cell = (CoachDetailVideoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CoachDetailVideoCell" forIndexPath:indexPath];
    
    NSString *stringUrl = [videoArray objectAtIndex:indexPath.row];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://img.youtube.com/vi/%@/0.jpg", stringUrl]];

    [cell.imageThumb sd_setImageWithURL:url];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *stringUrl = [videoArray objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/watch?v=%@", stringUrl]]];
}

@end

@implementation CoachDetailVideoCell

@end

@implementation NSString(RegularExpression)

- (NSString *)replacingWithPattern:(NSString *)pattern withTemplate:(NSString *)withTemplate error:(NSError **)error {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:error];
    return [regex stringByReplacingMatchesInString:self
                                           options:0
                                             range:NSMakeRange(0, self.length)
                                      withTemplate:withTemplate];
}

@end


