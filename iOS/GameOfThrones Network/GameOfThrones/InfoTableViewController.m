//
//  InfoTableViewController.m
//  GameOfThrones
//
//  Created by Spencer McWilliams on 4/23/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "InfoTableViewController.h"
#import "HTMLTagRemover.h"
#import "HTMLParser.h"

@interface InfoTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation InfoTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

// Text View
    NSArray *htmlSections        = [WikiFetcher infoTextOfPage:self.pageID];
    NSError *error              = NULL;
    NSString *descriptionString = [[NSString alloc] init];
    for (NSDictionary *curSectionDictionary in htmlSections) {
        HTMLParser *parser          = [[HTMLParser alloc] initWithString:curSectionDictionary[@"sectionHTMLString"] error:&error];
        HTMLNode *bodyNode          = [parser body];
        NSArray *nodeArray          = [bodyNode findChildTags:@"p"];
        descriptionString = [descriptionString stringByAppendingFormat:@"\n\t%@\n",curSectionDictionary[@"sectiontitle"]];
        for (int i=0; i<[nodeArray count]; i++) {
            descriptionString = [descriptionString stringByAppendingString:[HTMLTagRemover removeHTMLTags:[[nodeArray objectAtIndex:i] rawContents]]];
        }
    }
    self.textView.text   = descriptionString;
    [self.textView sizeToFit];
    CGRect frame         = CGRectMake(0, 0, self.textView.contentSize.width, self.textView.contentSize.height);
    self.textView.frame  = frame;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return self.textView.contentSize.height;
    }
    return 243;
}

@end
