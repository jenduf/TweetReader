//
//  ReaderCell.h
//  TweetReader
//
//  Created by Jennifer Duffey on 6/28/13.
//  Copyright (c) 2013 Jennifer Duffey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tweet, ProfileImage;
@interface TweetCell : UITableViewCell

@property (nonatomic, strong) UILabel *userName, *userText, *dateCreated;
@property (nonatomic, strong) ProfileImage *avatarImage;

@property (nonatomic, strong) Tweet *tweet;

@end
