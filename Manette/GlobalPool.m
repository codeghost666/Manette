//
//  GlobalPool.m
//  CitySavings
//
//  Created by Nicholas Lam on 10/19/16.
//  Copyright © 2016 Valrick. All rights reserved.
//

#import "GlobalPool.h"

@implementation GlobalPool
+(GlobalPool *) sharedInstance{
    static GlobalPool *sharedInstance = nil;
    
    if (!sharedInstance) {
        
        sharedInstance = [[super allocWithZone:nil] init
                        ];
    }
    return sharedInstance;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    
    return [self sharedInstance];
}

-(id)init{
    
    self = [super init];
    if (self) {

    }
    
    return self;
}


@end
