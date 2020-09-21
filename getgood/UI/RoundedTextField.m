//
//  RoundedTextField.m
//  getgood
//
//  Created by Md Aminuzzaman on 24/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "RoundedTextField.h"

@implementation RoundedTextField

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

- (void)drawPlaceholderInRect:(CGRect)rect {
    UIColor *colour = [UIColor lightGrayColor];
    if ([self.placeholder respondsToSelector:@selector(drawInRect:withAttributes:)])
    { // iOS7 and later
        NSDictionary *attributes = @{NSForegroundColorAttributeName: colour, NSFontAttributeName: self.font};
        CGRect boundingRect = [self.placeholder boundingRectWithSize:rect.size options:0 attributes:attributes context:nil];
        [self.placeholder drawAtPoint:CGPointMake(0, (rect.size.height/2)-boundingRect.size.height/2) withAttributes:attributes]; }
    else { // iOS 6
        [colour setFill];
        [self.placeholder drawInRect:rect withFont:self.font lineBreakMode:NSLineBreakByTruncatingTail alignment:self.textAlignment];
    }
}

@end

