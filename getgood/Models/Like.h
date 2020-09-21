//
//  Like.h
//  getgood
//
//  Created by Dan on 19/04/2018.
//  Copyright © 2018 PH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Like : NSObject

@property (nonatomic,strong) NSString *CommentID;
@property (nonatomic,strong) NSString *UserID;
@property (nonatomic,assign) NSNumber *Like;


-(id)initWithDictionary: (NSDictionary*) dictionary;
-(id) initWithComment: (NSString*) _commentID like:(NSNumber*) _like;

- (void) write:(void (^)(BOOL)) callback;
+ (void) loadLikes:(NSString*)commendID callback: (void (^)(NSMutableArray*)) callback;
@end
