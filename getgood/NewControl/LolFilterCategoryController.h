//
//  CategoryController.h
//  getgood
//
//  Created by Bhargav Mistri on 02/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Temp.h"

@interface LolFilterCategoryController : UIViewController{
    
    IBOutlet UIImageView *imageBackButton;
    __weak IBOutlet UITableView *tblView1;
    __weak IBOutlet UITableView *tblView2;

     NSMutableArray *ArrCategory1;
     NSMutableArray *ArrCategory2;
    
    NSMutableArray *ArrSelectCategory1;
    NSMutableArray *ArrSelectCategory2;
    
}

@property (nonatomic, assign) BOOL bRoleSelect;

@end
