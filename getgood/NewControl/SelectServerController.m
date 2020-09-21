//
//  SelectServerController.m
//  getgood
//
//  Created by Bhargav Mistri on 24/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "SelectServerController.h"
#import "ServerCell.h"

@interface SelectServerController ()
@end
@implementation SelectServerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    [self registerNibForCustomCell];
    self.ServerName = [[NSMutableArray alloc] initWithObjects:@"Americas",@"Europe",@"Asia", nil];

}
-(void)registerNibForCustomCell{
    
    UINib *nibnibAddTextCell=[UINib nibWithNibName:@"ServerCell" bundle:nil];
    [tblView registerNib:nibnibAddTextCell forCellReuseIdentifier:@"ServerCell"];
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  [self.ServerName count];
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
    
    NSString *Name=[self.ServerName objectAtIndex:indexPath.row];
    cell.lblTitle.text = Name;
    
    if ([self.SelectName isEqualToString:Name]) {
        
        cell.ImgSelect.image = [UIImage imageNamed:@"check"];
        
    }else{
        
        cell.ImgSelect.image = [UIImage imageNamed:@""];
    }
    
    cell.selectionStyle = NO;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *Name=[self.ServerName objectAtIndex:indexPath.row];
    
    
    [self.delegate doneWithServer:[DataArrays getRegionCode:Name]];
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
