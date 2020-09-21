//
//  ServerSelectionController.m
//  getgood
//
//  Created by Md Aminuzzaman on 27/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "DataArrays.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "LoLServerSelectionController.h"
#import "AppData.h"

@interface LoLServerSelectionController ()
{
    NSArray *serverArray;
    NSArray *serverValueArray;
    NSMutableArray *arrSelectionStatus;
}

@end

@implementation LoLServerSelectionController

@synthesize strServer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    serverArray = [DataArrays lolServerNames];
    serverValueArray = [DataArrays lolServerValues];
    
    strServer = [AppData profile].lol_server;
    
    [tableView reloadData];
    
    [self.segmentPlatform addTarget:self action:@selector(onPlatform:) forControlEvents:UIControlEventValueChanged];
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
    return serverArray.count;
}

-(UITableViewCell *) tableView:(UITableView *) theTableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    LoLServerSelectionCell *cell = (LoLServerSelectionCell *)[tableView dequeueReusableCellWithIdentifier:@"ServerSelectionCell"];
    
    NSString *serverValue = [serverArray objectAtIndex:indexPath.row];
    
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ServerSelectionCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    
    cell.labelNameView.text = serverValue;
    
    if([[serverValueArray objectAtIndex:indexPath.row] isEqualToString:self.strServer])
    {
        cell.imageCheck.hidden = NO;
    }
    else
    {
        cell.imageCheck.hidden = YES;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.strServer = [serverValueArray objectAtIndex:indexPath.row];
    
    [tableView reloadData];
}


- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onDone:(id)sender {
    [AppData profile].lol_server = [NSString stringWithFormat:@"%@", self.strServer];
    
    [RestClient updateLoLProfile:^(bool result, NSDictionary *data) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end

@implementation LoLServerSelectionCell

@end




