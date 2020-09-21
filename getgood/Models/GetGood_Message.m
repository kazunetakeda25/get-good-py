//
//  GetGood_Message.m
//  getgood
//
//  Created by Dan on 5/8/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "GetGood_Message.h"

@implementation GetGood_Message


-(id)initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    
    if(self)
    {
        self.id = dictionary[@"id"];
        self.dialog_id = dictionary[@"dialog_id"];
        self.user_id = dictionary[@"user_id"];
        self.message = dictionary[@"message"];
        self.type = dictionary[@"type"];
        self.timestamp = dictionary[@"timestamp"];
        
        self.name = dictionary[@"name"];
        self.avatar_url = dictionary[@"avatar_url"];
    }
    
    return self;
}
@end
