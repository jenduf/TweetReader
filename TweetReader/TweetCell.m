//
//  ReaderCell.m
//  TweetReader
//
//  Created by Jennifer Duffey on 6/28/13.
//  Copyright (c) 2013 Jennifer Duffey. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "ProfileImage.h"

@implementation TweetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
   
    if (self)
    {
        
        self.backgroundColor = [UIColor clearColor];
        
        // initialize profile pic and add to content view
        self.avatarImage = [[ProfileImage alloc] initWithFrame:CGRectMake(CELL_PADDING, CELL_PADDING, CELL_IMAGE_SIZE, CELL_IMAGE_SIZE)];
        [self.contentView addSubview:self.avatarImage];
        
        // initialize user name label with custom font
        // and add to content view
        self.userName = [[UILabel alloc] initWithFrame:CGRectMake(CELL_LABEL_X, CELL_PADDING, self.width - CELL_PADDING, LABEL_HEIGHT)];
        self.userName.backgroundColor = [UIColor clearColor];
        self.userName.font = [UIFont tweetFontOfSize:FONT_SIZE_TITLE];
        self.userName.textColor = [UIColor colorWithRed:96.0/255.0 green:221.0/255.0 blue:244.0/255.0 alpha:1.0];
        [self.contentView addSubview:self.userName];
        
        // initialize user tweet label and add to content view
        self.userText = [[UILabel alloc] initWithFrame:CGRectMake(CELL_LABEL_X, self.userName.bottom + CELL_PADDING, TEXT_MAX_WIDTH, SEARCHBAR_HEIGHT)];
        self.userText.numberOfLines = 0;
        self.userText.lineBreakMode = NSLineBreakByWordWrapping;
        self.userText.backgroundColor = [UIColor clearColor];
        self.userText.font = [UIFont systemFontOfSize:FONT_SIZE_TWEET];
        self.userText.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.userText];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        
    }
    
    return self;
}

- (void)setTweet:(Tweet *)tweet
{
    _tweet = tweet;
    
    // populate view with tweet data
    [self.avatarImage setPictureURL:tweet.thumbnail];
    
    self.userName.text = [NSString stringWithFormat:@"@%@", tweet.author];
    
    self.userText.text = tweet.message;
    
    // update height of cell based on content
    UIFont *postFont = [UIFont systemFontOfSize:FONT_SIZE_TWEET];
    
    CGSize sizeConstraint = CGSizeMake(TEXT_MAX_WIDTH, TEXT_MAX_HEIGHT);
    
    CGSize newSize = [tweet.message sizeWithFont:postFont constrainedToSize:sizeConstraint lineBreakMode:NSLineBreakByWordWrapping];
    
    self.userText.height = newSize.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
