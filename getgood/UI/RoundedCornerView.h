//
//  RoundedCorderView.h
//  getgood
//
//  Created by MD Aminuzzaman on 1/8/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface RoundedCornerView : UIView
{
    
}

@property (nonatomic,assign) IBInspectable CGFloat radius;

@property (nonatomic) IBInspectable CGFloat padding;

@property (nonatomic, copy)   IBInspectable UIColor *borderColor;

@end
