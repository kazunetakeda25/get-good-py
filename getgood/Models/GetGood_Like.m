//
//  GetGood_Dialog.m
//  getgood
//
//  Created by Dan on 5/7/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "GetGood_Like.h"

@implementation GetGood_Like

-(id)initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    
    if(self)
    {
        self.id = dictionary[@"id"];
        self.comment = dictionary[@"comment"];
        self.user_id = dictionary[@"user_id"];
        self.data = dictionary[@"data"];
    }
    
    return self;
}
@end
