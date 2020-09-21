//
//  CoachSortViewController.m
//  getgood
//
//  Created by Dan on 5/16/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "CoachSortViewController.h"

#import "SortoneSectionCell.h"
#import "SorttwoSectionCell.h"
#import "SortthreeSectionCell.h"
#import "SortfourSectionCell.h"
#import "SortfiveSectionCell.h"

@interface CoachSortViewController ()
{
    NSString* prefix;
}
@end

@implementation CoachSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [self registerNibForCustomCell];
    
    prefix = @"";
    if([Temp getGameMode] == Overwatch)
    {
        prefix = @"";
    }
    else if ([Temp getGameMode] == LeagueOfLegends)
    {
        prefix = @"lol_";
    }
    
    
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    
    SelectAvalibility = -1;
    
    if([defult objectForKey:[NSString stringWithFormat:@"sort_%@online", prefix]] != nil)
    {
        SelectAvalibility = [[defult valueForKey:[NSString stringWithFormat:@"sort_%@online", prefix]] integerValue];
    }
    SelectSortBy = [[defult valueForKey:[NSString stringWithFormat:@"sort_%@general", prefix]] integerValue];
    
    CoachRatingMin = [defult valueForKey:[NSString stringWithFormat:@"sort_%@CoachRatingMin", prefix]];
    CoachRatingMax = [defult valueForKey:[NSString stringWithFormat:@"sort_%@CoachRatingMax", prefix]];
    
    GameRatingMin = [defult valueForKey:[NSString stringWithFormat:@"sort_%@GameRatingMin", prefix]];
    GameRatingMax = [defult valueForKey:[NSString stringWithFormat:@"sort_%@GameRatingMax", prefix]];
    
    PriceMin = [defult valueForKey:[NSString stringWithFormat:@"sort_%@PriceMin", prefix]];
    PriceMax = [defult valueForKey:[NSString stringWithFormat:@"sort_%@PriceMax", prefix]];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDone:(id)sender {
    
    [self.view endEditing:YES];
    
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    
    [defult setInteger:SelectSortBy forKey:[NSString stringWithFormat:@"sort_%@general", prefix]];
    [defult setInteger:SelectAvalibility forKey:[NSString stringWithFormat:@"sort_%@online", prefix]];
    
    
    if(lbCoachRatingMin != nil)
    [defult setValue:lbCoachRatingMin.text forKey:[NSString stringWithFormat:@"sort_%@CoachRatingMin", prefix]];
    
    
    if(lbCoachRatingMax != nil)
    [defult setValue:lbCoachRatingMax.text forKey:[NSString stringWithFormat:@"sort_%@CoachRatingMax", prefix]];
    
    if([Temp getGameMode] == Overwatch)
    {
        if(lbGameRatingMin != nil)
            [defult setValue:lbGameRatingMin.text forKey:[NSString stringWithFormat:@"sort_%@GameRatingMin", prefix]];
        
        if(lbGameRatingMax != nil)
            [defult setValue:lbGameRatingMax.text forKey:[NSString stringWithFormat:@"sort_%@GameRatingMax", prefix]];
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        [defult setValue:GameRatingMin forKey:[NSString stringWithFormat:@"sort_%@GameRatingMin", prefix]];
        [defult setValue:GameRatingMax forKey:[NSString stringWithFormat:@"sort_%@GameRatingMax", prefix]];
    }

    
    if(lbPriceMin != nil)
    [defult setValue:lbPriceMin.text forKey:[NSString stringWithFormat:@"sort_%@PriceMin", prefix]];
    
    if(lbPriceMax != nil)
    [defult setValue:lbPriceMax.text forKey:[NSString stringWithFormat:@"sort_%@PriceMax", prefix]];
    
    
    [Temp setNeedReload:YES];
    [self.navigationController popViewControllerAnimated:YES];

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
        [self.tableView setContentInset:edgeInsets];
        [self.tableView setScrollIndicatorInsets:edgeInsets];
    }];
    
}

-(void) keyboardHidden:(NSNotification*) notification {
    
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
        [self.tableView setContentInset:edgeInsets];
        [self.tableView setScrollIndicatorInsets:edgeInsets];
    }];
}

