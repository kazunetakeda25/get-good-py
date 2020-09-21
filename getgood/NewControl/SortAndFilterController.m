//
//  SortAndFilterController.m
//  getgood
//
//  Created by Bhargav Mistri on 02/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "SortAndFilterController.h"
#import "SortoneSectionCell.h"
#import "SorttwoSectionCell.h"
#import "SortthreeSectionCell.h"
#import "SortfourSectionCell.h"

@interface SortAndFilterController ()

@property (nonatomic, strong) NSString* prefix;

@property (nonatomic, strong) UILabel* minPlayerRating;
@property (nonatomic, strong) UILabel* maxPlayerRating;
@property (nonatomic, strong) UILabel* minGameRating;
@property (nonatomic, strong) UILabel* maxGameRating;

@end

@implementation SortAndFilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [self registerNibForCustomCell];
    
    self.prefix = @"";
    if([Temp getGameMode] == Overwatch)
    {
        self.prefix = @"";
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        self.prefix = @"lol_";
    }
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    if([defult objectForKey:[NSString stringWithFormat:@"sort1_%@online", self.prefix]] != nil)
    {
        SelectAvalibility = [[defult valueForKey:[NSString stringWithFormat:@"sort1_%@online", self.prefix]] integerValue];
    }
    else
    {
        SelectAvalibility = -1;
    }
    
    SelectSortBy = [[defult valueForKey:[NSString stringWithFormat:@"sort1_%@general", self.prefix]] integerValue];
    
    playerMinimumR = [defult valueForKey:[NSString stringWithFormat:@"sort1_%@PlayerRatingMin", self.prefix]];
    playerMaximumR = [defult valueForKey:[NSString stringWithFormat:@"sort1_%@PlayerRatingMax", self.prefix]];
    
    gameMinimumR = [defult valueForKey:[NSString stringWithFormat:@"sort1_%@GameRatingMin", self.prefix]];
    gameMaximumR = [defult valueForKey:[NSString stringWithFormat:@"sort1_%@GameRatingMax", self.prefix]];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void) dismissKeyboard
{
    [self.view endEditing:YES];
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) keyboardShown:(NSNotification*) notification {
    
    CGSize kbSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0);
        [tblView setContentInset:edgeInsets];
        [tblView setScrollIndicatorInsets:edgeInsets];
    }];
    
}

