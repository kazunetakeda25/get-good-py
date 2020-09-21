//
//  User.m
//  getgood
//
//  Created by Dan on 5/1/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "User.h"

@implementation User



-(id)initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    
    if(self)
    {
        self.avatar_url = dictionary[@"avatar_url"];
        self.id = dictionary[@"id"];
        self.email = dictionary[@"email"];
        self.name = dictionary[@"name"];
        self.verified = [dictionary[@"verified"] boolValue];
        self.avatar_url = dictionary[@"avatar_url"];
        self.getgood_description = dictionary[@"description"];
        self.blizzard_id = dictionary[@"blizzard_id"];
        self.hero_count = [dictionary[@"overwatch_hero_count"] intValue];
        self.join_date = dictionary[@"join_date"];
        self.overwatch_rank = [dictionary[@"overwatch_rank"] intValue];
        self.server = dictionary[@"server"];
        self.overwatch_heroes = dictionary[@"overwatch_heroes"];
        self.ready = dictionary[@"ready"];
        
        self.coach_review_count = [dictionary[@"coach_review_count"] intValue];
        self.coach_rating = [dictionary[@"coach_rating"] floatValue];
        self.trainee_review_count = [dictionary[@"trainee_review_count"] intValue];
        self.trainee_rating = [dictionary[@"trainee_rating"] floatValue];
        self.player_review_count = [dictionary[@"player_review_count"] intValue];
        self.player_rating = [dictionary[@"player_rating"] floatValue];
        
        
        self.lol_ready = dictionary[@"lol_ready"];
        self.lol_description = dictionary[@"lol_description"];
        self.lol_id = dictionary[@"lol_id"];
        self.lol_rank = dictionary[@"lol_rank"];
        self.lol_heroes = dictionary[@"lol_heroes"];
        self.lol_category = dictionary[@"lol_category"];
        self.lol_hero_count = [dictionary[@"lol_hero_count"] intValue];
        self.lol_server = dictionary[@"lol_server"];
        self.lol_coach_review_count = [dictionary[@"lol_coach_review_count"] intValue];
        self.lol_coach_rating = [dictionary[@"lol_coach_rating"] floatValue];
        self.lol_trainee_review_count = [dictionary[@"lol_trainee_review_count"] intValue];
        self.lol_trainee_rating = [dictionary[@"lol_trainee_rating"] floatValue];
        self.lol_player_review_count = [dictionary[@"lol_player_review_count"] intValue];
        self.lol_player_rating = [dictionary[@"lol_player_rating"] floatValue];
    }
    
    return self;
}
@end
