//
//  NetworkActivityIndicator.h
//  Switchfit
//
//  Created by Brendan Mcmahon on 9/10/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkActivityTracker : NSObject

+ (NetworkActivityTracker *)sharedInstance;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;

@end