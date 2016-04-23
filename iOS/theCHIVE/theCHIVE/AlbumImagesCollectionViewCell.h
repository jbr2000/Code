//
//  AlbumImagesGridViewCell.h
//  theCHIVE
//
//  Created by Spencer McWilliams on 5/9/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumImagesCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@end
