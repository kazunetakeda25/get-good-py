//
//  User.h
//  getgood
//
//  Created by Dan on 5/1/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject


-(id)initWithDictionary: (NSDictionary*) dictionary;

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL verified;
@property (nonatomic, strong) NSString *avatar_url;
@property (nonatomic, strong) NSString *getgood_description;
@property (nonatomic, strong) NSString *blizzard_id;
@property (nonatomic, assign) int hero_count;
@property (nonatomic, strong) NSString *join_date;
@property (nonatomic, assign) int overwatch_rank;
@property (nonatomic, strong) NSString *server;
@property (nonatomic, strong) NSString *overwatch_heroes;

@property (nonatomic, strong) NSString *ready;
@property (nonatomic, assign) int coach_review_count;
@property (nonatomic, assign) float coach_rating;
@property (nonatomic, assign) int trainee_review_count;
@property (nonatomic, assign) float trainee_rating;
@property (nonatomic, assign) int player_review_count;
@property (nonatomic, assign) float player_rating;

/* League Of Legends Values */

@property (nonatomic, strong) NSString *lol_ready;
@property (nonatomic, strong) NSString *lol_description;
@property (nonatomic, strong) NSString *lol_id;
@property (nonatomic, strong) NSString *lol_rank;
@property (nonatomic, strong) NSString *lol_heroes;
@property (nonatomic, strong) NSString *lol_category;
@property (nonatomic, assign) int lol_hero_count;
@property (nonatomic, strong) NSString *lol_server;


@property (nonatomic, assign) int lol_coach_review_count;
@property (nonatomic, assign) float lol_coach_rating;
@property (nonatomic, assign) int lol_trainee_review_count;
@property (nonatomic, assign) float lol_trainee_rating;
@property (nonatomic, assign) int lol_player_review_count;
@property (nonatomic, assign) float lol_player_rating;

- (void) formatHero;
@end
