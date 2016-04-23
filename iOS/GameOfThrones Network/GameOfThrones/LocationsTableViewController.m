//
//  LocationsTableViewController.m
//  GameOfThrones
//
//  Created by Spencer McWilliams on 5/1/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "LocationsTableViewController.h"
#import "WikiFetcher.h"

@interface LocationsTableViewController ()
@property (nonatomic, strong) NSArray *infoList;
@end

@implementation LocationsTableViewController

- (NSArray *)infoList
{
    if (!_infoList) {
        _infoList = [[NSArray alloc] init];
        _infoList = [WikiFetcher locationsList];
    }
    return _infoList;
}

@end
