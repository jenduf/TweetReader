//
//  TweetsViewController.m
//  TweetReader
//
//  Created by Jennifer Duffey on 7/19/13.
//  Copyright (c) 2013 Jennifer Duffey. All rights reserved.
//

#import "TweetsViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "TweetsTableViewController.h"
#import "ShareCardView.h"
#import <MessageUI/MessageUI.h>
#import "MBProgressHUD.h"

@interface TweetsViewController ()
<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, ShareCardViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (strong, nonatomic) UISearchBar *tweetsSearchBar;
@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, strong) TweetsTableViewController *tableViewController;
@property (nonatomic, strong) Tweet *selectedTweet;
@property (nonatomic, assign) BOOL showingShareScreen;

@end

@implementation TweetsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // initialize our data array
    self.tweets = [[NSMutableArray alloc] init];
    
    // initialize table view controller and add to view
    self.tableViewController = [[TweetsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.tableViewController.tableView.delegate = self;
    self.tableViewController.tableView.dataSource = self;

    // only set refresh control if os is 6.0 or greater
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    // initialize refresh control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableViewController setRefreshControl:refreshControl];
#endif
    
    
    [self.view addSubview:self.tableViewController.view];
    [self.tableViewController.view setFrame:CGRectMake(0, SEARCHBAR_HEIGHT, self.view.width, self.view.height - SEARCHBAR_HEIGHT)];

    // add overlay image to view
    UIImageView *overlayView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"overlay"]];
    [self.view addSubview:overlayView];
    
    // initialize the search bar and add to view
    self.tweetsSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, SEARCHBAR_HEIGHT)];
    self.tweetsSearchBar.delegate = self;
    [self.tweetsSearchBar setBarStyle:UIBarStyleBlackTranslucent];
    self.tweetsSearchBar.text = DEFAULT_SEARCH_TERM;
    
    [self.view addSubview:self.tweetsSearchBar];
    
    // retrieve the data
    [self refresh:nil];
}

- (void)refresh:(id)sender
{
    [self getTweetsForUser:self.tweetsSearchBar.text];
}

- (void)getTweetsForUser:(NSString *)userName
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *newURL = [NSString stringWithFormat:kSearchURL, userName];
    
    // load the data
    dispatch_async(kBGQueue, ^
    {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:newURL]];
                       
        [self performSelectorOnMainThread:@selector(dataRetrieved:) withObject:data waitUntilDone:YES];
    });
    
    //SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:screenName] parameters:nil];
    
    /*  [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
     {
     NSString *output;
     
     NSLog(@"in handler block");
     
     if([urlResponse statusCode] == 200)
     {
     // deserialize JSON data
     NSError *error = nil;
     
     NSDictionary *tweetsDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
     
     output = [NSString stringWithFormat:@"HTTP response status: %i\nPublic timeline: \n%@", [urlResponse statusCode], tweetsDictionary];
     }
     else
     {
     output = [NSString stringWithFormat:@"No feed: HTTP Response was: %i\n", [urlResponse statusCode]];
     }
     
     NSLog(@"Output: %@", output);
     
     }];
     
     */
}

