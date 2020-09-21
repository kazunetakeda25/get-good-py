//
//  Hero.h
//  getgood
//
//  Created by MD Aminuzzaman on 1/11/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hero : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) double time;
@property (nonatomic,strong) NSNumber *selected;

-(id) initWithName: (NSString*) name time:(double ) t;

@end



