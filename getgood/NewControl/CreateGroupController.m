//
//  CreateGroupController.m
//  getgood
//
//  Created by Bhargav Mistri on 23/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "CreateGroupController.h"
#import <QuartzCore/QuartzCore.h>
#import "SelectHeroController.h"
#import "UIKit.h"
#include <stdlib.h>
#import "AppData.h"
#import "UIView+Borders.h"
#import "Temp.h"
#import "DataArrays.h"
@import Firebase;
@import FirebaseDatabase;

@interface CreateGroupController ()

@end

@implementation CreateGroupController 
@synthesize bEdit;
- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIColor *color = [UIColor grayColor];
    self.txtGroupTitle.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Group Title"
    attributes:@{NSForegroundColorAttributeName:color}];
   
    self.txtDescription.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Description"
    attributes:@{NSForegroundColorAttributeName:color}];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SelectHero:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.HeroView addGestureRecognizer:tapGestureRecognizer];
    self.HeroView.userInteractionEnabled = YES;

    [self.borderView addBottomBorderWithHeight:2.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
    [self.borderView1 addBottomBorderWithHeight:2.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
    [self.HeroView addBottomBorderWithHeight:2.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
    
    if(bEdit)
    {
        [self.txtGroupTitle setText:[Temp groupData].title];
        [self.txtDescription setText:[Temp groupData].getgood_description];
        
        NSArray* arHeros = [[Temp groupData].hero componentsSeparatedByString:@" "];
        NSMutableArray* arTemp = [[NSMutableArray alloc] init];
        BOOL isHero = YES;
        
        if([Temp getGameMode] == Overwatch)
        {
            for(NSString* strHero in arHeros)
            {
                NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:strHero , @"Title", [strHero lowercaseString], @"Image", nil];
                
                [arTemp addObject:dict];
                
                if([[DataArrays heroes] containsObject:strHero])
                {
                    isHero = YES;
                }
                else
                {
                    isHero = NO;
                }
            }
        }
        else if([Temp getGameMode] == LeagueOfLegends)
        {
            NSArray* arCategoryValues = [DataArrays lol_categories_values];
            NSArray* arCategoryNames = [DataArrays lol_categories];
            
            NSArray* arHeroes = [DataArrays lol_heroes];
            
            for(NSString* strHero in arHeros)
            {
                NSDictionary * dict;
                if([arHeroes containsObject:strHero])
                {
                    dict = [[NSDictionary alloc] initWithObjectsAndKeys:strHero , @"Title", strHero , @"Image", nil];
                }
                else
                {
                    int nIndex = [arCategoryValues indexOfObject:strHero];
                    
                    dict = [[NSDictionary alloc] initWithObjectsAndKeys:[arCategoryNames objectAtIndex:nIndex] , @"Title", strHero , @"Image", strHero, @"Value",  nil];
                }

                
                [arTemp addObject:dict];
                
                if([[DataArrays lol_heroes] containsObject:strHero])
                {
                    isHero = YES;
                }
                else
                {
                    isHero = NO;
                }
            }
        }

        
        if(isHero)
        {
            ArrayCategory1 = arTemp;
        }
        else
        {
            ArrayCategory2 = arTemp;
        }
        
        [self SetHeroImages:arTemp];
    }
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)SelectHero:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SelectHeroController *controller = [storyboard instantiateViewControllerWithIdentifier:@"SelectHeroController"];
    
    controller.ArrSelectCategory1 = [ArrayCategory1 mutableCopy];
    controller.ArrSelectCategory2 = [ArrayCategory2 mutableCopy];
    
    controller.delegate=self;
    
    [self.navigationController pushViewController:controller animated:YES];
}


-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

-(void)doneWithCategory1:(NSArray *)Category1 Category2:(NSArray *)Category2{

    
    if (Category1.count != 0) {
        ArrayCategory2 = [[NSMutableArray alloc] init];
        ArrayCategory1 = Category1;
        [self SetHeroImages:Category1];
      
    }else if (Category2.count != 0){
        ArrayCategory1 = [[NSMutableArray alloc] init];
        ArrayCategory2 = Category2;
        [self SetHeroImages:Category2];
    }


}

