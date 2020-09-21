//
//  GroupSelfMessageCell.h
//  getgood
//
//  Created by Bhargav Mistri on 01/03/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupSelfMessageCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UIImageView *imageUser;
@property (nonatomic,strong) IBOutlet UILabel *labelDateView;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UITextView *labelMessageView;

@end
