//
//  ChiveFetcher.m
//  theCHIVE
//
//  Created by Spencer McWilliams on 5/9/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "ChiveFetcher.h"
#import "XMLDictionary.h"

@implementation ChiveFetcher

#define GIRLS_FEED_URL @"http://thechive.com/category/girls/feed/"
#define MEMES_FEED_URL @"http://thechive.com/category/funny_hilarious_photos_pictures/meme/feed/"
#define RANDOM_PHOTOS_FEED_URL @"http://thechive.com/category/random/feed/"
#define LINGERIE_FEED_URL @"http://thechive.com/category/girls/lingerie-girls/feed/"
#define CHIVETTE_OF_THE_WEEK_FEED_URL @"http://thechive.com/category/girls/chivette-of-the-week/feed/"


+ (NSDictionary *)girlsAlbumsAttributes
{
    return [NSDictionary dictionaryWithXMLData:[NSData dataWithContentsOfURL:[NSURL URLWithString:GIRLS_FEED_URL]]];
}

+ (NSDictionary *)memesAlbumsAttributes
{
    return [NSDictionary dictionaryWithXMLData:[NSData dataWithContentsOfURL:[NSURL URLWithString:MEMES_FEED_URL]]];
}

+ (NSDictionary *)randomPhotosAlbumsAttributes
{
    return [NSDictionary dictionaryWithXMLData:[NSData dataWithContentsOfURL:[NSURL URLWithString:RANDOM_PHOTOS_FEED_URL]]];
}

@end
