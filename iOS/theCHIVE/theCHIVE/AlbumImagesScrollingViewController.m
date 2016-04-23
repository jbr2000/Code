//
//  AlbumImagesScrollingViewController.m
//  theCHIVE
//
//  Created by Spencer McWilliams on 5/13/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "AlbumImagesScrollingViewController.h"

@interface AlbumImagesScrollingViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction) unwindToCollectionViewController:(UIStoryboardSegue *)segue;
@end

@implementation AlbumImagesScrollingViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    dispatch_queue_t imageQ               = dispatch_queue_create("image queue", NULL);
    NSUInteger photoCount                 = self.album.numberOfPhotos;
    CGSize     viewableSize               = self.scrollView.frame.size;
    self.scrollView.contentSize           = CGSizeMake(viewableSize.width * photoCount, viewableSize.height);
    self.scrollView.contentOffset         = CGPointMake((viewableSize.width*self.startingIndex), 0);

    for (int i = 0; i < [self.album.albumImagesURLsArray count]; i++) {
        CGRect imageFrame = CGRectMake((i*viewableSize.width), 0, viewableSize.width, viewableSize.height);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageFrame];
        dispatch_async(imageQ, ^{
            if ([[self.album.albumImages objectAtIndex:i] isEqual:[NSNull null]]) {
                [self addImageToImagesArrayAtIndex:i];
            }
            imageView.image = [self.album.albumImages objectAtIndex:i];
        });
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:imageView];
    }
}

- (void)addImageToImagesArrayAtIndex:(NSUInteger)index
{
    [self.album.albumImages replaceObjectAtIndex:index withObject:[UIImage imageWithData:
                                                                   [NSData dataWithContentsOfURL:
                                                                    [self.album.albumImagesURLsArray objectAtIndex:index]]]];
}

- (IBAction) unwindToCollectionViewController:(UIStoryboardSegue *)segue
{
}

@end
