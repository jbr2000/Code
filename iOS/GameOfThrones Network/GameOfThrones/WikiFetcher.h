//
//  WikiFetcher.h
//  GameOfThrones
//
//  Created by Spencer McWilliams on 4/19/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WikiFetcher : NSObject
+ (NSArray *)characterList;
+ (NSArray *)locationsList;
+ (NSArray *)battlesList;
+ (NSString *)titleOfPage:(NSUInteger)pageID;
+ (UIImage *)imageForPageID:(NSUInteger)pageID;
+ (NSArray *)infoTextOfPage:(NSUInteger)pageID;
@end
