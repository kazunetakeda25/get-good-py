//
//  AppData.m
//  getgood
//
//  Created by Md Aminuzzaman on 11/9/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "AppData.h"

@import FirebaseAuth;
@import FirebaseDatabase;

@implementation AppData

@synthesize ProfileEvenListner;

static User *profile;
static NSString *token;

static NSMutableArray *lessonList;
static NSMutableArray *groupList;

+(void) userDefaultSetObject : (id) userObject forKey:(NSString *) userKey
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:userObject forKey:userKey];
}

+(id)uesrDefaultGetObjectForKey : (NSString *) userKey
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    return [userDefault objectForKey:userKey];
}

+(BOOL)isKeyExists : (NSString *) userKey
{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:userKey])
    {
        return YES;
    }
    
    return NO;
}

+(User *) profile
{
    @synchronized(self)
    {
        return profile;
    }
}

+(NSString *) token
{
    @synchronized(self)
    {
        return token;
    }
}


+(void) setProfile: (User *) _profile
{
    @synchronized(self)
    {
        profile = _profile;
    }
}



+(void) setToken: (NSString *) _token
{
    @synchronized(self)
    {
        token = _token;
    }
}

+(NSMutableArray *) lessonList
{
    @synchronized(self)
    {
        return lessonList;
    }
}

+(void) setLesson : (NSMutableArray *) ls
{
    @synchronized(self)
    {
        lessonList = ls;
    }
}

+(NSMutableArray *) groupList
{
    @synchronized(self)
    {
        return groupList;
    }
}

+(void) setGroup : (NSMutableArray *) gr
{
    @synchronized(self)
    {
        groupList = gr;
    }
}


@end
