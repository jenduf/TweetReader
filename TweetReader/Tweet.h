//
//  Post.h
//  TweetReader
//
//  Created by Jennifer Duffey on 6/28/13.
//  Copyright (c) 2013 Jennifer Duffey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *thumbnail, *message, *author;
@property (nonatomic, strong) NSDate *created;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
