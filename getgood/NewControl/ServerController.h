//
//  ServerController.h
//  getgood
//
//  Created by Bhargav Mistri on 02/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Temp.h"
#import "DataArrays.h"

@interface ServerController : UIViewController{
    
    IBOutlet UIImageView *imageBackButton;
    __weak IBOutlet UITableView *tblView;
    __weak IBOutlet UISegmentedControl *segmentPlatform;
}


@property (nonatomic, assign) int nServer;
@property (nonatomic, assign) int nPlatform;

@end
