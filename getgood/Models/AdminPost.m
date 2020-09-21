//
//  AdminPost.m
//  getgood
//
//  Created by Md Aminuzzaman on 1/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "AdminPost.h"
#import "AppData.h"
@import FirebaseDatabase;

@implementation AdminPost


@synthesize title;
@synthesize id;
@synthesize description;
@synthesize blocked;

-(id)initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    
    if(self)
    {
        self.title = dictionary[@"Title"];
        self.id = dictionary[@"ID"];
        self.description = dictionary[@"Description"];
        self.blocked = false;
    }
    
    return self;
}

-(id)initWithTitle:(NSString *)title description:(NSString *)desc
{
    self = [super init];
    
    if(self)
    {
        self.title        = title;
        self.description  = desc;
       
    }
    
    return self;
}

-(void) write
{
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    [[[ref child:@"group"] child:self.id] setValue:self];
}


-(void) load
{
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    
    [[[[ref child:@"group"] child:self.id] child:@"Title"] setValue:title];
    [[[[ref child:@"group"] child:self.id] child:@"Description"] setValue:description];
 
    
}

@end





