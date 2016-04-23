//
//  TVEpisodesTableViewController.m
//  ChartToppers
//
//  Created by Spencer McWilliams on 3/28/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "TVEpisodesTableViewController.h"
#import "ITunesFetcher.h"

@interface TVEpisodesTableViewController ()
@property (nonatomic, strong) NSArray *array;
@end

@implementation TVEpisodesTableViewController

- (NSArray *) array{
    if (!_array) {
        _array = [ITunesFetcher topTVEpisodes];
    }
    return _array;
}

@end
