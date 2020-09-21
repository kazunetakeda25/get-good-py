//
//  RestClient.m
//  getgood
//
//  Created by Dan on 4/28/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "RestClient.h"
#import "AppConstants.h"

@import Firebase;
@import FirebaseAuth;

@implementation RestClient

+ (void) getProfile:(void (^)(bool, NSDictionary*)) callback
{
    NSString* token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSDictionary *headers = @{ @"token": token,
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@account/profile", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                                callback(false, nil);
                                                        });
                                                        
                                                        return ;
                                                    }
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                                callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) checkMail:(NSString*) email name: (NSString*) name callback:(void (^)(bool, NSDictionary*)) callback
{
    
    NSDictionary *headers = @{ @"cache-control": @"no-cache" };
    
    NSString* str = [[NSString stringWithFormat:@"%@account/check_email?email=%@&name=%@",BASE_URL, email, name] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(str);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@account/check_email?email=%@&name=%@",BASE_URL, email, name] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                    } else {
                                                        
                                                        NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                        
                                                        bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                        
                                                        [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                            
                                                            callback(result, jsonData);
                                                            
                                                        }];
                                                        
                                                    }
                                                }];
    [dataTask resume];
}

+ (void) signup:(NSString*) email name: (NSString*)name avatar:(NSString*) avatar password:(NSString*) password callback:(void (^)(bool, NSDictionary*)) callback
{
    if(avatar == nil)
    {
        avatar = @"";
    }
    
    NSDictionary *headers = @{ @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"email=%@", email] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&password=%@", password] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&avatar=%@", avatar]  dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&name=%@", name] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@auth/register", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                    } else {
                                                        
                                                        NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                        
                                                        bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                        
                                                        [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                            
                                                            callback(result, jsonData);
                                                            
                                                        }];
                                                        
                                                    }
                                                }];
    [dataTask resume];
}

+ (void) verify:(NSString*) email callback:(void (^)(bool result, NSDictionary* data)) callback
{
    NSDictionary *headers = @{ @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"email=%@", email] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@account/verify", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    
                                                    if (error) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                    } else {
                                                        
                                                        NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                        
                                                        bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                        
                                                        [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                            
                                                            callback(result, jsonData);
                                                            
                                                        }];
                                                        
                                                    }
                                                }];
    [dataTask resume];
}

+ (void) login:(NSString*) email password:(NSString*) password callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"email=%@", email] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&password=%@", password] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[@"&platform=2" dataUsingEncoding:NSUTF8StringEncoding]];
    NSString* fcmToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"push_token"];
    
    [postData appendData:[[NSString stringWithFormat:@"&push_token=%@", fcmToken] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@auth/login", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if (error) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                    } else {
                                                        
                                                        NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                        
                                                        bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                        if([jsonData objectForKey:@"data"] == nil)
                                                        {
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                callback(false, nil);
                                                            });
                                                            return ;
                                                        }
                                                        [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                            
                                                            callback(result, [jsonData objectForKey:@"data"]);
                                                            
                                                        }];
                                                        
                                                    }
                                                }];
    [dataTask resume];
}


+ (void) forgotPassword:(NSString*) email callback:(void (^)(bool result, NSDictionary* data)) callback
{
    NSDictionary *headers = @{ @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"email=%@", email] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@account/forgot_password", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                    } else {
                                                        
                                                        NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                        
                                                        
                                                        NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                        
                                                        bool result = [[jsonData objectForKey:@"result"] boolValue];

                                                        [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                            
                                                            callback(result, [jsonData objectForKey:@"data"]);
                                                            
                                                        }];
                                                        
                                                    }
                                                }];
    [dataTask resume];
}

+ (void) updatePushToken:(NSString*) pushToken callback:(void (^)(bool result, NSDictionary* data)) callback
{
    NSString* token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSDictionary *headers = @{ @"content-type": @"application/x-www-form-urlencoded",
                               @"token": token,
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[@"platform=2" dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&push_token=%@" , pushToken] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@account/push_token", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                    
                                                }];
    [dataTask resume];
}


