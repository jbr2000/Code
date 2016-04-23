//
//  AlbumListTableViewCell.h
//  theCHIVE
//
//  Created by Spencer McWilliams on 5/9/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"

@interface AlbumsListTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet    UILabel     *title;
@property (nonatomic, weak) IBOutlet    UILabel     *subtitle;
@property (nonatomic, weak) IBOutlet    UIImageView *thumbnailImageView;
@end
