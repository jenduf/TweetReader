//
//  Constants.h
//  TweetReader
//
//  Created by Jennifer Duffey on 6/28/13.
//  Copyright (c) 2013 Jennifer Duffey. All rights reserved.
//

#define kBGQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#define kSearchURL   @"http://www.reddit.com/r/%@/.json"

#define DEFAULT_SEARCH_TERM     @"funny"

#define TWEET_CELL_IDENTIFIER  @"TweetCellIdentifier"

#define DIMMER_TAG              100


// Fonts
#define FONT_SIZE_TWEET     12
#define FONT_SIZE_TITLE     18
#define FONT_BEBASNEUE       @"Bebas Neue"

// Layout
#define APP_WIDTH				[UIScreen mainScreen].applicationFrame.size.width
#define APP_HEIGHT				[UIScreen mainScreen].applicationFrame.size.height

#define TEXT_MAX_WIDTH              208
#define TEXT_MAX_HEIGHT             9999
#define CELL_PADDING                5
#define CELL_IMAGE_SIZE             70
#define TWEET_PADDING               35

#define CELL_LABEL_X                88
#define CELL_LABEL_PADDING          6

#define TABLE_ROW_HEIGHT            90

#define SHARE_CARD_WIDTH            283
#define SHARE_CARD_HEIGHT           201

#define CLOSE_BUTTON_X              250
#define CLOSE_BUTTON_Y              8
#define CLOSE_BUTTON_SIZE           24

#define EMAIL_BUTTON_Y              70

#define SEARCHBAR_HEIGHT            44

#define HORIZONTAL_PADDING          10
#define VERTICAL_PADDING            8

#define LABEL_HEIGHT                20


