//
//  ServerController.m
//  getgood
//
//  Created by Bhargav Mistri on 02/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "ServerController.h"
#import "ServerCell.h"

@interface ServerController ()

@end

@implementation ServerController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self registerNibForCustomCell];
    
    NSUserDefaults *defult=[NSUserDefaults standardUserDefaults];
    self.nServer =[[defult valueForKey:@"server"] intValue];
    self.nPlatform =[[defult valueForKey:@"platform"] intValue];
    
    [segmentPlatform setSelectedSegmentIndex:self.nPlatform];
    
    [segmentPlatform addTarget:self action:@selector(onPlatform:) forControlEvents:UIControlEventValueChanged];
}

- (void) onPlatform:(id) control
{
    self.nPlatform = segmentPlatform.selectedSegmentIndex;
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)registerNibForCustomCell{
    
    UINib *nibnibAddTextCell=[UINib nibWithNibName:@"ServerCell" bundle:nil];
    [tblView registerNib:nibnibAddTextCell forCellReuseIdentifier:@"ServerCell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  [[DataArrays server] count];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"ServerCell";
    ServerCell *cell = (ServerCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    NSString *Name=[[DataArrays server] objectAtIndex:indexPath.row];
    cell.lblTitle.text = Name;
   
    if (indexPath.row == self.nServer) {
        
       cell.ImgSelect.image = [UIImage imageNamed:@"check"];
    
    }else{
        
       cell.ImgSelect.image = [UIImage imageNamed:@""];
    }
    
    cell.selectionStyle = NO;
  
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.nServer = indexPath.row;
    
    [tableView reloadData];
}
- (IBAction)onDone:(id)sender {
    
    NSUserDefaults *defult=[NSUserDefaults standardUserDefaults];
    [defult setValue:[NSString stringWithFormat:@"%d", self.nServer] forKey:@"server"];
    [defult setValue:[NSString stringWithFormat:@"%d", self.nPlatform] forKey:@"platform"];
    [Temp setNeedReload:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
