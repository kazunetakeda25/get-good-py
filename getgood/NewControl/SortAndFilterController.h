//
//  SortAndFilterController.h
//  getgood
//
//  Created by Bhargav Mistri on 02/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Temp.h"

@interface SortAndFilterController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    
    IBOutlet UIImageView *imageBackButton;
    __weak IBOutlet UITableView *tblView;
    
    NSInteger SelectSortBy;
    NSInteger SelectAvalibility;
    
    NSString *playerMinimumR;
    NSString *playerMaximumR;
    
    NSString *gameMinimumR;
    NSString *gameMaximumR;
    
}
@end
