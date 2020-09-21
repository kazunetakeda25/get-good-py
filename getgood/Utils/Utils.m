//
//  Utils.m
//  getgood
//
//  Created by Md Aminuzzaman on 1/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "Utils.h"
#import "AppData.h"

@import Firebase;
@import FirebaseDatabase;

@implementation Utils

#define ARC4RANDOM_MAX      0x100000000

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

+(NSDate *) getUTCTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd, yyy h:mm a zz"];
    NSString *localDateString = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDate *currDateUTC = [dateFormatter dateFromString:localDateString];
    
    return currDateUTC;
}



+(BOOL) checkDateAvailability:(NSString *)dateT
{
    if([dateT length] == 0)
        return NO;
    
    NSDate *utcTime = [Utils getUTCTime];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd, yyy h:mm a zz"];
    NSDate *date = [dateFormat dateFromString:dateT];
    
    NSTimeInterval secondsBetween = [date timeIntervalSinceDate:utcTime];
    double secondsInAnHour = 3600;
    NSInteger hoursBetweenDates = secondsBetween / secondsInAnHour;
    
    if(hoursBetweenDates < 5)
    {
        return NO;
    }
    
    return NO;
}


+(NSString *) getSaltString
{
    NSString *SALTCHARS = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    
    NSMutableString *saltString = [[NSMutableString alloc] init];
    
    while([saltString length] < 18)
    {
        double val = ((double)(arc4random() % [SALTCHARS length]) / (double) ([SALTCHARS length] ));
        
        int index = (int) (val * [SALTCHARS length]);
        
        [saltString appendFormat:@"%c",[SALTCHARS characterAtIndex:index]];
    }
    
    return [NSString stringWithFormat:@"%@",saltString];
}


+(void) setGroupChecked: (NSString*) id timestamp:(NSString*) timestamp
{
    if(!timestamp.length)
        return;
    
    [AppData userDefaultSetObject:timestamp forKey:[NSString stringWithFormat:@"group_%@", id]];
}

+(BOOL) checkIfGroupUpdate:(GetGood_Group *) dialog
{
    if(!dialog.timestamp.length)
        return NO;
    
    
    NSString *strTimeStamp = [AppData uesrDefaultGetObjectForKey:[NSString stringWithFormat:@"group_%@", dialog.id]];
    
    if(!strTimeStamp.length)
    {
        return YES;
    }
    
    if([strTimeStamp isEqualToString:dialog.timestamp])
    {
        return NO;
    }
    
    return YES;
}

+(void) setDialogChecked: (NSString*) id timestamp:(NSString*) timestamp
{
    if(!timestamp.length)
        return;
    
    [AppData userDefaultSetObject:timestamp forKey:[NSString stringWithFormat:@"dialog_%@", id]];
}

+(BOOL) checkIfNewMessage:(GetGood_Dialog *) dialog
{
    if(!dialog.timestamp.length)
        return NO;
    
    
    NSString *strTimeStamp = [AppData uesrDefaultGetObjectForKey:[NSString stringWithFormat:@"dialog_%@", dialog.id]];
    
    if(!strTimeStamp.length)
    {
        return YES;
    }
    
    if([strTimeStamp isEqualToString:dialog.timestamp])
    {
        return NO;
    }
    
    return YES;
}

+(BOOL) isVisited:(NSString *)strName
{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    NSString *visitsKey = strName;
    
    if ([preferences objectForKey:strName] == nil)
    {
        return NO;
    }
    else
    {
        const BOOL isVst = [preferences integerForKey:strName];
        
        return isVst;
    }
}

+(void) setVisited:(NSString *)strName
{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    [preferences setBool:YES forKey:strName];
    
    //  Save to disk
    const BOOL didSave = [preferences synchronize];
    
    if (!didSave)
    {
        NSLog(@"Failed to save");
    }
}

static id ObjectOrNull(id object)
{
    return object ?: [NSNull null];
}

+(NSString *) getLolRankAvatar:(NSString*) rank
{
    return [[rank stringByReplacingOccurrencesOfString:@" " withString:@"_"] lowercaseString];
}

