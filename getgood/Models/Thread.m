//
//  Thread.m
//  getgood
//
//  Created by Bhargav Mistri on 27/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "Thread.h"
#import "Utils.h"
#import "AppData.h"

@implementation Thread

-(id) initWithDictionary:(NSDictionary*) dictionary
{
    self = [super init];
    
    if(self)
    {
        self.AvatarUrl = dictionary[@"AvatarUrl"];
        self.Description = dictionary[@"Description"];
        self.ID = dictionary[@"ID"];
        self.Timestamp = dictionary[@"Timestamp"];
        self.Title = dictionary[@"Title"];
        self.UserID = dictionary[@"UserID"];
        self.UserName = dictionary[@"UserName"];
        
    }
    
    return self;
    
}

- (NSDictionary *) dictionaryValue
{
    return @
    {
        @"ID" : ObjectOrNull(self.ID),
        @"UserID" : ObjectOrNull(self.UserID),
        @"Title" : ObjectOrNull(self.Title),
        @"Description" : ObjectOrNull(self.Description),
        @"Timestamp" : ObjectOrNull(self.Timestamp),
        @"UserName" : ObjectOrNull(self.UserName),
        @"Blocked" : ObjectOrNull(self.Blocked),
        @"AvatarUrl" : ObjectOrNull(self.AvatarUrl)
    };
}

@end
