//
//  GetGood_Lesson.h
//  getgood
//
//  Created by Dan on 5/3/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface GetGood_Lesson : NSObject
-(id)initWithDictionary: (NSDictionary*) dictionary;

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* getgood_description;
@property (nonatomic, strong) NSString* hero;
@property (nonatomic, assign) int hero_count;
@property (nonatomic, assign) bool inactive;
@property (nonatomic, assign) float price;
@property (nonatomic, strong) NSString* owner_id;
@property (nonatomic, strong) NSString* server;
@property (nonatomic, strong) NSString* thumb_url;
@property (nonatomic, strong) NSString* videos;
@property (nonatomic, strong) NSString* ready;

@property (nonatomic, strong) User* owner;

@end
