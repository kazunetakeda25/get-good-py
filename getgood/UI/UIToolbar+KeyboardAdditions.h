//
//  UIToolbar+KeyboardAdditions.h
//  
//
//  Created by Shagun Madhikarmi on 17/06/2015.
//  Copyright (c) 2015 ustwo. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//  of the Software, and to permit persons to whom the Software is furnished to do
//  so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

@import UIKit;
@import Foundation;

/**
 *  UIToolbar category that creates toolbar's that are useful for text inputs.
 */
@interface UIToolbar (KeyboardAdditions)

/**
 *  Creates a toolbar with a system done button at the right
 *
 *  @param target The target object that receives the selector
 *  @param action The selector to perform on the target object
 *
 *  @return A new UIToolbar configured with a system done button
 */
+ (UIToolbar *)doneToolbarWithTarget:(id)target action:(SEL)action;

/**
 *  Creates a toolbar with a previous, next, space and system done button
 *
 *  @param target         The target object that receives the selector
 *  @param previousAction The selector to perform on the target object when previous is pressed
 *  @param previousText   The text for the previous button
 *  @param nextAction     The selector to perform on the target object when next is pressed
 *  @param nextText       The text for the next button
 *  @param doneAction     The selector to peform on the target object when done is pressed
 *
 *  @return A new UIToolbar configured with a previous, next, space and system done button
 */
+ (UIToolbar *)previousNextDoneToolbarWithTarget:(id)target previousAction:(SEL)previousAction previousText:(NSString *)previousText nextAction:(SEL)nextAction nextText:(NSString *)nextText doneAction:(SEL)doneAction;
@end
