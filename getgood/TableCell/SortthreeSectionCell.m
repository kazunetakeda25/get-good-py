//
//  SortthreeSectionCell.m
//  getgood
//
//  Created by Bhargav Mistri on 05/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "SortthreeSectionCell.h"

@implementation SortthreeSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.slider addTarget:self
                         action:@selector(rangeSliderValueDidChange:)
               forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)rangeSliderValueDidChange:(MARKRangeSlider *)slider {
    NSString * strFormat = @"%.1f";
    
    if(!self.showDecimal)
    {
        strFormat = @"%.0f";
    }
    [self.tvMin setText:[NSString stringWithFormat:strFormat, slider.leftValue]];
    [self.tvMax setText:[NSString stringWithFormat:strFormat, slider.rightValue]];
}

@end
