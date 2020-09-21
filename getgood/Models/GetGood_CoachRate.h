//
//  GetGood_CoachRate.h
//  getgood
//
//  Created by Dan on 5/20/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetGood_CoachRate : NSObject

@property (nonatomic, strong) NSString* id;
@property (nonatomic, assign) float competency;
@property (nonatomic, assign) float communication;
@property (nonatomic, assign) float flexibility;
@property (nonatomic, assign) float attitude;
@property (nonatomic, strong) NSString* comment;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* avatar_url;


-(id)initWithDictionary: (NSDictionary*) dictionary;
@end
