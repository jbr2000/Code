//
//  ITunesMediaItemsTableViewCell.h
//  ChartToppers
//
//  Created by Spencer McWilliams on 3/27/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITunesMediaItemsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel     *cellTitle;
@property (weak, nonatomic) IBOutlet UILabel     *cellSubtitle;
@property (weak, nonatomic) IBOutlet UILabel     *cellNumber;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;


@end
