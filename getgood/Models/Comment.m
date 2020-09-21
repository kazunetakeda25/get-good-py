//
//  Comment.m
//  getgood
//
//  Created by Bhargav Mistri on 27/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "Comment.h"
#import "AppConstants.h"
#include <math.h>
#import "Temp.h"
#import "Utils.h"
#import "AppData.h"

@import Firebase;
@import FirebaseDatabase;

@implementation Comment

-(id)     initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    
    if(self)
    {
        self.Comment     = dictionary[@"Comment"];
        self.ID   = dictionary[@"ID"];
        self.ThreadID   = dictionary[@"ThreadID"];
        self.UserID   = dictionary[@"UserID"];
    }
    
    return self;
}

-(void) write
{
    NSNumber* strTimestamp = [NSNumber numberWithLong:[[NSDate date] timeIntervalSince1970]];
    
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    [[[ref child:@"comment"] childByAutoId] setValue:[self dictionaryValue]];
    
    if(self.ThreadID != nil)
    {
        [[[[ref child:@"thread"] child:self.ThreadID] child:@"Timestamp"] setValue:strTimestamp];
    }
}

- (NSDictionary *) dictionaryValue
{
    return @
    {
        @"Comment" : ObjectOrNull(self.Comment),
        @"ID" : ObjectOrNull(self.ID),
        @"ThreadID" : ObjectOrNull(self.ThreadID),
        @"UserID" : ObjectOrNull(self.UserID),
        @"Reference" : ObjectOrNull(self.Reference)
    };
}

+ (void) loadReplyComments:(NSString*) ReferenceID callBack:(void (^)(NSArray*)) callback
{
    FIRDatabaseReference* ref = [[FIRDatabase database] reference];
    
    [[[[ref child:@"comment"] queryOrderedByChild:@"Reference"] queryEqualToValue:ReferenceID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSMutableArray* arComments = [[NSMutableArray alloc] init];
        
        for(FIRDataSnapshot* shot in snapshot.children)
        {
            Comment* thread = [[Comment alloc] initWithDictionary:shot.value];
            
            [arComments addObject:thread];
        }
        
        callback(arComments);
        
    }];
}

+ (void) loadComments:(NSString*) threadID callBack:(void (^)(NSArray*)) callback
{
    FIRDatabaseReference* ref = [[FIRDatabase database] reference];
    
    [[[[ref child:@"comment"] queryOrderedByChild:@"ThreadID"] queryEqualToValue:threadID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSMutableArray* arComments = [[NSMutableArray alloc] init];
        
        for(FIRDataSnapshot* shot in snapshot.children)
        {
            Comment* thread = [[Comment alloc] initWithDictionary:shot.value];
            
            [arComments addObject:thread];
        }
        
        callback(arComments);
        
    }];
}
@end
