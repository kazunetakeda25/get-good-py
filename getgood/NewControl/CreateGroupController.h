//
//  CreateGroupController.h
//  getgood
//
//  Created by Bhargav Mistri on 23/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectHeroController.h"
#import "BorderedView.h"
#import "RestClient.h"
#import "DescriptionController.h"
@interface CreateGroupController : UIViewController <SelectCategoryDelegate, DescriptionDelegate>{
    
    NSArray *ArrayCategory1;
    NSArray *ArrayCategory2;
    
}

@property (weak, nonatomic) IBOutlet UITextField *txtGroupTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtDescription;
@property (weak, nonatomic) IBOutlet UIImageView *imageBack;

@property (weak, nonatomic) IBOutlet UILabel *lblDescription;

@property (weak, nonatomic) IBOutlet UIImageView *heroImage1;
@property (weak, nonatomic) IBOutlet UIImageView *heroImage2;
@property (weak, nonatomic) IBOutlet UIImageView *heroImage3;
@property (weak, nonatomic) IBOutlet UIImageView *heroImage4;
@property (weak, nonatomic) IBOutlet UIImageView *heroImage5;

@property (weak, nonatomic) IBOutlet UIView *HeroView;

@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet UIView *borderView1;

@property (nonatomic, assign) BOOL bEdit;
@end
