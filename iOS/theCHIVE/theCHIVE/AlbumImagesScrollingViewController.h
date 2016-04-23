//
//  AlbumImagesScrollingViewController.h
//  theCHIVE
//
//  Created by Spencer McWilliams on 5/13/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"

@interface AlbumImagesScrollingViewController : UIViewController
@property (nonatomic, strong) Album *album;
@property (nonatomic) NSInteger startingIndex;
@end
