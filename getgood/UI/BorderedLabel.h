//
//  BorderedLabel.h
//  getgood
//
//  Created by Md Aminuzzaman on 29/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface BorderedLabelView : UILabel
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
@end
