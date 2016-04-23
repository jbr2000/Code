//
//  ITunesMediaItemsTableViewController.m
//  ChartToppers
//
//  Created by Spencer McWilliams on 3/28/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "ITunesMediaItemsTableViewController.h"
#import "ITunesMediaItemDetailViewController.h"
#import "ITunesMediaItemsTableViewCell.h"
#import "ITunesFetcher.h"
#import "NetworkActivityTracker.h"

@interface ITunesMediaItemsTableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationHeader;
@property (nonatomic, strong) ITunesMediaItemDetailViewController *detailViewController;
@property (nonatomic, weak) NSArray *array;
@property (nonatomic, strong) UIAlertView *alertView;

@end

@implementation ITunesMediaItemsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.refreshControl addTarget:self
                            action:@selector(refresh)
                  forControlEvents:UIControlEventValueChanged];
    if (self.array == nil) {
        self.alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Network Unavailable"] message:[NSString stringWithFormat:@"Make sure you are connected to the network"] delegate:self cancelButtonTitle:[NSString stringWithFormat:@"Alright"] otherButtonTitles: nil];
        [self.alertView show];
    }
}

- (IBAction)refresh
{
    [self.refreshControl beginRefreshing];
    self.array = nil;
    [self array];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ITunesMediaItemDetailViewController *detailViewController = segue.destinationViewController;
    ITunesMediaItemsTableViewCell *cell                       = sender;
    NSIndexPath *indexPath                                    = [self.tableView indexPathForCell:cell];
    detailViewController.item                                 = [self.array objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier     = @"Cell";
    ITunesMediaItemsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    ITunesMediaItem *item               = [self.array objectAtIndex:indexPath.row];
    dispatch_queue_t cellQ              = dispatch_queue_create("Creating Cell", NULL);
    
    cell.cellTitle.lineBreakMode    = NSLineBreakByTruncatingTail;
    cell.cellSubtitle.lineBreakMode = NSLineBreakByTruncatingTail;
    cell.cellTitle.text             = item.title;
    cell.cellSubtitle.text          = item.artist;
    cell.cellNumber.text            = [NSString stringWithFormat:@"#%i",item.rank];
    cell.cellImageView.image        = nil;
    
    [cell.activityIndicatorView startAnimating];
    [[NetworkActivityTracker sharedInstance] showActivityIndicator];
    
    dispatch_async(cellQ, ^{
        UIImage *image = item.artworkImage;
        if (!item.artworkImage) {
            image = [UIImage imageNamed:@"no_artwork.jpg"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            ITunesMediaItemsTableViewCell *newCell = (ITunesMediaItemsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            newCell.cellImageView.image = image;
            [newCell.activityIndicatorView stopAnimating];
            [[NetworkActivityTracker sharedInstance] hideActivityIndicator];
        });
    });
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}

@end
