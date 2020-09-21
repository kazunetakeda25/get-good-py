//
//  GetGood_Dialog.m
//  getgood
//
//  Created by Dan on 5/7/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "GetGood_AdminPost.h"

@implementation GetGood_AdminPost

-(id)initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    
    if(self)
    {
        self.id = dictionary[@"id"];
        self.title = dictionary[@"title"];
        self.post = dictionary[@"post"];
        self.enabled = dictionary[@"enabled"];
    }
    
    return self;
}
@end
