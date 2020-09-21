//
//  LessonCreateController.m
//  getgood
//
//  Created by Md Aminuzzaman on 27/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "LessonCreateController.h"
#import "UIKit.h"
#import "AppData.h"
#import "ISPlayerViewHelpers.h"
#import "UIView+Borders.h"
#import "Utils.h"
#import "UIKit.h"
#import "UIImageView+WebCache.h"

@import Firebase;
@import FirebaseDatabase;

@interface LessonCreateController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate>
{
    
}

@property (strong, nonatomic) UIAlertController *alertCtrl;
@property (strong, nonatomic) UIImagePickerController *imagePicker;



@end

@implementation LessonCreateController
@synthesize strDescription, arYoutubeIDs, collectionHeight, containerHeight, strHero;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *color = [UIColor darkGrayColor];
    txtTitle.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"LessonTitle"
                                        attributes:@{NSForegroundColorAttributeName:color}];


    
    txtPrice.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Price"
                                        attributes:@{NSForegroundColorAttributeName:color}];
    
    txtYoutubeUrl.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"YoutubeUrl"
                                     attributes:@{NSForegroundColorAttributeName:color}];
    
    labelServerValue.userInteractionEnabled = NO;
    
    txtTitle.returnKeyType = UIReturnKeyDone;
    txtPrice.returnKeyType = UIReturnKeyDone;
    txtYoutubeUrl.returnKeyType = UIReturnKeyDone;
    
    txtTitle.delegate = self;
    txtPrice.delegate = self;
    txtYoutubeUrl.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionBack:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageBack addGestureRecognizer:tapGestureRecognizer];
    imageBack.userInteractionEnabled = YES;
    
//   tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionVideoAdd:)];
//   tapGestureRecognizer.numberOfTapsRequired = 1;
//   [imageVideoAdd addGestureRecognizer:tapGestureRecognizer];
//   imageVideoAdd.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionProfileImage:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageProfile addGestureRecognizer:tapGestureRecognizer];
    imageProfile.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionDescription:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [_DescriptionView addGestureRecognizer:tapGestureRecognizer];
    _DescriptionView.userInteractionEnabled = YES;
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SelectHero:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.HeroView addGestureRecognizer:tapGestureRecognizer];
    self.HeroView.userInteractionEnabled = YES;
    
    arYoutubeIDs = [[NSMutableArray alloc] init];
    [collectionVideo setDelegate:self];
    [collectionVideo setDataSource:self];
    
    [self setupAlertCtrl];
    
    
    if(self.bEdit)
    {
        [self feedUI];
    }
}

- (void) feedUI
{
    [txtTitle setText:[Temp lessonData].title];
    [txtPrice setText:[NSString stringWithFormat:@"%.1f", [Temp lessonData].price]];
    
    [labelDescription setText:[Temp lessonData].getgood_description];
    arYoutubeIDs = [[[Temp lessonData].videos componentsSeparatedByString:@","] mutableCopy];
    [collectionVideo reloadData];

    txtYoutubeUrl.text = @"";
    
    int nCellCount = arYoutubeIDs.count;
    if(nCellCount % 2 == 1)
    {
        nCellCount ++;
    }
    collectionHeight.constant = 125 * (nCellCount / 2);
    containerHeight.constant = 450  + collectionHeight.constant;
    
    if([Temp lessonData].server.length)
    {
        if([[Temp lessonData].server isEqualToString:@"us"])
            labelServerValue.text = @"Americas";
        else if([[Temp lessonData].server isEqualToString:@"eu"])
            labelServerValue.text = @"Europe";
        else if([[Temp lessonData].server isEqualToString:@"kr"])
            labelServerValue.text = @"Asia";
    }
    
    self.strServer = [Temp lessonData].server;
    
    [imageProfile sd_setImageWithURL:[NSURL URLWithString:[Temp lessonData].thumb_url]];
    
    NSArray* arHeros = [[Temp lessonData].hero componentsSeparatedByString:@" "];
    NSMutableArray* arTemp = [[NSMutableArray alloc] init];
    BOOL isHero = YES;
    
    if([Temp getGameMode] == Overwatch)
    {
        for(NSString* strHero in arHeros)
        {
            NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:strHero , @"Title", [strHero lowercaseString], @"Image", nil];
            
            [arTemp addObject:dict];
            
            if([[DataArrays heroes] containsObject:strHero])
            {
                isHero = YES;
            }
            else
            {
                isHero = NO;
            }
        }
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        NSArray* arCategoryValues = [DataArrays lol_categories_values];
        NSArray* arCategoryNames = [DataArrays lol_categories];
        
        NSArray* arHeroes = [DataArrays lol_heroes];
        
        for(NSString* strHero in arHeros)
        {
            NSDictionary * dict;
            if([arHeroes containsObject:strHero])
            {
                dict = [[NSDictionary alloc] initWithObjectsAndKeys:strHero , @"Title", strHero , @"Image", nil];
            }
            else
            {
                int nIndex = [arCategoryValues indexOfObject:strHero];
                
                dict = [[NSDictionary alloc] initWithObjectsAndKeys:[arCategoryNames objectAtIndex:nIndex] , @"Title", strHero , @"Image", strHero, @"Value",  nil];
            }
            
            
            [arTemp addObject:dict];
            
            if([[DataArrays lol_heroes] containsObject:strHero])
            {
                isHero = YES;
            }
            else
            {
                isHero = NO;
            }
        }
    }
    
    if(isHero)
    {
        ArrayCategory1 = arTemp;
    }
    else
    {
        ArrayCategory2 = arTemp;
    }
    
    [self SetHeroImages:arTemp];
}

