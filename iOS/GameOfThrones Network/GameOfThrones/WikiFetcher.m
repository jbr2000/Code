//
//  WikiFetcher.m
//  GameOfThrones
//
//  Created by Spencer McWilliams on 4/19/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "WikiFetcher.h"
#import "HTMLNode.h"
#import "HTMLParser.h"

@interface WikiFetcher()
+ (NSDictionary *)createJsonDictionaryFromURLString:(NSString *)URL;
@end

@implementation WikiFetcher

#define CHARACTERS_CATEGORYINFO_URL @"http://gameofthrones.wikia.com/api.php?format=json&action=query&titles=Category:Characters&prop=categoryinfo"
#define CHARACTERS_LIST_URL         @"http://gameofthrones.wikia.com/api.php?format=json&action=query&list=categorymembers&cmtitle=Category:Characters&cmlimit=%i"

#define LOCATIONS_CATEGORYINFO_URL  @"http://gameofthrones.wikia.com/api.php?format=json&action=query&titles=Category:Locations&prop=categoryinfo"
#define LOCATIONS_LIST_URL          @"http://gameofthrones.wikia.com/api.php?format=json&action=query&list=categorymembers&cmtitle=Category:Locations&cmlimit=%i"

#define BATTLES_CATEGORYINFO_URL    @"http://gameofthrones.wikia.com/api.php?format=json&action=query&titles=Category:Battles&prop=categoryinfo"
#define BATTLES_LIST_URL            @"http://gameofthrones.wikia.com/api.php?format=json&action=query&list=categorymembers&cmtitle=Category:Battles&cmlimit=%i"

#define PAGE_HTMLTEXT_URL           @"http://gameofthrones.wikia.com/api.php?format=json&action=parse&pageid=%i"
#define SECTION_OF_HTML_TEXT_URL     @"http://gameofthrones.wikia.com/api.php?format=json&action=parse&pageid=%i&section=%i"
#define PAGE_INFO_URL               @"http://gameofthrones.wikia.com/api.php?format=json&action=query&pageids=%i"

+ (NSArray *)characterList
{
    NSInteger     numberOfPages;
    NSDictionary *parsedJSON = [WikiFetcher createJsonDictionaryFromURLString:CHARACTERS_CATEGORYINFO_URL];
    numberOfPages            = [parsedJSON[@"query"][@"pages"][@"2545"][@"categoryinfo"][@"pages"] integerValue];
    parsedJSON               = [WikiFetcher createJsonDictionaryFromURLString:[NSString stringWithFormat:CHARACTERS_LIST_URL,numberOfPages]];

    return parsedJSON[@"query"][@"categorymembers"];
}

+ (NSArray *)locationsList
{
    NSInteger    numberOfPages = 0;
    NSDictionary *parsedJSON = [WikiFetcher createJsonDictionaryFromURLString:LOCATIONS_CATEGORYINFO_URL];
    numberOfPages            = [parsedJSON[@"query"][@"pages"][@"3128"][@"categoryinfo"][@"pages"] integerValue];
    parsedJSON               = [WikiFetcher createJsonDictionaryFromURLString:[NSString stringWithFormat:LOCATIONS_LIST_URL,numberOfPages]];
    
    return parsedJSON[@"query"][@"categorymembers"];
}

+ (NSArray *)battlesList
{
    NSInteger    numberOfPages = 0;
    NSDictionary *parsedJSON = [WikiFetcher createJsonDictionaryFromURLString:BATTLES_CATEGORYINFO_URL];
    numberOfPages            = [parsedJSON[@"query"][@"pages"][@"3819"][@"categoryinfo"][@"pages"] integerValue];
    parsedJSON               = [WikiFetcher createJsonDictionaryFromURLString:[NSString stringWithFormat:BATTLES_LIST_URL,numberOfPages]];
    
    return parsedJSON[@"query"][@"categorymembers"];
}

+ (NSArray *)infoTextOfPage:(NSUInteger)pageID
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSDictionary *parsedJSON = [WikiFetcher createJsonDictionaryFromURLString:[NSString stringWithFormat:PAGE_HTMLTEXT_URL,pageID]];
    
    NSArray *sectionArray = parsedJSON[@"parse"][@"sections"];
    NSUInteger arraySize = [sectionArray count];
    
    for (int i = 0; i < arraySize; i++) {
        parsedJSON = [WikiFetcher createJsonDictionaryFromURLString:[NSString stringWithFormat:SECTION_OF_HTML_TEXT_URL,pageID,i]];
        NSDictionary *sectionDictionary = [[NSDictionary alloc]
                                           initWithObjects:@[[sectionArray objectAtIndex:i][@"line"],parsedJSON[@"parse"][@"text"][@"*"]]
                                                   forKeys:@[@"sectiontitle",@"sectionHTMLString"]];
        [array addObject:sectionDictionary];
    }
    return [array copy];
}

+ (NSString *)titleOfPage:(NSUInteger)pageID
{
    NSDictionary *parsedJSON = [WikiFetcher createJsonDictionaryFromURLString:[NSString stringWithFormat:PAGE_INFO_URL,pageID]];
    return parsedJSON[@"query"][@"pages"][[NSString stringWithFormat:@"%i",pageID]][@"title"];
}

+ (UIImage *)imageForPageID:(NSUInteger)pageID
{
    NSDictionary *parsedJSON = [WikiFetcher createJsonDictionaryFromURLString:[NSString stringWithFormat:SECTION_OF_HTML_TEXT_URL,pageID,0]];
    NSString *htmlString     = parsedJSON[@"parse"][@"text"][@"*"];
    
    HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlString error:nil];
    HTMLNode *bodyNode = [parser body];
    NSArray *nodeArray = [bodyNode findChildTags:@"img"];
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[nodeArray lastObject] getAttributeNamed:@"src"]]]];
}

+ (NSDictionary *)createJsonDictionaryFromURLString:(NSString *)URL
{
    NSData       *rawJson;
    NSError      *error;
    NSDictionary *parsedJSON;
    
    rawJson    = [NSData dataWithContentsOfURL:[NSURL URLWithString:URL]];
    parsedJSON = [NSJSONSerialization JSONObjectWithData:rawJson
                                                 options:NSJSONReadingMutableContainers
                                                   error:&error];
    return parsedJSON;
}

@end
