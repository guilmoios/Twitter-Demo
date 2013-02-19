//
//  VCViewController.m
//  TwitterDemo
//
//  Created by Guilherme Mogames on 2/17/13.
//  Copyright (c) 2013 Mogames. All rights reserved.
//

#import "VCViewController.h"
#import <Twitter/Twitter.h>

@interface VCViewController ()

@end

@implementation VCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* ATTENTION: If you are using the simulator, don't forget to go to the Settings app and configure your twitter account.
 I know that recently, the twitter login in the 5.1 simulator was not working, so if you are not able to login in the 5.1 simulator, change to the new 6.1 that is working as it should */

- (IBAction)shareToTwitter:(id)sender {
    
    // Set the Twitter Class
    Class tweeterClass = NSClassFromString(@"TWTweetComposeViewController");
    
    if(tweeterClass != nil) {  // check for Twitter integration
        // check Twitter accessibility and at least one account is setup
        if([TWTweetComposeViewController canSendTweet]) {
            TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init]; // Init the Twitter Controller
            [tweetViewController setInitialText:@"I highly recommend checking out Guilmo.com website for the latest iOS development tips!"];
            [tweetViewController addURL:[NSURL URLWithString:@"http://www.guilmo.com"]];
            
            tweetViewController.completionHandler = ^(TWTweetComposeViewControllerResult result) {
                if(result == TWTweetComposeViewControllerResultDone) {
                    // the user finished composing a tweet
                    NSLog(@"Tweet Done!");
                } else if(result == TWTweetComposeViewControllerResultCancelled) {
                    // the user cancelled composing a tweet
                    NSLog(@"User cancelled Tweet");
                }
                // Hides the tweet controller
                [self dismissViewControllerAnimated:YES completion:nil];
            };
            // Shows the tweet box
            [self presentViewController:tweetViewController animated:YES completion:nil];
        } else {
            // Twitter is not accessible or the user has not setup an account in the Settings Apps
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"No twitter account setup or error connecting to twitter" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [ alert show ];
        }
    } else {
        // no Twitter integration; default to third-party Twitter framework
    }
    
}
@end
