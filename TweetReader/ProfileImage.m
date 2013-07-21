//
//  AvatarImage.m
//  TweetReader
//
//  Created by Jennifer Duffey on 6/28/13.
//  Copyright (c) 2013 Jennifer Duffey. All rights reserved.
//

#import "ProfileImage.h"
#import "UIImageView+AFNetworking.h"

@implementation ProfileImage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setPictureURL:(NSString *)pictureURL
{
    _pictureURL = pictureURL;
    
    self.avatarImageView = [[UIImageView alloc] initWithFrame:self.frame];
    
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:pictureURL]];
    
    [self addSubview:self.avatarImageView];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    // to achieve a circle shape uncomment and use instead of corner radius
    /*UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, 2, 2)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFrame:self.bounds];
    [shapeLayer setPath:path.CGPath];
    [self.layer setMask:shapeLayer];*/
    
    // add a shadow
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(0, 2);
    layer.shadowRadius = 2.0;
    layer.shadowOpacity = 0.8;
    
    // make it rounded
    //layer.cornerRadius = 10;
    //layer.masksToBounds = YES;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}


@end
