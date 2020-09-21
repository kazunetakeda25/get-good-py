//
//  GroupChatMessage.h
//  getgood
//
//  Created by Bhargav Mistri on 01/03/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupChatMessage : NSObject

@property (nonatomic,strong) NSString *MessageText;
@property (nonatomic,strong) NSString *UserID;
@property (nonatomic,strong) NSString *GroupID;
@property (nonatomic,strong) NSNumber *State;
@property (nonatomic,strong) NSNumber *Timestamp;
@property (nonatomic,strong) NSString *AvatarUrl;

-(id) initWithDictionary: (NSDictionary*) dictionary;

-(void) write;

- (NSDictionary *) dictionaryValue;

@end
