//
//  Header.h
//  getgood
//
//  Created by Md Aminuzzaman on 25/11/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "XLPagerTabStripViewController.h"
#import "BorderedView.h"
#import "GetGood_Lesson.h"
#import "RoundButton.h"
#import "ActionSheetStringPicker.h"
#import "GameController.h"

@interface GameCoachController : UIViewController <XLPagerTabStripChildItem,UITableViewDelegate>
{
    IBOutlet UITableView *tableView;
    
    IBOutlet UIButton *buttonCreateLesson;
    
    NSInteger SelectSortBy;
    NSInteger SelectAvalibility;
    
    NSMutableArray* arLessons;
    __weak IBOutlet RoundButton *btnReady;
    
}

-(IBAction) actionCreateLesson:(id) sender;

@property (nonatomic, strong) GameController *vcParent;

@property (nonatomic, assign) BOOL bLoading;
@property (nonatomic, assign) BOOL bFinish;
@property (nonatomic, assign) int nPage;

- (void) update;

@end

@interface GameCoachCollectionCell : UITableViewCell
{
    
}

@property (weak, nonatomic) IBOutlet UIImageView *ivReady;

@property (nonatomic,strong) IBOutlet UILabel *labelTitle;
@property (nonatomic,strong) IBOutlet UIImageView *imageThumbView;
@property (nonatomic,strong) IBOutlet HCSStarRatingView *ratingCoachView;
@property (nonatomic,strong) IBOutlet UILabel *labelPriceView;
@property (nonatomic,strong) IBOutlet UILabel *labelDescriptionView;

@property (nonatomic,strong) IBOutlet UILabel *labelCoachNameView;

@property (nonatomic,strong) IBOutlet UILabel *labelGameRankingView;
@property (weak, nonatomic) IBOutlet UILabel *tvCount;

@property (nonatomic,strong) IBOutlet UIImageView *imageRankView;
@property (weak, nonatomic) IBOutlet BorderedView *borderedView;

@property (nonatomic,strong) IBOutlet UIImageView *imageHeroOneView;
@property (nonatomic,strong) IBOutlet UIImageView *imageHeroTwoView;
@property (nonatomic,strong) IBOutlet UIImageView *imageHeroThreeView;
@property (nonatomic,strong) IBOutlet UIImageView *imageHeroFourView;
@property (nonatomic,strong) IBOutlet UIImageView *imageHeroFiveView;
@end

