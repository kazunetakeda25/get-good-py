//
//  SortoneSectionCell.h
//  getgood
//
//  Created by Bhargav Mistri on 05/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoachSortOneCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnPopular;
@property (weak, nonatomic) IBOutlet UIButton *btnRelevance;
@property (weak, nonatomic) IBOutlet UIButton *btnCoachRatingLow;
@property (weak, nonatomic) IBOutlet UIButton *btnCoachRatingHigh;
@property (weak, nonatomic) IBOutlet UIButton *btnGameRatingLow;
@property (weak, nonatomic) IBOutlet UIButton *btnGameRatingHigh;
@property (weak, nonatomic) IBOutlet UIButton *btnPriceLow;
@property (weak, nonatomic) IBOutlet UIButton *btnPriceHigh;


@end
