//
//  GroupRateViewController.m
//  getgood
//
//  Created by Dan on 18/04/2018.
//  Copyright © 2018 PH. All rights reserved.
//

#import "GroupRateViewController.h"
#import "AppData.h"
#import "PlayerRateHelpController.h"

#define highlightColor [UIColor colorWithRed:170.0f / 255.0f green:198.0f / 255.0f blue:63.0f / 255.0f alpha:1.0f]
#define normalColor [UIColor whiteColor]
#define disableColor [UIColor grayColor]
@interface GroupRateViewController ()

@end

@implementation GroupRateViewController
@synthesize scrollView, content, profile;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self feedUI];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onRate:(id)sender {
    
    if([self.vReview.text length] == 0)
    {
        [UIKit showInformation:self message:@"Please fill note"];
        return;
    }
    
    [UIKit showYesNo:self message:@"Are you sure to leave this rate?" yesHandler:^(UIAlertAction *action) {

        [RestClient postPlayerReview:profile.id leader:[self getSelectedInt:self.vTeamLeader] cooperative:[self getSelectedInt:self.vCooperativePlayer] good_communication:[self getSelectedInt:self.vGoodCommunication] sportsmanship:[self getSelectedInt:self.vSportsmanship] mvp:[self getSelectedInt:self.vMVP] flex_player:[self getSelectedInt:self.vFlexPlayer] good_hero_competency:[self getSelectedInt:self.vGoodHeroCompetency] griefing:[self getSelectedInt:self.vGriefingAndInactivity] spam:[self getSelectedInt:self.vSpam] no_communication:[self getSelectedInt:self.vNoCommunication] un_cooperative:[self getSelectedInt:self.vUnCooperativePlayer] trickling_in:[self getSelectedInt:self.vTricklingIn] poor_hero_competency:[self getSelectedInt:self.vPoorHeroCompetency] bad_ultimate_usage:[self getSelectedInt:self.vBadUltimateUsage] overextending:[self getSelectedInt:self.vOverextending] comment:self.vReview.text abusive_chat:[self getSelectedInt:self.vAbusiveChat] good_ultimate_usage:[self getSelectedInt:self.vGoodUltimateUsage] callback:^(bool result, NSDictionary *data) {
            if(!result)
                return ;
            
            [RestClient sendNotification:[NSString stringWithFormat:@"%@ has just rated you!", [AppData profile].name] user_id:profile.id];
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    } cancelHandler:^(UIAlertAction *action) {
        
    }];
    
}

- (void) feedUI
{
    scrollView.contentSize = content.frame.size;
    
    [self.lblName setText:profile.name];
    [self.ivAvatar sd_setImageWithURL:[NSURL URLWithString:profile.avatar_url]];
    
    if([Temp getGameMode] == Overwatch)
    {
        [self.lblGameRating setText:[NSString stringWithFormat:@"%d", profile.overwatch_rank ]];
        
        if(profile.overwatch_rank == 0)
        {
            [self.lblGameRating setText:@"---"];
        }
        
        [self.rating setValue:profile.player_rating];
        
        
        
        if(profile.overwatch_heroes.length)
        {
            NSArray* arHr = [profile.overwatch_heroes componentsSeparatedByString: @" "];
            
            int i = 0;
            for(i = 0; i < [arHr count] ; ++i)
            {
                switch (i)
                {
                    case 0:
                        [self.ivHero1 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 1:
                        [self.ivHero2 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 2:
                        [self.ivHero3 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 3:
                        [self.ivHero4 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                    case 4:
                        [self.ivHero5 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                        break;
                        
                    default:
                        break;
                }
            }
            
            for(int j = i ; j < 5 ; ++j)
            {
                switch (j)
                {
                    case 0:
                        [self.ivHero1  setHidden:YES];
                        break;
                    case 1:
                        [self.ivHero2  setHidden:YES];
                        break;
                    case 2:
                        [self.ivHero3  setHidden:YES];
                        break;
                    case 3:
                        [self.ivHero4  setHidden:YES];
                        break;
                    case 4:
                        [self.ivHero5  setHidden:YES];
                        break;
                        
                    default:
                        break;
                }
            }
        }
        
        _lblServer.text = @"";
        [_ivPlatform setImage:nil];
        
        if(profile.server.length)
        {
            if([profile.server containsString:@"us"])
            {
                _lblServer.text = @"Americas";
            }
            else if([profile.server containsString:@"eu"])
            {
                _lblServer.text = @"Europe";
            }
            else if([profile.server containsString:@"kr"])
            {
                _lblServer.text = @"Asia";
            }
            if([profile.server containsString:@"pc"])
            {
                [_ivPlatform setImage:[UIImage imageNamed:@"pc"]];
            }
            else if([profile.server containsString:@"xbox"])
            {
                [_ivPlatform setImage:[UIImage imageNamed:@"xbox"]];
            }
            else if([profile.server containsString:@"ps4"])
            {
                [_ivPlatform setImage:[UIImage imageNamed:@"ps4"]];
            }
        }
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        [self.lblGameRating setText:profile.lol_rank ];
        
        if(!profile.lol_rank.length)
        {
            [self.lblGameRating setText:@"---"];
        }
        
        [self.rating setValue:profile.lol_player_rating];
        
        
        
        if(profile.lol_heroes.length)
        {
            NSArray* arHr = [profile.lol_heroes componentsSeparatedByString: @" "];
            
            int i = 0;
            for(i = 0; i < [arHr count] ; ++i)
            {
                switch (i)
                {
                    case 0:
                        [self.ivHero1 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 1:
                        [self.ivHero2 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 2:
                        [self.ivHero3 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 3:
                        [self.ivHero4 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                    case 4:
                        [self.ivHero5 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                        break;
                        
                    default:
                        break;
                }
            }
            
            for(int j = i ; j < 5 ; ++j)
            {
                switch (j)
                {
                    case 0:
                        [self.ivHero1  setHidden:YES];
                        break;
                    case 1:
                        [self.ivHero2  setHidden:YES];
                        break;
                    case 2:
                        [self.ivHero3  setHidden:YES];
                        break;
                    case 3:
                        [self.ivHero4  setHidden:YES];
                        break;
                    case 4:
                        [self.ivHero5  setHidden:YES];
                        break;
                        
                    default:
                        break;
                }
            }
        }
        
        _lblServer.text = @"";
        [_ivPlatform setImage:[UIImage imageNamed:@"pc"]];
        [_lblServer setText:[Utils getLolServerName:profile.lol_server]];
    }
    
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAttribute:)];
    [self.vTeamLeader addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAttribute:)];
    [self.vCooperativePlayer addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAttribute:)];
    [self.vGoodCommunication addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAttribute:)];
    [self.vSportsmanship addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAttribute:)];
    [self.vMVP addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAttribute:)];
    [self.vFlexPlayer addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAttribute:)];
    [self.vGoodHeroCompetency addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAttribute:)];
    [self.vGoodUltimateUsage addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAttribute:)];
    [self.vAbusiveChat addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAttribute:)];
    [self.vGriefingAndInactivity addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAttribute:)];
    
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAttribute:)];
    [self.vSpam addGestureRecognizer:tapGestureRecognizer];
    
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAttribute:)];
    [self.vNoCommunication addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAttribute:)];
    [self.vUnCooperativePlayer addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAttribute:)];
    [self.vTricklingIn addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAttribute:)];
    [self.vPoorHeroCompetency addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAttribute:)];
    [self.vBadUltimateUsage addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAttribute:)];
    [self.vOverextending addGestureRecognizer:tapGestureRecognizer];
    
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onHelp:)];
    [self.help addGestureRecognizer:tapGestureRecognizer];
}
- (void) onHelp: (UITapGestureRecognizer*) recognizer
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    PlayerRateHelpController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_player_rating_help"];
    [self.navigationController pushViewController:controller animated:YES];
}
- (void) onAttribute: (UITapGestureRecognizer*) recognizer
{
    RoundedCornerView* view  = (RoundedCornerView*) recognizer.view;
    
    if(![self getSelected: view])
    {
        [self setSelected:view selected: YES];
    }
    else
    {
        [self setSelected:view selected:NO];
    }
    
    if(view == self.vTeamLeader || view ==self.vCooperativePlayer)
    {
        [self enable:self.vAbusiveChat enabled:![self getSelected:view]];
        [self enable:self.vGriefingAndInactivity enabled:![self getSelected:view]];
        [self enable:self.vSpam enabled:![self getSelected:view]];
        [self enable:self.vNoCommunication enabled:![self getSelected:view]];
        [self enable:self.vUnCooperativePlayer enabled:![self getSelected:view]];
    }
    else if(view == self.vGoodCommunication)
    {
        [self enable:self.vAbusiveChat enabled:![self getSelected:view]];
        [self enable:self.vSpam enabled:![self getSelected:view]];
        [self enable:self.vNoCommunication enabled:![self getSelected:view]];
    }
    else if(view == self.vSportsmanship)
    {
        [self enable:self.vAbusiveChat enabled:![self getSelected:view]];
        [self enable:self.vSpam enabled:![self getSelected:view]];
        [self enable:self.vGriefingAndInactivity enabled:![self getSelected:view]];
        [self enable:self.vNoCommunication enabled:![self getSelected:view]];
        [self enable:self.vUnCooperativePlayer enabled:![self getSelected:view]];
    }
    else if(view == self.vMVP)
    {
        [self enable:self.vAbusiveChat enabled:![self getSelected:view]];
        [self enable:self.vSpam enabled:![self getSelected:view]];
        [self enable:self.vGriefingAndInactivity enabled:![self getSelected:view]];
        [self enable:self.vNoCommunication enabled:![self getSelected:view]];
        [self enable:self.vUnCooperativePlayer enabled:![self getSelected:view]];
        
        [self enable:self.vTricklingIn enabled:![self getSelected:view]];
        [self enable:self.vPoorHeroCompetency enabled:![self getSelected:view]];
        [self enable:self.vBadUltimateUsage enabled:![self getSelected:view]];
        [self enable:self.vOverextending enabled:![self getSelected:view]];
    }
    else if(view == self.vFlexPlayer)
    {
        
    }
    else if(view == self.vGoodHeroCompetency)
    {
        [self enable:self.vTricklingIn enabled:![self getSelected:view]];
        [self enable:self.vPoorHeroCompetency enabled:![self getSelected:view]];
        [self enable:self.vBadUltimateUsage enabled:![self getSelected:view]];
        [self enable:self.vOverextending enabled:![self getSelected:view]];
    }
    else if(view == self.vGoodUltimateUsage)
    {
        [self enable:self.vBadUltimateUsage enabled:![self getSelected:view]];
    }
    else if(view == self.vAbusiveChat || view == self.vGriefingAndInactivity || view == self.vUnCooperativePlayer)
    {
        [self enable:self.vTeamLeader enabled:![self getSelected:view]];
        [self enable:self.vCooperativePlayer enabled:![self getSelected:view]];
        [self enable:self.vGoodCommunication enabled:![self getSelected:view]];
        [self enable:self.vSportsmanship enabled:![self getSelected:view]];
    }
    else if(view == self.vSpam)
    {
        [self enable:self.vTeamLeader enabled:![self getSelected:view]];
        [self enable:self.vGoodCommunication enabled:![self getSelected:view]];
    }
    else if(view == self.vNoCommunication)
    {
        [self enable:self.vTeamLeader enabled:![self getSelected:view]];
        [self enable:self.vGoodCommunication enabled:![self getSelected:view]];
    }
    else if(view == self.vTricklingIn)
    {
        [self enable:self.vMVP enabled:![self getSelected:view]];
        [self enable:self.vGoodHeroCompetency enabled:![self getSelected:view]];
    }
    else if(view == self.vPoorHeroCompetency)
    {
        [self enable:self.vMVP enabled:![self getSelected:view]];
        [self enable:self.vGoodHeroCompetency enabled:![self getSelected:view]];
    }
    else if(view == self.vBadUltimateUsage)
    {
        [self enable:self.vMVP enabled:![self getSelected:view]];
        [self enable:self.vGoodUltimateUsage enabled:![self getSelected:view]];
    }
    else if(view == self.vOverextending)
    {
        [self enable:self.vMVP enabled:![self getSelected:view]];
        [self enable:self.vGoodHeroCompetency enabled:![self getSelected:view]];
    }
    
}

