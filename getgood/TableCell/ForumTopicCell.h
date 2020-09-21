//
//  ForumTopicCell.h
//  getgood
//
//  Created by Bhargav Mistri on 27/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForumTopicCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgLogo;
@property (strong, nonatomic) IBOutlet UILabel *lblUserName;
@property (strong, nonatomic) IBOutlet UILabel *lblTopic;

@end
