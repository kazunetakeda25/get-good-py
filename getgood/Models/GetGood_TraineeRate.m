//
//  GetGood_TraineeRate.m
//  getgood
//
//  Created by Dan on 5/21/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "GetGood_TraineeRate.h"

@implementation GetGood_TraineeRate

-(id)initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    
    if(self)
    {
        self.id = dictionary[@"id"];
        self.general = [dictionary[@"general"] floatValue];
        self.comment = dictionary[@"comment"];
        
        self.name = dictionary[@"name"];
        self.avatar_url = dictionary[@"avatar_url"];
    }
    
    return self;
}
@end
