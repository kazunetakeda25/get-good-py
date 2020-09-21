//
//  AppData.h
//  getgood
//
//  Created by Md Aminuzzaman on 11/9/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "User.h"
#import <Foundation/Foundation.h>

@interface AppData : NSObject
{
    
}

+(void) userDefaultSetObject : (id) userObject forKey:(NSString *) userKey;
+(id)   uesrDefaultGetObjectForKey : (NSString *) userKey;
+(BOOL)   isKeyExists : (NSString *) userKey;

@property (nonatomic,strong) void *(^ProfileEvenListner)(void);

+(User *) profile;
+(NSString *) token;

+(void) setProfile: (User *) profile;
+(void) setToken: (NSString *) _token;

+(NSMutableArray *) lessonList;
+(void) setLesson : (NSMutableArray *) ls;

+(NSMutableArray *) groupList;
+(void) setGroup : (NSMutableArray *) gr;

+(void) readProfile : (void (^)(void)) profileWatchListener;
+(void) setListeners : (void (^)(void)) profileWatchListener;

@end
