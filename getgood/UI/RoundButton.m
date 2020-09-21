//
//  RoundButton.m
//  getgood
//
//  Created by Md Aminuzzaman on 23/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "RoundButton.h"

@implementation RoundButton

@synthesize radius;

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder]))
        [self initialize];
    
    radius = 0;
        
    return self;
}

-(id) initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:frame]))
        [self initialize];
    
    radius = 0;
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateLayerProperties];
}


- (void)updateLayerProperties {
    //CGRect barRect = self.bounds;
    //UIBezierPath *path = [UIBezierPath bezierPathWithRect:barRect];
   
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)setRadius:(CGFloat)value {
    //if ((value >= 0.0) && (value <= 1.0)) {
        radius = value;
        [self updateLayerProperties];
    //}
}

-(void) initialize
{
    self.layer.cornerRadius = radius;
    self.clipsToBounds = true;
}

@end
