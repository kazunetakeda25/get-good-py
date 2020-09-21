//
//  Thread.h
//  getgood
//
//  Created by Bhargav Mistri on 27/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Comment.h"

@interface Thread : NSObject

@property (nonatomic,strong) NSString *AvatarUrl;
@property (nonatomic,strong) NSNumber *Blocked;
@property (nonatomic,strong) NSString *Description;
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSNumber *Timestamp;
@property (nonatomic,strong) NSString *Title;

@property (nonatomic,strong) NSString *UserID;
@property (nonatomic,strong) NSString *UserName;

-(id)initWithDictionary: (NSDictionary*) dictionary;
-(id) initWithTitle:(NSString*) title description: (NSString*) desc;

- (NSDictionary *) dictionaryValue;
- (void) write;

+ (void) loadThread:(int) nPage callBack:(void (^)(NSArray*)) callback;
+ (void) loadMyThread:(void (^)(NSArray*)) callback;

@end
