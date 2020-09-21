//
//  Temp.h
//  getgood
//
//  Created by Md Aminuzzaman on 18/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "GetGood_Group.h"
#import "GetGood_Dialog.h"
#import "Thread.h"
#import <Foundation/Foundation.h>
#import "GetGood_Lesson.h"
#import "GetGood_Thread.h"

@interface Temp : NSObject
{
    
}

typedef enum
{
    Overwatch,
    LeagueOfLegends
} GameMode;

+(int) getGameNumber;
+(GameMode) getGameMode;
+(void) setGameMode : (GameMode) nGameMode;


+(GetGood_Group *) groupData;
+(void) setGroupData : (GetGood_Group *) group;

+(Thread *) thread;
+(void) setThread : (Thread *) thread;

+(BOOL) needReload;
+(void) setNeedReload : (BOOL) reload;

+(GetGood_Thread *) threadData;
+(void) setThreadData : (GetGood_Thread *) thread;

+(BOOL) onGroupChat;
+(void) setOnGroupChat : (BOOL) group;




+(GetGood_Dialog *) dialogData;
+(void) setDialogData : (GetGood_Dialog *) dialog;

+(int) currentTab;
+(void) setCurrentTab : (int) _currentTab;

+(NSString *)getDateFromTimeInterval:(NSNumber *)timeInterval dateFormat:(NSString *)dateFormat;


+(GetGood_Lesson *) lessonData;

+(void) setLessonData: (GetGood_Lesson *) lessonModel;

@end
