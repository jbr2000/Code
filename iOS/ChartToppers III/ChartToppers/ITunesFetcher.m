//
//  ITunesFetcher.m
//  ChartToppers
//
//  Created by Spencer McWilliams on 3/26/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "ITunesFetcher.h"
#import "NetworkActivityTracker.h"

@interface ITunesFetcher()

//@property (nonatomic, readwrite) NSUInteger networkCounter;
+ (NSArray *) makeArray:(NSURL *)url type:(NSString *)type;

@end

@implementation ITunesFetcher

+ (NSArray *)topFreeApps
{
    return [ITunesFetcher makeArray:[[NSURL alloc]
                                     initWithString:@"https://itunes.apple.com/us/rss/topfreeapplications/limit=50/json"]
                               type:@"apps"];
}

+ (NSArray *)topAlbums
{
    return [ITunesFetcher makeArray:[[NSURL alloc]
                                     initWithString:@"https://itunes.apple.com/us/rss/topalbums/limit=50/explicit=true/json"]
                               type:@"albums"];
}

+ (NSArray *)topPaidBooks
{
    return [ITunesFetcher makeArray:[[NSURL alloc]
                                     initWithString:@"https://itunes.apple.com/us/rss/toppaidebooks/limit=50/json"]
                               type:@"books"];
}

+ (NSArray *)topMovies
{
    return [ITunesFetcher makeArray:[[NSURL alloc]
                                     initWithString:@"https://itunes.apple.com/us/rss/topmovies/limit=50/json"]
                               type:@"movies"];
}

+ (NSArray *)topTVEpisodes
{
    return [ITunesFetcher makeArray:[[NSURL alloc]
                                     initWithString:@"https://itunes.apple.com/us/rss/toptvepisodes/limit=50/json"]
                               type:@"tv"];
}

+ (NSArray *)topITunesUCourses
{
    return [ITunesFetcher makeArray:[[NSURL alloc]
                                     initWithString:@"https://itunes.apple.com/us/rss/topitunesucollections/limit=50/json"]
                               type:@"courses"];
}

+ (NSArray *) makeArray:(NSURL *)url type:(NSString *)type
{
    int i = 0;
    NSError        *error;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSData *rawJSON          = [[NSData alloc] initWithContentsOfURL:url];

    [[NetworkActivityTracker sharedInstance] showActivityIndicator];
// I cannot find a way to throw the sleep in here and have it dispatch from outside the model.
    [[NetworkActivityTracker sharedInstance] hideActivityIndicator];
    
    if (!rawJSON) {
        return nil;
    }
    
    NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:rawJSON
                                                               options:NSJSONReadingMutableContainers
                                                                 error:&error];
    for (NSDictionary *jsonAttributesDictionary in parsedJSON[@"feed"][@"entry"])
    {
        [array addObject:[[ITunesMediaItem alloc] initWithJSONAttributes:jsonAttributesDictionary
                                                                    rank:i
                                                                    type:type]];
        i++;
    }
    return array;
}

@end
