//
//  CharactersTableViewController.m
//  GameOfThrones
//
//  Created by Spencer McWilliams on 4/23/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "CharactersTableViewController.h"

@interface CharactersTableViewController ()
@property (nonatomic, strong) NSArray *infoList;
@end

@implementation CharactersTableViewController
- (NSArray *)infoList
{
    if (!_infoList) {
        _infoList = [[NSArray alloc] init];
        _infoList = [WikiFetcher characterList];
    }
    return _infoList;
}
@end
