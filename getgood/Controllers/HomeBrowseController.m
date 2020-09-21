//
//  HomeBrowseController.m
//  getgood
//
//  Created by Md Aminuzzaman on 21/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "GameController.h"
#import "HomeBrowseController.h"

@interface HomeBrowseController ()
{
    NSArray *browseNameArray;
    NSArray *browseImageArray;
}

@end

@implementation HomeBrowseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    screenWidth=[[UIScreen mainScreen] bounds].size.width;
    cellSize = CGSizeMake(((screenWidth - 16)/2)-2,170);

    browseImageArray = [NSArray arrayWithObjects:@"overwatch", @"leagueoflegends",
    @"cs", @"dota", @"fortnite", @"pubg", nil];
    
     browseNameArray = [NSArray arrayWithObjects:@"Overwatch", @"League of Legends",
                       @"CS GO", @"Dota2", @"Fortnite",  @"PUBG",nil];
    
    [collectionView reloadData];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
   
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     [collectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UIEdgeInsets)collectionView:(UICollectionView *) collectionView
                        layout:(UICollectionViewLayout *) collectionViewLayout
        insetForSectionAtIndex:(NSInteger) section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *) collectionView
                   layout:(UICollectionViewLayout *) collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger) section {
    return 1.0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BrowseCollectionCell *cell = (BrowseCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
   
    if(indexPath.row < 2)
        cell.imageComingSoonView.hidden = YES;
    else
        cell.imageComingSoonView.hidden = NO;
    
    cell.labelNameView.text = [browseNameArray objectAtIndex:indexPath.row];
    cell.imageAvatarView.image =[UIImage imageNamed:[browseImageArray objectAtIndex:indexPath.row]];
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 3;
    
    border.borderColor = [UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f].CGColor;
    border.frame = CGRectMake(0, cell.imageAvatarView.frame.size.height - borderWidth, cell.imageAvatarView.frame.size.width, cell.imageAvatarView.frame.size.height);
    border.borderWidth = borderWidth;
    [cell.imageAvatarView.layer addSublayer:border];
    cell.imageAvatarView.layer.masksToBounds = YES;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0)
    {
        [Temp setGameMode:Overwatch];
    }
    else if(indexPath.row == 1)
    {
        [Temp setGameMode:LeagueOfLegends];
    }
    else
    {
        return;
    }
    
//    if(indexPath.row == 0)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];

        GameController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sid_game_controller"];

        [self.navigationController pushViewController:controller animated:YES];
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return cellSize;
}
#pragma mark - XLPagerTabStripViewControllerDelegate

-(NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"Browse";
}

-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f];
}

@end

@implementation BrowseCollectionCell

@end
