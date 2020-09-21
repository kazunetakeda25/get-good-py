//
//  SelectServerController.h
//  getgood
//
//  Created by Bhargav Mistri on 24/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataArrays.h"

@protocol SelectServerDelegate <NSObject>
-(void)doneWithServer:(NSString *)Server;

@end
@interface SelectServerController : UIViewController{
    
    IBOutlet UIImageView *imageBackButton;
    __weak IBOutlet UITableView *tblView;
}

@property(strong,nonatomic)id <SelectServerDelegate> delegate;
@property (strong,nonatomic) NSMutableArray *ServerName;
@property (strong,nonatomic) NSString *SelectName;

@end
