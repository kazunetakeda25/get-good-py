//
//  GetGood_Dialog.m
//  getgood
//
//  Created by Dan on 5/7/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "GetGood_Comment.h"

@implementation GetGood_Comment

-(id)initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    
    if(self)
    {
        self.id = dictionary[@"id"];
        self.comment = dictionary[@"comment"];
        self.thread = dictionary[@"thread"];
        self.owner_id = dictionary[@"owner_id"];
        self.reference = dictionary[@"reference"];
        self.name = dictionary[@"name"];
        self.avatar_url = dictionary[@"avatar_url"];
    }
    
    return self;
}
@end
