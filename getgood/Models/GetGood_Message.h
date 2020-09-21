//
//  GetGood_Message.h
//  getgood
//
//  Created by Dan on 5/8/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetGood_Message : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *dialog_id;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatar_url;


-(id)initWithDictionary: (NSDictionary*) dictionary;
@end
