//
//  AdminPost.h
//  getgood
//
//  Created by Md Aminuzzaman on 1/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "Utils.h"
#import <Foundation/Foundation.h>

@interface Follow : NSObject

@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *followId;

-(id)     initWithDictionary: (NSDictionary*) dictionary;
-(id)     initWithUserId: (NSString*)  userId followId:(NSString *) followId;

-(void) write  : (void (^)(void)) followFinishListener;
-(void) delete : (void (^)(void)) followFinishListener;

+ (void) checkFollows:(NSString *) userId
             followId:(NSString *) followId
             listener:(void (^)(BOOL)) checkFollowListener;

+ (void) getFollowers:(NSString *) userId
             listener:(void (^)(NSMutableArray *)) getFollowFinishListener;

+ (void) getFollows:(NSString *) userId
           listener:(void (^)(NSMutableArray *)) getFollowFinishListener;

@end


