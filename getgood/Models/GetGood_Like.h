//
//  GetGood_Dialog.h
//  getgood
//
//  Created by Dan on 5/7/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface GetGood_Like : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *data;

-(id)initWithDictionary: (NSDictionary*) dictionary;
@end
