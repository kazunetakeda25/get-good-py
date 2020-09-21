//
//  CategoryController.m
//  getgood
//
//  Created by Bhargav Mistri on 02/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "CategoryController.h"
#import "CategoryCell.h"

@interface CategoryController ()

@end

@implementation CategoryController

- (void)viewDidLoad {
    [super viewDidLoad];

    ArrCategory1 = [[NSMutableArray alloc]init];
    [ArrCategory1 addObject:@{@"Image":@"ana",@"Title":@"Ana"}];
    [ArrCategory1 addObject:@{@"Image":@"bastion",@"Title":@"Bastion"}];
    [ArrCategory1 addObject:@{@"Image":@"brigitte",@"Title":@"Brigitte"}];
    [ArrCategory1 addObject:@{@"Image":@"dva",@"Title":@"Dva"}];
    [ArrCategory1 addObject:@{@"Image":@"doomfist",@"Title":@"Doomfist"}];
    [ArrCategory1 addObject:@{@"Image":@"genji",@"Title":@"Genji"}];
    [ArrCategory1 addObject:@{@"Image":@"hanzo",@"Title":@"Hanzo"}];
    [ArrCategory1 addObject:@{@"Image":@"junkrat",@"Title":@"Junkrat"}];
    [ArrCategory1 addObject:@{@"Image":@"lucio",@"Title":@"Lucio"}];
    [ArrCategory1 addObject:@{@"Image":@"mccree",@"Title":@"McCree"}];
    [ArrCategory1 addObject:@{@"Image":@"mei",@"Title":@"Mei"}];
    [ArrCategory1 addObject:@{@"Image":@"mercy",@"Title":@"Mercy"}];
    [ArrCategory1 addObject:@{@"Image":@"moira",@"Title":@"Moira"}];
    [ArrCategory1 addObject:@{@"Image":@"orisa",@"Title":@"Orisa"}];
    
    [ArrCategory1 addObject:@{@"Image":@"pharah",@"Title":@"Pharah"}];
    [ArrCategory1 addObject:@{@"Image":@"reaper",@"Title":@"Reaper"}];
    [ArrCategory1 addObject:@{@"Image":@"reinhardt",@"Title":@"Reinhardt"}];
    [ArrCategory1 addObject:@{@"Image":@"roadhog",@"Title":@"Roadhog"}];
    [ArrCategory1 addObject:@{@"Image":@"soldier76",@"Title":@"Soldier76"}];
    [ArrCategory1 addObject:@{@"Image":@"sombra",@"Title":@"Sombra"}];
    
    [ArrCategory1 addObject:@{@"Image":@"symmetra",@"Title":@"Symmetra"}];
    [ArrCategory1 addObject:@{@"Image":@"torbjorn",@"Title":@"Torbjorn"}];
    [ArrCategory1 addObject:@{@"Image":@"tracer",@"Title":@"Tracer"}];
    [ArrCategory1 addObject:@{@"Image":@"widowmaker",@"Title":@"Widowmaker"}];
    [ArrCategory1 addObject:@{@"Image":@"winston",@"Title":@"Winston"}];
    [ArrCategory1 addObject:@{@"Image":@"wrecking_ball",@"Title":@"Wrecking_Ball"}];
    [ArrCategory1 addObject:@{@"Image":@"zarya",@"Title":@"Zarya"}];
    [ArrCategory1 addObject:@{@"Image":@"zenyatta",@"Title":@"Zenyatta"}];
 
    
    ArrCategory2 = [[NSMutableArray alloc]init];
    [ArrCategory2 addObject:@{@"Image":@"tank",@"Title":@"Tank"}];
    [ArrCategory2 addObject:@{@"Image":@"dps",@"Title":@"Dps"}];
    [ArrCategory2 addObject:@{@"Image":@"support",@"Title":@"Support"}];
    [ArrCategory2 addObject:@{@"Image":@"flex",@"Title":@"Flex"}];
    

    ArrSelectCategory1 =[[NSMutableArray alloc] init];
    ArrSelectCategory2 =[[NSMutableArray alloc] init];
    
    [self registerNibForCustomCell];
    
    NSUserDefaults *defult=[NSUserDefaults standardUserDefaults];
    
    NSString* strCategory = @"";
    
    if([Temp currentTab] == 0)
    {
        strCategory = [defult objectForKey:@"category_player"];
        self.bRoleSelect = [defult boolForKey:@"category_player_role"];
    }
    else if([Temp currentTab] == 1)
    {
        strCategory = [defult objectForKey:@"category_group"];
        self.bRoleSelect = [defult boolForKey:@"category_group_role"];
    }
    else if([Temp currentTab] == 2)
    {
        strCategory = [defult objectForKey:@"category_coach"];
        self.bRoleSelect = [defult boolForKey:@"category_coach_role"];
    }
    
    ArrSelectCategory1 = [[NSMutableArray alloc] init];
    ArrSelectCategory2 = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < ArrCategory1.count; i++)
    {
        NSDictionary* category = [ArrCategory1 objectAtIndex:i];
        
        if([strCategory containsString:[category objectForKey:@"Title"]])
        {
            [ArrSelectCategory1 addObject:category];
        }
    }
    
    for(int i = 0; i < ArrCategory2.count; i++)
    {
        NSDictionary* category = [ArrCategory2 objectAtIndex:i];
        
        if([strCategory containsString:[category objectForKey:@"Title"]])
        {
            [ArrSelectCategory2 addObject:category];
        }
    }
    
    [tblView1 reloadData];
    [tblView2 reloadData];
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)registerNibForCustomCell{
    
    UINib *nibCategoryCell=[UINib nibWithNibName:@"CategoryCell" bundle:nil];
    [tblView1 registerNib:nibCategoryCell forCellReuseIdentifier:@"CategoryCell"];
    
    UINib *nibCategoryCell1=[UINib nibWithNibName:@"CategoryCell" bundle:nil];
    [tblView2 registerNib:nibCategoryCell1 forCellReuseIdentifier:@"CategoryCell"];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == tblView1) {
        
        return ArrCategory1.count;
        
    }else{
        
         return ArrCategory2.count;
    }
    
    return 0;
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
    
    static NSString *simpleTableIdentifier = @"CategoryCell";
    CategoryCell *cell = (CategoryCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    cell.selectionStyle = NO;
    
    if (tableView == tblView1) {
        
        NSString *Name=[[ArrCategory1 valueForKey:@"Title"] objectAtIndex:indexPath.row];
        cell.lblName.text = [Name stringByReplacingOccurrencesOfString:@"_" withString:@" "];
                cell.lblName.numberOfLines = 0;
        if ([ArrSelectCategory1 containsObject:[ArrCategory1 objectAtIndex:indexPath.row]]) {
            
            if(!self.bRoleSelect)
                cell.ImgSelect.image = [UIImage imageNamed:@"check"];
            else
                cell.ImgSelect.image = [UIImage imageNamed:@"gray_check"];

        }else{

            cell.ImgSelect.image = [UIImage imageNamed:@""];
        }
        
        NSString *imageName=[[ArrCategory1 valueForKey:@"Image"] objectAtIndex:indexPath.row];
        cell.ImgLogo.image = [UIImage imageNamed:imageName];
        
        return cell;
        
    }else{
        
        NSString *Name=[[ArrCategory2 valueForKey:@"Title"] objectAtIndex:indexPath.row];
        cell.lblName.text = Name;
        
        if ([ArrSelectCategory2 containsObject:[ArrCategory2 objectAtIndex:indexPath.row]]) {

            if(self.bRoleSelect)
                cell.ImgSelect.image = [UIImage imageNamed:@"check"];
            else
                cell.ImgSelect.image = [UIImage imageNamed:@"gray_check"];

        }else{

            cell.ImgSelect.image = [UIImage imageNamed:@""];
        }
        
         NSString *imageName=[[ArrCategory2 valueForKey:@"Image"] objectAtIndex:indexPath.row];
         cell.ImgLogo.image = [UIImage imageNamed:imageName];
        
         return cell;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView == tblView1) {
        
        NSString *Name=[ArrCategory1 objectAtIndex:indexPath.row];
        
        if ([ArrSelectCategory1 containsObject:Name]) {
            
            [ArrSelectCategory1 removeObject:Name];
            
        }else{
            
            [ArrSelectCategory1 addObject:Name];
        }

        self.bRoleSelect = NO;
        [tblView1 reloadData];
        [tblView2 reloadData];
        
        
    }else{
        
        NSString *Name=[ArrCategory2 objectAtIndex:indexPath.row];

        if ([ArrSelectCategory2 containsObject:Name]) {
            
            [ArrSelectCategory2 removeObject:Name];
            
        }else{
            
            [ArrSelectCategory2 addObject:Name];
        }
        
        self.bRoleSelect = YES;
        [tblView1 reloadData];
        [tblView2 reloadData];
    }
    
}

