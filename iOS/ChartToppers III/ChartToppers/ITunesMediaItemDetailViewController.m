//
//  ITunesMediaItemDetailViewController.m
//  ChartToppers
//
//  Created by Spencer McWilliams on 3/28/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "ITunesMediaItemDetailViewController.h"
#import "NetworkActivityTracker.h"
#import "FavoritesManager.h"

@interface ITunesMediaItemDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel         *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel         *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel         *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel         *releasedLabel;
@property (weak, nonatomic) IBOutlet UIImageView     *imageView;
@property (weak, nonatomic) IBOutlet UIButton        *priceButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;
@property (weak, nonatomic) IBOutlet UITextView      *detailsTextView;
@property (weak, nonatomic) IBOutlet UIButton        *favoritesButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

- (IBAction)shareButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)priceTapped:(UIButton *)sender;
- (IBAction)favoriteTapped:(UIButton *)sender;

@end

@implementation ITunesMediaItemDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.artistLabel.lineBreakMode   = NSLineBreakByTruncatingTail;
    self.categoryLabel.lineBreakMode = NSLineBreakByTruncatingTail;

    self.title                 = self.item.title;
    self.artistLabel.text      = self.item.artist;
    self.categoryLabel.text    = self.item.category;
    self.releasedLabel.text    = self.item.releaseDate;
    self.imageView.image       = self.item.artworkImage;
    if ([[[FavoritesManager sharedInstance] allFavorites] containsObject:self.item]) {
        self.favoritesButton.selected = YES;
    }

    if (!self.item.artworkImage) {
        self.imageView.image = [UIImage imageNamed:@"no_artwork.jpg"];
    }
    self.rankLabel.text        = [NSString stringWithFormat:@"%i",self.item.rank];

    self.detailsTextView.text  = self.item.description;
    CGRect frame               = self.detailsTextView.frame;
    frame.size.height          = self.detailsTextView.contentSize.height;
    self.detailsTextView.frame = frame;
    
    [self.priceButton setTitle:self.item.price forState:UIControlStateNormal];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 141.0;
            break;
        case 2:
            return self.detailsTextView.contentSize.height + 20;
            break;
            
        default:
            return 45.0;
            break;
    }
}


#pragma mark - Actions

- (IBAction)shareButtonTapped:(UIBarButtonItem *)sender
{
    NSArray                  *activityItems;
    UIActivityViewController *activityViewController;

    NSString *textToShare = self.item.title;
    UIImage *imageToShare = self.item.artworkImage;
    NSURL *urlToShare     = self.item.storeURL;
    
    activityItems          = @[textToShare, imageToShare, urlToShare];
    activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                                               applicationActivities:nil];
    
    [self presentViewController:activityViewController
                       animated:YES
                     completion:nil];
}

- (IBAction)priceTapped:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:self.item.storeURL];
}

- (IBAction)favoriteTapped:(UIButton *)sender
{
    if (sender.selected == NO) {
        [[FavoritesManager sharedInstance] addFavorite:self.item];
    }
    else
        [[FavoritesManager sharedInstance] removeFavorite:self.item];
    sender.selected = !sender.selected;
}
@end