-(void)dismissKeyboard
{
    //    [textEmailField resignFirstResponder];
    //    [textPasswordField resignFirstResponder];
    //    [self animateTextField:nil up:NO];
    [self.view endEditing:YES];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.LessonView addBottomBorderWithHeight:2.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
//    [self.DescriptionView addBottomBorderWithHeight:2.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
    [self.HeroView addBottomBorderWithHeight:2.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
    [self.PriceView addBottomBorderWithHeight:2.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
    [self.YoutubeView addBottomBorderWithHeight:2.0f andColor:[UIColor colorWithRed:0.56f green:0.77f blue:0.24f alpha:1.0f]];
    
        
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)doneWithServer:(NSString *)Server{
    
    self.strServer = Server;
    labelServerValue.text = [DataArrays getRegionName:self.strServer];
    
}

-(void)doneWithCategory1:(NSArray *)Category1 Category2:(NSArray *)Category2{
    
    if (Category1.count != 0) {
        
        ArrayCategory2 = [[NSMutableArray alloc] init];
        ArrayCategory1 = Category1;
        [self SetHeroImages:Category1];
        
    }else if (Category2.count != 0){
        
        ArrayCategory1 = [[NSMutableArray alloc] init];
        ArrayCategory2 = Category2;
        [self SetHeroImages:Category2];
    
    }
}


-(void)SetHeroImages:(NSArray *)ObjArray{
    
    [self.heroImage1 setHidden:NO];
    [self.heroImage2 setHidden:NO];
    [self.heroImage3 setHidden:NO];
    [self.heroImage4 setHidden:NO];
    [self.heroImage5 setHidden:NO];
    
    NSArray* arHr = [ObjArray valueForKey:@"Image"];
    
    int i = 0;
    if([Temp getGameMode] == Overwatch)
    {
        for(i = 0; i < [arHr count] ; ++i)
        {
            switch (i)
            {
                case 0:
                    [self.heroImage1 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                    break;
                case 1:
                    [self.heroImage2 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                    break;
                case 2:
                    [self.heroImage3 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                    break;
                case 3:
                    [self.heroImage4 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                    break;
                case 4:
                    [self.heroImage5 setImage:[UIImage imageNamed:[[arHr objectAtIndex:i] lowercaseString]]];
                    break;
                    
                default:
                    break;
            }
        }
    }
    else if([Temp getGameMode] == LeagueOfLegends)
    {
        for(i = 0; i < [arHr count] ; ++i)
        {
            switch (i)
            {
                case 0:
                    [self.heroImage1 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                    break;
                case 1:
                    [self.heroImage2 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                    break;
                case 2:
                    [self.heroImage3 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                    break;
                case 3:
                    [self.heroImage4 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                    break;
                case 4:
                    [self.heroImage5 setImage:[UIImage imageNamed:[arHr objectAtIndex:i] ]];
                    break;
                    
                default:
                    break;
            }
        }
    }
    
    
    for(int j = i ; j < 5 ; j++)
    {
        switch (j)
        {
            case 0:
                [self.heroImage1 setHidden:YES];
                break;
            case 1:
                [self.heroImage2 setHidden:YES];
                break;
            case 2:
                [self.heroImage3 setHidden:YES];
                break;
            case 3:
                [self.heroImage4 setHidden:YES];
                break;
            case 4:
                [self.heroImage5 setHidden:YES];
                break;
                
            default:
                break;
        }
    }
}

- (void)SelectServer:(UITapGestureRecognizer *)tapGesture{
    
    [self.view endEditing:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SelectServerController *controller = [storyboard instantiateViewControllerWithIdentifier:@"SelectServerController"];
    controller.delegate=self;
    
    if (labelServerValue.text.length != 0) {
        controller.SelectName = labelServerValue.text;
    }
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (void)SelectHero:(UITapGestureRecognizer *)tapGesture
{
    [self.view endEditing:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SelectHeroController *controller = [storyboard instantiateViewControllerWithIdentifier:@"SelectHeroController"];
    
    controller.ArrSelectCategory1 = [ArrayCategory1 mutableCopy];
    controller.ArrSelectCategory2 = [ArrayCategory2 mutableCopy];
    
    controller.delegate=self;
    [self.navigationController pushViewController:controller animated:YES];
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
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = img;
    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image];
    imageCropVC.delegate = self;
    [self.navigationController pushViewController:imageCropVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.avatarContainer redraw];
}

-(NSString *) randomStringWithLength: (int) len {
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    return randomString;
}

-(IBAction)actionDone:(id)sender
{
    [self.view endEditing:YES];
    
    if( txtTitle.text.length == 0 || labelDescription.text.length == 0 || imageProfile.image == nil)
    {
        [UIKit showInformation:self message:@"Please fill all fields!"];
        return;
    }else if (ArrayCategory1.count == 0 && ArrayCategory2.count == 0){
        
        [UIKit showInformation:self message:@"Please fill all fields!"];
        return;
    }
    
    [UIKit showLoading];
    CGFloat scaleSize = 0.2f;
    UIImage *smallImage = [UIImage imageWithCGImage:imageProfile.image.CGImage
                                              scale:scaleSize
                                        orientation:imageProfile.image.imageOrientation];

    NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.3);
    NSString *imagePath =[NSString stringWithFormat:@"images/%@.jpg",
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

         [self firebaseSignUp:metadata.downloadURL.absoluteString];
     }];
}



-(void) firebaseSignUp:(NSString *) urlString
{
        NSString *Heros;
        NSString *HeroCount;
    
        if (ArrayCategory1.count != 0) {
    
            HeroCount = [NSString stringWithFormat:@"%lu",(unsigned long)ArrayCategory1.count];
            Heros = [[ArrayCategory1 valueForKey:@"Title"] componentsJoinedByString:@" "];
    
        }else{
    
            HeroCount = [NSString stringWithFormat:@"%lu",(unsigned long)ArrayCategory2.count];
            Heros = [[ArrayCategory2 valueForKey:@"Value"] componentsJoinedByString:@" "];
        }
    
        NSString *videoID = [arYoutubeIDs componentsJoinedByString:@","];
    
    
    [UIKit showLoading];
    if(self.bEdit)
    {
        [RestClient updateLesson:[Temp lessonData].id title:txtTitle.text description:labelDescription.text hero:Heros price:[txtPrice.text floatValue] thumb_url:urlString videos:videoID ready:[Temp lessonData].ready callback:^(bool result, NSDictionary *data) {
            
            [UIKit dismissDialog];
            if(!result)
            {
                return ;
            }
            
            [Temp setNeedReload:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    else
    {
        [RestClient createLesson:txtTitle.text description:labelDescription.text hero:Heros videos:videoID thumb_url:urlString price:[txtPrice.text floatValue] callback:^(bool result, NSDictionary *data) {
            [UIKit dismissDialog];
            if(!result)
            {
                return ;
            }
            [Temp lessonData].title = txtTitle.text;
            [Temp lessonData].getgood_description = txtTitle.text;
            [Temp lessonData].server = txtTitle.text;
            [Temp lessonData].hero = txtTitle.text;
            [Temp lessonData].videos = txtTitle.text;
            [Temp lessonData].thumb_url = txtTitle.text;
            [Temp lessonData].price = [txtPrice.text floatValue];
            
            [Temp setNeedReload:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
     [textField resignFirstResponder];
     return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    if(up)
    {
        if(self.view.frame.origin.y < -10)
            return;
    }
    else
    {
        if(self.view.frame.origin.y > -10)
            return;
    }

    
    const int movementDistance = -130; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)actionBack:(UITapGestureRecognizer *)tapGesture
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)actionDescription: (UITapGestureRecognizer*) tapGesture
{
    [self.view endEditing:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DescriptionController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sid_create_description_controller"];
    controller.strDesc = labelDescription.text;
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)actionVideoAdd:(UITapGestureRecognizer *)tapGesture
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)actionProfileImage:(UITapGestureRecognizer *)tapGesture
{
    [self.view endEditing:YES];
    [self presentViewController:self.alertCtrl animated:YES completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arYoutubeIDs.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/2 - 14 , 120);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LessonVideoCell *cell = (LessonVideoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"LessonVideoCell" forIndexPath:indexPath];
    NSString* strYoutubeId = [arYoutubeIDs objectAtIndex:indexPath.row];
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg", strYoutubeId]];
    [cell.imageVideo setImage:nil];
    [cell.imageVideo sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@""]];
    
    if(self.bEdit)
    {
        [cell.ivDelete setHidden:NO];
    }
    else
    {
        [cell.ivDelete setHidden:YES];
    }
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(delete:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [cell.ivDelete addGestureRecognizer:tapGestureRecognizer];
    cell.ivDelete.userInteractionEnabled = YES;
    tapGestureRecognizer.view.tag = indexPath.row;
    
    return cell;
}


- (void)delete:(UITapGestureRecognizer *)recognizer
{
    
    [arYoutubeIDs removeObjectAtIndex:recognizer.view.tag];
    
    [collectionVideo reloadData];
    
    int nCellCount = arYoutubeIDs.count;
    if(nCellCount % 2 == 1)
    {
        nCellCount ++;
    }
    collectionHeight.constant = 125 * (nCellCount / 2);
    containerHeight.constant = 450  + collectionHeight.constant;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle: @"didSelectItemAtIndexPath:"
                                                                        message: [NSString stringWithFormat: @"Indexpath = %@", indexPath]
                                                                 preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle: @"Dismiss"
                                                          style: UIAlertActionStyleDestructive
                                                        handler: nil];
    
    [controller addAction: alertAction];
    
    [self presentViewController: controller animated: YES completion: nil];
}

- (void) onDescriptionEntered:(NSString *)strDescription
{
    [labelDescription setText:strDescription];
    
//    CGSize constraint = CGSizeMake(labelDescription.frame.size.width, CGFLOAT_MAX);
//    CGSize size;
//    UIFont *font = [UIFont fontWithName:@"Poppins-Regular" size:14.0f];
//
//    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
//    CGSize boundingBox = [strDescription boundingRectWithSize:constraint
//                                                                           options:NSStringDrawingUsesLineFragmentOrigin
//                                                                        attributes:@{NSFontAttributeName:font}
//                                                                           context:context].size;
//
//    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height + 20));
//    self.DescHeight.constant = size.height;
//    [self.view layoutSubviews];
}



// Crop image has been canceled.
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}

// The original image has been cropped. Additionally provides a rotation angle used to produce image.
- (void)imageCropViewController:(RSKImageCropViewController *)controller
                   didCropImage:(UIImage *)croppedImage
                  usingCropRect:(CGRect)cropRect
                  rotationAngle:(CGFloat)rotationAngle
{
    [imageProfile setImage:croppedImage];
    [self.navigationController popViewControllerAnimated:YES];
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
- (IBAction)onAddYoutube:(id)sender {
    
   NSString* youtubeID = [Utils videoIDfromYoutubeUrl:txtYoutubeUrl.text];
    if(youtubeID == nil)
    {
        [UIKit showInformation:self message:@"Invalid youtube url."];
        return;
    }
    [UIKit showLoading];
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg", youtubeID]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            UIImage* img = [UIImage imageWithData:imageData];
            [UIKit dismissDialog];
//        && ![arYoutubeIDs containsObject:youtubeID]
            if(img != nil )
            {
                [arYoutubeIDs addObject:youtubeID];
            }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [collectionVideo reloadData];
            txtYoutubeUrl.text = @"";
            
            int nCellCount = arYoutubeIDs.count;
            if(nCellCount % 2 == 1)
            {
                nCellCount ++;
            }
            collectionHeight.constant = 125 * (nCellCount / 2);
            containerHeight.constant = 450  + collectionHeight.constant;
            
        });
        
        });
    
    
}


@end

@implementation LessonVideoCell

@end



