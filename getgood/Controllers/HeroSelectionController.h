//
//  ServerSelectionController.h
//  getgood
//
//  Created by Md Aminuzzaman on 27/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import "RoundButton.h"
#import <UIKit/UIKit.h>

@class HeroSelectionController;

@protocol HeroSelectionControllerDelegate <NSObject>
- (void)onHeroSelect:(HeroSelectionController *)controller didFinishEnteringItem:(NSMutableArray *)heroes;
@end

@interface HeroSelectionController : UIViewController <UITableViewDelegate>
{
    IBOutlet RoundButton *buttonUpdate;
    
    IBOutlet UILabel *labelReset;
    
    IBOutlet UIImageView *imageBack;
    
    __weak IBOutlet UITableView *tblRoles;
    IBOutlet UITableView *tableView;
}


@property (nonatomic, weak) id <HeroSelectionControllerDelegate> delegate;

@end

@interface HeroSelectionCell : UITableViewCell
{
    
}

@property (nonatomic,strong) IBOutlet UILabel *labelNameView;

@property (nonatomic,strong) IBOutlet UIImageView *imageCheck;

@property (nonatomic,strong) IBOutlet UIImageView *imageHeroThumb;
@end



