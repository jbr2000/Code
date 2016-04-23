//
//  AlbumImagesPageViewController.h
//  theCHIVE
//
//  Created by Spencer McWilliams on 5/15/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"

@interface AlbumImagesPageViewController : UIViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic, strong) Album                *album;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic)         NSUInteger            initialIndex;
@end
