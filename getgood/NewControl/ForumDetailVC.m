//
//  ForumDetailVC.m
//  getgood
//
//  Created by Bhargav Mistri on 27/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "ForumDetailVC.h"
#import "ForumDetailCell.h"

@interface ForumDetailVC ()

@end

@implementation ForumDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionBack:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.imageBack addGestureRecognizer:tapGestureRecognizer];
    self.imageBack.userInteractionEnabled = YES;
    
    self.tblView.estimatedRowHeight = 140;
    self.tblView.rowHeight = UITableViewAutomaticDimension;
   
    [self registerNibForCustomCell];
    
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)registerNibForCustomCell{
    
    UINib *nibnibAddTextCell=[UINib nibWithNibName:@"ForumDetailCell" bundle:nil];
    [self.tblView registerNib:nibnibAddTextCell forCellReuseIdentifier:@"ForumDetailCell"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"ForumDetailCell";
    ForumDetailCell *cell = (ForumDetailCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    cell.lblDescription.text = self.Description;
    cell.selectionStyle = NO;
    
    return cell;
    
}


@end
