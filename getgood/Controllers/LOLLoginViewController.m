//
//  OWLoginViewController.m
//  getgood
//
//  Created by Dan on 16/03/2018.
//  Copyright © 2018 PH. All rights reserved.
//

#import "LOLLoginViewController.h"
#import "UIKit.h"
#import "ProfileTitleEditController.h"

@interface LoLLoginViewController ()

@end

@implementation LoLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    [_vWeb setDelegate:self];
    [_vWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://leagueoflegends.com/en/game-info/"]]];    
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
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView{
    NSString  *html = [webView stringByEvaluatingJavaScriptFromString: @"document.body.innerHTML"];
    
    if([html containsString:@"riotbar-summoner-icon"])
    {
        NSLog(@"Login Success");
        
        [self getUserID:html];
        [self.parent getOverwatchHeroes];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSString*) getUserID:(NSString*) strContent
{
    NSRange range = [strContent rangeOfString:@"<div class=\"riotbar-summoner-name\">"];
    if(range.location == NSNotFound)
        return nil;
    strContent = [strContent substringFromIndex: range.location + 35];
    
    
    range = [strContent rangeOfString:@"</div>"];
    if(range.location == NSNotFound)
        return nil;
    strContent = [strContent substringToIndex:range.location ];
    
    self.parent.strGameID = strContent;
    return strContent;
}

@end
