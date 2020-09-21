//
//  ServerSelectionController.h
//  getgood
//
//  Created by Md Aminuzzaman on 27/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestClient.h"

@class LoLServerSelectionController;

@protocol LoLServerSelectionControllerDelegate <NSObject>
- (void)onServerSelect:(LoLServerSelectionController *)controller didFinishEnteringItem:(NSString *)server;
@end

@interface  LoLServerSelectionController : UIViewController <UITableViewDelegate>
{
    IBOutlet UITableView *tableView;
    IBOutlet UIImageView *imageBack;
}

@property (nonatomic,strong) NSString *strPlatform;
@property (nonatomic,strong) NSString *strServer;
@property (nonatomic, weak) id <LoLServerSelectionControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentPlatform;

@end

@interface LoLServerSelectionCell : UITableViewCell
{
}

@property (nonatomic,strong) IBOutlet UILabel *labelNameView;
@property (nonatomic,strong) IBOutlet UIImageView *imageCheck;

@end