+(NSString *) getRankAvatar:(int) nRank
{
    if( nRank < 1500 && nRank > 0 )
    {
        return @"bronze";
    }
    else if(nRank > 1499 && nRank < 2000)
    {
        return @"silver";
    }
    else if(nRank > 1999 && nRank < 2500)
    {
        return @"gold";
    }
    else if(nRank > 2499 && nRank < 3000)
    {
        return @"platinum";
    }
    else if(nRank > 2999 && nRank < 3500)
    {
        return @"diamond";
    }
    else if(nRank > 3499 && nRank < 4000)
    {
        return @"master";
    }
    else if(nRank > 3999 )
    {
        return @"grandmaster";
    }
    
    return @"";
}

+ (int) getOccurence:(NSString*) str
{
    NSUInteger count = 0, length = [str length];
    NSRange range = NSMakeRange(0, length);
    while(range.location != NSNotFound)
    {
        range = [str rangeOfString: @":" options:0 range:range];
        if(range.location != NSNotFound)
        {
            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            count++;
        }
    }
    
    return count / 2;
}

+ (NSString*) videoIDfromYoutubeUrl:(NSString*) link
{
    NSString *regexString = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)";
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
    
    NSArray *array = [regExp matchesInString:link options:0 range:NSMakeRange(0,link.length)];
    if (array.count > 0) {
        NSTextCheckingResult *result = array.firstObject;
        return [link substringWithRange:result.range];
    }
    return nil;
}


-(NSString*)stringWithSentenceCapitalization:(NSString*)str
{
    // Get the first character in the string and capitalize it.
    NSString *firstCapChar = [[str substringToIndex:1] capitalizedString];
    
    NSMutableString * temp = [str mutableCopy];
    
    // Replace the first character with the capitalized version.
    [temp replaceCharactersInRange:NSMakeRange(0, 1) withString:firstCapChar];
    
    return temp;
}


+ (NSString*) getTimeStamp
{
    NSTimeInterval timeInSeconds = [[NSDate date] timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%d", (int) timeInSeconds];
}


+ (NSString*) getHeroString:(NSString*) strCategory
{
    if([Temp getGameMode] == Overwatch)
    {
        for(int i = 0; i < [DataArrays CategoryGroups].count; i++)
        {
            NSString* category = [[DataArrays CategoryGroups] objectAtIndex:i];
            
            strCategory = [strCategory stringByReplacingOccurrencesOfString:category withString:@""];
        }
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        for(int i = 0; i < [DataArrays lol_categories_values].count; i++)
        {
            NSString* category = [[DataArrays lol_categories_values] objectAtIndex:i];
            
            strCategory = [strCategory stringByReplacingOccurrencesOfString:category withString:@""];
        }
    }

    
    return strCategory;
}



+ (NSString*) getRoleString:(NSString*) strCategory
{
    if([Temp getGameMode] == Overwatch)
    {
        for(int i = 0; i < [DataArrays category].count; i++)
        {
            NSString* category = [[DataArrays category] objectAtIndex:i];
            
            strCategory = [strCategory stringByReplacingOccurrencesOfString:category withString:@""];
        }
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        for(int i = 0; i < [DataArrays lol_heroes].count; i++)
        {
            NSString* category = [[DataArrays lol_heroes] objectAtIndex:i];
            
            strCategory = [strCategory stringByReplacingOccurrencesOfString:category withString:@""];
        }
    }

    
    return strCategory;
}


+ (NSString*) getLolServerName:(NSString*) serverValue
{
    if([[DataArrays lolServerValues] containsObject:serverValue])
    {
        int nPos = [[DataArrays lolServerValues] indexOfObject:serverValue];
        
        return [[DataArrays lolServerNames] objectAtIndex:nPos];
    }
    
    return @"All";
}

+ (NSString*) getLolServerEndPoint:(NSString*) serverValue
{
    if([[DataArrays lolServerValues] containsObject:serverValue])
    {
        int nPos = [[DataArrays lolServerValues] indexOfObject:serverValue];
        
        return [[DataArrays lolServerEndPoints] objectAtIndex:nPos];
    }
    
    return @"All";
}


+ (NSString*) getLolServerValue:(NSString*) serverName
{
    if([[DataArrays lolServerNames] containsObject:serverName])
    {
        int nPos = [[DataArrays lolServerNames] indexOfObject:serverName];
        
        return [[DataArrays lolServerValues] objectAtIndex:nPos];
    }
    
    return @"all";
}

@end
