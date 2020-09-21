//
//  Comment.h
//  getgood
//
//  Created by Bhargav Mistri on 27/02/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property (nonatomic,strong) NSString *Comment;
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *ThreadID;
@property (nonatomic,strong) NSString *UserID;
@property (nonatomic,strong) NSString *Reference;

@property (nonatomic,strong) NSArray *arReplys;

-(id)initWithDictionary: (NSDictionary*) dictionary;
-(id) initWithComment: (NSString*) _comment thread:(NSString*) _threadID reference: (NSString*) _reference;
-(void) write;
- (NSDictionary *) dictionaryValue;

+ (void) loadReplyComments:(NSString*) ReferenceID callBack:(void (^)(NSArray*)) callback;
+ (void) loadComments:(NSString*) threadID callBack:(void (^)(NSArray*)) callback;

@end
