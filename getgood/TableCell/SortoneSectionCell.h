//
//  SortoneSectionCell.h
//  getgood
//
//  Created by Bhargav Mistri on 05/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortoneSectionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnPopular;
@property (weak, nonatomic) IBOutlet UIButton *btnRelevance;
@property (weak, nonatomic) IBOutlet UIButton *btnLowestPlayerR;
@property (weak, nonatomic) IBOutlet UIButton *btnHighestPlayerR;
@property (weak, nonatomic) IBOutlet UIButton *btnLowestGameR;
@property (weak, nonatomic) IBOutlet UIButton *btnHighestGameR;

@end
