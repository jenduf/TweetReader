//
//  AppDelegate.h
//  TweetReader
//
//  Created by Jennifer Duffey on 6/28/13.
//  Copyright (c) 2013 Jennifer Duffey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TweetsTableViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TweetsTableViewController *readerViewController;

@end
