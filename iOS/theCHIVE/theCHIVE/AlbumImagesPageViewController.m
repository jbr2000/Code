//
//  AlbumImagesPageViewController.m
//  theCHIVE
//
//  Created by Spencer McWilliams on 5/15/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "NetworkActivityTracker.h"

#import "AlbumImagesPageViewController.h"
#import "ImageViewController.h"

@interface AlbumImagesPageViewController ()
@property (atomic, strong) NSOperationQueue *imageQueue;
@end

@implementation AlbumImagesPageViewController

#pragma mark - View LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageQueue = [[NSOperationQueue alloc] init];
    
    //Check for missing pictures in the album.albumImages
//    for (int i = 0; i < [self.album.albumImages count]; i++) {
//        if ([[self.album.albumImages objectAtIndex:i] isEqual:[NSNull null]]) {
//            [[NetworkActivityTracker sharedInstance] showActivityIndicator];
//            [self.imageQueue addOperationWithBlock:^{
//                [self addImageToAlbumImagesAtIndex:i];
//                [[NetworkActivityTracker sharedInstance] hideActivityIndicator];
//            }];
//        }
//    }
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:@{UIPageViewControllerOptionInterPageSpacingKey: @20.f}];
    
    //Setting the PVC delegate
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    //Kick off the first page based off the index of the selected cell
    ImageViewController *pageZero = [[ImageViewController alloc] init];
    pageZero.image = [self.album.albumImages objectAtIndex:self.initialIndex];
    [self.pageViewController setViewCovntrollers:@[pageZero]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:NULL];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    //    [self.pageViewController didMoveToParentViewController:self];
    
    CGRect pageViewRect = self.view.bounds;
    self.pageViewController.view.frame = pageViewRect;
    
    //    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
}



#pragma mark - Instance Methods
- (void)addImageToAlbumImagesAtIndex:(NSUInteger)index
{
    [NSThread sleepForTimeInterval:3];
    [self.album.albumImages replaceObjectAtIndex:index withObject:[UIImage imageWithData:
                                                                   [NSData dataWithContentsOfURL:
                                                                    [self.album.albumImagesURLsArray objectAtIndex:index]]]];
}



#pragma mark - UIPageViewController Delegate Methods
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(ImageViewController *)viewController
{
    NSInteger currentIndex = [self.album.albumImages indexOfObject:[(ImageViewController *)viewController image]];
    if (currentIndex > 0 && currentIndex < [self.album.albumImages count]) {
        ImageViewController *newImageViewController = [[ImageViewController alloc] init];
        if ([[self.album.albumImages objectAtIndex:currentIndex-1] isEqual:[NSNull null]]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self addImageToAlbumImagesAtIndex:currentIndex-1];
            });
            return nil;
        }
        else
            newImageViewController.image = [self.album.albumImages objectAtIndex:currentIndex-1];
        return newImageViewController;
    }
    else
        return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger currentIndex = [self.album.albumImages indexOfObject:[(ImageViewController *)viewController image]];
    if (currentIndex >= 0 && currentIndex < [self.album.albumImages count]-1) {
        ImageViewController *newImageViewController = [[ImageViewController alloc] init];
        if ([[self.album.albumImages objectAtIndex:currentIndex+1] isEqual:[NSNull null]]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self addImageToAlbumImagesAtIndex:currentIndex+1];
            });
            return nil;
        }
        else
            newImageViewController.image = [self.album.albumImages objectAtIndex:currentIndex+1];
        return newImageViewController;
    }
    else
        return nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}




@end
