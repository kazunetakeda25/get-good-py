//
//  GetGood_Group.m
//  getgood
//
//  Created by Dan on 5/3/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "GetGood_Group.h"

@implementation GetGood_Group


-(id)initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    
    if(self)
    {
        self.id = dictionary[@"id"];
        self.average_game_rating = [dictionary[@"average_game_rating"] intValue];
        self.average_player_rating = [dictionary[@"average_player_rating"] floatValue];
        self.getgood_description = dictionary[@"description"];
        self.hero = dictionary[@"hero"];
        self.hero_count = [dictionary[@"hero_count"] intValue];
        self.inactive = [dictionary[@"inactive"] boolValue];
        self.owner_id = dictionary[@"owner_id"];
        self.title = dictionary[@"title"];
        self.users = dictionary[@"users"];
        self.pending_users = dictionary[@"pending_users"];
        self.ready = dictionary[@"ready"];
        self.timestamp = dictionary[@"timestamp"];
        
        self.owner = [[User alloc] initWithDictionary:dictionary[@"owner"]];
        
    }
    
    return self;
}
@end
