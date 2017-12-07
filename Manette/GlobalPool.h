//
//  GlobalPool.h
//  CitySavings
//
//  Created by Nicholas Lam on 10/19/16.
//  Copyright © 2016 Valrick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AFNetworking.h>
#import <AFOAuth2Manager.h>

@interface GlobalPool : NSObject

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) AFOAuthCredential* credential;

+(GlobalPool *) sharedInstance;

@end
