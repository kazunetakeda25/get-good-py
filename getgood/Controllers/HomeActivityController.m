//
//  HomeActivityController.m
//  getgood
//
//  Created by Md Aminuzzaman on 21/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "AppData.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "HomeActivityController.h"

@import Firebase;
@import FirebaseDatabase;

@interface HomeActivityController ()
{
    NSMutableArray *activityListArray;
}

@end

@implementation HomeActivityController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    activityListArray = [[NSMutableArray alloc] init];
    
    [self initActivityData];
    //[tableView reloadData];
}

-(void) initActivityData
{
    [RestClient getActivities:^(bool result, NSDictionary *data) {
        if(!result)
            return ;
        
        activityListArray = [data objectForKey:@"activities"];
        if(activityListArray.count == 0)
        {
            [self.lblNoActivities setHidden:NO];
        }
        [tableView reloadData];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

-(NSInteger) tableView:(UITableView *) theTableView numberOfRowsInSection:(NSInteger) section
{
    return activityListArray.count;
}

-(UITableViewCell *) tableView:(UITableView *) theTableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    BrowseActivityCell *cell = (BrowseActivityCell *)[tableView dequeueReusableCellWithIdentifier:@"BrowseActivityCell"];
    
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BrowseActivityCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    
    cell.userInteractionEnabled = NO;
    
    cell.labelNameView.text = [[activityListArray objectAtIndex:indexPath.row] objectForKey:@"message"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
}

#pragma mark - XLPagerTabStripViewControllerDelegate

-(NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"Activity";
}

-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f];
}

@end

@implementation BrowseActivityCell

@end