- (IBAction)btnDoneClick:(id)sender {
    
    NSUserDefaults *deflult=[NSUserDefaults standardUserDefaults];
    
    NSString* strCategory = @"";
    
    for(int i = 0; i < ArrSelectCategory1.count; i++)
    {
        strCategory = [NSString stringWithFormat:@"%@ %@", strCategory, [[ArrSelectCategory1 objectAtIndex:i] objectForKey:@"Title"]];
    }
    for(int i = 0; i < ArrSelectCategory2.count; i++)
    {
        strCategory = [NSString stringWithFormat:@"%@ %@", strCategory, [[ArrSelectCategory2 objectAtIndex:i] objectForKey:@"Title"]];
    }
    
    if(strCategory.length)
    {
        strCategory = [strCategory substringFromIndex:1];
    }
    
    
    if([Temp currentTab] == 0)
    {        
        [deflult setValue:strCategory forKey:@"category_player"];
        [deflult setBool:self.bRoleSelect forKey:@"category_player_role"];
    }
    else if([Temp currentTab] == 1)
    {
        [deflult setValue:strCategory forKey:@"category_group"];
        [deflult setBool:self.bRoleSelect forKey:@"category_group_role"];
    }
    else if([Temp currentTab] == 2)
    {
        [deflult setValue:strCategory forKey:@"category_coach"];
        [deflult setBool:self.bRoleSelect forKey:@"category_coach_role"];
    }
    
    [deflult synchronize];
    
    [Temp setNeedReload:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
