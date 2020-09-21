//
//  GroupChatMessage.m
//  getgood
//
//  Created by Bhargav Mistri on 01/03/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "GroupChatMessage.h"
#import "Utils.h"
#import "AppData.h"
#import "ChatMessage.h"
#import "AppConstants.h"

@import Firebase;
@import FirebaseDatabase;

@implementation GroupChatMessage

@synthesize AvatarUrl;
@synthesize GroupID;
@synthesize MessageText;
@synthesize State;
@synthesize UserID;

-(id)     initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    
    if(self)
    {
        self.UserID     = dictionary[@"UserID"];
        self.MessageText   = dictionary[@"MessageText"];
        self.AvatarUrl   = dictionary[@"AvatarUrl"];
        self.State   = dictionary[@"State"];
        self.GroupID   = dictionary[@"GroupID"];
        self.Timestamp   = dictionary[@"Timestamp"];
    }
    return self;
}

-(void) write
{
    
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    [[[[[ref child:@"group"] child:self.GroupID] child:@"msg"] childByAutoId] setValue:[self dictionaryValue]];
}

- (NSDictionary *) dictionaryValue
{
    return @
    {
        @"UserID" : ObjectOrNull(self.UserID),
        @"MessageText" : ObjectOrNull(self.MessageText),
        @"AvatarUrl" : ObjectOrNull(self.AvatarUrl),
        @"State" : ObjectOrNull(self.State),
        @"GroupID" : ObjectOrNull(self.GroupID),
        @"Timestamp" : ObjectOrNull(self.Timestamp)
        
    };
}

@end
