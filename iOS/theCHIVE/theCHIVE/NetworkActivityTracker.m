//
//  NetworkActivityTracker.m
//  ChartToppers
//
//  Created by Spencer McWilliams on 4/8/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "NetworkActivityTracker.h"

@interface NetworkActivityTracker()

@property (atomic) NSUInteger networkCounter;

@end

@implementation NetworkActivityTracker

+ (NetworkActivityTracker *)sharedInstance
{
    static NetworkActivityTracker *sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkActivityTracker alloc] init];
    });
    
    return sharedInstance;
}

- (void)showActivityIndicator
{
    self.networkCounter++;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)hideActivityIndicator
{
    self.networkCounter--;
    if (!self.networkCounter)
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
