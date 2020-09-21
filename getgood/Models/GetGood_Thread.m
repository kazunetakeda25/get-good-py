//
//  GetGood_Dialog.m
//  getgood
//
//  Created by Dan on 5/7/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "GetGood_Thread.h"

@implementation GetGood_Thread

-(id)initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    
    if(self)
    {
        self.id = dictionary[@"id"];
        self.title = dictionary[@"title"];
        self.getgood_description = dictionary[@"description"];
        self.owner_id = dictionary[@"owner_id"];
        self.name = dictionary[@"name"];
        self.avatar_url = dictionary[@"avatar_url"];
    }
    
    return self;
}
@end
