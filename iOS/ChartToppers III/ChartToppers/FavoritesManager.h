//
//  FavoritesManager.h
//  ChartToppers
//
//  Created by Spencer McWilliams on 4/18/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITunesMediaItem.h"

@interface FavoritesManager : NSObject

- (void)addFavorite:(ITunesMediaItem *)mediaItem;
- (void)removeFavorite:(ITunesMediaItem *)mediaItem;
- (BOOL)isFavorite:(ITunesMediaItem *)mediaItem;

- (NSArray *)allFavorites;

+ (FavoritesManager *)sharedInstance;

@end
