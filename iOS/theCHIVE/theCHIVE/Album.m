//
//  Album.m
//  theCHIVE
//
//  Created by Spencer McWilliams on 5/9/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "Album.h"
#import "ChiveFetcher.h"

@interface Album()
@property (nonatomic, strong) NSURL *thumbnailURL;
@end

@implementation Album

- (id) initWithAlbumAttributesDictionary:(NSDictionary *)albumsAttributesDictionary albumForRow:(NSUInteger)row
{
        self = [super init];
        
        NSError *error = NULL;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat       = @"EEE, MMM d yyyy";
        NSDateFormatter *dateParser    = [[NSDateFormatter alloc] init];
        dateParser.dateFormat          = @"EEE, dd MMM yyyy HH:mm:ss ZZZ";
        NSDate *date                   = [dateParser dateFromString:albumsAttributesDictionary[@"channel"][@"item"][row][@"pubDate"]];
        NSRange range;
        NSRegularExpression *regexToRemoveNumberOfPhotosTag = [NSRegularExpression regularExpressionWithPattern:@"(\\([^)]+\\))"
                                                                                                        options:0
                                                                                                          error:&error];
        NSRegularExpression *regexToDetermineNumberOfPhotos = [NSRegularExpression regularExpressionWithPattern:@"(\\d+)"
                                                                                                        options:0
                                                                                                          error:&error];
        
        _title                      = albumsAttributesDictionary[@"channel"][@"item"][row][@"title"];
        range                       = [[regexToDetermineNumberOfPhotos firstMatchInString:_title options:0 range:NSMakeRange(0,[_title length])] range];
        _numberOfPhotos             = [[_title substringWithRange:range] integerValue];
        NSMutableString *tempString = [_title mutableCopy];
        
        [regexToRemoveNumberOfPhotosTag replaceMatchesInString:tempString options:0 range:NSMakeRange(0,[_title length]) withTemplate:@""];
        
        _title                      = [tempString copy];
        _author                     = albumsAttributesDictionary[@"channel"][@"item"][row][@"dc:creator"];
        _pubDate                    = [dateFormatter stringFromDate:date];
        _albumImages                = nil;
    if (![albumsAttributesDictionary[@"channel"][@"item"][row][@"category"] containsObject:@"Video"] ) {
        _thumbnailURL               = [NSURL URLWithString:albumsAttributesDictionary[@"channel"][@"item"][row][@"media:thumbnail"][@"_url"]];
        _albumURL                   = [NSURL URLWithString:albumsAttributesDictionary[@"channel"][@"item"][row][@"link"]];
        _commentsURL                = [NSURL URLWithString:albumsAttributesDictionary[@"channel"][@"item"][row][@"comments"]];
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (int i = 2; i < [albumsAttributesDictionary[@"channel"][@"item"][row][@"media:content"] count]; i++)
            [tempArray addObject:[NSURL URLWithString:albumsAttributesDictionary[@"channel"][@"item"][row][@"media:content"][i][@"_url"]]];
        _albumImagesURLsArray = [tempArray copy];
    
    }
    return self;
}

#pragma - mark Lazy Instantiation

- (UIImage *)thumbnail
{
    if (!_thumbnail) {
        _thumbnail = [UIImage imageWithData:[NSData dataWithContentsOfURL:_thumbnailURL]];
    }
    return _thumbnail;
}

- (NSArray *)albumImagesURLsArray
{
    if (!_albumImagesURLsArray) {
        _albumImagesURLsArray = [[NSArray alloc] init];
    }
    return _albumImagesURLsArray;
}

- (NSArray *)albumImages
{
    if (!_albumImages) {
        _albumImages = [[NSMutableArray alloc] init];
        for (int i = 0; i < _numberOfPhotos; i++)
            [_albumImages addObject:[NSNull null]];
    }
    return _albumImages;
}


@end
