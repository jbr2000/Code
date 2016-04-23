//
//  ITunesFetcher.h
//  ChartToppers
//
//  Created by Spencer McWilliams on 3/26/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITunesMediaItem.h"

@interface ITunesFetcher : NSObject

+ (NSArray *)topFreeApps;
+ (NSArray *)topAlbums;
+ (NSArray *)topPaidBooks;
+ (NSArray *)topMovies;
+ (NSArray *)topTVEpisodes;
+ (NSArray *)topITunesUCourses;

@end