-(void)SetHeroImages:(NSArray *)ObjArray{

    [self.heroImage1 setHidden:NO];
    [self.heroImage2 setHidden:NO];
    [self.heroImage3 setHidden:NO];
    [self.heroImage4 setHidden:NO];
    [self.heroImage5 setHidden:NO];
    
    NSArray* arHr = [ObjArray valueForKey:@"Image"];
    
    int i = 0;
    if([Temp getGameMode] == Overwatch)
    {
        for(i = 0; i < [arHr count] ; ++i)
        {
            switch (i)
            {
                case 0:
                    [self.heroImage1 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                    break;
                case 1:
                    [self.heroImage2 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                    break;
                case 2:
                    [self.heroImage3 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                    break;
                case 3:
                    [self.heroImage4 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                    break;
                case 4:
                    [self.heroImage5 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                    break;
                    
                default:
                    break;
            }
        }
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        for(i = 0; i < [arHr count] ; ++i)
        {
            switch (i)
            {
                case 0:
                    [self.heroImage1 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                    break;
                case 1:
                    [self.heroImage2 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                    break;
                case 2:
                    [self.heroImage3 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                    break;
                case 3:
                    [self.heroImage4 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                    break;
                case 4:
                    [self.heroImage5 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                    break;
                    
                default:
                    break;
            }
        }
    }

    
    for(int j = i ; j < 5 ; j++)
    {
        switch (j)
        {
            case 0:
                [self.heroImage1 setHidden:YES];
                break;
            case 1:
                [self.heroImage2 setHidden:YES];
                break;
            case 2:
                [self.heroImage3 setHidden:YES];
                break;
            case 3:
                [self.heroImage4 setHidden:YES];
                break;
            case 4:
                [self.heroImage5 setHidden:YES];
                break;
                
            default:
                break;
        }
    }
}

-(NSString *) randomStringWithLength: (int) len {
   
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

- (IBAction)btnDoneClick:(id)sender {
    
    if( _txtGroupTitle.text.length == 0 || _txtDescription.text.length == 0)
    {
        [UIKit showInformation:self message:@"Please fill all fields!"];
        return;
 
    }else if (ArrayCategory1.count == 0 && ArrayCategory2.count == 0){
        
        [UIKit showInformation:self message:@"Please fill all fields!"];
        return;
        
    }else{
        if(!bEdit)
        {
            NSString *GroupID = [self randomStringWithLength:18];
            NSString *Heros;
            NSNumber *HeroCount;
            if (ArrayCategory1.count != 0) {
                
                HeroCount = [NSNumber numberWithInteger:ArrayCategory1.count];
                Heros = [[ArrayCategory1 valueForKey:@"Title"] componentsJoinedByString:@" "];
                
            }else{
                
                HeroCount = [NSNumber numberWithInteger:ArrayCategory2.count];
                Heros = [[ArrayCategory2 valueForKey:@"Value"] componentsJoinedByString:@" "];
            }

            
            [RestClient createGroup:_txtGroupTitle.text description:_txtDescription.text hero:Heros callback:^(bool result, NSDictionary *data) {
                [Temp setNeedReload:YES];
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else
        {
            NSString *GroupID = [self randomStringWithLength:18];
            NSString *Heros;
            NSNumber *HeroCount;
            if (ArrayCategory1.count != 0) {
                
                HeroCount = [NSNumber numberWithInteger:ArrayCategory1.count];
                Heros = [[ArrayCategory1 valueForKey:@"Title"] componentsJoinedByString:@" "];
                
            }else{
                
                HeroCount = [NSNumber numberWithInteger:ArrayCategory2.count];
                Heros = [[ArrayCategory2 valueForKey:@"Value"] componentsJoinedByString:@" "];
            }
            
            [RestClient updateGroup:Temp.groupData.id title:_txtGroupTitle.text description:_txtDescription.text hero:Heros ready:Temp.groupData.ready callback:^(bool result, NSDictionary *data) {
                if(!result)
                    return ;
                
                [Temp groupData].title = _txtGroupTitle.text;
                [Temp groupData].getgood_description = _txtDescription.text;
                [Temp groupData].hero = Heros;
                
                [Temp setNeedReload:YES];
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    }
   
}
- (IBAction)onBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
