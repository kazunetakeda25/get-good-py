//
//  GetGood_TraineeRate.h
//  getgood
//
//  Created by Dan on 5/21/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetGood_TraineeRate : NSObject

@property (nonatomic, strong) NSString* id;
@property (nonatomic, assign) float general;
@property (nonatomic, strong) NSString* comment;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* avatar_url;


-(id)initWithDictionary: (NSDictionary*) dictionary;
@end
