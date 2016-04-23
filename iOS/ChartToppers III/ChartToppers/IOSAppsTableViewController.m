//
//  IOSAppsTableViewController.m
//  ChartToppers
//
//  Created by Spencer McWilliams on 3/28/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "IOSAppsTableViewController.h"
#import "ITunesFetcher.h"

@interface IOSAppsTableViewController ()
@property (nonatomic, strong) NSArray *array;
@end

@implementation IOSAppsTableViewController

- (NSArray *) array{
    if (!_array) {
        _array = [ITunesFetcher topFreeApps];
    }
    return _array;
}

@end
