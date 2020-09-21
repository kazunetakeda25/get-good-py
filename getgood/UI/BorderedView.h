//
//  BorderView.h
//  getgood
//
//  Created by MD Aminuzzaman on 1/8/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface BorderedView : UIView
{
    
}

@property (nonatomic) IBInspectable BOOL left;

@property (nonatomic) IBInspectable BOOL right;

@property (nonatomic) IBInspectable BOOL top;

@property (nonatomic) IBInspectable BOOL bottom;

@property (nonatomic) IBInspectable int leftThikness;

@property (nonatomic) IBInspectable int rightThikness;

@property (nonatomic) IBInspectable int topThikness;

@property (nonatomic) IBInspectable int bottomThikness;

- (void) redraw;
@end
