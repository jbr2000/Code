//
//  BattlesTableViewController.m
//  GameOfThrones
//
//  Created by Spencer McWilliams on 5/6/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "BattlesTableViewController.h"

@interface BattlesTableViewController ()
@property (nonatomic, strong) NSArray *infoList;
@end

@implementation BattlesTableViewController

- (NSArray *)infoList
{
    if (!_infoList) {
        _infoList = [[NSArray alloc] init];
        _infoList = [WikiFetcher battlesList];
    }
    return _infoList;
}

@end
