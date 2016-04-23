//
//  ITunesMediaItem.m
//  ChartToppers
//
//  Created by Spencer McWilliams on 3/26/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "ITunesMediaItem.h"
#import "NetworkActivityTracker.h"

@interface ITunesMediaItem() <NSCoding>

@end

@implementation ITunesMediaItem
@synthesize artworkImage = _artworkImage;


- (id)initWithJSONAttributes:(NSDictionary *)jsonAttributes
                        rank:(int)rank
                        type:(NSString *)type
{
    self = [super init];
    
    if (self)
    {
        _title        = jsonAttributes[@"im:name"][@"label"];
        _category     = jsonAttributes[@"category"][@"attributes"][@"label"];
        _artist       = jsonAttributes[@"im:artist"][@"label"];
        _releaseDate  = jsonAttributes[@"im:releaseDate"][@"attributes"][@"label"];
        _price        = jsonAttributes[@"im:price"][@"label"];
        _artworkURL   = [[NSURL alloc] initWithString:jsonAttributes[@"im:image"][2][@"label"]];
        _storeURL     = [[NSURL alloc] initWithString:jsonAttributes[@"id"][@"label"]];
        _rank         = rank+1;
        
        // using (NSString *)type instead of just BOOL in case the rss changes
        // to utilize the different types if later needed
        if ([type isEqualToString:@"apps"] || [type isEqualToString:@"courses"]) {
             _desc = jsonAttributes[@"summary"][@"label"];
        }
        else
        {
            _desc = [NSString stringWithFormat:@"%@\n   by: %@",_title,_artist];
        }
    }
    
    return self;
}

- (UIImage *)artworkImage
{
    if (!_artworkImage)
    {
        _artworkImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:_artworkURL]];
    }
    
    return  _artworkImage;
}


#pragma mark - NSSet functions
- (NSUInteger) hash
{
    return [self.artworkURL hash];
}

- (BOOL)isEqual:(id)object
{
    return [self.artworkURL isEqual:((ITunesMediaItem *)object).artworkURL];
}


#pragma mark - <NSCoding>
- (void)encodeWithCoder:(NSCoder  *)coder {
    [coder encodeObject:(NSString *)_title       forKey:@"title"];
    [coder encodeObject:(NSString *)_category    forKey:@"category"];
    [coder encodeObject:(NSString *)_artist      forKey:@"artist"];
    [coder encodeObject:(NSString *)_price       forKey:@"price"];
    [coder encodeObject:(NSString *)_desc        forKey:@"description"];
    [coder encodeObject:(NSString *)_releaseDate forKey:@"releaseDate"];
    [coder encodeObject:(NSURL    *)_artworkURL  forKey:@"artworkURL"];
    [coder encodeObject:(NSURL    *)_storeURL    forKey:@"storeURL"];
    [coder encodeInt:               _rank        forKey:@"rank"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    _title = [aDecoder decodeObjectForKey:@"title"];
    _category = [aDecoder decodeObjectForKey:@"category"];
    _artist = [aDecoder decodeObjectForKey:@"artist"];
    _price = [aDecoder decodeObjectForKey:@"price"];
    _desc = [aDecoder decodeObjectForKey:@"description"];
    _releaseDate = [aDecoder decodeObjectForKey:@"releaseDate"];
    _artworkURL = [aDecoder decodeObjectForKey:@"artworkURL"];
    _storeURL = [aDecoder decodeObjectForKey:@"storeURL"];
    _rank = [aDecoder decodeIntForKey:@"rank"];
    
    return self;
}



@end
