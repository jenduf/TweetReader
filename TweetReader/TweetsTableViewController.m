//
//  ViewController.m
//  TweetReader
//
//  Created by Jennifer Duffey on 6/28/13.
//  Copyright (c) 2013 Jennifer Duffey. All rights reserved.
//

#import "TweetsTableViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "ProfileImage.h"
#import "ShareCardView.h"

@interface TweetsTableViewController ()

@end

@implementation TweetsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // add background image
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"bg%@.jpg", [Utils getResolutionSuffix]]]];
    
    self.tableView.rowHeight = TABLE_ROW_HEIGHT;
}

- (void)setDataProvider:(NSArray *)dataProvider
{
    _dataProvider = dataProvider;

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    if([self.refreshControl isRefreshing])
        [self.refreshControl endRefreshing];
#endif
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
