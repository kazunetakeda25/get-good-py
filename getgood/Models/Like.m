//
//  Like.m
//  getgood
//
//  Created by Dan on 19/04/2018.
//  Copyright © 2018 PH. All rights reserved.
//

#import "Like.h"
#import "AppData.h"
#import "Utils.h"

@implementation Like

-(id)initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    
    if(self)
    {
        self.UserID     = dictionary[@"UserID"];
        self.CommentID   = dictionary[@"CommentID"];
        self.Like   = dictionary[@"Like"];
    }
    return self;
}


- (NSDictionary *) dictionaryValue
{
    return @
    {
        @"CommentID" : ObjectOrNull(self.CommentID),
        @"UserID" : ObjectOrNull(self.UserID),
        @"Like" : ObjectOrNull(self.Like)
    };
}


@end
