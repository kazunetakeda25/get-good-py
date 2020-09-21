//
//  SelectHeroController.h
//  getgood
//
//  Created by Bhargav Mistri on 24/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectCategoryDelegate <NSObject>
-(void)doneWithCategory1:(NSArray *)Category1 Category2:(NSArray *)Category2;
@end

@interface SelectHeroController : UIViewController {
    
    IBOutlet UIImageView *imageBackButton;
    __weak IBOutlet UITableView *tblView1;
    __weak IBOutlet UITableView *tblView2;
    
    NSMutableArray *ArrCategory1;
    NSMutableArray *ArrCategory2;
}

@property(strong,nonatomic)id <SelectCategoryDelegate> delegate;

@property(strong,nonatomic)NSMutableArray *ArrSelectCategory1;
@property(strong,nonatomic)NSMutableArray *ArrSelectCategory2;
@end
