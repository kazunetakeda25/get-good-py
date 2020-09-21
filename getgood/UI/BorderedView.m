//
//  BorderView.m
//  getgood
//
//  Created by MD Aminuzzaman on 1/8/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "BorderedView.h"

@interface BorderedView()
@property (nonatomic, strong) CAShapeLayer *leftLayer;
@property (nonatomic, strong) CAShapeLayer *rightLayer;
@property (nonatomic, strong) CAShapeLayer *topLayer;
@property (nonatomic, strong) CAShapeLayer *bottomLayer;
@end

@implementation BorderedView

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
//    [self updateLayerProperties];
}


//- (void)updateLayerProperties {
//    self.layer.borderWidth = 1;
//
//    self.layer.masksToBounds = YES;
//}
//
-(void) setLeft : (BOOL) left
{
    _left = left;

    [self.leftLayer removeFromSuperlayer];

    [self updateLeftLayer];
}

-(void) updateLeftLayer
{
    if(self.left)
    {
        self.leftLayer = [CAShapeLayer layer];

        self.leftLayer.frame = CGRectMake(0, 0, self.leftThikness, CGRectGetHeight(self.frame));

        self.leftLayer.backgroundColor = [[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] CGColor];

        [self.layer addSublayer:self.leftLayer];
    }
}

-(void) setTop : (BOOL) top
{
    _top = top;

    [self.topLayer removeFromSuperlayer];

    [self updateTopLayer];
}

-(void) updateTopLayer
{
    if(self.top)
    {
        self.topLayer = [CAShapeLayer layer];

        self.topLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), self.topThikness);

        self.topLayer.backgroundColor = [[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] CGColor];

        [self.layer addSublayer:self.topLayer];
    }
}

-(void) setRight : (BOOL) right
{
    _right = right;

    [self.rightLayer removeFromSuperlayer];

    [self updateRightLayer];
}

-(void) updateRightLayer
{
    if(self.right)
    {
        self.rightLayer = [CAShapeLayer layer];

        self.rightLayer.frame = CGRectMake(CGRectGetWidth(self.frame) - self.rightThikness, 0, self.rightThikness, CGRectGetHeight(self.frame));

        self.rightLayer.backgroundColor = [[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] CGColor];
        self.rightLayer.borderColor = [[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] CGColor];
        self.rightLayer.fillColor = [[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] CGColor];

        [self.layer addSublayer:self.rightLayer];
    }
}

-(void) setBottom : (BOOL) bottom
{
    _bottom = bottom;

    [self.bottomLayer removeFromSuperlayer];

    [self updateBottomLayer];
}

-(void) updateBottomLayer
{
    if(self.bottom)
    {
        self.bottomLayer = [CAShapeLayer layer];

        self.bottomLayer.frame = CGRectMake(0, CGRectGetHeight(self.frame) - self.bottomThikness, CGRectGetWidth(self.frame), self.bottomThikness);

        self.bottomLayer.backgroundColor = [[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] CGColor];

        [self.layer addSublayer:self.bottomLayer];
    }
}

//-(void) setLeftThikness :(int) leftThikness
//{
//    _leftThikness = leftThikness;
//
//    [self.leftLayer removeFromSuperlayer];
//
//    [self updateLeftLayer];
//}
//
//-(void) setTopThikness :(int) topThikness
//{
//    _topThikness= topThikness;
//
//    [self.topLayer removeFromSuperlayer];
//
//    [self updateTopLayer];
//}
//
//-(void) setRightThikness :(int) rightThikness
//{
//    _rightThikness = rightThikness;
//
//    [self.rightLayer removeFromSuperlayer];
//
//    [self updateRightLayer];
//}
//
//-(void) setBottomThikness :(int) bottomThikness
//{
//    _bottomThikness = bottomThikness;
//
//    [self.bottomLayer removeFromSuperlayer];
//
//    [self updateBottomLayer];
//}
//
-(void) initialize
{
//    self.topThikness = 1;
//    self.leftThikness = 1;
//    self.rightThikness = 1;
//    self.bottomThikness = 1;
//
//    self.topLayer = [CAShapeLayer layer];
//
//    self.topLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), self.topThikness);
//
//    self.topLayer.backgroundColor = [[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] CGColor];
//    self.topLayer.strokeColor = [[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] CGColor];
//
//    [ self.layer addSublayer:self.topLayer ];
//
//    CAShapeLayer *border = [CAShapeLayer layer];
//
//    [self.layer addSublayer:border];
//
//    self.leftLayer = [CAShapeLayer layer];
//
//    self.leftLayer.frame = CGRectMake(0, 0, self.leftThikness, CGRectGetHeight(self.frame));
//
//    self.leftLayer.backgroundColor = [[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] CGColor];
//
//    [self.layer addSublayer:self.leftLayer];
//
//    self.bottomLayer = [CAShapeLayer layer];
//
//    self.bottomLayer.frame = CGRectMake(0, CGRectGetHeight(self.frame) - self.bottomThikness, CGRectGetWidth(self.frame), self.bottomThikness);
//
//    self.bottomLayer.backgroundColor = [[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] CGColor];
//
//    [self.layer addSublayer:self.bottomLayer];
//
//    self.rightLayer = [CAShapeLayer layer];
//
//    self.rightLayer.frame = CGRectMake(CGRectGetWidth(self.frame) - self.rightThikness, 0, self.rightThikness, CGRectGetHeight(self.frame));
//
//    self.rightLayer.backgroundColor = [[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f] CGColor];
//
//    [self.layer addSublayer:self.rightLayer];
}
//
- (void) redraw
{
    [self.bottomLayer removeFromSuperlayer];
    [self updateBottomLayer];
    [self.rightLayer removeFromSuperlayer];
    [self updateRightLayer];
    [self.leftLayer removeFromSuperlayer];
    [self updateLeftLayer];
    [self.topLayer removeFromSuperlayer];
    [self updateTopLayer];
}


@end
