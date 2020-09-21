//
//  HomeProfileController.m
//  getgood
//
//  Created by Md Aminuzzaman on 21/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

@import Firebase;
@import FirebaseDatabase;

#import "UIKit.h"
#import "Utils.h"
#import "Follow.h"
#import "AppData.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "ColorConstants.h"
#import "HomeProfileController.h"
#import "ProfileFollowerController.h"
#import "HeroSelectionController.h"
#import "CoachRateDisplayController.h"
#import "ProfileTitleEditController.m"
#import "PlayerRateDisplayController.h"
#import "TraineeRateDisplayController.h"
#import "Temp.h"
#import "LoLServerSelectionController.h"

@interface HomeProfileController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    BOOL isReload;
    BOOL isImageSelected;
}

@property (strong, nonatomic) FIRStorageReference *storageRef;
@property (strong, nonatomic) UIAlertController *alertCtrl;
@property (strong, nonatomic) UIImagePickerController *imagePicker;

@end

@implementation HomeProfileController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    isImageSelected = NO;
    
    [self initUI];
    
}

- (void) setupAlertCtrl
{
    self.alertCtrl = [UIAlertController alertControllerWithTitle:@"Select Image"
                                                         message:nil
                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"From camera"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action)
                             {
                                 [self handleCamera];
                             }];
    
    UIAlertAction *imageGallery = [UIAlertAction actionWithTitle:@"From Photo Library"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       [self handleImageGallery];
                                   }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action)
                             {
                                 [self dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    
    [self.alertCtrl addAction:camera];
    [self.alertCtrl addAction:imageGallery];
    [self.alertCtrl addAction:cancel];
}

- (void)handleCamera
{
#if TARGET_IPHONE_SIMULATOR
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"Camera is not available on simulator"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *action)
                         {
                             [self dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
#elif TARGET_OS_IPHONE
    //Some code for iPhone
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
#endif
}

- (void)handleImageGallery
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSData *dataImage = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"],1);
    UIImage *img = [[UIImage alloc] initWithData:dataImage];
    [imageProfile setImage:img];
//    isImageSelected = YES;
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
    
    UIImage *image = img;
    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image];
    imageCropVC.delegate = self;
    
    [self.navigationController pushViewController:imageCropVC animated:YES];
}


// Crop image has been canceled.
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
    
    
    [self uploadImage];
}

// The original image has been cropped. Additionally provides a rotation angle used to produce image.
- (void)imageCropViewController:(RSKImageCropViewController *)controller
                   didCropImage:(UIImage *)croppedImage
                  usingCropRect:(CGRect)cropRect
                  rotationAngle:(CGFloat)rotationAngle
{
    [imageProfile setImage:croppedImage];
    [self.navigationController popViewControllerAnimated:YES];
    
    
    [self uploadImage];
}

// The original image will be cropped.
- (void)imageCropViewController:(RSKImageCropViewController *)controller
                  willCropImage:(UIImage *)originalImage
{
    // Use when `applyMaskToCroppedImage` set to YES.
    
}

// Returns a custom rect for the mask.
- (CGRect)imageCropViewControllerCustomMaskRect:(RSKImageCropViewController *)controller
{
    CGSize maskSize;
    if ([controller isPortraitInterfaceOrientation]) {
        maskSize = CGSizeMake(250, 250);
    } else {
        maskSize = CGSizeMake(220, 220);
    }
    
    CGFloat viewWidth = CGRectGetWidth(controller.view.frame);
    CGFloat viewHeight = CGRectGetHeight(controller.view.frame);
    
    CGRect maskRect = CGRectMake((viewWidth - maskSize.width) * 0.5f,
                                 (viewHeight - maskSize.height) * 0.5f,
                                 maskSize.width,
                                 maskSize.height);
    
    return maskRect;
}


