//
//  OWLoginViewController.m
//  getgood
//
//  Created by Dan on 16/03/2018.
//  Copyright © 2018 PH. All rights reserved.
//

#import "OWLoginViewController.h"
#import "UIKit.h"
#import "ProfileTitleEditController.h"

@interface OWLoginViewController ()

@end

@implementation OWLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    [_vWeb setDelegate:self];
    [_vWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://us.battle.net/login/en/?ref=https://us.battle.net/account/management/&app=bam&cr=true"]]];
    
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

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if([request.URL.absoluteString isEqualToString:@"https://us.battle.net/account/management/"])
    {
        [webView setHidden:YES];
        [UIKit showLoading];
    }
    
    return YES;
}

- (void) webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"-------------------Start Loading %@", webView.request.URL.absoluteString);
    if([webView.request.URL.absoluteString isEqualToString:@"https://us.battle.net/account/management/"])
    {
        NSString  *html = [webView stringByEvaluatingJavaScriptFromString: @"document.body.innerHTML"];
        

        NSString *strContent = [self getUserID:html];
        
        if(strContent != nil)
        {
            [UIKit dismissDialog];
            _parent.strGameID = strContent;
            [_parent getOverwatchHeroes];
            [webView setDelegate:nil];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
}

- (NSString*) getUserID:(NSString*) strContent
{
    NSRange range = [strContent rangeOfString:@"BattleTag</h4>"];
    if(range.location == NSNotFound)
        return nil;
    strContent = [strContent substringFromIndex: range.location + 19];
    
    
    range = [strContent rangeOfString:@"<span class="];
    if(range.location == NSNotFound)
        return nil;
    strContent = [strContent substringToIndex:range.location - 1];
    
    return strContent;
}
@end
