//
//  AlbumsTableViewController.m
//  ChartToppers
//
//  Created by Spencer McWilliams on 3/28/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "AlbumsTableViewController.h"
#import "ITunesFetcher.h"

@interface AlbumsTableViewController ()
@property (nonatomic, strong) NSArray *array;
@end

@implementation AlbumsTableViewController

- (NSArray *) array{
    if (!_array) {
        _array = [ITunesFetcher topAlbums];
    }
    return _array;
}

@end
