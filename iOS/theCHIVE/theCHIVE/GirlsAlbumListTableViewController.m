//
//  GirlsAlbumListTableViewController.m
//  theCHIVE
//
//  Created by Spencer McWilliams on 5/9/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "GirlsAlbumListTableViewController.h"

@interface GirlsAlbumListTableViewController ()
@property (nonatomic, strong) NSDictionary *albumsAttributesDictionary;
@end

@implementation GirlsAlbumListTableViewController

- (NSDictionary *)albumsAttributesDictionary
{
    if (!_albumsAttributesDictionary) {
        _albumsAttributesDictionary = [[NSDictionary alloc] init];
        _albumsAttributesDictionary = [ChiveFetcher girlsAlbumsAttributes];
    }
    return _albumsAttributesDictionary;
}

@end
