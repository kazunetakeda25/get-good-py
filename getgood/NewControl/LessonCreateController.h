//
//  LessonCreateController.h
//  getgood
//
//  Created by Md Aminuzzaman on 27/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "SelectHeroController.h"
#import "SelectServerController.h"
#import "DescriptionController.h"
#import <RSKImageCropper/RSKImageCropper.h>
#import "RestClient.h"
#import "BorderedView.h"
#import "Temp.h"

@interface LessonCreateController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource,SelectCategoryDelegate,SelectServerDelegate, DescriptionDelegate, RSKImageCropViewControllerDelegate, RSKImageCropViewControllerDataSource>
{
    IBOutlet UIImageView *imageVideoAdd;
    
    IBOutlet UIImageView *imageBack;
    IBOutlet UIImageView *imageProfile;
   
    IBOutlet UITextField *txtTitle;
    IBOutlet UITextField *txtPrice;
    IBOutlet UITextField *txtYoutubeUrl;
    
    __weak IBOutlet UILabel *labelDescription;
    __weak IBOutlet UILabel *LabelDescription;
    IBOutlet UIButton *buttonDone;
    IBOutlet UICollectionView *collectionVideo;
    
    NSArray *ArrayCategory1;
    NSArray *ArrayCategory2;
    
    __weak IBOutlet UILabel *labelServer;
    __weak IBOutlet UILabel *labelServerValue;
}

@property (weak, nonatomic) IBOutlet UIImageView *heroImage1;
@property (weak, nonatomic) IBOutlet UIImageView *heroImage2;
@property (weak, nonatomic) IBOutlet UIImageView *heroImage3;
@property (weak, nonatomic) IBOutlet UIImageView *heroImage4;
@property (weak, nonatomic) IBOutlet UIImageView *heroImage5;

@property (weak, nonatomic) IBOutlet UIView *HeroView;
@property (weak, nonatomic) IBOutlet UIView *LessonView;
@property (weak, nonatomic) IBOutlet UIView *DescriptionView;
@property (weak, nonatomic) IBOutlet UIView *PriceView;
@property (weak, nonatomic) IBOutlet UIView *YoutubeView;
@property (strong, nonatomic) NSString* strDescription;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *DescHeight;

- (IBAction)actionDone:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerHeight;
@property (nonatomic, strong) NSString* strHero;
@property (weak, nonatomic) IBOutlet BorderedView *avatarContainer;

@property (nonatomic, strong) NSMutableArray* arYoutubeIDs;
@property (nonatomic,assign) BOOL bEdit;
@property (nonatomic,strong) NSString* strServer;
@end

@interface LessonVideoCell : UICollectionViewCell
{
    
}

@property (nonatomic,strong) IBOutlet UIImageView *imageVideo;
@property (weak, nonatomic) IBOutlet UIImageView *ivDelete;

@end

