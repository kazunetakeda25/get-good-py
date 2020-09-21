//
//  SortfourSectionCell.h
//  getgood
//
//  Created by Bhargav Mistri on 05/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortfourSectionCell : UITableViewCell<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtMiniGameR;
@property (weak, nonatomic) IBOutlet UITextField *txtMaxiGameR;
@property (weak, nonatomic) IBOutlet UIButton *title;


@property(nonatomic, strong) UIPickerView* minPicker;
@property(nonatomic, strong) UIPickerView* maxPicker;
@end
