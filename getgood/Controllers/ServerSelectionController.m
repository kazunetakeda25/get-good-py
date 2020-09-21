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
#import "ServerSelectionController.h"
#import "AppData.h"

@interface ServerSelectionController ()
{
    NSArray *serverArray;
    NSArray *serverValueArray;
    NSMutableArray *arrSelectionStatus;
}

@end

@implementation ServerSelectionController

@synthesize strServer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    serverArray = [DataArrays profileServer];
    serverValueArray = [DataArrays profileServerValue];
    
    strServer = [AppData profile].server;
    NSArray* arComponents = [strServer componentsSeparatedByString:@"/"];
   
    if(!strServer.length)
    {
        self.strPlatform = @"pc";
        self.strServer = @"";
    }
    else
    {
        self.strPlatform = [arComponents objectAtIndex:0];
        
        if(arComponents.count > 1)
        {
            self.strServer = [arComponents objectAtIndex:1];
        }
    }
    
    [tableView reloadData];
    [self updatePlatformUI];
    
    [self.segmentPlatform addTarget:self action:@selector(onPlatform:) forControlEvents:UIControlEventValueChanged];
}

- (void) onPlatform:(id) control
{
    switch (self.segmentPlatform.selectedSegmentIndex) {
        case 0:
            self.strPlatform = @"pc";
            break;
        case 1:
            self.strPlatform = @"xbox";
            break;
        case 2:
            self.strPlatform = @"ps4";
            break;
            
        default:
            break;
    }
}

- (void) updatePlatformUI
{
    if([self.strPlatform isEqualToString:@"pc"])
    {
        [self.segmentPlatform setSelectedSegmentIndex:0];
    }
    else if([self.strPlatform isEqualToString:@"xbox"])
    {
        [self.segmentPlatform setSelectedSegmentIndex:1];
    }
    else if([self.strPlatform isEqualToString:@"ps4"])
    {
        [self.segmentPlatform setSelectedSegmentIndex:2];
    }
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
    ServerSelectionCell *cell = (ServerSelectionCell *)[tableView dequeueReusableCellWithIdentifier:@"ServerSelectionCell"];
    
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
    [AppData profile].server = [NSString stringWithFormat:@"%@/%@", self.strPlatform, self.strServer];
    
    [RestClient updateProfile:^(bool result, NSDictionary *data) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end

@implementation ServerSelectionCell

@end




