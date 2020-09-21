//
//  DescriptionController.h
//  getgood
//
//  Created by Dan on 04/04/2018.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DescriptionDelegate <NSObject>
-(void)onDescriptionEntered:(NSString*) strDescription;
@end

@interface DescriptionController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *tfDescription;
@property (nonatomic, strong) id <DescriptionDelegate> delegate;

@property (nonnull, strong) NSString* strDesc;
@end