-(UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size
{
    float width = size.width;
    float height = size.height;
    
    UIGraphicsBeginImageContext(size);
    CGRect rect = CGRectMake(0, 0, width, height);
    
    float widthRatio = image.size.width / width;
    float heightRatio = image.size.height / height;
    float divisor = widthRatio > heightRatio ? widthRatio : heightRatio;
    
    width = image.size.width / divisor;
    height = image.size.height / divisor;
    
    rect.size.width  = width;
    rect.size.height = height;
    
    if(height < width)
        rect.origin.y = height / 3;
    
    [image drawInRect: rect];
    
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return smallImage;
}

                                                    
- (void)actionEditTitle:(UITapGestureRecognizer *)tapGesture
{
    
    
    if([Temp getGameMode] == Overwatch)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        ProfileTitleEditController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_profile_edit_controller"];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"edit"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        LoLProfileTitleEditController *controller = [storyboard instantiateViewControllerWithIdentifier:@"lol_profile_edit_vc"];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"edit"];
        [self.navigationController pushViewController:controller animated:YES];
    }

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"profile"];
    [_homeController.buttonBarView reloadData];
    
    [self updateGuideUI];
    
    [self feedUI];
    
    
    [self moveToViewControllerAtIndex:1 animated:NO];
    [self moveToViewControllerAtIndex:0 animated:NO];
    
    if([Temp getGameMode] == Overwatch)
    {
        platformWidth.constant = 25;
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
//        platformWidth.constant = 0;
    }
}

- (void) updateGuideUI
{
    if(![[[NSUserDefaults standardUserDefaults] objectForKey:@"edit"] boolValue])
    {
        [imageEditProfile setImage:[UIImage imageNamed:@"glow_edit"]];
    }
    else
    {
        [imageEditProfile setImage:[UIImage imageNamed:@"edit"]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
    
    [Temp setCurrentTab:4];
    
//    [RestClient getProfile:^(bool result, NSDictionary *data) {
//
//        if(result)
//        {
//            User* user = [[User alloc] initWithDictionary:[data objectForKey:@"profile"]];
//
//            [AppData setProfile:user];
//
//            [self feedUI];
//
//        }
//    }];
}


-(void) initUI
{
    [self.buttonBarView setSelectedBarHeight:1.0f];
    self.buttonBarView.selectedBar.backgroundColor = [UIColor orangeColor];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionPicker:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageProfile addGestureRecognizer:tapGestureRecognizer];
    imageProfile.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionEditTitle:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageEditProfile addGestureRecognizer:tapGestureRecognizer];
    imageEditProfile.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionShowCoachRatingDetails:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [viewCoachRating addGestureRecognizer:tapGestureRecognizer];
    viewCoachRating.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionShowTraineeRatingDetails:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [viewTraineeRating addGestureRecognizer:tapGestureRecognizer];
    viewTraineeRating.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionShowPlayerRatingDetails:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [viewPlayerRating addGestureRecognizer:tapGestureRecognizer];
    viewPlayerRating.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionServerSelection:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [viewServerSelection addGestureRecognizer:tapGestureRecognizer];
    viewServerSelection.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionHeroSelection:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [viewHeroSelection addGestureRecognizer:tapGestureRecognizer];
    viewHeroSelection.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionCoinInfo:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [viewCoinInfo addGestureRecognizer:tapGestureRecognizer];
    viewCoinInfo.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionProfileFollower:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [labelFollowers addGestureRecognizer:tapGestureRecognizer];
    labelFollowers.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionProfileFollowing:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [labelFollowings addGestureRecognizer:tapGestureRecognizer];
    labelFollowings.userInteractionEnabled = YES;
    
    self.buttonBarView.shouldCellsFillAvailableWidth = YES;
    self.isProgressiveIndicator = NO;
    
    [self.buttonBarView setSelectedBarHeight:4.0f];
    self.buttonBarView.selectedBar.backgroundColor = [UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f];
    
    self.changeCurrentIndexProgressiveBlock = ^void(XLButtonBarViewCell *oldCell, XLButtonBarViewCell *newCell, CGFloat progressPercentage, BOOL changeCurrentIndex, BOOL animated)
    {
        if (changeCurrentIndex)
        {
            [oldCell.label setTextColor:[UIColor colorWithWhite:1 alpha:0.6]];
            [newCell.label setTextColor:[UIColor whiteColor]];
            
            if (animated)
            {
                [UIView animateWithDuration:0.1
                                 animations:^()
                 {
                     newCell.transform = CGAffineTransformMakeScale(1.0, 1.0);
                     oldCell.transform = CGAffineTransformMakeScale(0.8, 0.8);
                     
                 }
                                 completion:nil];
            }
            else
            {
                newCell.transform = CGAffineTransformMakeScale(1.0, 1.0);
                oldCell.transform = CGAffineTransformMakeScale(0.8, 0.8);
            }
        }
    };

    if([Utils isVisited:@"edit"])
    {
        [imageEditProfile setImage:[UIImage imageNamed:@"glow_edit"]];
    }
    else
    {
        [imageEditProfile setImage:[UIImage imageNamed:@"edit"]];
    }
    
   
    [self setupAlertCtrl];
    
//    [self feedUI];
    
}



