//
//  ISPlayerViewHelpers.m
//  ISPrintThrough
//
//  Created by Khaled Khaldi on 21/01/2016.
//  Copyright © 2016 iPhoneAlsham. All rights reserved.
//

#import "ISPlayerViewHelpers.h"


@interface NSURL (QueryString)

- (NSDictionary <NSString *, id> *) queryStringComponents;

@end

@implementation NSURL (QueryString)

- (NSDictionary <NSString *, id> *) queryStringComponents {
    
    NSMutableDictionary <NSString *, id> *dict = [NSMutableDictionary dictionary];
    
    // Check for query string
    if (self.query) {
        
        // Loop through pairings (separated by &)
        for (NSString *pair in [self.query componentsSeparatedByString:@"&"]) {
            
            // Pull key, val from from pair parts (separated by =) and set dict[key] = value
            NSArray *components = [pair componentsSeparatedByString:@"="];
            dict[components[0]] = components[1];
        }
    }

    return dict;
}

@end


@implementation ISPlayerViewHelpers

+ (NSString  *)videoIDFromYouTubeURL:(NSURL *)videoURL {

    NSString *host = videoURL.host;
    NSArray *pathComponents = videoURL.pathComponents;
    
    if (host != nil && pathComponents != nil && pathComponents.count > 1 && [host hasPrefix:@"youtu.be"]) {
        return pathComponents[1];
    }
    
    NSDictionary *queryStringComponents = videoURL.queryStringComponents;
    return queryStringComponents[@"v"];
}

@end