+ (void) checkGameID:(NSString*) gameID callback:(void (^)(bool result, NSDictionary* data)) callback
{
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache"};
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@account/check_game_id?gameid=%@", BASE_URL, gameID]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) checkLoLGameID:(NSString*) gameID callback:(void (^)(bool result, NSDictionary* data)) callback
{
    NSString* str = [gameID stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache"};
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@account/check_lol_id?gameid=%@", BASE_URL, str]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    
    
    
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) checkName:(NSString*) name callback:(void (^)(bool result, NSDictionary* data)) callback
{
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache"};
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@account/check_name?name=%@", BASE_URL, name] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) updateProfile:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"content-type": @"application/x-www-form-urlencoded",
                               @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"name=%@", [AppData profile].name] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&avatar_url=%@", [AppData profile].avatar_url] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&description=%@", [AppData profile].getgood_description] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&blizzard_id=%@", [AppData profile].blizzard_id] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&overwatch_rank=%d", [AppData profile].overwatch_rank] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&server=%@", [AppData profile].server] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&overwatch_heroes=%@", [AppData profile].overwatch_heroes] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@account/profile", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}



+ (void) updateLoLProfile:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"content-type": @"application/x-www-form-urlencoded",
                               @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"name=%@", [AppData profile].name] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&avatar_url=%@", [AppData profile].avatar_url] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&description=%@", [AppData profile].lol_description] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&id=%@", [AppData profile].lol_id] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&rank=%@", [AppData profile].lol_rank] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&server=%@", [AppData profile].lol_server] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&heroes=%@", [AppData profile].lol_heroes] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&category=%@", [AppData profile].lol_category] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@account/lol_profile", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) readyProfile:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"content-type": @"application/x-www-form-urlencoded",
                               @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"game=%d",  [Temp getGameNumber]] dataUsingEncoding:NSUTF8StringEncoding]];
        
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@account/profile/ready", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}