-(void) keyboardHidden:(NSNotification*) notification {
    
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
        [tblView setContentInset:edgeInsets];
        [tblView setScrollIndicatorInsets:edgeInsets];
    }];
}
-(void) scrollToCell:(NSIndexPath*) path {
    [tblView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:YES];
}
-(void)registerNibForCustomCell{
    
    UINib *nibCell=[UINib nibWithNibName:@"SortoneSectionCell" bundle:nil];
    [tblView registerNib:nibCell forCellReuseIdentifier:@"SortoneSectionCell"];
    
    UINib *nibCell1=[UINib nibWithNibName:@"SorttwoSectionCell" bundle:nil];
    [tblView registerNib:nibCell1 forCellReuseIdentifier:@"SorttwoSectionCell"];
    
    UINib *nibCell2=[UINib nibWithNibName:@"SortthreeSectionCell" bundle:nil];
    [tblView registerNib:nibCell2 forCellReuseIdentifier:@"SortthreeSectionCell"];
    
    UINib *nibCell3=[UINib nibWithNibName:@"SortfourSectionCell" bundle:nil];
    [tblView registerNib:nibCell3 forCellReuseIdentifier:@"SortfourSectionCell"];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  4;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
        
             return 173;
        }
        break;
       
        case 1:{
            
            return 166;
        }
        break;
        
        case 2:{
            
            return 120;
        }
        break;
        
        case 3:{
            
            return 120;
        }
        break;
            
        default:
        break;
    }
    
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    switch (indexPath.row) {
        case 0:{
            
             SortoneSectionCell *cell = (SortoneSectionCell *)[tableView dequeueReusableCellWithIdentifier:@"SortoneSectionCell"];
            
            cell.btnPopular.tag=0;
            [cell.btnPopular addTarget:self action:@selector(btnSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btnRelevance.tag=1;
            [cell.btnRelevance addTarget:self action:@selector(btnSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btnLowestPlayerR.tag=2;
            [cell.btnLowestPlayerR addTarget:self action:@selector(btnSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btnHighestPlayerR.tag=3;
            [cell.btnHighestPlayerR addTarget:self action:@selector(btnSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btnLowestGameR.tag=4;
            [cell.btnLowestGameR addTarget:self action:@selector(btnSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btnHighestGameR.tag=5;
            [cell.btnHighestGameR addTarget:self action:@selector(btnSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.selectionStyle = NO;
            
            [cell.btnPopular setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.btnRelevance setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.btnLowestPlayerR setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.btnHighestPlayerR setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.btnLowestGameR setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.btnHighestGameR setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            
            if (SelectSortBy == 0) {
                
                [cell.btnPopular setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
                
            }else if (SelectSortBy == 1){
                
                [cell.btnRelevance setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
                
            }else if (SelectSortBy == 2){
                
                 [cell.btnLowestPlayerR setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
                
            }else if (SelectSortBy == 3){
                
                [cell.btnHighestPlayerR setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
                
            }else if (SelectSortBy == 4){
                
                [cell.btnLowestGameR setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
                
            }else if (SelectSortBy == 5){
                
                [cell.btnHighestGameR setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
          
            }
        
            return cell;
        }
         break;
        
        case 1:{
            
            SorttwoSectionCell *cell = (SorttwoSectionCell *)[tableView dequeueReusableCellWithIdentifier:@"SorttwoSectionCell"];
            
            cell.btnOnline.tag=1;
            [cell.btnOnline addTarget:self action:@selector(btnAvaliabilityClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btnOffline.tag=0;
            [cell.btnOffline addTarget:self action:@selector(btnAvaliabilityClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btnLive.tag=2;
            [cell.btnLive addTarget:self action:@selector(btnAvaliabilityClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btnAny.tag=-1;
            [cell.btnAny addTarget:self action:@selector(btnAvaliabilityClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.btnOnline setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.btnOffline setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.btnAny setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.btnLive setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            if (SelectAvalibility == 1) {
            
                [cell.btnOnline setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
                
            }else if (SelectAvalibility == 0){
                
                [cell.btnOffline setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
                
            }else if (SelectAvalibility == -1){
                
                [cell.btnAny setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
            }else if (SelectAvalibility == 2){
                
                [cell.btnLive setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
            }
            
            cell.selectionStyle = NO;
            return cell;
            
        }
        break;
         
        case 2:{
            SortthreeSectionCell *cell = (SortthreeSectionCell *)[tableView dequeueReusableCellWithIdentifier:@"SortthreeSectionCell"];
            
            [cell.slider setMinValue:0 maxValue:5.0];
            float min = 0.0f;
            float max = 5.0f;
            
            if (playerMinimumR.length != 0) {
                min = [playerMinimumR floatValue];
                
            }
            
            if (playerMaximumR.length != 0) {
                max = [playerMaximumR floatValue];
            }

            [cell.tvMin setText:[NSString stringWithFormat:@"%.1f", min]];
            [cell.tvMax setText:[NSString stringWithFormat:@"%.1f", max]];
            [cell.slider setLeftValue:min rightValue:max];
            
            self.minPlayerRating = cell.tvMin;
            self.maxPlayerRating = cell.tvMax;
            
            cell.showDecimal = YES;
            
            cell.selectionStyle = NO;
            return cell;
        }
        break;
        case 3:{
           if([Temp getGameMode] == Overwatch)
           {
               SortthreeSectionCell *cell = (SortthreeSectionCell *)[tableView dequeueReusableCellWithIdentifier:@"SortthreeSectionCell"];
               
               [cell.tvTitle setTitle:@"In-game Rating" forState:UIControlStateNormal];
               [cell.slider setMinValue:0 maxValue:10000.0];
               float min = 0.0f;
               float max = 10000.0f;
               
               if (gameMinimumR.length != 0) {
                   min = [gameMinimumR floatValue];
                   
               }
               
               if (gameMaximumR.length != 0) {
                   max = [gameMaximumR floatValue];
               }
               
               [cell.tvMin setText:[NSString stringWithFormat:@"%.0f", min]];
               [cell.tvMax setText:[NSString stringWithFormat:@"%.0f", max]];
               [cell.slider setLeftValue:min rightValue:max];
               
               self.minGameRating = cell.tvMin;
               self.maxGameRating = cell.tvMax;
               
               cell.selectionStyle = NO;
               cell.showDecimal = NO;
               return cell;
           }
            else if([Temp getGameMode] == LeagueOfLegends)
            {
                SortfourSectionCell *cell = (SortfourSectionCell *)[tableView dequeueReusableCellWithIdentifier:@"SortfourSectionCell"];
                
                [cell.title setTitle:@"In-game Rating" forState:UIControlStateNormal];
                
                cell.txtMiniGameR.text = @"";
                if (gameMinimumR.length != 0) {
                    cell.txtMiniGameR.text = gameMinimumR;
                }
                
                cell.txtMiniGameR.tag=3;
                cell.txtMiniGameR.delegate=self;
                cell.txtMiniGameR.keyboardType=UIKeyboardTypeDecimalPad;
                
                cell.txtMaxiGameR.text = @"";
                if (gameMaximumR.length != 0) {
                    cell.txtMaxiGameR.text = gameMaximumR;
                }
                
                cell.txtMaxiGameR.tag=4;
                cell.txtMaxiGameR.delegate=self;
                cell.txtMaxiGameR.keyboardType=UIKeyboardTypeDecimalPad;
                
                cell.selectionStyle = NO;
                return cell;
            }

        }
        break;
        default:
        break;
    }
    
    return nil;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag==1) {
        
        playerMinimumR=textField.text;
    }
    else if (textField.tag==2)
    {
        playerMaximumR=textField.text;
    }
    else if (textField.tag==3)
    {
        gameMinimumR=textField.text;
    }
    else if (textField.tag==4)
    {
        gameMaximumR=textField.text;
    }

}
- (UITableViewCell *)cellWithSubview:(UIView *)subview {
    
    while (subview && ![subview isKindOfClass:[UITableViewCell self]])
        subview = subview.superview;
    return (UITableViewCell *)subview;
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self.view endEditing:TRUE];
}
-(void)btnAvaliabilityClick:(UIButton *)btn{
    
    SelectAvalibility = btn.tag;
    [tblView reloadData];
}
-(void)btnSelectClick:(UIButton *)btn{
    
    SelectSortBy = btn.tag;
    [tblView reloadData];
}
- (void)actionBack:(UITapGestureRecognizer *)tapGesture{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnDoneClick:(id)sender {
    
    [self.view endEditing:YES];
    
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    [defult setInteger:SelectSortBy forKey:[NSString stringWithFormat:@"sort1_%@general", self.prefix]];
    [defult setInteger:SelectAvalibility forKey:[NSString stringWithFormat:@"sort1_%@online", self.prefix]];
    
    if(self.minPlayerRating != nil)
    [defult setValue:self.minPlayerRating.text forKey:[NSString stringWithFormat:@"sort1_%@PlayerRatingMin", self.prefix]];
    if(self.maxPlayerRating != nil)
    [defult setValue:self.maxPlayerRating.text forKey:[NSString stringWithFormat:@"sort1_%@PlayerRatingMax", self.prefix]];
    if([Temp getGameMode] == Overwatch)
    {
        if(self.minGameRating != nil)
            [defult setValue:self.minGameRating.text forKey:[NSString stringWithFormat:@"sort1_%@GameRatingMin", self.prefix]];
        if(self.maxGameRating != nil)
            [defult setValue:self.maxGameRating.text forKey:[NSString stringWithFormat:@"sort1_%@GameRatingMax", self.prefix]];
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
            [defult setValue:gameMinimumR forKey:[NSString stringWithFormat:@"sort1_%@GameRatingMin", self.prefix]];
            [defult setValue:gameMaximumR forKey:[NSString stringWithFormat:@"sort1_%@GameRatingMax", self.prefix]];
        
    }
    
    
    [Temp setNeedReload:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
