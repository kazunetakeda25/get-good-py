//
//  HomeBrowseController.h
//  getgood
//
//  Created by Md Aminuzzaman on 21/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"
#import "iToast.h"

@interface HomeBrowseController : UIViewController <XLPagerTabStripChildItem,UICollectionViewDelegate>
{
    IBOutlet UICollectionView *collectionView;
    CGSize cellSize;
    float screenWidth;
}

@end

@interface BrowseCollectionCell : UICollectionViewCell
{
    
}

@property (nonatomic,strong) IBOutlet UILabel *labelNameView;
@property (nonatomic,strong) IBOutlet UIImageView *imageAvatarView;
@property (nonatomic,strong) IBOutlet UIImageView *imageComingSoonView;

@end

