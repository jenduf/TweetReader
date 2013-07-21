//
//  ShareCardView.m
//  TweetReader
//
//  Created by Jennifer Duffey on 7/20/13.
//  Copyright (c) 2013 Jennifer Duffey. All rights reserved.
//

#import "ShareCardView.h"

@implementation ShareCardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // add invisible close button
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setFrame:CGRectMake(CLOSE_BUTTON_X, CLOSE_BUTTON_Y, CLOSE_BUTTON_SIZE, CLOSE_BUTTON_SIZE)];
        [closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
        
        // add email button
        UIImage *emailImage = [UIImage imageNamed:@"email"];
        UIButton *emailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [emailButton setFrame:CGRectMake(HORIZONTAL_PADDING, EMAIL_BUTTON_Y, emailImage.size.width, emailImage.size.height)];
        [emailButton setBackgroundImage:emailImage forState:UIControlStateNormal];
        [emailButton addTarget:self action:@selector(sendEmail:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:emailButton];
        
        // add sms button
        UIImage *smsImage = [UIImage imageNamed:@"sms"];
        UIButton *smsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [smsButton setBackgroundImage:smsImage forState:UIControlStateNormal];
        [smsButton setFrame:CGRectMake(HORIZONTAL_PADDING, emailButton.bottom + (VERTICAL_PADDING * 2), smsImage.size.width, smsImage.size.height)];
        [smsButton addTarget:self action:@selector(sendSMS:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:smsButton];
    }
    
    return self;
}

- (void)close:(id)sender
{
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^
    {
        [self setOrigin:CGPointMake(APP_WIDTH, -self.height)];
    }
     completion:^(BOOL finished)
    {
        [self removeFromSuperview];
    }];
    
    [self.delegate shareCardViewDidRequestClose:self];
}

- (void)sendEmail:(id)sender
{
    [self.delegate shareCardViewDidRequestEmail:self];
}

- (void)sendSMS:(id)sender
{
    [self.delegate shareCardViewDidRequestSMS:self];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIImage *backgroundImage = [UIImage imageNamed:@"shareCard"];
	
    CGRect imageRect = CGRectMake(0, 0, self.width, self.height);
		CGContextSaveGState(context);
		
    // flip coordinates so image isn't drawn upside down
    CGContextTranslateCTM(context, 0.0f, CGRectGetHeight(rect));
    CGContextScaleCTM(context, 1.0f, -1.0f);
		
    CGContextDrawImage(context, imageRect, backgroundImage.CGImage);
    CGContextRestoreGState(context);
}


@end
