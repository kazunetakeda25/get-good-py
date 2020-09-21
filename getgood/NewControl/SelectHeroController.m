//
//  SelectHeroController.m
//  getgood
//
//  Created by Bhargav Mistri on 24/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "SelectHeroController.h"
#import "CategoryCell.h"
#import "Temp.h"

@interface SelectHeroController ()

@end
@implementation SelectHeroController
@synthesize ArrSelectCategory1, ArrSelectCategory2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ArrCategory1 = [[NSMutableArray alloc]init];
    ArrCategory2 = [[NSMutableArray alloc]init];
    
    if([Temp getGameMode] == Overwatch)
    {
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
        
        [ArrCategory2 addObject:@{@"Image":@"tank",@"Title":@"Tank", @"Value":@"Tank"}];
        [ArrCategory2 addObject:@{@"Image":@"dps",@"Title":@"Dps", @"Value":@"Dps"}];
        [ArrCategory2 addObject:@{@"Image":@"support",@"Title":@"Support", @"Value":@"Support"}];
        [ArrCategory2 addObject:@{@"Image":@"flex",@"Title":@"Flex", @"Value":@"Flex"}];
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        
        [ArrCategory1 addObject:@{@"Image":@"Aatrox", @"Title":@"Aatrox"}];
        [ArrCategory1 addObject:@{@"Image":@"Ahri", @"Title":@"Ahri"}];
        [ArrCategory1 addObject:@{@"Image":@"Akali", @"Title":@"Akali"}];
        [ArrCategory1 addObject:@{@"Image":@"Alistar", @"Title":@"Alistar"}];
        [ArrCategory1 addObject:@{@"Image":@"Amumu", @"Title":@"Amumu"}];
        [ArrCategory1 addObject:@{@"Image":@"Anivia", @"Title":@"Anivia"}];
        [ArrCategory1 addObject:@{@"Image":@"Annie", @"Title":@"Annie"}];
        [ArrCategory1 addObject:@{@"Image":@"Ashe", @"Title":@"Ashe"}];
        [ArrCategory1 addObject:@{@"Image":@"AurelionSol", @"Title":@"AurelionSol"}];
        [ArrCategory1 addObject:@{@"Image":@"Azir", @"Title":@"Azir"}];
        [ArrCategory1 addObject:@{@"Image":@"Bard", @"Title":@"Bard"}];
        [ArrCategory1 addObject:@{@"Image":@"Blitzcrank", @"Title":@"Blitzcrank"}];
        [ArrCategory1 addObject:@{@"Image":@"Brand", @"Title":@"Brand"}];
        [ArrCategory1 addObject:@{@"Image":@"Braum", @"Title":@"Braum"}];
        [ArrCategory1 addObject:@{@"Image":@"Caitlyn", @"Title":@"Caitlyn"}];
        [ArrCategory1 addObject:@{@"Image":@"Camille", @"Title":@"Camille"}];
        [ArrCategory1 addObject:@{@"Image":@"Cassiopeia", @"Title":@"Cassiopeia"}];
        [ArrCategory1 addObject:@{@"Image":@"Chogath", @"Title":@"Chogath"}];
        [ArrCategory1 addObject:@{@"Image":@"Corki", @"Title":@"Corki"}];
        [ArrCategory1 addObject:@{@"Image":@"Darius", @"Title":@"Darius"}];
        [ArrCategory1 addObject:@{@"Image":@"Diana", @"Title":@"Diana"}];
        [ArrCategory1 addObject:@{@"Image":@"Draven", @"Title":@"Draven"}];
        [ArrCategory1 addObject:@{@"Image":@"DrMundo", @"Title":@"DrMundo"}];
        [ArrCategory1 addObject:@{@"Image":@"dugx85", @"Title":@"dugx85"}];
        [ArrCategory1 addObject:@{@"Image":@"Ekko", @"Title":@"Ekko"}];
        [ArrCategory1 addObject:@{@"Image":@"Elise", @"Title":@"Elise"}];
        [ArrCategory1 addObject:@{@"Image":@"Evelynn", @"Title":@"Evelynn"}];
        [ArrCategory1 addObject:@{@"Image":@"Ezreal", @"Title":@"Ezreal"}];
        [ArrCategory1 addObject:@{@"Image":@"Fiddlesticks", @"Title":@"Fiddlesticks"}];
        [ArrCategory1 addObject:@{@"Image":@"Fiora", @"Title":@"Fiora"}];
        [ArrCategory1 addObject:@{@"Image":@"Fizz", @"Title":@"Fizz"}];
        [ArrCategory1 addObject:@{@"Image":@"Galio", @"Title":@"Galio"}];
        [ArrCategory1 addObject:@{@"Image":@"Gangplank", @"Title":@"Gangplank"}];
        [ArrCategory1 addObject:@{@"Image":@"Garen", @"Title":@"Garen"}];
        [ArrCategory1 addObject:@{@"Image":@"Gnar", @"Title":@"Gnar"}];
        [ArrCategory1 addObject:@{@"Image":@"Gragas", @"Title":@"Gragas"}];
        [ArrCategory1 addObject:@{@"Image":@"Graves", @"Title":@"Graves"}];
        [ArrCategory1 addObject:@{@"Image":@"Hecarim", @"Title":@"Hecarim"}];
        [ArrCategory1 addObject:@{@"Image":@"Heimerdinger", @"Title":@"Heimerdinger"}];
        [ArrCategory1 addObject:@{@"Image":@"Illaoi", @"Title":@"Illaoi"}];
        [ArrCategory1 addObject:@{@"Image":@"Irelia", @"Title":@"Irelia"}];
        [ArrCategory1 addObject:@{@"Image":@"Ivern", @"Title":@"Ivern"}];
        [ArrCategory1 addObject:@{@"Image":@"Janna", @"Title":@"Janna"}];
        [ArrCategory1 addObject:@{@"Image":@"JarvanIV", @"Title":@"JarvanIV"}];
        [ArrCategory1 addObject:@{@"Image":@"Jax", @"Title":@"Jax"}];
        [ArrCategory1 addObject:@{@"Image":@"Jayce", @"Title":@"Jayce"}];
        [ArrCategory1 addObject:@{@"Image":@"Jhin", @"Title":@"Jhin"}];
        [ArrCategory1 addObject:@{@"Image":@"Jinx", @"Title":@"Jinx"}];
        [ArrCategory1 addObject:@{@"Image":@"Kaisa", @"Title":@"Kaisa"}];
        [ArrCategory1 addObject:@{@"Image":@"Kalista", @"Title":@"Kalista"}];
        [ArrCategory1 addObject:@{@"Image":@"Karma", @"Title":@"Karma"}];
        [ArrCategory1 addObject:@{@"Image":@"Karthus", @"Title":@"Karthus"}];
        [ArrCategory1 addObject:@{@"Image":@"Kassadin", @"Title":@"Kassadin"}];
        [ArrCategory1 addObject:@{@"Image":@"Katarina", @"Title":@"Katarina"}];
        [ArrCategory1 addObject:@{@"Image":@"Kayle", @"Title":@"Kayle"}];
        [ArrCategory1 addObject:@{@"Image":@"Kayn", @"Title":@"Kayn"}];
        [ArrCategory1 addObject:@{@"Image":@"Kennen", @"Title":@"Kennen"}];
        [ArrCategory1 addObject:@{@"Image":@"Khazix", @"Title":@"Khazix"}];
        [ArrCategory1 addObject:@{@"Image":@"Kindred", @"Title":@"Kindred"}];
        [ArrCategory1 addObject:@{@"Image":@"Kled", @"Title":@"Kled"}];
        [ArrCategory1 addObject:@{@"Image":@"KogMaw", @"Title":@"KogMaw"}];
        [ArrCategory1 addObject:@{@"Image":@"Leblanc", @"Title":@"Leblanc"}];
        [ArrCategory1 addObject:@{@"Image":@"LeeSin", @"Title":@"LeeSin"}];
        [ArrCategory1 addObject:@{@"Image":@"Leona", @"Title":@"Leona"}];
        [ArrCategory1 addObject:@{@"Image":@"Lissandra", @"Title":@"Lissandra"}];
        [ArrCategory1 addObject:@{@"Image":@"Lucian", @"Title":@"Lucian"}];
        [ArrCategory1 addObject:@{@"Image":@"Lulu", @"Title":@"Lulu"}];
        [ArrCategory1 addObject:@{@"Image":@"Lux", @"Title":@"Lux"}];
        [ArrCategory1 addObject:@{@"Image":@"Malphite", @"Title":@"Malphite"}];
        [ArrCategory1 addObject:@{@"Image":@"Malzahar", @"Title":@"Malzahar"}];
        [ArrCategory1 addObject:@{@"Image":@"Maokai", @"Title":@"Maokai"}];
        [ArrCategory1 addObject:@{@"Image":@"MasterYi", @"Title":@"MasterYi"}];
        [ArrCategory1 addObject:@{@"Image":@"MissFortune", @"Title":@"MissFortune"}];
        [ArrCategory1 addObject:@{@"Image":@"MonkeyKing", @"Title":@"MonkeyKing"}];
        [ArrCategory1 addObject:@{@"Image":@"Mordekaiser", @"Title":@"Mordekaiser"}];
        [ArrCategory1 addObject:@{@"Image":@"Morgana", @"Title":@"Morgana"}];
        [ArrCategory1 addObject:@{@"Image":@"Nami", @"Title":@"Nami"}];
        [ArrCategory1 addObject:@{@"Image":@"Nasus", @"Title":@"Nasus"}];
        [ArrCategory1 addObject:@{@"Image":@"Nautilus", @"Title":@"Nautilus"}];
        [ArrCategory1 addObject:@{@"Image":@"Nidalee", @"Title":@"Nidalee"}];
        [ArrCategory1 addObject:@{@"Image":@"Nocturne", @"Title":@"Nocturne"}];
        [ArrCategory1 addObject:@{@"Image":@"Nunu", @"Title":@"Nunu"}];
        [ArrCategory1 addObject:@{@"Image":@"Olaf", @"Title":@"Olaf"}];
        [ArrCategory1 addObject:@{@"Image":@"Orianna", @"Title":@"Orianna"}];
        [ArrCategory1 addObject:@{@"Image":@"Ornn", @"Title":@"Ornn"}];
        [ArrCategory1 addObject:@{@"Image":@"Pantheon", @"Title":@"Pantheon"}];
        [ArrCategory1 addObject:@{@"Image":@"Poppy", @"Title":@"Poppy"}];
        [ArrCategory1 addObject:@{@"Image":@"Pyke", @"Title":@"Pyke"}];
        [ArrCategory1 addObject:@{@"Image":@"Quinn", @"Title":@"Quinn"}];
        [ArrCategory1 addObject:@{@"Image":@"Rakan", @"Title":@"Rakan"}];
        [ArrCategory1 addObject:@{@"Image":@"Rammus", @"Title":@"Rammus"}];
        [ArrCategory1 addObject:@{@"Image":@"RekSai", @"Title":@"RekSai"}];
        [ArrCategory1 addObject:@{@"Image":@"Renekton", @"Title":@"Renekton"}];
        [ArrCategory1 addObject:@{@"Image":@"Rengar", @"Title":@"Rengar"}];
        [ArrCategory1 addObject:@{@"Image":@"Riven", @"Title":@"Riven"}];
        [ArrCategory1 addObject:@{@"Image":@"Rumble", @"Title":@"Rumble"}];
        [ArrCategory1 addObject:@{@"Image":@"Ryze", @"Title":@"Ryze"}];
        [ArrCategory1 addObject:@{@"Image":@"Sejuani", @"Title":@"Sejuani"}];
        [ArrCategory1 addObject:@{@"Image":@"Shaco", @"Title":@"Shaco"}];
        [ArrCategory1 addObject:@{@"Image":@"Shen", @"Title":@"Shen"}];
        [ArrCategory1 addObject:@{@"Image":@"Shyvana", @"Title":@"Shyvana"}];
        [ArrCategory1 addObject:@{@"Image":@"Singed", @"Title":@"Singed"}];
        [ArrCategory1 addObject:@{@"Image":@"Sion", @"Title":@"Sion"}];
        [ArrCategory1 addObject:@{@"Image":@"Sivir", @"Title":@"Sivir"}];
        [ArrCategory1 addObject:@{@"Image":@"Skarner", @"Title":@"Skarner"}];
        [ArrCategory1 addObject:@{@"Image":@"Sona", @"Title":@"Sona"}];
        [ArrCategory1 addObject:@{@"Image":@"Soraka", @"Title":@"Soraka"}];
        [ArrCategory1 addObject:@{@"Image":@"Swain", @"Title":@"Swain"}];
        [ArrCategory1 addObject:@{@"Image":@"Syndra", @"Title":@"Syndra"}];
        [ArrCategory1 addObject:@{@"Image":@"TahmKench", @"Title":@"TahmKench"}];
        [ArrCategory1 addObject:@{@"Image":@"Taliyah", @"Title":@"Taliyah"}];
        [ArrCategory1 addObject:@{@"Image":@"Talon", @"Title":@"Talon"}];
        [ArrCategory1 addObject:@{@"Image":@"Taric", @"Title":@"Taric"}];
        [ArrCategory1 addObject:@{@"Image":@"Teemo", @"Title":@"Teemo"}];
        [ArrCategory1 addObject:@{@"Image":@"Thresh", @"Title":@"Thresh"}];
        [ArrCategory1 addObject:@{@"Image":@"Tristana", @"Title":@"Tristana"}];
        [ArrCategory1 addObject:@{@"Image":@"Trundle", @"Title":@"Trundle"}];
        [ArrCategory1 addObject:@{@"Image":@"Tryndamere", @"Title":@"Tryndamere"}];
        [ArrCategory1 addObject:@{@"Image":@"TwistedFate", @"Title":@"TwistedFate"}];
        [ArrCategory1 addObject:@{@"Image":@"Twitch", @"Title":@"Twitch"}];
        [ArrCategory1 addObject:@{@"Image":@"Udyr", @"Title":@"Udyr"}];
        [ArrCategory1 addObject:@{@"Image":@"Urgot", @"Title":@"Urgot"}];
        [ArrCategory1 addObject:@{@"Image":@"Varus", @"Title":@"Varus"}];
        [ArrCategory1 addObject:@{@"Image":@"Vayne", @"Title":@"Vayne"}];
        [ArrCategory1 addObject:@{@"Image":@"Veigar", @"Title":@"Veigar"}];
        [ArrCategory1 addObject:@{@"Image":@"Velkoz", @"Title":@"Velkoz"}];
        [ArrCategory1 addObject:@{@"Image":@"Vi", @"Title":@"Vi"}];
        [ArrCategory1 addObject:@{@"Image":@"Viktor", @"Title":@"Viktor"}];
        [ArrCategory1 addObject:@{@"Image":@"Vladimir", @"Title":@"Vladimir"}];
        [ArrCategory1 addObject:@{@"Image":@"Volibear", @"Title":@"Volibear"}];
        [ArrCategory1 addObject:@{@"Image":@"Warwick", @"Title":@"Warwick"}];
        [ArrCategory1 addObject:@{@"Image":@"Xayah", @"Title":@"Xayah"}];
        [ArrCategory1 addObject:@{@"Image":@"Xerath", @"Title":@"Xerath"}];
        [ArrCategory1 addObject:@{@"Image":@"XinZhao", @"Title":@"XinZhao"}];
        [ArrCategory1 addObject:@{@"Image":@"Yasuo", @"Title":@"Yasuo"}];
        [ArrCategory1 addObject:@{@"Image":@"Yorick", @"Title":@"Yorick"}];
        [ArrCategory1 addObject:@{@"Image":@"Zac", @"Title":@"Zac"}];
        [ArrCategory1 addObject:@{@"Image":@"Zed", @"Title":@"Zed"}];
        [ArrCategory1 addObject:@{@"Image":@"Ziggs", @"Title":@"Ziggs"}];
        [ArrCategory1 addObject:@{@"Image":@"Zilean", @"Title":@"Zilean"}];
        [ArrCategory1 addObject:@{@"Image":@"Zoe", @"Title":@"Zoe"}];
        [ArrCategory1 addObject:@{@"Image":@"Zyra", @"Title":@"Zyra"}];
        
        [ArrCategory2 addObject:@{@"Image":@"Top_Lane",@"Title":@"Top Lane", @"Value":@"Top_Lane"}];
        [ArrCategory2 addObject:@{@"Image":@"ADC",@"Title":@"ADC", @"Value":@"ADC"}];
        [ArrCategory2 addObject:@{@"Image":@"Mid_Lane",@"Title":@"Mid Lane", @"Value":@"Mid_Lane"}];
        [ArrCategory2 addObject:@{@"Image":@"Jungler",@"Title":@"Jungler", @"Value":@"Jungler"}];
        [ArrCategory2 addObject:@{@"Image":@"Lol_Support",@"Title":@"Support", @"Value":@"Lol_Support"}];
    }

    
    if(ArrSelectCategory2 == nil)
        ArrSelectCategory2 =[[NSMutableArray alloc] init];
    if(ArrSelectCategory1 == nil)
        ArrSelectCategory1 =[[NSMutableArray alloc] init];
    
    [self registerNibForCustomCell];
}
- (void)actionBack:(UITapGestureRecognizer *)tapGesture
{
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
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
        cell.lblName.text = Name;
        
        if ([ArrSelectCategory1 containsObject:[ArrCategory1 objectAtIndex:indexPath.row]]) {
            
            cell.ImgSelect.image = [UIImage imageNamed:@"check"];
            
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
            
            cell.ImgSelect.image = [UIImage imageNamed:@"check"];
            
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
        
        NSArray *Array=[ArrCategory1 objectAtIndex:indexPath.row];
        if (ArrSelectCategory1.count < 5) {
            
            if ([ArrSelectCategory1 containsObject:Array]) {
                
                [ArrSelectCategory1 removeObject:Array];
                
            }else{
                
                [ArrSelectCategory1 addObject:Array];
            }
            
            ArrSelectCategory2 = [[NSMutableArray alloc] init];
            
            [tblView1 reloadData];
            [tblView2 reloadData];
        }
        else
        {
            if ([ArrSelectCategory1 containsObject:Array]) {
                
                [ArrSelectCategory1 removeObject:Array];
                
            }
            
            ArrSelectCategory2 = [[NSMutableArray alloc] init];
            
            [tblView1 reloadData];
            [tblView2 reloadData];
        }
        
    }else{
        
        NSArray *Array=[ArrCategory2 objectAtIndex:indexPath.row];
        if ([ArrSelectCategory2 containsObject:Array]) {
            
            [ArrSelectCategory2 removeObject:Array];
            
        }else{
            
            [ArrSelectCategory2 addObject:Array];
        }
        
        ArrSelectCategory1 = [[NSMutableArray alloc] init];
        
        [tblView2 reloadData];
        [tblView1 reloadData];
    }
    
}

- (IBAction)btnUpdateClick:(id)sender {
    
    [self.delegate doneWithCategory1:ArrSelectCategory1 Category2:ArrSelectCategory2];
    [self.navigationController popViewControllerAnimated:true];
    
}
@end