+ (void) getPlayers:(int)nPage
               sort:(NSString*) sort
    playerRatingMax:(float) playerRatingMax
    playerRatingMin:(float) playerRatingMin
      gameRatingMax:(NSString*) gameRatingMax
      gameRatingMin:(NSString*) gameRatingMin
             server:(NSString*) server
             platform:(NSString*) platform
             online:(int) online
           category:(NSString*) category
            keyword:(NSString*) keyword
           callback:(void (^)(bool result, NSDictionary* data)) callback
{
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"Page=%d", nPage] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Sort=%@", sort] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&PlayerRatingMax=%f", playerRatingMax] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&PlayerRatingMin=%f", playerRatingMin] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&GameRatingMax=%@", gameRatingMax] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&GameRatingMin=%@", gameRatingMin] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Server=%@", server] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Platform=%@", platform] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Online=%d", online] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Category=%@", category] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Keyword=%@", keyword] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *game = @"";
    if([Temp getGameMode] == Overwatch)
    {
        game = @"0";
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        game = @"1";
    }
    
    [postData appendData:[[NSString stringWithFormat:@"&Game=%@", game] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/player_list", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) createGroup:(NSString*) name description:(NSString*) description hero:(NSString*) hero callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache"};
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"title=%@", name] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&description=%@", description] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&hero=%@", hero] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&game=%d", [Temp getGameNumber]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/group", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) getGroups:(int)nPage
              sort:(NSString*) sort
   playerRatingMax:(float) playerRatingMax
   playerRatingMin:(float) playerRatingMin
     gameRatingMax:(NSString*) gameRatingMax
     gameRatingMin:(NSString*) gameRatingMin
            server:(NSString*) server
            platform:(NSString*) platform
            online:(int) online
          category:(NSString*) category
           keyword:(NSString*) keyword
          callback:(void (^)(bool result, NSDictionary* data)) callback
{
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"Page=%d", nPage] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Sort=%@", sort] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&PlayerRatingMax=%f", playerRatingMax] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&PlayerRatingMin=%f", playerRatingMin] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&GameRatingMax=%@", gameRatingMax] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&GameRatingMin=%@", gameRatingMin] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Server=%@", server] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Game=%d", [Temp getGameNumber]] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Platform=%@", platform] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Online=%d", online] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Category=%@", category] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Keyword=%@", keyword] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/group_list", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) createLesson:(NSString*) name description:(NSString*) description hero:(NSString*) hero videos:(NSString*) videos thumb_url:(NSString*) thumb_url price:(float) price callback:(void (^)(bool result, NSDictionary* data)) callback
{
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"title=%@", name] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&description=%@", description] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&hero=%@", hero] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&videos=%@", videos] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&thumb_url=%@", thumb_url] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&game=%d", [Temp getGameNumber]] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&price=%f", price] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/lesson", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) getLessons:(int)nPage
               sort:(NSString*) sort
     coachRatingMax:(float) coachRatingMax
     coachRatingMin:(float) coachRatingMin
      gameRatingMax:(NSString*) gameRatingMax
      gameRatingMin:(NSString*) gameRatingMin
           priceMax:(float) priceMax
           priceMin:(float) priceMin
             server:(NSString*) server
           platform:(NSString*) platform
             online:(int) online
           category:(NSString*) category
            keyword:(NSString*) keyword
           callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"Page=%d", nPage] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Sort=%@", sort] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&CoachRatingMax=%f", coachRatingMax] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&CoachRatingMin=%f", coachRatingMin] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&GameRatingMax=%@", gameRatingMax] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&GameRatingMin=%@", gameRatingMin] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&PriceMax=%f", priceMax] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&PriceMin=%f", priceMin] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Server=%@", server] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Platform=%@", platform] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Online=%d", online] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Category=%@", category] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Game=%d", [Temp getGameNumber]] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&Keyword=%@", keyword] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/lesson_list", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) getMyGroups:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/my_groups?game=%d", BASE_URL, [Temp getGameNumber]]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) updateGroup:(NSString*) id title:(NSString*) title description:(NSString*) description hero:(NSString*) hero ready:(NSString*) ready callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"id=%@", id] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&title=%@", title] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&description=%@", description] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&hero=%@", hero] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&ready=%@", ready] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/group", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"PUT"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) getMyLessons:(void (^)(bool, NSDictionary *))callback{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/my_lessons?game=%d", BASE_URL, [Temp getGameNumber]]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) updateLesson:(NSString*) id title:(NSString*) title description:(NSString*) description hero:(NSString*) hero price:(float)price thumb_url:(NSString*) thumb_url videos:(NSString*) videos ready:(NSString*) ready callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"id=%@", id] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&title=%@", title] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&description=%@", description] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&hero=%@", hero] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&ready=%@", ready] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&thumb_url=%@", thumb_url] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&videos=%@", videos] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&price=%f", price] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/lesson", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"PUT"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) getLessonsWithUserID:(NSString *)userID callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache",
                               @"postman-token": @"820d86e2-733e-f2da-5964-66622ebf07f0" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/lessons?userid=%@&game=%d", BASE_URL, userID, [Temp getGameNumber]]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) getGroupsWithUserID:(NSString *)userID callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache",
                               @"postman-token": @"820d86e2-733e-f2da-5964-66622ebf07f0" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/groups?userid=%@&game=%d", BASE_URL, userID, [Temp getGameNumber]]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) readyGroup:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"content-type": @"application/x-www-form-urlencoded",
                               @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"id=%@", id] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/group/ready", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) readyLesson:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"content-type": @"application/x-www-form-urlencoded",
                               @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"id=%@", id] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/lesson/ready", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) createDialog:(NSString*) type reference:(NSString*) reference_id receiver:(NSString*) rec_id callback:(void (^)(bool result, NSDictionary* data)) callback
{
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"type=%@", type] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&reference_id=%@", reference_id] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&rec_id=%@", rec_id] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&game=%d", [Temp getGameNumber]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/dialog", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) readProfile:(NSString*) userID callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/user_profile?userid=%@", BASE_URL, userID]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) getDialogList:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/dialog_list?game=%d", BASE_URL, [Temp getGameNumber]]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) sendMessage:(NSString*) dialog_id message:(NSString*) message type:(NSString*) type callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"dialog_id=%@", dialog_id] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&message=%@", message] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&type=%@", type] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/message", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) getDialog:(NSString*) dialog_id message_id:(int) message_id callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/dialog?id=%@&message_id=%d", BASE_URL, dialog_id, message_id]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) sendNotification:(NSString*) message user_id:(NSString*) user_id
{
    
    NSDictionary *headers = @{ @"content-type": @"application/x-www-form-urlencoded",
                               @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"message=%@", message] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&user_id=%@", user_id] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/send_notification", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    
                                                }];
    [dataTask resume];
}


