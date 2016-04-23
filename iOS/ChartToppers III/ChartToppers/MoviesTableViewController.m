//
//  MoviesTableViewController.m
//  ChartToppers
//
//  Created by Spencer McWilliams on 3/28/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "MoviesTableViewController.h"
#import "ITunesFetcher.h"

@interface MoviesTableViewController ()
@property (nonatomic, strong) NSArray *array;
@end

@implementation MoviesTableViewController

- (NSArray *) array{
    if (!_array) {
        _array = [ITunesFetcher topMovies];
    }
    return _array;
}

@end
