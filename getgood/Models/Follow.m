//
//  Follow.m
//  getgood
//
//  Created by Md Aminuzzaman on 1/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "Utils.h"
#import "Helpers.h"
#import "Follow.h"
#import "AppData.h"

@import FirebaseDatabase;

@implementation Follow

@synthesize id;
@synthesize userId;
@synthesize followId;

-(id)     initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    
    if(self)
    {
        self.id       = dictionary[@"ID"];
        self.userId   = dictionary[@"Description"];
        self.followId = false;
    }
    
    return self;
}

-(id)     initWithUserId: (NSString*)  userId followId:(NSString *) followId
{
    self = [super init];
    
    if(self)
    {
        self.userId    = userId;
        self.followId  = followId;
        
        self.id = [Utils getSaltString];
    }
    
    return self;
}

-(void) write : (void (^)(void)) followFinishListener
{
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    
    [self delete:^(void)
    {
        [[[ref child:@"follow"] child:self.id] setValue:[self dictionaryValue]];
        followFinishListener();
    }];
}


-(void) delete : (void (^)(void)) followFinishListener
{
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    
    [[[[ref child:@"follow"] queryOrderedByChild:@"UserID"] queryEqualToValue:userId]  observeSingleEventOfType: FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *_Nonnull snapshot)
     {
         if(![snapshot.value isEqual:[NSNull null]])
         {
             followFinishListener();
             return;
         }
         
         for ( FIRDataSnapshot *child in snapshot.children )
         {
             Follow *follow = [[Follow alloc] initWithDictionary:child.value];
             
             if([follow.followId isEqualToString:followId])
             {
                 [[[ref child:@"follow"] child:follow.id] setValue:[NSNull null]];
                 
                 followFinishListener();
             }
         }
     }
     withCancelBlock:^(NSError * _Nonnull error)
     {
         followFinishListener();
     }];
    
}

- (NSDictionary *)dictionaryValue
{
    return @{
             @"ID" : ObjectOrNull(self.id),
             @"UserID" : ObjectOrNull(self.userId),
             @"FollowID" : ObjectOrNull(self.followId)
            };
}


+ (void) checkFollows:(NSString *) userId
             followId:(NSString *) followId
             listener:(void (^)(BOOL)) checkFollowListener
{
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    
    [[[[ref child:@"follow"] queryOrderedByChild:@"UserID"] queryEqualToValue:userId]  observeSingleEventOfType: FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *_Nonnull snapshot)
     {
         if(![snapshot.value isEqual:[NSNull null]])
         {
             checkFollowListener(NO);
             return;
         }
         
         for ( FIRDataSnapshot *child in snapshot.children )
         {
             Follow *follow = [[Follow alloc] initWithDictionary:child.value];
             
             if([follow.followId isEqualToString:followId])
             {
                 checkFollowListener(YES);
                 return;
             }
         }
     }
     withCancelBlock:^(NSError * _Nonnull error)
     {
         checkFollowListener(NO);
     }];
}

+ (void) getFollowers:(NSString *) userId
             listener:(void (^)(NSMutableArray *)) getFollowFinishListener
{
    NSMutableArray *arFollows = [[NSMutableArray alloc] init];
                                
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    
    [[[[ref child:@"follow"] queryOrderedByChild:@"FollowID"] queryEqualToValue:userId]  observeSingleEventOfType: FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *_Nonnull snapshot)
    {
         if(![snapshot.value isEqual:[NSNull null]])
         {
             getFollowFinishListener(arFollows);
             return;
         }
                                      
         for ( FIRDataSnapshot *child in snapshot.children )
         {
             Follow *follow = [[Follow alloc] initWithDictionary:child.value];
                                          
             [arFollows addObject:follow];
         }
        
         getFollowFinishListener(arFollows);
    }
    withCancelBlock:^(NSError * _Nonnull error)
    {
        getFollowFinishListener(arFollows);
    }];
}

+ (void) getFollows:(NSString *) userId
           listener:(void (^)(NSMutableArray *)) getFollowFinishListener
{
    NSMutableArray *arFollows = [[NSMutableArray alloc] init];
    
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    
    [[[[ref child:@"follow"] queryOrderedByChild:@"UserID"] queryEqualToValue:userId]  observeSingleEventOfType: FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *_Nonnull snapshot)
     {
         if(![snapshot.value isEqual:[NSNull null]])
         {
             getFollowFinishListener(arFollows);
             return;
         }
         
         for ( FIRDataSnapshot *child in snapshot.children )
         {
             Follow *follow = [[Follow alloc] initWithDictionary:child.value];
             
             [arFollows addObject:follow];
         }
         
         getFollowFinishListener(arFollows);
     }
     withCancelBlock:^(NSError * _Nonnull error)
     {
         getFollowFinishListener(arFollows);
     }];
}

@end
