//
//  OverwatchService.h
//  getgood
//
//  Created by Md Aminuzzaman on 11/9/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"
#import "RestClient.h"

@interface OverwatchService : NSObject
{
    
}

@property (nonatomic,strong) void *(^GetOverwatchProfileHandler)(NSDictionary *json);

+(void) getOverwatchState : (NSString *) gameId profileWatchListener:(void (^)(NSDictionary *)) listener;
+(void) getOverwatchState:(NSString*) strGameID listener: (void (^)(NSDictionary *)) listener;

+(void) getLolState;

+(void) getOverwatchState :(void (^)(NSDictionary *)) listener;
+(void) getOverwatchHeros :(void (^)(NSDictionary *)) listener;
@end
