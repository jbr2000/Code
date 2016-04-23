//
//  MemesAlbumsListTableViewController.m
//  theCHIVE
//
//  Created by Spencer McWilliams on 5/13/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "MemesAlbumsListTableViewController.h"

@interface MemesAlbumsListTableViewController ()
@property (nonatomic, strong) NSDictionary *albumsAttributesDictionary;
@end

@implementation MemesAlbumsListTableViewController

- (NSDictionary *)albumsAttributesDictionary
{
    if (!_albumsAttributesDictionary) {
        _albumsAttributesDictionary = [[NSDictionary alloc] init];
        _albumsAttributesDictionary = [ChiveFetcher memesAlbumsAttributes];
    }
    return _albumsAttributesDictionary;
}

@end
