//
//  FavoritesTableViewController.m
//  ChartToppers
//
//  Created by Spencer McWilliams on 4/18/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "FavoritesTableViewController.h"
#import "FavoritesManager.h"

@interface FavoritesTableViewController ()
@property (nonatomic, weak) NSArray *array;
@end

@implementation FavoritesTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    _array = nil;
    [self array];
    [self.tableView reloadData];
}

- (NSArray *)array
{
    if (!_array) {
        _array = [[FavoritesManager sharedInstance] allFavorites];
    }
    
    return _array;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[[FavoritesManager sharedInstance] allFavorites] isEqual: @[]]) {
        return 0;
    }
    return [[[FavoritesManager sharedInstance] allFavorites] count];
}

@end
