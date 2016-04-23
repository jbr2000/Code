//
//  PhotosOfTheDayViewController.m
//  theCHIVE
//
//  Created by Spencer McWilliams on 5/16/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "RandomPhotosAlbumsListTableViewController.h"

@interface RandomPhotosAlbumsListTableViewController ()
@property (nonatomic, strong) NSDictionary *albumsAttributesDictionary;
@end

@implementation RandomPhotosAlbumsListTableViewController
- (NSDictionary *)albumsAttributesDictionary
{
    if (!_albumsAttributesDictionary) {
        _albumsAttributesDictionary = [[NSDictionary alloc] init];
        _albumsAttributesDictionary = [ChiveFetcher randomPhotosAlbumsAttributes];
    }
    return _albumsAttributesDictionary;
}

@end
