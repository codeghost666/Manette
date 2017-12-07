//
//  DetailViewController.m
//  Manette
//
//  Created by Kiosk on 11/26/17.
//  Copyright © 2017 Kiosk. All rights reserved.
//

#import "DetailViewController.h"
#import <AFNetworking.h>
#import <AFOAuth2Manager.h>
#import "GlobalPool.h"
#import <SVProgressHUD.h>

#define kGreenColor [UIColor colorWithRed:83.0/255.0 green:190.0/255.0 blue:73.0/255.0 alpha:1]
#define kDGreenColor [UIColor colorWithRed:26.0/255.0 green:110.0/255.0 blue:76.0/255.0 alpha:1]

@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *resultsArray;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
        
    [self performSelector:@selector(loadData)];
    
    
    
    self.stackContentView.backgroundColor = kDGreenColor;
    
    self.mTableView.layer.cornerRadius = 6;
    self.mTableView.clipsToBounds = YES;
    
    self.contentView.layer.cornerRadius = 6;
    self.contentView.clipsToBounds = YES;

    
    self.titleLbl.text = self.screenName;
    self.titleLbl.layer.cornerRadius = self.titleLbl.frame.size.height/2;
    self.titleLbl.clipsToBounds = YES;
    
    self.mTableView.dataSource = self;
    self.mTableView.delegate = self;
    
    self.contentView.backgroundColor = kDGreenColor;
    self.mTableView.backgroundColor = kDGreenColor;
//    self.presentationBtn.layer.cornerRadius = 6;
//    self.presentationBtn.layer.borderWidth = 5;
//    self.presentationBtn.layer.borderColor = kGreenColor.CGColor;
    
    
    // Do any additional setup after loading the view.
}

- (void) loadData {
    
    [SVProgressHUD showWithStatus:@"Fetching..."];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager.requestSerializer setAuthorizationHeaderFieldWithCredential:[GlobalPool sharedInstance].credential];
    [manager GET:@"https://citymeo.fr/api/management/v2/ads/"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"Success: %@", responseObject);
             resultsArray = [responseObject objectForKey:@"results"];
             [SVProgressHUD dismiss];
             [self.mTableView reloadData];
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Failure: %@", error);
             [SVProgressHUD dismiss];

             [SVProgressHUD showErrorWithStatus:@""];
         }];
    
    // id = "d530ce3c-3034-4c72-930c-603ad3ea9b3c";
}

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return resultsArray.count;    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    NSDictionary *dict = [resultsArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor  ];
    cell.textLabel.text = dict[@"name"];
    cell.textLabel.font = [UIFont fontWithName:@"Futura-Light" size:20];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
