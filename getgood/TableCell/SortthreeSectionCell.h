//
//  SortthreeSectionCell.h
//  getgood
//
//  Created by Bhargav Mistri on 05/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MARKRangeSlider.h"

@interface SortthreeSectionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *txtMiniPlayerR;
@property (weak, nonatomic) IBOutlet UITextField *txtMaxiPlayerR;
@property (weak, nonatomic) IBOutlet UIButton *tvTitle;
@property (weak, nonatomic) IBOutlet MARKRangeSlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *tvMax;
@property (weak, nonatomic) IBOutlet UILabel *tvMin;

@property (nonatomic, assign) BOOL showDecimal;
@end
