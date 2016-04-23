//
//  FavoritesManager.m
//  ChartToppers
//
//  Created by Spencer McWilliams on 4/18/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "FavoritesManager.h"

@interface FavoritesManager()

@property (nonatomic, strong) NSMutableSet *favorites;
@property (nonatomic, strong) NSString *filePath;
@end

@implementation FavoritesManager

- (void)addFavorite:(ITunesMediaItem *)mediaItem
{
    [self.favorites addObject:mediaItem];
    [NSKeyedArchiver archiveRootObject:self.favorites toFile:self.filePath];
}

- (void)removeFavorite:(ITunesMediaItem *)mediaItem
{
    [self.favorites removeObject:mediaItem];
    [NSKeyedArchiver archiveRootObject:self.favorites toFile:self.filePath];
}

- (BOOL)isFavorite:(ITunesMediaItem *)mediaItem
{
    return [self.favorites containsObject:mediaItem];
}

- (NSArray *)allFavorites
{
    if (![self.favorites allObjects]) {
        return [[NSArray alloc] init];
    }
    else
        return [self.favorites allObjects];
}

+ (FavoritesManager *)sharedInstance
{
    static FavoritesManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FavoritesManager alloc] init];
    });
    
    return sharedInstance;
}

- (NSMutableSet *)favorites
{
    if (!_favorites) {
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        self.filePath = [documentsDirectory stringByAppendingFormat:@"favoritesList.list"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:self.filePath]) {
            _favorites = [NSKeyedUnarchiver unarchiveObjectWithFile:self.filePath];
            return _favorites;
        }
        else {
            _favorites = [[NSMutableSet alloc] init];
            return _favorites;
        }
    }
    return _favorites;
}

@end
