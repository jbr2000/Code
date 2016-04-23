//
//  Album.h
//  theCHIVE
//
//  Created by Spencer McWilliams on 5/9/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject
@property (nonatomic, readonly, strong) NSString *title;
@property (nonatomic, readonly, strong) NSString *author;
@property (nonatomic, readonly, strong) NSString *pubDate;
@property (nonatomic, readonly, strong) NSURL    *albumURL;
@property (nonatomic, readonly, strong) NSString *commentsURL;
@property (nonatomic, readonly)         NSUInteger numberOfPhotos;
@property (nonatomic, strong) UIImage  *thumbnail;
@property (nonatomic, strong) NSArray *albumImagesURLsArray;
@property (nonatomic, strong) NSMutableArray *albumImages;
- (id) initWithAlbumAttributesDictionary:(NSDictionary *)albumsAttributesDictionary albumForRow:(NSUInteger)row;
@end
