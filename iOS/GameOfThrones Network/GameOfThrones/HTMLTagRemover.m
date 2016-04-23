//
//  HTMLTagRemover.m
//  GameOfThrones
//
//  Created by Spencer McWilliams on 4/30/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "HTMLTagRemover.h"

@implementation HTMLTagRemover
+ (NSString *)removeHTMLTags:(NSString *)stringToParse
{
    NSError *error = NULL;
    // removes all html attributes.
    NSRegularExpression *regex1 = [NSRegularExpression regularExpressionWithPattern:@"<[^>]+>" options:0 error:&error];
    // remove all [x]
    NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:@"\\[[^]]+\\]\\]" options:0 error:&error];
    // remove all "Edit"s
    NSRegularExpression *regex3 = [NSRegularExpression regularExpressionWithPattern:@"(Edit)" options:0 error:&error];
    NSRegularExpression *regex4 = [NSRegularExpression regularExpressionWithPattern:@"\\[\\d+\\]" options:0 error:&error];
    stringToParse = [regex1 stringByReplacingMatchesInString:stringToParse options:0 range:NSMakeRange(0, [stringToParse length]) withTemplate:@""];
    stringToParse = [regex2 stringByReplacingMatchesInString:stringToParse options:0 range:NSMakeRange(0, [stringToParse length]) withTemplate:@""];
    stringToParse = [regex3 stringByReplacingMatchesInString:stringToParse options:0 range:NSMakeRange(0, [stringToParse length]) withTemplate:@""];
    stringToParse = [regex4 stringByReplacingMatchesInString:stringToParse options:0 range:NSMakeRange(0, [stringToParse length]) withTemplate:@""];
    return stringToParse;
}
@end