//
//  PhotoLibrary.m
//  PhotoPicker
//
//  Created by Spencer McWilliams on 2/28/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "PhotoLibrary.h"

@implementation PhotoLibrary

- (id) init
{
    self = [super init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"photos" ofType:@"plist"];
    self.photoDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    return self;
}

- (NSUInteger) numberOfCategories
{
    return self.photoDictionary.count;
}

- (NSString *)nameForCategory:(NSUInteger)category
{
    NSMutableArray *categoryArray = [[self.photoDictionary allKeys] mutableCopy];
    categoryArray = [[categoryArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] mutableCopy];
    return [categoryArray objectAtIndex:category];
}

- (NSUInteger)numberOfPhotosInCategory:(NSUInteger)category
{
    NSString *categoryKey;
    NSMutableArray *array = [[self.photoDictionary allKeys] mutableCopy];
    array = [[array sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] mutableCopy];
    categoryKey = [array objectAtIndex:category];
    
    array = [[[self.photoDictionary objectForKey:categoryKey] allKeys] mutableCopy];
    return array.count;
}

- (NSString *)nameForPhotoInCategory:(NSUInteger)category
                          atPosition:(NSUInteger)position
{
    NSString *categoryKey;
    NSString *pokemonName;
    NSMutableArray *array = [[self.photoDictionary allKeys] mutableCopy];
    
    // set categoryKey
    array = [[array sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] mutableCopy];
    categoryKey = [array objectAtIndex:category];
    
    // set pokemonName
    array = [[[self.photoDictionary objectForKey:categoryKey] allKeys] mutableCopy];
    array = [[array sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] mutableCopy];
    if (array.count > position) {
        pokemonName = [array objectAtIndex:position];
        return pokemonName;
    }
    else
        return nil;
}

- (UIImage *)imageForPhotoInCategory:(NSUInteger)category
                          atPosition:(NSUInteger)position
{
    NSString *categoryKey;
    NSString *fileName;
    NSMutableArray *array = [[self.photoDictionary allKeys] mutableCopy];
    
    // set categoryKey
    array = [[array sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] mutableCopy];
    categoryKey = [array objectAtIndex:category];
    
    // set fileName
    array = [[[self.photoDictionary objectForKey:categoryKey] allObjects] mutableCopy];
    array = [[array sortedArrayUsingComparator:^(id firstObject, id secondObject) {
        return [((NSString *)firstObject) compare:((NSString *)secondObject) options:NSNumericSearch];
    }] mutableCopy];
    fileName = [array objectAtIndex:position];
    
    return [UIImage imageNamed:fileName];
}

@end
