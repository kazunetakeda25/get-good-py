//
//  GetGood_CoachRate.m
//  getgood
//
//  Created by Dan on 5/20/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "GetGood_CoachRate.h"

@implementation GetGood_CoachRate


-(id)initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    
    if(self)
    {
        self.id = dictionary[@"id"];
        self.competency = [dictionary[@"competency"] floatValue];
        self.communication = [dictionary[@"communication"] floatValue];
        self.flexibility = [dictionary[@"flexibility"] floatValue];
        self.attitude = [dictionary[@"attitude"] floatValue];
        self.comment = dictionary[@"comment"];
        
        self.name = dictionary[@"name"];
        self.avatar_url = dictionary[@"avatar_url"];
    }
    
    return self;
}

@end
