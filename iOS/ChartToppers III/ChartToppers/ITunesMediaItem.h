//
//  ITunesMediaItem.h
//  ChartToppers
//
//  Created by Spencer McWilliams on 3/26/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITunesMediaItem : NSObject

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *category;
@property (nonatomic, readonly) NSString *artist;
@property (nonatomic, readonly) NSString *desc;
@property (nonatomic, readonly) NSString *releaseDate;
@property (nonatomic, readonly) NSString *price;
@property (nonatomic, readonly) NSURL    *artworkURL;
@property (nonatomic, readonly) UIImage  *artworkImage;
@property (nonatomic, readonly) NSURL    *storeURL;
@property (nonatomic, readonly) int       rank;

- (id)initWithJSONAttributes:(NSDictionary *)jsonAttributes
                        rank:(int)rank
                        type:(NSString *)type;
@end