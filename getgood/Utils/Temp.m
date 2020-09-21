//
//  Temp.m
//  getgood
//
//  Created by Md Aminuzzaman on 18/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "Temp.h"

@import FirebaseAuth;
@import FirebaseDatabase;

static GetGood_Dialog *tempDialog;
static GetGood_Group* groupModel;
static GetGood_Lesson* tempLesson;
static GetGood_Thread* tempThread;
static BOOL reload_flag;
static GameMode gameMode;

static Thread *thread;
static BOOL onGroupChat;

static int nCurrentTab;

@implementation Temp


+(BOOL) needReload
{
    @synchronized(self)
    {
        return reload_flag;
    }
}

+(void) setNeedReload : (BOOL) reload
{
    @synchronized(self)
    {
        reload_flag = reload;
    }
}


+(GameMode) getGameMode
{
    @synchronized(self)
    {
        return gameMode;
    }
}

+(int) getGameNumber
{
    @synchronized(self)
    {
        if(gameMode == Overwatch)
        {
            return 0;
        }
        else if(gameMode == LeagueOfLegends)
        {
            return 1;
        }
        
        return 0;
    }
}

+(void) setGameMode : (GameMode) nGameMode
{
    @synchronized(self)
    {
        gameMode = nGameMode;
    }
}

+(GetGood_Group *) groupData
{
    @synchronized(self)
    {
        return groupModel;
    }
}
+(void) setGroupData : (GetGood_Group *) group
{
    @synchronized(self)
    {
        groupModel = group;
    }
}


+(int) currentTab
{
    @synchronized(self){
        return nCurrentTab;
    }
}
+(void) setCurrentTab : (int) _currentTab
{
    @synchronized(self)
    {
        nCurrentTab = _currentTab;
    }
}


+(BOOL *) onGroupChat
{
    return onGroupChat;
}

+(void) setOnGroupChat : (BOOL *) group
{
    @synchronized(self)
    {
        onGroupChat = group;
    }
}


+(GetGood_Dialog *) dialogData
{
    return tempDialog;
}

+(void) setDialogData : (GetGood_Dialog *) dialog
{
    @synchronized(self)
    {
        tempDialog = dialog;
    }
}

+(Thread *) thread
{
    @synchronized(self)
    {
        return thread;
    }
}
+(void) setThread : (Thread *) _thread
{
    @synchronized(self)
    {
        thread = _thread;
    }
}

+(GetGood_Thread *) threadData
{
    @synchronized(self)
    {
        return tempThread;
    }
}
+(void) setThreadData : (GetGood_Thread *) thread
{
    @synchronized(self)
    {
        tempThread = thread;
    }
}
+(NSString *)getDateFromTimeInterval:(NSString *)timeInterval dateFormat:(NSString *)dateFormat{
    
    
    double getDate= [timeInterval doubleValue]; // here replace your value
    NSTimeInterval seconds = getDate;
    //NSTimeInterval seconds = getDate;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:dateFormat];
    
    // @"dd-MMM-yyyy hh:mm a"
    //[dateFormatter setDateFormat:@"dd MMM,yyyy hh:mm:ss a"];
    return [dateFormatter stringFromDate:date];
    
}


+(GetGood_Lesson *) lessonData
{
    @synchronized(self)
    {
        return tempLesson;
    }
}

+(void) setLessonData: (GetGood_Lesson *) lessonModel
{
    @synchronized(self)
    {
        tempLesson = lessonModel;
    }
}

@end
