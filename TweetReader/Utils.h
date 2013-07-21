//
//  Utils.h
//  TweetReader
//
//  Created by Jennifer Duffey on 6/28/13.
//  Copyright (c) 2013 Jennifer Duffey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (NSString *)getResolutionSuffix;
+ (UIAlertView *)createAlertWithTitle:(NSString *)title message:(NSString *)message andDelegate:(id)del;

@end
