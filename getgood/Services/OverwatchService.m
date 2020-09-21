//
//  OverwatchService.m
//  getgood
//
//  Created by Md Aminuzzaman on 11/9/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "UIKit.h"
#import "AppData.h"
#import "AFNetworking.h"
#import "AppConstants.h"
#import "OverwatchService.h"

@implementation OverwatchService

@synthesize GetOverwatchProfileHandler;

+(void) getOverwatchState : (NSString *) gameId profileWatchListener:(void (^)(NSDictionary *)) listener
{
    [UIKit showLoading];
    
    gameId = [gameId stringByReplacingOccurrencesOfString:@"#"
                                         withString:@"-"];
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@%@",OW_BASE_URL,gameId, @"/stats"];
    
    NSLog(@"%@",requestUrl);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer     = [AFHTTPRequestSerializer serializer];
    
    [manager.requestSerializer
     setValue:@"application/x-www-form-urlencoded; charset=UTF-8"
     forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:requestUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         //NSLog(@"Response from server 1 :  %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
         
         NSString *str = [[NSString alloc] initWithData:responseObject
                                               encoding:NSUTF8StringEncoding];
         
         NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
         
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:NSJSONReadingAllowFragments
                                                                      error:nil];
         
         NSLog(@"JSON:%@",dictionary);
         
         listener(dictionary);
     }
     failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         NSLog(@"Error:  %@", [error description]);
     }];
    
    
}

+(void) getOverwatchState:(NSString*) strGameID listener: (void (^)(NSDictionary *)) listener
{
    NSString *gameId = strGameID;
    
    gameId = [gameId stringByReplacingOccurrencesOfString:@"#"
                                               withString:@"-"];
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@%@",OW_BASE_URL,gameId, @"/stats"];
    
    NSLog(@"%@",requestUrl);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer     = [AFHTTPRequestSerializer serializer];
    
    [manager.requestSerializer
     setValue:@"application/x-www-form-urlencoded; charset=UTF-8"
     forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:requestUrl parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         //NSLog(@"Response from server 1 :  %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
         
         NSString *str = [[NSString alloc] initWithData:responseObject
                                               encoding:NSUTF8StringEncoding];
         
         NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
         
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:NSJSONReadingAllowFragments
                                                                      error:nil];
         
         NSLog(@"JSON:%@",dictionary);
         
         listener(dictionary);
     }
         failure:^(NSURLSessionDataTask *operation, NSError *error)
     {
         NSLog(@"Error:  %@", [error description]);
         listener(nil);
     }];
}



+(void) getLolState
{
    
    NSDictionary *headers = @{ @"Cache-Control": @"no-cache",
                               @"Postman-Token": @"ffad38fe-b1d6-4180-a395-ef89cd887f22" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@.api.riotgames.com/lol/summoner/v3/summoners/by-name/%@?api_key=%@", [Utils getLolServerEndPoint:[AppData profile].lol_server], [[AppData profile].lol_id stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]], RIOT_KEY]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    @try
                                                    {
                                                        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                   options:NSJSONReadingAllowFragments
                                                                                                                     error:nil];
                                                        
                                                        
                                                        NSDictionary *headers = @{ @"Cache-Control": @"no-cache",
                                                                                   @"Postman-Token": @"5263e652-27e5-4132-980c-051134ee3baf" };
                                                        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@.api.riotgames.com/lol/league/v3/positions/by-summoner/%@?api_key=%@", [Utils getLolServerEndPoint:[AppData profile].lol_server], [[dictionary valueForKey:@"id"] stringValue], RIOT_KEY]]
                                                                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                                                           timeoutInterval:10.0];
                                                        [request setHTTPMethod:@"GET"];
                                                        [request setAllHTTPHeaderFields:headers];
                                                        
                                                        NSURLSession *session = [NSURLSession sharedSession];
                                                        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                                                        
                                                                                                        @try{
                                                                                                            NSArray* arRes = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                                                             options:NSJSONReadingAllowFragments
                                                                                                                                                               error:nil];
                                                                                                            NSDictionary *dictionary = [arRes objectAtIndex:0];
                                                                            
                                                                                                            NSString* strRank = [NSString stringWithFormat:@"%@ %@", [dictionary objectForKey:@"tier"] , [dictionary objectForKey:@"rank"]];
                                                                                                            
                                                                                                            
                                                                                                            [AppData profile].lol_rank = strRank;
                                                                                                            
                                                                                                            [RestClient updateLoLProfile:^(bool result, NSDictionary *data) {
                                                                                                                
                                                                                                            }];
                                                                                                        }
                                                                                                        @catch(NSException* ex)
                                                                                                        {
                                                                                                            
                                                                                                        }
                                                                                                        
                                                                                                        
                                                                                                    }];
                                                        [dataTask resume];
                                                    }
                                                    @catch(NSException* ex)
                                                    {
                                                        
                                                    }
                                                    
                                                }];
    [dataTask resume];
}


@end
