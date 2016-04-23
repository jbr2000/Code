//
//  NetworkActivityIndicator.m
//  Switchfit
//
//  Created by Brendan Mcmahon on 9/10/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import "NetworkActivityIndicator.h"
@interface NetworkActivityTracker()
@property (nonatomic) NSInteger netCount;
@end
@implementation NetworkActivityTracker

- (void)showActivityIndicator
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.netCount++;
}
- (void)hideActivityIndicator
{
    self.netCount--;
    if(self.netCount == 0)
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}
+ (NetworkActivityTracker *)sharedInstance
{
    static NetworkActivityTracker *sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkActivityTracker alloc] init];
    });
    
    return sharedInstance;
}

@end
