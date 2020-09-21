//
//  GetGood_Lesson.m
//  getgood
//
//  Created by Dan on 5/3/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "GetGood_Lesson.h"

@implementation GetGood_Lesson


-(id)initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    
    if(self)
    {
        self.id = dictionary[@"id"];
        self.title = dictionary[@"title"];
        self.getgood_description = dictionary[@"description"];
        self.hero = dictionary[@"hero"];
        self.hero_count = [dictionary[@"hero_count"] intValue];
        self.inactive = [dictionary[@"inactive"] boolValue];
        self.owner_id = dictionary[@"owner_id"];
        self.price = [dictionary[@"price"] floatValue];
        self.server = dictionary[@"server"];
        self.thumb_url = dictionary[@"thumb_url"];
        self.videos = dictionary[@"videos"];
        self.ready = dictionary[@"ready"];
        
        
        self.owner = [[User alloc] initWithDictionary:dictionary[@"owner"]];
        
    }
    
    return self;
}
@end
