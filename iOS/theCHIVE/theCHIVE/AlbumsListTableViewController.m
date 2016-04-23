//
//  AlbumListTableViewController.m
//  theCHIVE
//
//  Created by Spencer McWilliams on 5/9/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "AlbumsListTableViewController.h"
#import "AlbumsListTableViewCell.h"
#import "AlbumImagesCollectionViewController.h"
#import "AlbumImagesCollectionViewCell.h"
#import "NetworkActivityTracker.h"

@interface AlbumsListTableViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSDictionary *albumsAttributesDictionary;
@property (nonatomic, strong) NSArray *albumsArray;
@end

@implementation AlbumsListTableViewController

#pragma mark  - View LifeCycle
//- (void) viewDidLoad
//{
//    [super viewDidLoad];
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AlbumImagesCollectionViewController *newViewController = segue.destinationViewController;
    AlbumsListTableViewCell *cell                          = sender;
    NSIndexPath *indexPath                                 = [self.tableView indexPathForCell:cell];
    newViewController.album                                = [self.albumsArray objectAtIndex:indexPath.row];
}



#pragma mark - UITableView Delegeate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.albumsAttributesDictionary[@"channel"][@"item"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    dispatch_queue_t cellQueue      = dispatch_queue_create("Create Cell", NULL);
    AlbumsListTableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Album *album                    = [self.albumsArray objectAtIndex:indexPath.item];
    
    cell.title.text                 = album.title;
    cell.subtitle.text              = [NSString stringWithFormat:@"%@ - (%i Photos)",album.author,album.numberOfPhotos];
    cell.thumbnailImageView.image   = nil;
    
    dispatch_async(cellQueue, ^{
        [[NetworkActivityTracker sharedInstance] showActivityIndicator];
        UIImage *image = album.thumbnail;
        if (!album.thumbnail) {
            // set image to no image picture
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            AlbumsListTableViewCell *newCell = (AlbumsListTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            if (newCell) {
                newCell.thumbnailImageView.image = image;
            }
        });
        [[NetworkActivityTracker sharedInstance] hideActivityIndicator];
    });
    
    return cell;
}

- (IBAction) unwindToAlbumsListTableViewController:(UIStoryboardSegue *)segue{}



#pragma mark - Lazy Instantiation
- (NSArray *)albumsArray
{
    if (!_albumsArray) {
        _albumsArray = [[NSArray alloc] init];
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [self.albumsAttributesDictionary[@"channel"][@"item"] count]; i++) {
            [tempArray addObject:[[Album alloc] initWithAlbumAttributesDictionary:self.albumsAttributesDictionary albumForRow:i]];
        }
        _albumsArray = [tempArray copy];
    }
    return _albumsArray;
}

@end