-(void) feedUI
{
    User *profile = [AppData profile];
    
    [imageProfile sd_setImageWithURL:[NSURL URLWithString:profile.avatar_url]];
    
    if([Temp getGameMode] == Overwatch)
    {
        if([profile.id isEqualToString:[AppData profile].id])
        {
            if(!profile.blizzard_id.length)
            {
                if(self.homeController.greetingsTooltip != nil)
                    [self.homeController.greetingsTooltip dismissAnimated:YES];
                
                NSAttributedString* attrString = [[NSAttributedString alloc] initWithString:@"Link to your overwatch account"];
                
                if(self.greetingsTooltip != nil)
                    [self.greetingsTooltip dismissAnimated:NO];
                
                self.greetingsTooltip = [[SexyTooltip alloc] initWithAttributedString:attrString
                                                                          sizedToView:self.view
                                                                          withPadding:UIEdgeInsetsMake(10, 10, 10, 10)
                                                                            andMargin:UIEdgeInsetsMake(0, 0, 0, 0)];
                
                [self.greetingsTooltip presentFromView:imageEditProfile
                                                inView:self.view
                                            withMargin:10
                                              animated:NO];
            }
            else
            {
                if(self.greetingsTooltip != nil)
                    [self.greetingsTooltip dismissAnimated:NO];
            }
        }
        
        
        labelName.text = profile.name;
        labelDateJoined.text = profile.join_date;
        
        //    if( [profile.coachCoin integerValue] == 1 )
        //    {
        //        labelCoachCoin.text = @"1";
        //    }
        //    else
        //    {
        //        labelCoachCoin.text = @"0";
        //    }
        //
        //    labelPlayerCoin.text = [NSString stringWithFormat:@"%@",profile.playerCoin];
        
        if(profile.getgood_description != nil)
        {
            labelDescriptions.hidden = NO;
            labelDescriptions.text = profile.getgood_description;
        }
        else
        {
            labelDescriptions.hidden = YES;
        }
        
//        if(profile.blizzard_id != nil && profile.blizzard_id.length != 0)
        {
            viewGameAccount.hidden = NO;
            labelGameId.text = profile.blizzard_id;
            
            if(profile.overwatch_heroes != nil)
            {
                NSArray* arHr = [profile.overwatch_heroes componentsSeparatedByString: @" "];
                
                [imageHeroOne setHidden:NO];
                [imageHeroTwo setHidden:NO];
                [imageHeroThree setHidden:NO];
                [imageHeroFour setHidden:NO];
                [imageHeroFive setHidden:NO];
                
                int i = 0;
                for(i = 0; i < [arHr count] ; ++i)
                {
                    switch (i)
                    {
                        case 0:
                            [imageHeroOne setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                            break;
                        case 1:
                            [imageHeroTwo setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                            break;
                        case 2:
                            [imageHeroThree setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                            break;
                        case 3:
                            [imageHeroFour setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                            break;
                        case 4:
                            [imageHeroFive setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                            break;
                            
                        default:
                            break;
                    }
                }
                
                for(int j = i ; j < 5 ; ++j)
                {
                    switch (j)
                    {
                        case 0:
                            [imageHeroOne setHidden:YES];
                            break;
                        case 1:
                            [imageHeroTwo setHidden:YES];
                            break;
                        case 2:
                            [imageHeroThree setHidden:YES];
                            break;
                        case 3:
                            [imageHeroFour setHidden:YES];
                            break;
                        case 4:
                            [imageHeroFive setHidden:YES];
                            break;
                            
                        default:
                            break;
                    }
                }
            }
            
            
            if([profile.server containsString:@"us"])
            {
                labelServer.text = @"Americas";
            }
            else if([profile.server containsString:@"eu"])
            {
                labelServer.text = @"Europe";
            }
            else if([profile.server containsString:@"kr"])
            {
                labelServer.text = @"Asia";
            }
            
            if([profile.server containsString:@"pc"])
            {
                [ivPlatform setImage:[UIImage imageNamed:@"pc"]];
            }
            else if([profile.server containsString:@"xbox"])
            {
                [ivPlatform setImage:[UIImage imageNamed:@"xbox"]];
            }
            else if([profile.server containsString:@"ps4"])
            {
                [ivPlatform setImage:[UIImage imageNamed:@"ps4"]];
            }
            
            labelInGameRating.hidden = NO;
            if(profile.overwatch_rank != 0)
            {
                labelInGameRating.text = [NSString stringWithFormat:@"In-Game Rating (%d)",profile.overwatch_rank];
            }
            else
                labelInGameRating.text = [NSString stringWithFormat:@"In-Game Rating (---)"];
        }
//        else
//        {
//            labelInGameRating.hidden = YES;
//            viewGameAccount.hidden = YES;
//        }
        
       
        ratingCoach.value = profile.coach_rating ;
        ratingPlayer.value = profile.player_rating ;
        ratingTrainee.value = profile.trainee_rating ;
        
        labelCoachRating.text = [NSString stringWithFormat:@"%.2f",profile.coach_rating];
        
        labelTraineeRating.text = [NSString stringWithFormat:@"%.2f",profile.trainee_rating];
        
        labelPlayerRating.text = [NSString stringWithFormat:@"%.2f",profile.player_rating];
        
        
        labelCoachRatingCount.text = [NSString stringWithFormat:@"Coach Rating (%ld Reviews)",(long)[AppData profile].coach_review_count];
        
        labelTraineeRatingCount.text = [NSString stringWithFormat:@"Trainee Rating (%ld Reviews)",(long)[AppData profile].trainee_review_count];
        
        labelPlayerRatingCount.text = [NSString stringWithFormat:@"Player Rating (%ld Reviews)",(long)[AppData profile].player_review_count];
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        if([profile.id isEqualToString:[AppData profile].id])
        {
            if(!profile.lol_id.length)
            {
                if(self.homeController.greetingsTooltip != nil)
                    [self.homeController.greetingsTooltip dismissAnimated:YES];
                
                NSAttributedString* attrString = [[NSAttributedString alloc] initWithString:@"Link to your League of Legends account"];
                
                if(self.greetingsTooltip != nil)
                    [self.greetingsTooltip dismissAnimated:NO];
                
                self.greetingsTooltip = [[SexyTooltip alloc] initWithAttributedString:attrString
                                                                          sizedToView:self.view
                                                                          withPadding:UIEdgeInsetsMake(10, 10, 10, 10)
                                                                            andMargin:UIEdgeInsetsMake(0, 0, 0, 0)];
                
                [self.greetingsTooltip presentFromView:imageEditProfile
                                                inView:self.view
                                            withMargin:10
                                              animated:NO];
            }
            else
            {
                if(self.greetingsTooltip != nil)
                    [self.greetingsTooltip dismissAnimated:NO];
            }
        }
        
        
        labelName.text = profile.name;
        labelDateJoined.text = profile.join_date;
        
        //    if( [profile.coachCoin integerValue] == 1 )
        //    {
        //        labelCoachCoin.text = @"1";
        //    }
        //    else
        //    {
        //        labelCoachCoin.text = @"0";
        //    }
        //
        //    labelPlayerCoin.text = [NSString stringWithFormat:@"%@",profile.playerCoin];
        
        if(profile.lol_description != nil)
        {
            labelDescriptions.hidden = NO;
            labelDescriptions.text = profile.lol_description;
        }
        else
        {
            labelDescriptions.hidden = YES;
        }
        
//        if(profile.lol_id != nil && profile.lol_id.length != 0)
        {
            viewGameAccount.hidden = NO;
            labelGameId.text = profile.lol_id;
            
            if(profile.lol_heroes != nil)
            {
                NSArray* arHr = [profile.lol_heroes componentsSeparatedByString: @" "];
                
                [imageHeroOne setHidden:NO];
                [imageHeroTwo setHidden:NO];
                [imageHeroThree setHidden:NO];
                [imageHeroFour setHidden:NO];
                [imageHeroFive setHidden:NO];
                
                int i = 0;
                for(i = 0; i < [arHr count] ; ++i)
                {
                    switch (i)
                    {
                        case 0:
                            [imageHeroOne setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                            break;
                        case 1:
                            [imageHeroTwo setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                            break;
                        case 2:
                            [imageHeroThree setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                            break;
                        case 3:
                            [imageHeroFour setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                            break;
                        case 4:
                            [imageHeroFive setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                            break;
                            
                        default:
                            break;
                    }
                }
                
                for(int j = i ; j < 5 ; ++j)
                {
                    switch (j)
                    {
                        case 0:
                            [imageHeroOne setHidden:YES];
                            break;
                        case 1:
                            [imageHeroTwo setHidden:YES];
                            break;
                        case 2:
                            [imageHeroThree setHidden:YES];
                            break;
                        case 3:
                            [imageHeroFour setHidden:YES];
                            break;
                        case 4:
                            [imageHeroFive setHidden:YES];
                            break;
                            
                        default:
                            break;
                    }
                }
            }
            
            labelServer.text = [Utils getLolServerName:profile.lol_server];
            [ivPlatform setImage:[UIImage imageNamed:@"pc"]];
            labelInGameRating.hidden = NO;
            if(profile.lol_rank.length)
            {
                labelInGameRating.text = [NSString stringWithFormat:@"In-Game Rating (%@)",profile.lol_rank];
            }
            else
                labelInGameRating.text = [NSString stringWithFormat:@"In-Game Rating (---)"];
        }
//        else
//        {
//            labelInGameRating.hidden = YES;
//            viewGameAccount.hidden = YES;
//        }
        
        
        ratingCoach.value = profile.lol_coach_rating ;
        ratingPlayer.value = profile.lol_player_rating ;
        ratingTrainee.value = profile.lol_trainee_rating ;
        
        labelCoachRating.text = [NSString stringWithFormat:@"%.2f",profile.lol_coach_rating];
        
        labelTraineeRating.text = [NSString stringWithFormat:@"%.2f",profile.lol_trainee_rating];
        
        labelPlayerRating.text = [NSString stringWithFormat:@"%.2f",profile.lol_player_rating];
        
        
        labelCoachRatingCount.text = [NSString stringWithFormat:@"Coach Rating (%ld Reviews)",(long)[AppData profile].lol_coach_review_count];
        
        labelTraineeRatingCount.text = [NSString stringWithFormat:@"Trainee Rating (%ld Reviews)",(long)[AppData profile].lol_trainee_review_count];
        
        labelPlayerRatingCount.text = [NSString stringWithFormat:@"Player Rating (%ld Reviews)",(long)[AppData profile].lol_player_review_count];
    }

    
    
}

-(void) updateFollowUI
{
//    [Follow getFollows:[AppData userProfile].userId listener:^(NSMutableArray *arr)
//     {
//         labelFollowings.text = [NSString stringWithFormat:@"Followings (%ld)",arr.count];
//     }];
//
//    [Follow getFollowers:[AppData userProfile].userId listener:^(NSMutableArray *arr)
//     {
//         labelFollowers.text = [NSString stringWithFormat:@"Followers (%ld)",arr.count];
//     }];
}

- (void)actionPicker:(UITapGestureRecognizer *)tapGesture
{
    [self presentViewController:self.alertCtrl animated:YES completion:nil];
}

- (void)uploadSuccess:(FIRStorageMetadata *) metadata storagePath: (NSString *) storagePath
{
    NSLog(@"Upload Succeeded!");
    
    [[NSUserDefaults standardUserDefaults] setObject:storagePath forKey:@"storagePath"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void) uploadImage
{
    [UIKit showLoading];
    
    CGFloat scaleSize = 0.2f;
    UIImage *smallImage = [UIImage imageWithCGImage:imageProfile.image.CGImage
                                              scale:scaleSize
                                        orientation:imageProfile.image.imageOrientation];
    
    NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.3);
    NSString *imagePath =[NSString stringWithFormat:@"%@.jpg",
                          [Utils getSaltString]];
    
    FIRStorageMetadata *metadata = [FIRStorageMetadata new];
    metadata.contentType = @"image/jpeg";
    
    FIRStorageReference *storageRef = [[FIRStorage storage] reference];
    
    [[storageRef child:imagePath]
     putData:imageData
     metadata:metadata
     completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error)
     {
         [UIKit dismissDialog];
         if (error)
         {
             
             [UIKit showInformation:self message:error.localizedDescription];
             NSLog(@"Error uploading: %@", error);
             
             return;
         }
         
         //[//[self firebaseSignUp:metadata.downloadURL.absoluteString];]
         [AppData profile].avatar_url = metadata.downloadURL.absoluteString;
         [RestClient updateProfile:^(bool result, NSDictionary *data) {
             
         }];
         
         [self feedUI];
         
         // [self updateProfile];
     }];
}

-(void) updateProfile
{
  // [[Temp context] refreshProfile];
}

- (void)actionShowCoachRatingDetails:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    CoachRateDisplayController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_coach_rating"];
    
    controller.userId = [AppData profile].id;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)actionProfileFollower:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    ProfileFollowerController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_profile_follower_controller"];
    
    controller.viewType = VIEW_FOLLOWER_TYPE;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)actionProfileFollowing:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    ProfileFollowerController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_profile_follower_controller"];
    
    controller.viewType = VIEW_FOLLOWING_TYPE;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)actionShowTraineeRatingDetails:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    TraineeRateDisplayController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_trainee_rating"];
    
    controller.userId = [AppData profile].id;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)actionServerSelection:(UITapGestureRecognizer *)tapGesture
{
    if([Temp getGameMode] == Overwatch)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        ServerSelectionController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sid_srv_slc_controller"];
        
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        LoLServerSelectionController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sid_lol_srv_slc_controller"];
        
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)actionHeroSelection:(UITapGestureRecognizer *)tapGesture
{
    if([Temp getGameMode] == Overwatch)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        HeroSelectionController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sid_hr_slc_controller"];
        controller.delegate = self;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        LolCategoryController *controller = [storyboard instantiateViewControllerWithIdentifier:@"LolCategoryController"];
//        controller.delegate = self;
        [self.navigationController pushViewController:controller animated:YES];
    }

}

- (void)actionCoinInfo:(UITapGestureRecognizer *)tapGesture
{
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    
}


- (void)actionShowPlayerRatingDetails:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    PlayerRateDisplayController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_player_rating"];
    
    controller.userId = [AppData profile].id;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)onServerSelect:(ServerSelectionController *)controller didFinishEnteringItem:(NSString *)server
{
    NSLog(@"This was returned from ViewControllerB %@",server);
    

}

- (void)onHeroSelect:(HeroSelectionController *)controller didFinishEnteringItem:(NSMutableArray *)heroArray
{
    [self feedUI];
}

-(void) updateServer:(NSString *) server
{

}

#pragma mark - XLPagerTabStripViewControllerDataSource

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    // create child view controllers that will be managed by XLPagerTabStripViewController
    
    NSString * storyboardName = @"Main";
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc1 = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_profile_coach_listing"];
    
    UIViewController * vc2 = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_profile_group_listing"];
;
    
    if (!isReload)
    {
        return @[vc1,vc2];
    }
    
    NSMutableArray * childViewControllers = [NSMutableArray arrayWithObjects:vc1, nil];
    NSUInteger count = [childViewControllers count];
    
    for (NSUInteger i = 0; i < count; ++i)
    {
        // Select a random element between i and end of array to swap with.
        NSUInteger nElements = count - i;
        NSUInteger n = (arc4random() % nElements) + i;
        [childViewControllers exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    NSUInteger nItems = 1 + (rand() % 8);
    
    return [childViewControllers subarrayWithRange:NSMakeRange(0, nItems)];
}

-(void)reloadPagerTabStripView
{
    isReload = YES;
    self.isProgressiveIndicator  = (rand() % 2 == 0);
    self.isElasticIndicatorLimit = (rand() % 2 == 0);
    
    [super reloadPagerTabStripView];
}

- (void)pagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController didMoveToIndex:(NSInteger)toIndex
{
    
}

#pragma mark - XLPagerTabStripViewControllerDelegate

-(NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"My Profile";
}

-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f];
}

@end
