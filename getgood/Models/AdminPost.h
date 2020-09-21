//
//  AdminPost.h
//  getgood
//
//  Created by Md Aminuzzaman on 1/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdminPost : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *description;
@property (nonatomic,strong) NSNumber *blocked;

-(id)initWithDictionary: (NSDictionary*) dictionary;

-(id)     initWithTitle: (NSString*)  title
        description: (NSString*)  desc;

-(void) write;
-(void) load;

@end

