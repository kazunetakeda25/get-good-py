//
//  SignUpController.m
//  getgood
//
//  Created by Md Aminuzzaman on 18/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "UIKit.h"
#import "AppData.h"
#import "RoundedTextField.h"
#import "OverwatchService.h"
#import "SVProgressHUD.h"
#import "HomeController.h"
#import "TermsController.h"
#import "SignUpController.h"
#import "Utils.h"

@import Photos;
@import Firebase;
@import FirebaseStorage;

@interface SignUpController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate>

{
    BOOL isImageSelected;
}

@property (strong, nonatomic) FIRStorageReference *storageRef;
@property (strong, nonatomic) UIAlertController *alertCtrl;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@end

@implementation SignUpController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isImageSelected = NO;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionPicker:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [imageProfile addGestureRecognizer:tapGestureRecognizer];
    imageProfile.userInteractionEnabled = YES;
   
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTerms:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [labelTerms addGestureRecognizer:tapGestureRecognizer];
    labelTerms.userInteractionEnabled = YES;
    
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionBack:)];
    
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [labelLogin addGestureRecognizer:tapGestureRecognizer];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    labelLogin.userInteractionEnabled = YES;
    
    textUserNameField.returnKeyType = UIReturnKeyDone;
    textEmailField.returnKeyType = UIReturnKeyDone;
    textPasswordField.returnKeyType = UIReturnKeyDone;
    textConfirmPasswordField.returnKeyType = UIReturnKeyDone;
    
    textUserNameField.delegate = self;
    textEmailField.delegate = self;
    textPasswordField.delegate = self;
    textConfirmPasswordField.delegate = self;
    
    [self setupAlertCtrl];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [borderView redraw];
}
-(void)dismissKeyboard
{
    //    [textEmailField resignFirstResponder];
    //    [textPasswordField resignFirstResponder];
    //    [self animateTextField:nil up:NO];
    [self.view endEditing:YES];
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
    
    isImageSelected = YES;
    
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = img;
    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image];
    imageCropVC.delegate = self;
    
    self.bmpAvatar = img;
    [self.navigationController pushViewController:imageCropVC animated:YES];
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
    self.bmpAvatar = croppedImage;
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

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:false];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)actionPicker:(UITapGestureRecognizer *)tapGesture
{
    [self presentViewController:self.alertCtrl animated:YES completion:nil];
}
- (void)actionBack:(UITapGestureRecognizer *)tapGesture
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)actionTerms:(UITapGestureRecognizer *)tapGesture
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    TermsController *controller = [storyboard instantiateViewControllerWithIdentifier:@"sb_id_terms_controller"];
    
    [self.navigationController pushViewController:controller animated:YES];
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

-(IBAction) actionSignUp:(id)sender
{
    [self.view endEditing:YES];
    if( textEmailField.text.length == 0
       || textPasswordField.text.length == 0
       || textUserNameField.text.length == 0
       || textConfirmPasswordField.text.length == 0
       || !radioTermsButton.isSelected)
    {
        [UIKit showInformation:self message:@"Please fill all fields!"];
        return;
    }
    
    if(![textPasswordField.text isEqualToString:textConfirmPasswordField.text])
    {
        [UIKit showInformation:self message:@"Password mismatch!"];
        return;
    }
    
    [UIKit showLoading];
    
    [RestClient checkMail:textEmailField.text name:textUserNameField.text callback:^(bool result, NSDictionary *data) {
        
        [UIKit dismissDialog];
        
        if(result == false)
        {
            int code = [[[data objectForKey:@"data"] objectForKey:@"code"] intValue];
            
            if(code == 1)
            {
                [UIKit showInformation:self message:@"Duplicate Email. Please enter other mail."];
            }
            else
            {
                [UIKit showInformation:self message:@"Duplicate Username. Please enter other name."];
            }
            
            return;
        }
        
        if(self.bmpAvatar != nil)
        {
            [self uploadBitmap];
        }
        else
        {
            [self signup];
        }
        
    }];
    
}

- (void) uploadBitmap
{
    NSData *imageData = UIImageJPEGRepresentation(self.bmpAvatar, 0.2);
    
    NSString *imagePath =[NSString stringWithFormat:@"images/%@",
                          [Utils getSaltString]];
    
    FIRStorageMetadata *metadata = [FIRStorageMetadata new];
    metadata.contentType = @"image/jpeg";
    
    FIRStorageReference *storageRef = [[FIRStorage storage] reference];
    [UIKit showLoading];
    [[storageRef child:imagePath]
     putData:imageData
     metadata:metadata
     completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error)
     {
         if (error)
         {
             [UIKit dismissDialog];
             
             [UIKit showInformation:self message:error.localizedDescription];
             NSLog(@"Error uploading: %@", error);
             
             return;
         }
         
         self.strAvatar = metadata.downloadURL.absoluteString;
         
         [self signup];

     }];
}

- (void) signup
{
    [UIKit showLoading];

    [RestClient signup:textEmailField.text name:textUserNameField.text avatar:self.strAvatar password:textPasswordField.text callback:^(bool result, NSDictionary *data) {
        
        [UIKit dismissDialog];
        if(result)
        {
            id listener = ^(bool result, NSDictionary *data){
                [UIKit dismissDialog];
                
//                if(result == true)
                {
                    [UIKit showGotIt:self message:@"Verification email sent to your email address. Please check your spam folder if you cannot find it in your inbox." yesHandler:^(UIAlertAction *action) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    
                }
            };
            
            
            [UIKit showLoading];
            
            [RestClient verify:textEmailField.text callback:listener];
            
        }
        else
        {
            [UIKit showInformation:self message:@""];
        }
        
    }];
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

/*
- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [aTextField resignFirstResponder];
    return YES;
}*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isKindOfClass:[RoundedTextField class]])
    {
        UITextField *nextField = [(RoundedTextField *)textField nextField];
        
        if (nextField)
        {
            dispatch_async(dispatch_get_main_queue(), ^
            {
                [nextField becomeFirstResponder];
            });
        }
        else
        {
            [textField resignFirstResponder];
        }
    }
    
    return YES;
}

@end


