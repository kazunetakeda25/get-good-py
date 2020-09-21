//
//  GetGood_Dialog.h
//  getgood
//
//  Created by Dan on 5/7/18.
//  Copyright © 2018 PH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface GetGood_AdminPost : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *post;
@property (nonatomic, strong) NSString *enabled;

-(id)initWithDictionary: (NSDictionary*) dictionary;
@end
