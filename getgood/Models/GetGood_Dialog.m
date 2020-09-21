//
//  GetGood_Dialog.m
//  getgood
//
//  Created by Dan on 5/7/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "GetGood_Dialog.h"

@implementation GetGood_Dialog

-(id)initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    
    if(self)
    {
        self.id = dictionary[@"id"];
        self.holder_id = dictionary[@"holder_id"];
        self.rec_id = dictionary[@"rec_id"];
        self.type = dictionary[@"type"];
        self.state = dictionary[@"state"];
        self.reference_id = dictionary[@"reference_id"];
        self.inviter_id = dictionary[@"inviter_id"];
        self.block_id = dictionary[@"block_id"];
        self.timestamp = dictionary[@"timestamp"];        
    }
    
    return self;
}
@end