- (void) enable: (RoundedCornerView*) view enabled: (BOOL) enabled
{
    if(enabled)
    {
        [view setBorderColor:normalColor];
        [((UILabel*)[view.subviews objectAtIndex:0]) setTextColor:normalColor];
        [view setUserInteractionEnabled:YES];
    }
    else
    {
        [view setBorderColor:disableColor];
        [((UILabel*)[view.subviews objectAtIndex:0]) setTextColor:disableColor];
        [view setUserInteractionEnabled:NO];
    }
}
- (void) setSelected: (UIView*) view selected: (BOOL) selected
{
    RoundedCornerView* rView = (RoundedCornerView*) view;
    if(selected == YES)
    {
        [rView setBorderColor:highlightColor];
        [((UILabel*)[rView.subviews objectAtIndex:0]) setTextColor:highlightColor];
    }
    else
    {
        [rView setBorderColor:normalColor];
        [((UILabel*)[rView.subviews objectAtIndex:0]) setTextColor:normalColor];
    }
    
    [rView layoutSubviews];
}

- (BOOL) getSelected: (RoundedCornerView*) view
{
    if([view.borderColor isEqual:highlightColor])
    {
        return YES;
    }
    
    return NO;
}

- (int) getSelectedInt: (RoundedCornerView*) view
{
    if([view.borderColor isEqual:highlightColor])
    {
        return 1;
    }
    
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