- (void)dataRetrieved:(NSData *)data
{
    // remove all the previous tweets
    [self.tweets removeAllObjects];
    
    // temp tweet holder for pre-filtered data
    NSMutableArray *tempTweetArray = [NSMutableArray array];
    
    // parse the data
    
    if(data)
    {
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        NSDictionary *feedData = json[@"data"];
        
        NSArray *childArray = feedData[@"children"];
        
        for(NSDictionary *dict in childArray)
        {
            NSDictionary *dataDict = dict[@"data"];
            
            if(dataDict)
            {
                Tweet *tweet = [[Tweet alloc] initWithDictionary:dataDict];
                [tempTweetArray addObject:tweet];
            }
        }
        
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"created" ascending:NO];
        
        [self.tweets addObjectsFromArray:[tempTweetArray sortedArrayUsingDescriptors:@[sortDescriptor]]];
        
        [self.tableViewController setDataProvider:self.tweets];
    }
    
   [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

- (void)showShareCard
{
    // dim background with provided image
    UIImage *dimImage = [UIImage imageNamed:@"dimmer"];
    UIImageView *dimImageView = [[UIImageView alloc] initWithImage:dimImage];
    [dimImageView setHeight:APP_HEIGHT];
    dimImageView.tag = DIMMER_TAG;
    dimImageView.alpha = 0.0;
    [self.view addSubview:dimImageView];
    
    //self.tableViewController.tableView.alpha = 0.5;
    
    // create and add share card to view
    ShareCardView *shareCardView = [[ShareCardView alloc] initWithFrame:CGRectMake(APP_WIDTH, APP_HEIGHT, SHARE_CARD_WIDTH, SHARE_CARD_HEIGHT)];
    shareCardView.delegate = self;
    [self.view addSubview:shareCardView];
    
    // animate dimmer to be visible
    [UIView animateWithDuration:0.4 animations:^
    {
        dimImageView.alpha = 1.0;
    }];
    
    // animate share card onto screen
    [UIView animateWithDuration:0.4 delay:0.2 options:0 animations:^
     {
         [shareCardView centerInSuperView];
     }
    completion:^(BOOL finished)
     {
         
     }];
    
    self.showingShareScreen = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.tweets.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Tweet *tweet = self.tweets[indexPath.row];
    
    UIFont *postFont = [UIFont systemFontOfSize:FONT_SIZE_TWEET];
    
    CGSize sizeConstraint = CGSizeMake(TEXT_MAX_WIDTH, TEXT_MAX_HEIGHT);
    
    CGSize newSize = [tweet.message sizeWithFont:postFont constrainedToSize:sizeConstraint lineBreakMode:NSLineBreakByWordWrapping];
    
    NSLog(@"New Size: %@", NSStringFromCGSize(newSize));
    
    return MAX(tableView.rowHeight, (newSize.height + TWEET_PADDING));
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetCell *cell = (TweetCell *)[tableView dequeueReusableCellWithIdentifier:TWEET_CELL_IDENTIFIER];
    
    if(!cell)
    {
        cell = [[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TWEET_CELL_IDENTIFIER];
    }
    
    Tweet *tweet = self.tweets[indexPath.row];
    
    [cell setTweet:tweet];
    
	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedTweet = self.tweets[indexPath.row];
    
    if(!self.showingShareScreen)
        [self showShareCard];
}

#pragma mark -
#pragma mark UISearchBar Delegate Methods
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self getTweetsForUser:searchBar.text];
    
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - 
#pragma mark ShareCardView Delegate Methods
- (void)shareCardViewDidRequestClose:(ShareCardView *)shareCardView
{
    UIView *dimView = [self.view viewWithTag:DIMMER_TAG];
    
    // animate dimmer to be invisible
    [UIView animateWithDuration:0.4 delay:0.0 options:0 animations:^
     {
         dimView.alpha = 0.0;
     }
     completion:^(BOOL finished)
     {
         [dimView removeFromSuperview];
     }];
    
    self.showingShareScreen = NO;
}

- (void)shareCardViewDidRequestEmail:(ShareCardView *)shareCardView
{
    // check to ensure device can send mail
    if([MFMailComposeViewController canSendMail])
    {
        // Email Subject
        NSString *emailSubject = @"check out this epic tweet!";
        
        // initialize mail compose controller and populate
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        mailController.mailComposeDelegate = self;
        [mailController setSubject:emailSubject];
        [mailController setMessageBody:self.selectedTweet.message isHTML:NO];
        
        // show mail controller
        [self presentViewController:mailController animated:YES completion:NULL];
    }
    else
    {
        UIAlertView *alertView = [Utils createAlertWithTitle:@"Message Status" message:@"Your device cannot send e-mail" andDelegate:nil];
        [alertView show];
    }
}

- (void)shareCardViewDidRequestSMS:(ShareCardView *)shareCardView
{
    // check to ensure device can send texts
    if([MFMessageComposeViewController canSendText])
    {
        // initialize message compose controller and populate
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
        messageController.messageComposeDelegate = self;
        [messageController setBody:self.selectedTweet.message];
        
        // show mail controller
        [self presentViewController:messageController animated:YES completion:NULL];
    }
    else
    {
        UIAlertView *alertView = [Utils createAlertWithTitle:@"Message Status" message:@"Your device cannot send SMS messages" andDelegate:nil];
        [alertView show];
    }
}

#pragma mark -
#pragma mark MailComposeViewController Delegate Methods
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    UIAlertView *alertView;
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            alertView = [Utils createAlertWithTitle:@"Message Status" message:@"Your e-mail has been cancelled" andDelegate:nil];
            break;
            
        case MFMailComposeResultSaved:
            alertView = [Utils createAlertWithTitle:@"Message Status" message:@"Your e-mail has been saved" andDelegate:nil];
            break;
            
        case MFMailComposeResultSent:
            alertView = [Utils createAlertWithTitle:@"Message Status" message:@"Your e-mail has been sent" andDelegate:nil];
            break;
            
        case MFMailComposeResultFailed:
            alertView = [Utils createAlertWithTitle:@"Message Status" message:@"Your e-mail could not be sent" andDelegate:nil];
            NSLog(@"Error: %@", [error localizedDescription]);
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:^
    {
        [alertView show];
    }];
}

#pragma mark -
#pragma mark MessageComposeViewController Delegate Methods
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    UIAlertView *alertView;
    
    switch (result)
    {
        case MessageComposeResultCancelled:
            alertView = [Utils createAlertWithTitle:@"Message Status" message:@"Your e-mail has been cancelled" andDelegate:nil];
            break;
            
        case MessageComposeResultSent:
            alertView = [Utils createAlertWithTitle:@"Message Status" message:@"Your message has been sent" andDelegate:nil];
            break;
            
        case MessageComposeResultFailed:
            alertView = [Utils createAlertWithTitle:@"Message Status" message:@"Your message could not be sent" andDelegate:nil];
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:^
     {
         [alertView show];
     }];
}

@end
