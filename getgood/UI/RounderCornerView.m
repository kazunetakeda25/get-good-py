//
//  RounderCornerView.m
//  getgood
//
//  Created by MD Aminuzzaman on 1/8/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "RoundedCornerView.h"

@implementation RoundedCornerView

@synthesize radius;
@synthesize padding;
@synthesize borderColor;

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder]))
        [self initialize];
    
    return self;
}

-(id) initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:frame]))
        [self initialize];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateLayerProperties];
}


- (void)updateLayerProperties {
    self.layer.borderWidth = 1;
    self.layer.borderColor = self.borderColor.CGColor;
    
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)setRadius:(CGFloat)value {
    //if ((value >= 0.0) && (value <= 1.0)) {
    radius = value;
    [self updateLayerProperties];
    //}
}

-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, padding, padding);
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    return [self textRectForBounds:bounds];
}

-(void) initialize
{
    radius = 0;
    padding = 10;
    
    self.borderColor = [UIColor whiteColor];
    
    self.layer.cornerRadius = radius;
    self.clipsToBounds = true;
}

@end



