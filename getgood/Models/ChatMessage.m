//
//  ChatMessage.m
//  getgood
//
//  Created by Md Aminuzzaman on 23/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

@import Firebase;
@import FirebaseDatabase;

#include <math.h>

#import "Temp.h"
#import "Utils.h"
#import "AppData.h"
#import "ChatMessage.h"
#import "AppConstants.h"

@implementation ChatMessage

@synthesize messageText;
@synthesize userId;
@synthesize state;
@synthesize type;
@synthesize dialogId;

-(id)     initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    
    if(self)
    {
        self.userId     = dictionary[@"UserID"];
        self.messageText   = dictionary[@"MessageText"];
        self.type   = dictionary[@"Type"];
        self.state   = dictionary[@"State"];
        self.dialogId   = dictionary[@"DialogID"];
        self.Timestamp   = dictionary[@"Timestamp"];
    }
    
    return self;
}

-(void) write
{
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    [[[[[ref child:@"dialog"] child:dialogId] child:@"msg"]  childByAutoId] setValue:[self dictionaryValue]];
}

- (NSDictionary *) dictionaryValue
{
    return @
    {
        @"UserID" : ObjectOrNull(self.userId),
        @"MessageText" : ObjectOrNull(self.messageText),
        @"Type" : ObjectOrNull(self.type),
        @"State" : ObjectOrNull(self.state),
        @"DialogID" : ObjectOrNull(self.dialogId),
        @"Timestamp" : ObjectOrNull(self.Timestamp)
        
    };
}

@end


