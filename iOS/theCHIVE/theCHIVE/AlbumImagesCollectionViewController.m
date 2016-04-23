//
//  AlbumImagesCollectionViewViewController.m
//  theCHIVE
//
//  Created by Spencer McWilliams on 5/9/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "NetworkActivityTracker.h"

#import "AlbumsListTableViewController.h"

#import "AlbumImagesCollectionViewController.h"
#import "AlbumImagesCollectionViewCell.h"
#import "AlbumImagesCollectionViewReusableView.h"

#import "AlbumImagesPageViewController.h"

@interface AlbumImagesCollectionViewController ()
@property (atomic, strong) NSOperationQueue *imageQueue;
- (void) addImageToAlbumImagesAtIndex:(NSUInteger)index;
- (IBAction)shareButtonTapped:(UIBarButtonItem *)sender;
@end

@implementation AlbumImagesCollectionViewController

#pragma mark - View LifeCycle
- (void)viewDidLoad
{
    self.navigationItem.title = self.album.title;
    self.imageQueue           = [[NSOperationQueue alloc] init];

    // update cell when image loads!
    [self.album albumImages];
    for (int i=0; i<[self.album.albumImagesURLsArray count]; i++)
    {
        [self.imageQueue addOperationWithBlock:^{
            [self.album.albumImages replaceObjectAtIndex:i withObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[self.album.albumImagesURLsArray objectAtIndex:i]]]];
            //[self.album.albumImages insertObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[self.album.albumImagesURLsArray objectAtIndex:i]]] atIndex:i];
        }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"forward"]) {
        [self.imageQueue cancelAllOperations];
        AlbumImagesCollectionViewCell *cell = sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        AlbumImagesPageViewController *newViewController = segue.destinationViewController;
        newViewController.initialIndex = indexPath.item;
        newViewController.album = self.album;
    }
}



#pragma mark - Actions
- (IBAction)shareButtonTapped:(UIBarButtonItem *)sender
{
    NSArray                  *activityItems;
    UIActivityViewController *activityViewController;
    
    NSString *textToShare = self.album.title;
    UIImage *imageToShare = self.album.thumbnail;
    NSURL *urlToShare     = self.album.albumURL;
    
    activityItems          = @[textToShare, imageToShare, urlToShare];
    activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                                               applicationActivities:nil];
    
    [self presentViewController:activityViewController
                       animated:YES
                     completion:nil];
}

- (IBAction) unwindToCollectionViewController:(UIStoryboardSegue *)segue{}



#pragma mark - Instance Methods
- (void)addImageToAlbumImagesAtIndex:(NSUInteger)index
{
    [NSThread sleepForTimeInterval:1.0];
    [self.album.albumImages replaceObjectAtIndex:index withObject:[UIImage imageWithData:
                                                                   [NSData dataWithContentsOfURL:
                                                                    [self.album.albumImagesURLsArray objectAtIndex:index]]]];
}



#pragma mark - UICollectionViewController Delegate Methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.album.albumImagesURLsArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.imageQueue waitUntilAllOperationsAreFinished];
    static NSString *reuseIndentifier    = @"Cell";
    AlbumImagesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIndentifier forIndexPath:indexPath];
    [cell.activityIndicatorView startAnimating];
    
    cell.imageView.image = nil;
    
        // checking if the image is cached in the albumImages array
//        if ([[self.album.albumImages objectAtIndex:indexPath.item] isEqual:[NSNull null]]){
//            [[NetworkActivityTracker sharedInstance] showActivityIndicator];
//            [self addImageToAlbumImagesAtIndex:indexPath.item];
//        }
        UIImage *image = [self.album.albumImages objectAtIndex:indexPath.item];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            AlbumImagesCollectionViewCell *newCell = (AlbumImagesCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
            newCell.imageView.alpha = 0;
            newCell.imageView.image = image;
            newCell.imageView.image = image;
            [newCell.activityIndicatorView stopAnimating];
            [[NetworkActivityTracker sharedInstance] hideActivityIndicator];
            [UIView animateWithDuration:0.3
                             animations:^{
                                 newCell.imageView.alpha = 1;
                             }];
        });
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Header";
    AlbumImagesCollectionViewReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                       withReuseIdentifier:reuseIdentifier
                                                                                              forIndexPath:indexPath];
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"forward" sender:[self.collectionView cellForItemAtIndexPath:indexPath]];
}

@end
