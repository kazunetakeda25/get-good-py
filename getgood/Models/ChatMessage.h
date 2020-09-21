//
//  ChatMessage.h
//  getgood
//
//  Created by Md Aminuzzaman on 23/12/17.
//  Copyright © 2017 PH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatMessage : NSObject

@property (nonatomic,strong) NSString *messageText;
@property (nonatomic,strong) NSString *userId;

@property (nonatomic,strong) NSNumber *state;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *dialogId;
@property (nonatomic,strong) NSNumber *Timestamp;

-(id) initWithDictionary: (NSDictionary*) dictionary;

-(void) write;

- (NSDictionary *) dictionaryValue;
@end

