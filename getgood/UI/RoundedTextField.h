//
//  RoundedTextField.h
//  getgood
//
//  Created by Md Aminuzzaman on 24/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface RoundedTextField : UITextField
{
    
}

@property (nonatomic,assign) IBInspectable CGFloat radius;

@property (nonatomic) IBInspectable CGFloat padding;

@property (weak, nonatomic) IBOutlet UITextField *nextField;
//@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

@property (nonatomic, copy)   IBInspectable UIColor *borderColor;

@end


