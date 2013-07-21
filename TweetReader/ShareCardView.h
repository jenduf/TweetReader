//
//  ShareCardView.h
//  TweetReader
//
//  Created by Jennifer Duffey on 7/20/13.
//  Copyright (c) 2013 Jennifer Duffey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareCardViewDelegate;

@interface ShareCardView : UIView

@property (nonatomic, weak) id <ShareCardViewDelegate> delegate;

@end

@protocol ShareCardViewDelegate

- (void)shareCardViewDidRequestClose:(ShareCardView *)shareCardView;
- (void)shareCardViewDidRequestEmail:(ShareCardView *)shareCardView;
- (void)shareCardViewDidRequestSMS:(ShareCardView *)shareCardView;

@end
