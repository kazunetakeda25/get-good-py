//
//  GetGood_Dialog.h
//  getgood
//
//  Created by Dan on 5/7/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface GetGood_Thread : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *getgood_description;
@property (nonatomic, strong) NSString *owner_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatar_url;

-(id)initWithDictionary: (NSDictionary*) dictionary;
@end
