//
//  HTMLTagRemover.h
//  GameOfThrones
//
//  Created by Spencer McWilliams on 4/30/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTMLTagRemover : NSObject
+ (NSString *)removeHTMLTags:(NSString *)stringToParse;
@end