+ (void) sendSilentNotification:(NSString*) user_id dialogID:(NSString*) dialogID
{
    
    NSDictionary *headers = @{ @"content-type": @"application/x-www-form-urlencoded",
                               @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"user_id=%@", user_id] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&dialog_id=%@", dialogID] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/send_silent_notification", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    }];
    [dataTask resume];
}

+ (void) updateDialog:(NSString*) dialog_id state:(NSString*) state inviter_id:(NSString*) inviter_id block_id:(NSString*) block_id reference_id:(NSString*) reference_id callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"dialog_id=%@", dialog_id] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&state=%@", state] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&inviter_id=%@", inviter_id] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&block_id=%@", block_id] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&reference_id=%@", reference_id] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/dialog", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"PUT"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) joinGroup:(NSString*) group_id callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"id=%@", group_id] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/group/join", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) getLessonWithID:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/lesson?id=%@", BASE_URL, id]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) postCoachReview:(NSString*) id comment:(NSString*) comment competency:(int) competency communication:(int)communication flexibility:(int) flexibility attitude:(int) attitude callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"content-type": @"application/x-www-form-urlencoded",
                               @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"id=%@", id] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&comment=%@", comment] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&competency=%d", competency] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&communication=%d", communication] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&flexibility=%d", flexibility] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&attitude=%d", attitude] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&game=%d", [Temp getGameNumber]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/lesson/coach_rating", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) postTraineeReview:(NSString*) id comment:(NSString*) comment general:(int) general callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"content-type": @"application/x-www-form-urlencoded",
                               @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"id=%@", id] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&comment=%@", comment] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&general=%d", general] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&game=%d", [Temp getGameNumber]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/lesson/trainee_rating", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) getGroupWithID:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/group?id=%@", BASE_URL, id]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) getUsersWithIDs:(NSString*) ids callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/users?ids=%@", BASE_URL, ids]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) leaveGroup:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"id=%@", id] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/group/leave", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) applyGroup:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"id=%@", id] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/group/apply", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) joinUserGroup:(NSString*) id user:(NSString*) user_id callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"id=%@", id] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&user_id=%@", user_id] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/group/join_user", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) kick:(NSString*) id user:(NSString*) user_id callback:(void (^)(bool result, NSDictionary* data)) callback
{
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"id=%@", id] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&user_id=%@", user_id] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/group/kick", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) getGroupMessages:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/group/messages?id=%@", BASE_URL, id]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) postPlayerReview:(NSString*) to_id
                   leader:(int) leader
              cooperative:(int) cooperative
       good_communication:(int) good_communication
            sportsmanship:(int) sportsmanship
                      mvp:(int) mvp
              flex_player:(int) flex_player
     good_hero_competency:(int) good_hero_competency
                 griefing:(int) griefing
                     spam:(int) spam
         no_communication:(int) no_communication
           un_cooperative:(int) un_cooperative
             trickling_in:(int) trickling_in
     poor_hero_competency:(int) poor_hero_competency
       bad_ultimate_usage:(int) bad_ultimate_usage
            overextending:(int) overextending
                  comment:(NSString*) comment
             abusive_chat:(int) abusive_chat
      good_ultimate_usage:(int) good_ultimate_usage
                 callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"to_id=%@", to_id] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&leader=%d", leader] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&cooperative=%d", cooperative] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&good_communication=%d", good_communication] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&sportsmanship=%d", sportsmanship] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&mvp=%d", mvp] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&flex_player=%d", flex_player] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&good_hero_competency=%d", good_hero_competency] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&griefing=%d", griefing] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&spam=%d", spam] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&no_communication=%d", no_communication] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&un_cooperative=%d", un_cooperative] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&trickling_in=%d", trickling_in] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&poor_hero_competency=%d", poor_hero_competency] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&bad_ultimate_usage=%d", bad_ultimate_usage] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&overextending=%d", overextending] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&comment=%@", comment] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&abusive_chat=%d", abusive_chat] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&good_ultimate_usage=%d", good_ultimate_usage] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&game=%d", [Temp getGameNumber]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/group/player_rating", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) deleteGroup:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"id=%@", id] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/group", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"DELETE"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) deleteLesson:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"id=%@", id] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/lesson", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"DELETE"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) getAdminPost:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/thread/admin_post?game=%d", BASE_URL, [Temp getGameNumber]]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) createThread:(NSString*) title description:(NSString*) description callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"d0e4b561-00a0-46ce-f060-9598b600bc2f" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"title=%@", title] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&description=%@", description] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&game=%d", [Temp getGameNumber]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/thread", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) getThreadList:(int) page keyword:(NSString*) keyword callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@overwatch/thread_list?page=%d&keyword=%@&game=%d", BASE_URL, page, keyword, [Temp getGameNumber]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) getCommentList:(NSString*) thread reference:(NSString*) reference  callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/thread/comment_list?thread=%@&reference=%@", BASE_URL, thread, reference]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    
    
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if(response == nil)
                                                    {
                                                        callback(true, nil);
                                                        return;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    NSString *strLen = [[response URL] absoluteString];
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) addComment:(NSString*) comment thread:(NSString*) thread reference:(NSString*) reference  callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"comment=%@", comment] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&reference=%@", reference] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&thread=%@", thread] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/thread/comment", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, nil);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) getLikes:(NSString*) id callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/thread/comment/like?id=%@", BASE_URL, id]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    NSString *strLen = [[response URL] absoluteString];
                                                    
                                                    @try
                                                    {
                                                        
                                                        NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                        
                                                        bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                        
                                                        [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                            
                                                            callback(result, [jsonData objectForKey:@"data"]);
                                                            
                                                        }];
                                                    }
                                                    @catch(NSException* ex)
                                                    {
                                                        int a = 0;
                                                        a++;
                                                    }
                                                    
                                                }];
    [dataTask resume];
}