-(void)registerNibForCustomCell{
    
    UINib *nibCell=[UINib nibWithNibName:@"CoachSortOneCell" bundle:nil];
    [self.tableView registerNib:nibCell forCellReuseIdentifier:@"CoachSortOneCell"];
    
    UINib *nibCell1=[UINib nibWithNibName:@"SorttwoSectionCell" bundle:nil];
    [self.tableView registerNib:nibCell1 forCellReuseIdentifier:@"SorttwoSectionCell"];
    
    UINib *nibCell2=[UINib nibWithNibName:@"SortthreeSectionCell" bundle:nil];
    [self.tableView registerNib:nibCell2 forCellReuseIdentifier:@"SortthreeSectionCell"];
    
    UINib *nibCell3=[UINib nibWithNibName:@"SortfourSectionCell" bundle:nil];
    [self.tableView registerNib:nibCell3 forCellReuseIdentifier:@"SortfourSectionCell"];
    
    UINib *nibCell4=[UINib nibWithNibName:@"SortfiveSectionCell" bundle:nil];
    [self.tableView registerNib:nibCell4 forCellReuseIdentifier:@"SortfiveSectionCell"];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  5;
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
            
            return 233;
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
            
        case 4:{
            
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
            
            CoachSortOneCell *cell = (CoachSortOneCell *)[tableView dequeueReusableCellWithIdentifier:@"CoachSortOneCell"];
            
            cell.btnPopular.tag=0;
            [cell.btnPopular addTarget:self action:@selector(btnSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btnRelevance.tag=1;
            [cell.btnRelevance addTarget:self action:@selector(btnSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btnCoachRatingLow.tag=2;
            [cell.btnCoachRatingLow addTarget:self action:@selector(btnSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btnCoachRatingHigh.tag=3;
            [cell.btnCoachRatingHigh addTarget:self action:@selector(btnSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btnGameRatingLow.tag=4;
            [cell.btnGameRatingLow addTarget:self action:@selector(btnSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btnGameRatingHigh.tag=5;
            [cell.btnGameRatingHigh addTarget:self action:@selector(btnSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btnPriceLow.tag=6;
            [cell.btnPriceLow addTarget:self action:@selector(btnSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btnPriceHigh.tag=7;
            [cell.btnPriceHigh addTarget:self action:@selector(btnSelectClick:) forControlEvents:UIControlEventTouchUpInside];

            
            cell.selectionStyle = NO;
            
            [cell.btnPopular setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.btnRelevance setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.btnCoachRatingLow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.btnCoachRatingHigh setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.btnGameRatingLow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.btnGameRatingHigh setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.btnPriceLow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.btnPriceHigh setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            
            if (SelectSortBy == 0) {
                
                [cell.btnPopular setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
                
            }else if (SelectSortBy == 1){
                
                [cell.btnRelevance setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
                
            }else if (SelectSortBy == 2){
                
                [cell.btnCoachRatingLow setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
                
            }else if (SelectSortBy == 3){
                
                [cell.btnCoachRatingHigh setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
                
            }else if (SelectSortBy == 4){
                
                [cell.btnGameRatingLow setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
                
            }else if (SelectSortBy == 5){
                
                [cell.btnGameRatingHigh setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
                
            }else if (SelectSortBy == 6){
                
                [cell.btnPriceLow setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
                
            }else if (SelectSortBy == 7){
                
                [cell.btnPriceHigh setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
                
            }
            
            return cell;
        }
            break;
            
        case 1:{
            
            SorttwoSectionCell *cell = (SorttwoSectionCell *)[tableView dequeueReusableCellWithIdentifier:@"SorttwoSectionCell"];
            
            [cell.btnLive setTitle:@"Live Coaches" forState:UIControlStateNormal];
            
            
            cell.btnOnline.tag=1;
            [cell.btnOnline addTarget:self action:@selector(btnAvaliabilityClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btnOffline.tag=0;
            [cell.btnOffline addTarget:self action:@selector(btnAvaliabilityClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btnAny.tag=-1;
            [cell.btnAny addTarget:self action:@selector(btnAvaliabilityClick:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btnLive.tag=2;
            [cell.btnLive addTarget:self action:@selector(btnAvaliabilityClick:) forControlEvents:UIControlEventTouchUpInside];
            
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
            }
            else if (SelectAvalibility == 2){
                
                [cell.btnLive setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
            }
            
            cell.selectionStyle = NO;
            return cell;
            
        }
            break;
            
        case 2:{
            SortthreeSectionCell *cell = (SortthreeSectionCell *)[tableView dequeueReusableCellWithIdentifier:@"SortthreeSectionCell"];
            [cell.tvTitle setTitle:@"Coach Rating Range" forState:UIControlStateNormal];
            [cell.slider setMinValue:0 maxValue:5.0];
            float min = 0.0f;
            float max = 5.0;
            
            if (CoachRatingMin.length != 0) {
                min = [CoachRatingMin floatValue];
                
            }
            
            if (CoachRatingMax.length != 0) {
                max = [CoachRatingMax floatValue];
            }
            
            [cell.tvMin setText:[NSString stringWithFormat:@"%.1f", min]];
            [cell.tvMax setText:[NSString stringWithFormat:@"%.1f", max]];
            [cell.slider setLeftValue:min rightValue:max];
            
            lbCoachRatingMin = cell.tvMin;
            lbCoachRatingMax = cell.tvMax;
            
            cell.showDecimal = YES;
            
            cell.selectionStyle = NO;
            return cell;
            
            
        }
            break;
        case 3:{
            if([Temp getGameMode] == Overwatch)
            {
                SortthreeSectionCell *cell = (SortthreeSectionCell *)[tableView dequeueReusableCellWithIdentifier:@"SortthreeSectionCell"];
                [cell.tvTitle setTitle:@"In-game Rating Range" forState:UIControlStateNormal];
                [cell.slider setMinValue:0 maxValue:10000.0f];
                float min = 0.0f;
                float max = 10000.0f;
                
                if (GameRatingMin.length != 0) {
                    min = [GameRatingMin floatValue];
                    
                }
                
                if (GameRatingMax.length != 0) {
                    max = [GameRatingMax floatValue];
                }
                
                [cell.tvMin setText:[NSString stringWithFormat:@"%.0f", min]];
                [cell.tvMax setText:[NSString stringWithFormat:@"%.0f", max]];
                [cell.slider setLeftValue:min rightValue:max];
                
                lbGameRatingMin = cell.tvMin;
                lbGameRatingMax = cell.tvMax;
                
                cell.showDecimal = NO;
                
                cell.selectionStyle = NO;
                return cell;
            }
            else if([Temp getGameMode] == LeagueOfLegends)
            {
                SortfourSectionCell *cell = (SortfourSectionCell *)[tableView dequeueReusableCellWithIdentifier:@"SortfourSectionCell"];
                
                [cell.title setTitle:@"In-game Rating Range" forState:UIControlStateNormal];
                
                cell.txtMiniGameR.text = @"";
                if (GameRatingMin.length != 0) {
                    cell.txtMiniGameR.text = GameRatingMin;
                }
                
                cell.txtMiniGameR.tag=3;
                cell.txtMiniGameR.delegate=self;
                cell.txtMiniGameR.keyboardType=UIKeyboardTypeDecimalPad;
                
                cell.txtMaxiGameR.text = @"";
                if (GameRatingMax.length != 0) {
                    cell.txtMaxiGameR.text = GameRatingMax;
                }
                
                cell.txtMaxiGameR.tag=4;
                cell.txtMaxiGameR.delegate=self;
                cell.txtMaxiGameR.keyboardType=UIKeyboardTypeDecimalPad;
                
                cell.selectionStyle = NO;
                return cell;
            }

        }
        case 4:{
            
            SortthreeSectionCell *cell = (SortthreeSectionCell *)[tableView dequeueReusableCellWithIdentifier:@"SortthreeSectionCell"];
            [cell.tvTitle setTitle:@"Price Range" forState:UIControlStateNormal];
            [cell.slider setMinValue:0 maxValue:50.0f];
            float min = 0.0f;
            float max = 50.0f;
            
            if (PriceMin.length != 0) {
                min = [PriceMin floatValue];
                
            }
            
            if (PriceMax.length != 0) {
                max = [PriceMax floatValue];
            }
            
            [cell.tvMin setText:[NSString stringWithFormat:@"%.0f", min]];
            [cell.tvMax setText:[NSString stringWithFormat:@"%.0f", max]];
            [cell.slider setLeftValue:min rightValue:max];
            
            lbPriceMin = cell.tvMin;
            lbPriceMax = cell.tvMax;
            
            cell.showDecimal = NO;
            
            cell.selectionStyle = NO;
            return cell;
        }
            break;
        default:
            break;
    }
    
    return nil;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag==1) {
        
        CoachRatingMin=textField.text;
    }
    else if (textField.tag==2)
    {
        CoachRatingMax=textField.text;
    }
    else if (textField.tag==3)
    {
        GameRatingMin=textField.text;
    }
    else if (textField.tag==4)
    {
        GameRatingMax=textField.text;
    }
    else if (textField.tag==5)
    {
        PriceMin=textField.text;
    }
    else if (textField.tag==6)
    {
        PriceMax=textField.text;
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
    [self.tableView reloadData];
}
-(void)btnSelectClick:(UIButton *)btn{
    
    SelectSortBy = btn.tag;
    [self.tableView reloadData];
}
@end
