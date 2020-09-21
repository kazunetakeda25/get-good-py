//
//  Utils.h
//  getgood
//
//  Created by Md Aminuzzaman on 1/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataArrays.h"
#import "GetGood_Dialog.h"
#import "GetGood_Group.h"
#import "Temp.h"

#define ReadyDuration 180
@interface Utils : NSObject
{
    
}

+(NSDate *) getUTCTime;
+(NSString *) getSaltString;
+(NSString *) getRankAvatar:(int) nRank;
+(NSString *) getLolRankAvatar:(NSString*) rank;
+(BOOL) checkDateAvailability:(NSString *)dateT;
+(BOOL) isVisited:(NSString *) strName;
+(void) setVisited:(NSString *) strName;
+(BOOL) checkIfNewMessage:(GetGood_Dialog *) dialog;
+(void) setDialogChecked: (NSString*) id timestamp:(NSString*) timestamp;
+ (void) checkValidName:(NSString *)strUserName callBack:(void (^)(bool)) callback;
+ (NSString*) videoIDfromYoutubeUrl:(NSString*) strUrl;

-(NSString*)stringWithSentenceCapitalization:(NSString*)str;
+ (NSString*) getTimeStamp;
static id ObjectOrNull(id object);
+ (NSString*) getHeroString:(NSString*) strCategory;
+ (NSString*) getRoleString:(NSString*) strCategory;

+(void) setGroupChecked: (NSString*) id timestamp:(NSString*) timestamp;
+(BOOL) checkIfGroupUpdate:(GetGood_Group *) dialog;

+ (int) getOccurence:(NSString*) str;
+ (NSString*) getLolServerName:(NSString*) serverValue;
+ (NSString*) getLolServerEndPoint:(NSString*) serverValue;
+ (NSString*) getLolServerValue:(NSString*) serverName;


@end

