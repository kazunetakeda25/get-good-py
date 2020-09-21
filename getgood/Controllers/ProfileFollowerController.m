//
//  ProfileFollowerController.m
//  getgood
//
//  Created by Md Aminuzzaman on 30/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "Utils.h"
#import "Follow.h"
#import "AppData.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "ProfileFollowerController.h"

@interface ProfileFollowerController ()
{
    NSMutableArray *arrFollowers;
}

@end

@implementation ProfileFollowerController

@synthesize viewType;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrFollowers = [[NSMutableArray alloc] init];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionBack:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageBack addGestureRecognizer:tapGestureRecognizer];
    imageBack.userInteractionEnabled = YES;
    
    if(viewType == VIEW_FOLLOWER_TYPE)
    {
    }
    else if(viewType == VIEW_FOLLOWING_TYPE)
    {
    }
    
    //[tableView reloadData];
}

- (void)actionBack:(UITapGestureRecognizer *)tapGesture
{
    [self.navigationController popViewControllerAnimated:YES];
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


-(NSInteger) tableView:(UITableView *) theTableView numberOfRowsInSection:(NSInteger) section
{
    return arrFollowers.count;
}

-(UITableViewCell *) tableView:(UITableView *) theTableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    ProfileFollowerCell *cell = (ProfileFollowerCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfileFollowerCell"];
    
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProfileFollowerCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    

   
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
}

@end

@implementation ProfileFollowerCell

@end
