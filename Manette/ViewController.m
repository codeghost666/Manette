//
//  ViewController.m
//  Manette
//
//  Created by Kiosk on 11/26/17.
//  Copyright © 2017 Kiosk. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <AFOAuth2Manager.h>
#import "GlobalPool.h"
#import "DetailViewController.h"
#import <MBProgressHUD.h>
#import <SVProgressHUD.h>

#define kClientID @"yQHUPBoDBaoGgUrfcfuvLMeXzGchiBWOIGOpohx1"
#define kClientSecret @"LwWCmHLIz1EwPRMrN9pwiAVqKCaC5qejFApjqY5h4ERHpu1YTjE4fgWg0n7SgI2tl6ycWpLIk7CGfpc9Nfed6lBQ5UxSNbXH5WOvxuZhSpmX8nHRQiYxpoizZpg2mKcy"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];

    if ([[AFNetworkReachabilityManager sharedManager] isReachable])
    {
        [SVProgressHUD showErrorWithStatus:@"Network Connection Error"];
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:@"client_credentials" forKey:@"grant_type"];
    parameters[@"client_id"] = kClientID;
    parameters[@"client_secret"] = kClientSecret;
    
    __block AFOAuthCredential *credential;
    
    [SVProgressHUD showWithStatus:@"Authorizing"];
    [manager POST:@"https://citymeo.fr/api/oauth/token/" parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {

        NSLog(@"%@",responseObject);
        credential = [AFOAuthCredential credentialWithOAuthToken:responseObject[@"access_token"] tokenType:responseObject[@"token_type"]];
        [GlobalPool sharedInstance].credential = credential;
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"Can not authorize"];
        NSLog(@"OAuth2 Error: %@", error);
    
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController* destination = [segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"escren1"])
    {
        destination.screenName = @"ÉCRAN 1";
    }
    if ([[segue identifier] isEqualToString:@"escren2"])
    {
        destination.screenName = @"ÉCRAN 2";
    }
}

@end
