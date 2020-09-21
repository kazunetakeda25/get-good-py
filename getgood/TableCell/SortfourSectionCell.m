//
//  SortfourSectionCell.m
//  getgood
//
//  Created by Bhargav Mistri on 05/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import "SortfourSectionCell.h"
#import "Temp.h"
#import "DataArrays.h"

@implementation SortfourSectionCell
@synthesize minPicker, maxPicker;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    if(Temp.getGameMode == LeagueOfLegends)
    {
        minPicker = [[UIPickerView alloc] init];
        minPicker.dataSource = self;
        minPicker.delegate = self;
                
        maxPicker = [[UIPickerView alloc] init];
        maxPicker.dataSource = self;
        maxPicker.delegate = self;
        // ... ...
        
        UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
        [keyboardToolbar sizeToFit];
        UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                          target:nil action:nil];
        UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                          target:self action:@selector(yourTextViewDoneButtonPressed)];
        keyboardToolbar.items = @[flexBarButton, doneBarButton];
       
        self.txtMiniGameR.inputView = minPicker;
        self.txtMiniGameR.inputAccessoryView = keyboardToolbar;
        
        self.txtMaxiGameR.inputView = maxPicker;
        self.txtMaxiGameR.inputAccessoryView = keyboardToolbar;
        
        self.txtMiniGameR.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.txtMaxiGameR.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
}

-(void)yourTextViewDoneButtonPressed
{
    [self endEditing:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [DataArrays lolRanks].count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView == self.minPicker)
    {
        self.txtMiniGameR.text = [[DataArrays lolRanks] objectAtIndex:row];
    }
    else if (pickerView == self.maxPicker)
    {
        self.txtMaxiGameR.text = [[DataArrays lolRanks] objectAtIndex:row];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[DataArrays lolRanks] objectAtIndex:row];
}

@end
