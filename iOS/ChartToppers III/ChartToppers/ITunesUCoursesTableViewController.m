//
//  ITunesUCoursesTableViewController.m
//  ChartToppers
//
//  Created by Spencer McWilliams on 3/28/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "ITunesUCoursesTableViewController.h"
#import "ITunesFetcher.h"

@interface ITunesUCoursesTableViewController ()
@property (nonatomic, strong) NSArray *array;
@end

@implementation ITunesUCoursesTableViewController

- (NSArray *) array{
    if (!_array) {
        _array = [ITunesFetcher topITunesUCourses];
    }
    return _array;
}

@end
