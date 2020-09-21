//
//  LevelView.m
//  getgood
//
//  Created by Md Aminuzzaman on 24/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "LevelView.h"

@interface LevelView ()
@property (nonatomic, strong) CAShapeLayer *barLayer;
@end

@implementation LevelView

- (void)setupDefaults {
    if (self.barLayer == nil) {
        self.barLayer = [CAShapeLayer layer];
        [self.layer addSublayer:self.barLayer];
    }
    self.value = 1.0f;
    self.threshold = 0.3f;
    self.borderWidth = 2.0f;
    self.borderColor = [UIColor blackColor];
    self.fullColor = [UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f];
    self.emptyColor = [UIColor redColor];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateLayerProperties];
}

- (void)setValue:(CGFloat)value {
    if ((value >= 0.0) && (value <= 1.0)) {
        _value = value;
        [self updateLayerProperties];
    }
}

- (void)setThreshold:(CGFloat)threshold {
    if ((threshold >= 0.0) && (threshold <= 1.0)) {
        _threshold = threshold;
        [self updateLayerProperties];
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    if (borderWidth != _borderWidth) {
        _borderWidth = borderWidth;
        [self updateLayerProperties];
    }
}

- (void)setBorderColor:(UIColor *)borderColor {
    if (borderColor != _borderColor) {
        _borderColor = borderColor;
        [self updateLayerProperties];
    }
}

- (void)setFullColor:(UIColor *)fullColor {
    if (fullColor != _fullColor) {
        _fullColor = fullColor;
        [self updateLayerProperties];
    }
}

- (void)setEmptyColor:(UIColor *)emptyColor {
    if (emptyColor != _emptyColor) {
        _emptyColor = emptyColor;
        [self updateLayerProperties];
    }
}

- (void)updateLayerProperties {
    CGRect barRect = self.bounds;
    barRect.size.width = self.bounds.size.width * self.value;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:barRect];
    self.barLayer.path = path.CGPath;
    self.barLayer.fillColor = (self.value >= self.threshold) ? self.fullColor.CGColor : self.emptyColor.CGColor;
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
}

@end
