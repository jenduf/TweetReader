//
//  Post.m
//  TweetReader
//
//  Created by Jennifer Duffey on 6/28/13.
//  Copyright (c) 2013 Jennifer Duffey. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if(self)
    {
        _message = dictionary[@"title"];
        _author = dictionary[@"author"];
        _thumbnail = dictionary[@"thumbnail"];
        _created = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"created"] intValue]];
    }
    
    return self;
}

@end
