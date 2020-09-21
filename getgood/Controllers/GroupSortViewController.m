//
//  GroupSortViewController.m
//  getgood
//
//  Created by Dan on 5/15/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "GroupSortViewController.h"

#import "SortoneSectionCell.h"
#import "SorttwoSectionCell.h"
#import "SortthreeSectionCell.h"
#import "SortfourSectionCell.h"

@interface GroupSortViewController ()
{
    NSString* prefix;
}
@end

@implementation GroupSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [self registerNibForCustomCell];
    
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    
    prefix = @"";
    
    if([Temp getGameMode] == Overwatch)
    {
        prefix = @"";
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        prefix = @"lol_";
    }
    
    SelectAvalibility = -1;
    
    if([defult objectForKey:[NSString stringWithFormat:@"sort2_%@online", prefix]] != nil)
    {
        SelectAvalibility = [[defult valueForKey:[NSString stringWithFormat:@"sort2_%@online", prefix]] integerValue];
    }
    
    SelectSortBy = [[defult valueForKey:[NSString stringWithFormat:@"sort2_%@general", prefix]] integerValue];
    
    AvgPlayerRatingMin = [defult valueForKey:[NSString stringWithFormat:@"sort2_%@PlayerRatingMin", prefix]];
    AvgPlayerRatingMax = [defult valueForKey:[NSString stringWithFormat:@"sort2_%@PlayerRatingMax", prefix]];
    
    AvgGameRatingMin = [defult valueForKey:[NSString stringWithFormat:@"sort2_%@GameRatingMin", prefix]];
    AvgGameRatingMax = [defult valueForKey:[NSString stringWithFormat:@"sort2_%@GameRatingMax", prefix]];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void) dismissKeyboard
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onDone:(id)sender {
    
    [self.view endEditing:YES];
    
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    [defult setInteger:SelectSortBy forKey:[NSString stringWithFormat:@"sort2_%@general", prefix]];
    [defult setInteger:SelectAvalibility forKey:[NSString stringWithFormat:@"sort2_%@online", prefix]];
    if(lbPlayerMin != nil)
    [defult setValue:lbPlayerMin.text forKey:[NSString stringWithFormat:@"sort2_%@PlayerRatingMin", prefix]];
    if(lbPlayerMax != nil)
    [defult setValue:lbPlayerMax.text forKey:[NSString stringWithFormat:@"sort2_%@PlayerRatingMax", prefix]];
    
    if([Temp getGameMode] == Overwatch)
    {
        if(lbGameMin != nil)
            [defult setValue:lbGameMin.text forKey:[NSString stringWithFormat:@"sort2_%@GameRatingMin", prefix]];
        if(lbGameMax != nil)
            [defult setValue:lbGameMax.text forKey:[NSString stringWithFormat:@"sort2_%@GameRatingMax", prefix]];
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
            [defult setValue:AvgGameRatingMin forKey:[NSString stringWithFormat:@"sort2_%@GameRatingMin", prefix]];
            [defult setValue:AvgGameRatingMax forKey:[NSString stringWithFormat:@"sort2_%@GameRatingMax", prefix]];
    }
    
    
    [Temp setNeedReload:YES];
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
-(void) scrollToCell:(NSIndexPath*) path {
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:YES];
}
-(void)registerNibForCustomCell{
    
    UINib *nibCell=[UINib nibWithNibName:@"GroupSortOneCell" bundle:nil];
    [self.tableView registerNib:nibCell forCellReuseIdentifier:@"GroupSortOneCell"];
    
    UINib *nibCell1=[UINib nibWithNibName:@"SorttwoSectionCell" bundle:nil];
    [self.tableView registerNib:nibCell1 forCellReuseIdentifier:@"SorttwoSectionCell"];
    
    UINib *nibCell2=[UINib nibWithNibName:@"SortthreeSectionCell" bundle:nil];
    [self.tableView registerNib:nibCell2 forCellReuseIdentifier:@"SortthreeSectionCell"];
    
    UINib *nibCell3=[UINib nibWithNibName:@"SortfourSectionCell" bundle:nil];
    [self.tableView registerNib:nibCell3 forCellReuseIdentifier:@"SortfourSectionCell"];
    
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
            
            GroupSortOneCell *cell = (GroupSortOneCell *)[tableView dequeueReusableCellWithIdentifier:@"GroupSortOneCell"];
            
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
            [cell.btnLive setTitle:@"Live Groups" forState:UIControlStateNormal];
            
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
            }else if (SelectAvalibility == 2){
                
                [cell.btnLive setTitleColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] forState:UIControlStateNormal];
            }
            
            cell.selectionStyle = NO;
            return cell;
            
        }
            break;
            
        case 2:{
            
            SortthreeSectionCell *cell = (SortthreeSectionCell *)[tableView dequeueReusableCellWithIdentifier:@"SortthreeSectionCell"];
            
            [cell.tvTitle setTitle:@"Average Player Rating Range" forState:UIControlStateNormal];
            [cell.slider setMinValue:0 maxValue:5.0];
            float min = 0.0f;
            float max = 5.0f;
            
            if (AvgPlayerRatingMin.length != 0) {
                min = [AvgPlayerRatingMin floatValue];
                
            }
            
            if (AvgPlayerRatingMax.length != 0) {
                max = [AvgPlayerRatingMax floatValue];
            }
            
            [cell.tvMin setText:[NSString stringWithFormat:@"%.1f", min]];
            [cell.tvMax setText:[NSString stringWithFormat:@"%.1f", max]];
            [cell.slider setLeftValue:min rightValue:max];
            
            lbPlayerMin = cell.tvMin;
            lbPlayerMax = cell.tvMax;
            
            cell.showDecimal = YES;
            
            cell.selectionStyle = NO;
            return cell;
            
            
        }
            break;
        case 3:{
            if([Temp getGameMode] == Overwatch)
            {
                SortthreeSectionCell *cell = (SortthreeSectionCell *)[tableView dequeueReusableCellWithIdentifier:@"SortthreeSectionCell"];
                [cell.tvTitle setTitle:@"Average In-Game Rating Range" forState:UIControlStateNormal];
                [cell.slider setMinValue:0 maxValue:10000.0f];
                float min = 0.0f;
                float max = 10000.0f;
                
                if (AvgGameRatingMin.length != 0) {
                    min = [AvgGameRatingMin floatValue];
                    
                }
                
                if (AvgGameRatingMax.length != 0) {
                    max = [AvgGameRatingMax floatValue];
                }
                
                [cell.tvMin setText:[NSString stringWithFormat:@"%.0f", min]];
                [cell.tvMax setText:[NSString stringWithFormat:@"%.0f", max]];
                [cell.slider setLeftValue:min rightValue:max];
                
                lbGameMin = cell.tvMin;
                lbGameMax = cell.tvMax;
                
                cell.showDecimal = NO;
                
                cell.selectionStyle = NO;
                return cell;
            }
            else if([Temp getGameMode] == LeagueOfLegends)
            {
                SortfourSectionCell *cell = (SortfourSectionCell *)[tableView dequeueReusableCellWithIdentifier:@"SortfourSectionCell"];
                
                [cell.title setTitle:@"Average In-Game Rating Range" forState:UIControlStateNormal];
                
                cell.txtMiniGameR.text = @"";
                if (AvgGameRatingMin.length != 0) {
                    cell.txtMiniGameR.text = AvgGameRatingMin;
                }
                
                cell.txtMiniGameR.tag=3;
                cell.txtMiniGameR.delegate=self;
                cell.txtMiniGameR.keyboardType=UIKeyboardTypeDecimalPad;
                
                cell.txtMaxiGameR.text = @"";
                if (AvgGameRatingMax.length != 0) {
                    cell.txtMaxiGameR.text = AvgGameRatingMax;
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
        
        AvgPlayerRatingMin=textField.text;
    }
    else if (textField.tag==2)
    {
        AvgPlayerRatingMax=textField.text;
    }
    else if (textField.tag==3)
    {
        AvgGameRatingMin=textField.text;
    }
    else if (textField.tag==4)
    {
        AvgGameRatingMax=textField.text;
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
- (void)actionBack:(UITapGestureRecognizer *)tapGesture{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
