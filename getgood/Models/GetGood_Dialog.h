//
//  GetGood_Dialog.h
//  getgood
//
//  Created by Dan on 5/7/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetGood_Dialog : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *holder_id;
@property (nonatomic, strong) NSString *rec_id;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *reference_id;
@property (nonatomic, strong) NSString *inviter_id;
@property (nonatomic, strong) NSString *block_id;
@property (nonatomic, strong) NSString *timestamp;

-(id)initWithDictionary: (NSDictionary*) dictionary;
@end
