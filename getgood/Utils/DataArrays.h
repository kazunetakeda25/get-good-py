//
//  DataArrays.h
//  getgood
//
//  Created by Md Aminuzzaman on 2/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataArrays : NSObject
{
    
}

+ (NSArray *) profileServer;
+ (NSArray *) profileServerValue;
+ (NSArray *) server;
+ (NSArray *) serverValue;
+ (NSArray *) category;
+ (NSArray *) sort;
+ (NSArray *) hero;
+ (NSArray *) coachMode;
+ (NSArray *) gameRegions;
+ (NSArray *) gameRegionCodes;
+ (NSArray *) heroes;
+ (NSString*) getRegionCode:(NSString*) strSerer;
+ (NSString*) getRegionName:(NSString*) strCode;

+ (NSArray *) PlayerChatSelfInfromation;
+ (NSArray *) PlayerChatPatnerInfromation;

+(NSArray *)TankHeroes;
+(NSArray *)DpsHeroes;
+(NSArray *)SupportHeroes;
+(NSArray *)CategoryGroups;
+ (NSArray *) platformValue;

+ (NSArray *) lolServerNames;
+ (NSArray *) lolServerValues;
+ (NSArray *) lolServerEndPoints;
+ (NSArray *) lol_heroes;
+ (NSArray *) lol_categories;
+ (NSArray *) lol_categories_values;

+ (NSArray *) lolFilterServerValues;
+ (NSArray *) lolFilterServerNames;
+ (NSArray *) lolRanks;
@end

