//
//  GroupListViewController.h
//  getgood
//
//  Created by Dan on 21/04/2018.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BorderedView.h"
#import "HCSStarRatingView.h"
#import "RestClient.h"

@interface GroupListViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *vCollectionView;

@property (weak, nonatomic) IBOutlet UILabel *lbNoGroup;
@property (nonatomic, strong) NSMutableArray *arrGroup;
@end


