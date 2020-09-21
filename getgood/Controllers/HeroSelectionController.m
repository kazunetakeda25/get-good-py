//
//  ServerSelectionController.m
//  getgood
//
//  Created by Md Aminuzzaman on 27/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "Hero.h"
#import "UIKit.h"
#import "AppData.h"
#import "DataArrays.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "OverwatchService.h"
#import "HeroSelectionController.h"
#import "RestClient.h"

@interface HeroSelectionController ()
{
    NSMutableString *topPlayedHeroes;
    NSMutableArray *heroArray;
    NSMutableArray *roleArray;
}

@end

@implementation HeroSelectionController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionReset:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [labelReset addGestureRecognizer:tapGestureRecognizer];
    labelReset.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionUpdate:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [buttonUpdate addGestureRecognizer:tapGestureRecognizer];
    buttonUpdate.userInteractionEnabled = YES;

    [self initData];
    
    [tableView reloadData];
    
    tblRoles.dataSource = self;
    tblRoles.delegate = self;
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) initData
{
    //arrSelectionStatus = [[NSMutableArray alloc] init];
    
    NSArray *arHeroNames = [DataArrays heroes];
    
    heroArray = [[NSMutableArray alloc] init];
    
    for(int i = 0 ; i < arHeroNames.count ; ++i)
    {
        Hero *hero = [[Hero alloc] initWithName:arHeroNames[i] time:0];
        
        if([[AppData profile].overwatch_heroes length] != 0)
        {
            if ([[[AppData profile].overwatch_heroes lowercaseString] containsString:[hero.name lowercaseString]]) {
                hero.selected = [NSNumber numberWithBool:YES];
            } else {
                hero.selected = [NSNumber numberWithBool:NO];
            }
        }
        
        [heroArray addObject:hero];
    }
    
    NSArray *arRoleNames = [DataArrays CategoryGroups];
    
    roleArray = [[NSMutableArray alloc] init];
    
    for(int i = 0 ; i < arRoleNames.count ; ++i)
    {
        Hero *hero = [[Hero alloc] initWithName:arRoleNames[i] time:0];
        
        if([[AppData profile].overwatch_heroes length] != 0)
        {
            if ([[[AppData profile].overwatch_heroes lowercaseString] containsString:[hero.name lowercaseString]]) {
                hero.selected = [NSNumber numberWithBool:YES];
            } else {
                hero.selected = [NSNumber numberWithBool:NO];
            }
        }
        
        [roleArray addObject:hero];
    }
}

- (void)actionReset:(UITapGestureRecognizer *)tapGesture
{
//    if([AppData userProfile].gameId == nil || [[AppData userProfile].gameId length] == 0)
//    {
//        [UIKit showInformation:self message:@"Overwatch not set"];
//        return;
//    }
//
//    [self getOverwatchHeroes];
    for(int i = 0; i < heroArray.count; i++)
    {
        Hero *hero = [heroArray objectAtIndex:i];
        
        hero.selected = [NSNumber numberWithBool:NO];
    }
    for(int i = 0; i < roleArray.count; i++)
    {
        Hero *hero = [roleArray objectAtIndex:i];
        
        hero.selected = [NSNumber numberWithBool:NO];
    }
    
    [tableView reloadData];
    [tblRoles reloadData];
}


-(void) getMostPlayedHeroes:(NSDictionary *)dict
{
    NSEnumerator *enumerator = [dict keyEnumerator];
    id key;
   
    while((key = [enumerator nextObject]))
    {
        NSNumber *issue = [dict objectForKey:key];
        
        Hero *hero = [[Hero alloc] initWithName:key time:[issue doubleValue]];
        
        [heroArray addObject:hero];
    }
    
    [heroArray sortUsingComparator:^NSComparisonResult(id a, id b) {
        double first = [(Hero*)a time];
        double second = [(Hero*)b time];
        return (fabs(first - second) < 0.01);;
    }];
    
    topPlayedHeroes = [NSMutableString stringWithFormat:@"%@ %@ %@ %@ %@",
                       [[(Hero*)heroArray[0] name] uppercaseString],
                       [[(Hero*)heroArray[1] name] uppercaseString],
                       [[(Hero*)heroArray[2] name] uppercaseString],
                       [[(Hero*)heroArray[3] name] uppercaseString],
                       [[(Hero*)heroArray[4] name] uppercaseString]];
    
    NSArray *arHeroNames = [DataArrays heroes];
    
    heroArray = [[NSMutableArray alloc] init];
    
    for(int i = 0 ; i < arHeroNames.count ; ++i)
    {
        Hero *hero = [[Hero alloc] initWithName:arHeroNames[i] time:0];
        
        if([[AppData profile].overwatch_heroes length] != 0)
        {
            if ([[[AppData profile].overwatch_heroes lowercaseString] containsString:[hero.name lowercaseString]]) {
                hero.selected = [NSNumber numberWithBool:YES];
            } else {
                hero.selected = [NSNumber numberWithBool:NO];
            }
        }
        
        [heroArray addObject:hero];
    }
    
    [tableView reloadData];
}