+ (void) addLike:(NSString*) id like: (NSString*) like callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"content-type": @"application/x-www-form-urlencoded",
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"id=%@", id] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&like=%@", like] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/thread/comment/like", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    NSString *strLen = [[response URL] absoluteString];
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) getActivities:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/activities", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    NSString *strLen = [[response URL] absoluteString];
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        callback(result, nil);
                                                    }
                                                    
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) getLastDialogTimestamp:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/dialog/timestamp?game=%d", BASE_URL, [Temp getGameNumber]]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    NSString *strLen = [[response URL] absoluteString];
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) getLastGroupTimestamp:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/group/timestamp", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}


+ (void) getParticipatingGroups:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache"  };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/participating_groups?game=%d", BASE_URL, [Temp getGameMode]]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    NSString *strLen = [[response URL] absoluteString];
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) getCoachReview:(NSString*) id callback: (void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/profile/coach_rating?id=%@&game=%d", BASE_URL, id, [Temp getGameNumber]]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    NSString *strLen = [[response URL] absoluteString];
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) getTraineeReview:(NSString*) id callback: (void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/profile/trainee_rating?id=%@&game=%d", BASE_URL, id, [Temp getGameNumber]]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    NSString *strLen = [[response URL] absoluteString];
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) getPlayerReview:(NSString*) id callback: (void (^)(bool result, NSDictionary* data)) callback
{
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/profile/player_rating?id=%@&game=%d", BASE_URL, id, [Temp getGameNumber]]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    NSString *strLen = [[response URL] absoluteString];
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

+ (void) online
{
    if(![AppData token].length)
        return;
    
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache"};
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@overwatch/online", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                }];
    [dataTask resume];
}


+ (void) logout
{
    NSDictionary *headers = @{ @"token": [AppData token],
                               @"cache-control": @"no-cache",
                               @"postman-token": @"592511b2-30c2-3c28-3f05-c85bbc9e0aea" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@auth/logout", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                    }
                                                }];
    [dataTask resume];
}


+ (void) sendFeedback:(NSString*) content callback:(void (^)(bool result, NSDictionary* data)) callback
{
    
    NSDictionary *headers = @{ @"content-type": @"application/x-www-form-urlencoded",
                               @"token": [AppData token],
                               @"cache-control": @"no-cache" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"content=%@", content] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@feedback", BASE_URL]]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if(error)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    
                                                    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                    
                                                    
                                                    NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                    
                                                    bool result = [[jsonData objectForKey:@"result"] boolValue];
                                                    if([jsonData objectForKey:@"data"] == nil)
                                                    {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            callback(false, nil);
                                                        });
                                                        return ;
                                                    }
                                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                                        
                                                        callback(result, [jsonData objectForKey:@"data"]);
                                                        
                                                    }];
                                                }];
    [dataTask resume];
}

@end
