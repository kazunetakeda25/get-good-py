//
//  UIToolbar+KeyboardAdditions.m
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

#import "UIToolbar+KeyboardAdditions.h"

// Constants
static CGFloat const kToolBarHeight = 44.0f;


@implementation UIToolbar (KeyboardAdditions)


#pragma mark - Factory

+ (UIToolbar *)doneToolbarWithTarget:(id)target action:(SEL)action
{
    NSArray *buttonItems = [[self class] flexibleSpaceAndDoneBarButtonItemsWithTarget:target doneAction:action];
    
    return [UIToolbar toolbarWithButtonItems:buttonItems];
}

+ (UIToolbar *)previousNextDoneToolbarWithTarget:(id)target previousAction:(SEL)previousAction previousText:(NSString *)previousText nextAction:(SEL)nextAction nextText:(NSString *)nextText doneAction:(SEL)doneAction
{
    UIBarButtonItem *previousBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:previousText style:UIBarButtonItemStylePlain target:target action:previousAction];
    UIBarButtonItem *nextBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nextText style:UIBarButtonItemStylePlain target:target action:nextAction];
    
    NSMutableArray *previousNextButtonItems = [@[previousBarButtonItem, nextBarButtonItem] mutableCopy];
    NSArray *flexibleSpaceAndDoneBarButtonItems = [[self class] flexibleSpaceAndDoneBarButtonItemsWithTarget:target doneAction:doneAction];
    
    [previousNextButtonItems addObjectsFromArray:flexibleSpaceAndDoneBarButtonItems];
    
    return [UIToolbar toolbarWithButtonItems:previousNextButtonItems];
}


#pragma mark - Private

+ (UIToolbar *)toolbarWithButtonItems:(NSArray *)buttonItems
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 0.0, kToolBarHeight)];
    toolbar.translucent = NO;
    toolbar.barTintColor = [UIColor whiteColor];
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    toolbar.items = buttonItems;
    
    return toolbar;
}

+ (NSArray *)flexibleSpaceAndDoneBarButtonItemsWithTarget:(id)target doneAction:(SEL)doneAction
{
    UIBarButtonItem *flexibleSpaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:target action:doneAction];

    NSArray *buttonItems = @[flexibleSpaceButtonItem, doneButtonItem];
    
    return buttonItems;
}

@end
