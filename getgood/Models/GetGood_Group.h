//
//  GetGood_Group.h
//  getgood
//
//  Created by Dan on 5/3/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface GetGood_Group : NSObject

-(id)initWithDictionary: (NSDictionary*) dictionary;

@property (nonatomic, strong) NSString *id;
@property (nonatomic, assign) int average_game_rating;
@property (nonatomic, assign) float average_player_rating;
@property (nonatomic, strong) NSString* getgood_description;
@property (nonatomic, strong) NSString* hero;
@property (nonatomic, assign) int hero_count;
@property (nonatomic, assign) bool inactive;
@property (nonatomic, strong) NSString* owner_id;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* users;
@property (nonatomic, strong) NSString* pending_users;
@property (nonatomic, strong) NSString* ready;
@property (nonatomic, strong) NSString* timestamp;

@property (nonatomic, strong) User* owner;

@end
