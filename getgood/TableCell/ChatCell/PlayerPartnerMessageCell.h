//
//  PlayerPartnerMessageCell.h
//  getgood
//
//  Created by Bhargav Mistri on 09/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerPartnerMessageCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UIImageView *imageUser;
@property (nonatomic,strong) IBOutlet UILabel *labelDateView;
@property (weak, nonatomic) IBOutlet UITextView *tvMessage;

@end
