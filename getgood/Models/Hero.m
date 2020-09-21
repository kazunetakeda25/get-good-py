//
//  Hero.m
//  getgood
//
//  Created by MD Aminuzzaman on 1/11/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "Hero.h"

@implementation Hero

@synthesize name;
@synthesize time;
@synthesize selected;

-(id) initWithName: (NSString*) name time:(double ) t
{
    self = [super init];
    
    if(self)
    {
        self.name = name;
        self.time = t;
    }
    
    return self;
}

@end
