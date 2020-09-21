//
//  GetGood_PlayerRate.h
//  getgood
//
//  Created by Dan on 5/21/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetGood_PlayerRate : NSObject

@property (nonatomic, strong) NSString* id;
@property (nonatomic, assign) int leader;
@property (nonatomic, assign) int cooperative;
@property (nonatomic, assign) int good_communication;
@property (nonatomic, assign) int sportsmanship;
@property (nonatomic, assign) int mvp;
@property (nonatomic, assign) int flex_player;
@property (nonatomic, assign) int good_hero_competency;
@property (nonatomic, assign) int good_ultimate_usage;
@property (nonatomic, assign) int abusive_chat;
@property (nonatomic, assign) int griefing;
@property (nonatomic, assign) int spam;
@property (nonatomic, assign) int no_communication;
@property (nonatomic, assign) int un_cooperative;
@property (nonatomic, assign) int trickling_in;
@property (nonatomic, assign) int poor_hero_competency;
@property (nonatomic, assign) int bad_ultimate_usage;
@property (nonatomic, assign) int overextending;
@property (nonatomic, strong) NSString* comment;
@property (nonatomic, strong) NSString* name;


-(id)initWithDictionary: (NSDictionary*) dictionary;
@end
