//
//  ServerSelectionController.h
//  getgood
//
//  Created by Md Aminuzzaman on 27/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestClient.h"

@class ServerSelectionController;

@protocol ServerSelectionControllerDelegate <NSObject>
- (void)onServerSelect:(ServerSelectionController *)controller didFinishEnteringItem:(NSString *)server;
@end

@interface  ServerSelectionController : UIViewController <UITableViewDelegate>
{
    IBOutlet UITableView *tableView;
    IBOutlet UIImageView *imageBack;
}

@property (nonatomic,strong) NSString *strPlatform;
@property (nonatomic,strong) NSString *strServer;
@property (nonatomic, weak) id <ServerSelectionControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentPlatform;

@end

@interface ServerSelectionCell : UITableViewCell
{
}

@property (nonatomic,strong) IBOutlet UILabel *labelNameView;
@property (nonatomic,strong) IBOutlet UIImageView *imageCheck;

@end


