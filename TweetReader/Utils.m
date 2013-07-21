//
//  Utils.m
//  TweetReader
//
//  Created by Jennifer Duffey on 6/28/13.
//  Copyright (c) 2013 Jennifer Duffey. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString*) getResolutionSuffix
{
	if ([UIScreen mainScreen].scale == 2)
			return @"@2x";
		
    return @"";
}

+ (UIAlertView *)createAlertWithTitle:(NSString *)title message:(NSString *)message andDelegate:(id)del
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:del
                                          cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                          otherButtonTitles:nil];
    
    return alert;
}

@end
