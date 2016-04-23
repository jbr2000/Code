//
//  BooksTableViewController.m
//  ChartToppers
//
//  Created by Spencer McWilliams on 3/28/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "BooksTableViewController.h"
#import "ITunesFetcher.h"

@interface BooksTableViewController ()
@property (nonatomic, strong) NSArray *array;
@end

@implementation BooksTableViewController

- (NSArray *) array{
    if (!_array) {
        _array = [ITunesFetcher topPaidBooks];
    }
    return _array;
}

@end
