//
//  NetworkActivityTracker.h
//  ChartToppers
//
//  Created by Spencer McWilliams on 4/8/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkActivityTracker : NSObject

+ (NetworkActivityTracker *)sharedInstance;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;

@end