//
//  GetGood_PlayerRate.m
//  getgood
//
//  Created by Dan on 5/21/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "GetGood_PlayerRate.h"

@implementation GetGood_PlayerRate

-(id)initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    
    if(self)
    {
        self.id = dictionary[@"id"];
        
        self.leader = [dictionary[@"leader"] intValue];
        self.cooperative = [dictionary[@"cooperative"] intValue];
        self.good_communication = [dictionary[@"good_communication"] intValue];
        self.sportsmanship = [dictionary[@"sportsmanship"] intValue];
        self.mvp = [dictionary[@"mvp"] intValue];
        self.flex_player = [dictionary[@"flex_player"] intValue];
        self.good_hero_competency = [dictionary[@"good_hero_competency"] intValue];
        self.good_ultimate_usage = [dictionary[@"good_ultimate_usage"] intValue];
        self.abusive_chat = [dictionary[@"abusive_chat"] intValue];
        self.griefing = [dictionary[@"griefing"] intValue];
        self.spam = [dictionary[@"spam"] intValue];
        self.no_communication = [dictionary[@"no_communication"] intValue];
        self.un_cooperative = [dictionary[@"un_cooperative"] intValue];
        self.trickling_in = [dictionary[@"trickling_in"] intValue];
        self.poor_hero_competency = [dictionary[@"poor_hero_competency"] intValue];
        self.bad_ultimate_usage = [dictionary[@"bad_ultimate_usage"] intValue];
        self.overextending = [dictionary[@"overextending"] intValue];
        
        self.comment = dictionary[@"comment"];
        
        self.name = dictionary[@"name"];
    }
    
    return self;
}
@end
