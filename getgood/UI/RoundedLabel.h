//
//  RoundedLabel.h
//  getgood
//
//  Created by Md Aminuzzaman on 8/1/18.
//  Copyright © 2018 PH. All rights reserved.
//


#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface RoundedLabel : UILabel
{
    
}

@property (nonatomic,assign) IBInspectable CGFloat radius;

@property (nonatomic) IBInspectable CGFloat padding;

@property (nonatomic, copy)   IBInspectable UIColor *borderColor;

@end