- (void)actionUpdate:(UITapGestureRecognizer *)tapGesture
{
    int nCount = 0;
    
    NSMutableString *strResult = [[NSMutableString alloc] init];
    
    for(int i = 0 ; i < heroArray.count ; ++i)
    {
        Hero *hero = heroArray[i];
        
        if([hero.selected boolValue] == YES)
        {
            [strResult appendString:[NSString stringWithFormat:@" %@",hero.name]];
            ++nCount;
        }
    }
    
    for(int i = 0 ; i < roleArray.count ; ++i)
    {
        Hero *hero = roleArray[i];
        
        if([hero.selected boolValue] == YES)
        {
            [strResult appendString:[NSString stringWithFormat:@" %@",hero.name]];
            ++nCount;
        }
    }
    
    if([strResult length] > 0)
    {
        [AppData profile].overwatch_heroes = [strResult substringFromIndex:1];
    }
    else
    {
        [AppData profile].overwatch_heroes = @"";
    }
    
    [RestClient updateProfile:^(bool result, NSDictionary *data) {
        
    }];
    
    [self.delegate onHeroSelect:self didFinishEnteringItem:heroArray];
    
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

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 59.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger) tableView:(UITableView *) theTableView numberOfRowsInSection:(NSInteger) section
{
    if(tableView == theTableView)
    {
        return heroArray.count;
    }
    else
    {
        return roleArray.count;
    }
}

-(UITableViewCell *) tableView:(UITableView *) theTableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(theTableView == tableView)
    {
        HeroSelectionCell *cell = (HeroSelectionCell *)[tableView dequeueReusableCellWithIdentifier:@"HeroSelectionCell"];
        
        Hero *hero = [heroArray objectAtIndex:indexPath.row];
        
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HeroSelectionCell" owner:self options:nil];
            
            cell = [nib objectAtIndex:0];
        }
        
        if ([hero.selected boolValue] == YES)
            cell.imageCheck.hidden = NO;
        else
            cell.imageCheck.hidden = YES;
        
        cell.labelNameView.text = [hero.name stringByReplacingOccurrencesOfString:@"_" withString:@"\n"];
        cell.labelNameView.numberOfLines = 0;

        cell.imageHeroThumb.contentMode = UIViewContentModeScaleAspectFit;
        
        [cell.imageHeroThumb setImage:[UIImage imageNamed:[hero.name lowercaseString]]];
        
        
        return cell;
    }
    else
    {
        HeroSelectionCell *cell = (HeroSelectionCell *)[tableView dequeueReusableCellWithIdentifier:@"HeroSelectionCell"];
        
        Hero *hero = [roleArray objectAtIndex:indexPath.row];
        
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HeroSelectionCell" owner:self options:nil];
            
            cell = [nib objectAtIndex:0];
        }
        
        if ([hero.selected boolValue] == YES)
            cell.imageCheck.hidden = NO;
        else
            cell.imageCheck.hidden = YES;
        
        cell.labelNameView.text = hero.name;
        
        cell.imageHeroThumb.contentMode = UIViewContentModeScaleAspectFit;
        
        [cell.imageHeroThumb setImage:[UIImage imageNamed:[hero.name lowercaseString]]];
        
        
        return cell;
    }

}

-(void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == theTableView)
    {
        for(int i = 0; i < roleArray.count; i++)
        {
            Hero * hero = [roleArray objectAtIndex:i];
            hero.selected = [NSNumber numberWithBool:NO];
        }
        
        [tblRoles reloadData];
        
        HeroSelectionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if([self getSelectionCount] < 5)
        {
            cell.imageCheck.hidden = NO;
            
            Hero *hero = [heroArray objectAtIndex:indexPath.row];
            
            hero.selected = [NSNumber numberWithBool:YES];
        }
        

    }
    else
    {
        for(int i = 0; i < heroArray.count; i++)
        {
            Hero * hero = [heroArray objectAtIndex:i];
            hero.selected = [NSNumber numberWithBool:NO];
        }
        
        [tableView reloadData];
        
        HeroSelectionCell *cell = [tblRoles cellForRowAtIndexPath:indexPath];
        
        if([self getSelectionCount] < 5)
        {
            cell.imageCheck.hidden = NO;
            
            Hero *hero = [roleArray objectAtIndex:indexPath.row];
            
            hero.selected = [NSNumber numberWithBool:YES];
        }
        

    }

}

-(void)tableView:(UITableView *)theTableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == theTableView)
    {
        HeroSelectionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.imageCheck.hidden = YES;
        
        Hero *hero = [heroArray objectAtIndex:indexPath.row];
        
        hero.selected = [NSNumber numberWithBool:NO];
    }
    else
    {
        HeroSelectionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.imageCheck.hidden = YES;
        
        Hero *hero = [heroArray objectAtIndex:indexPath.row];
        
        hero.selected = [NSNumber numberWithBool:NO];
    }

}

-(int) getSelectionCount
{
    int count = 0;
    
    for(int i = 0 ; i < heroArray.count ; ++i)
    {
        Hero *hero = [heroArray objectAtIndex:i];
        
        if([hero.selected boolValue] == YES)
            ++count;
    }
    
    for(int i = 0 ; i < roleArray.count ; ++i)
    {
        Hero *hero = [roleArray objectAtIndex:i];
        
        if([hero.selected boolValue] == YES)
            ++count;
    }
    
    return count;
}

@end

@implementation HeroSelectionCell

@end





