//
//  TableViewController.m
//  GameOfThrones
//
//  Created by Spencer McWilliams on 4/23/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "TableViewController.h"
#import "InfoTableViewController.h"
#import "TableCell.h"

@interface TableViewController () <UISearchBarDelegate>
@property (nonatomic, strong) NSArray *infoList;
@property (nonatomic, strong) NSArray *searchList;
@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    InfoTableViewController *infoViewController = segue.destinationViewController;
    TableCell *cell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    infoViewController.pageID = [((NSDictionary *)[self.infoList objectAtIndex:indexPath.row])[@"pageid"] integerValue];
}


#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.infoList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.titleLabel.text = [self.infoList objectAtIndex:indexPath.row][@"title"];
    
    return cell;
}


#pragma mark - UISearchBar Delegate Methods
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *string = [[NSString alloc] init];
    for (int i = 0; i < [self.infoList count]; i++)
    {
        string = [self.infoList objectAtIndex:i][@"title"];
        if ([string rangeOfString:searchBar.text].location != NSNotFound) {
            [array addObject:string];
        }
    }
    self.searchList = [array copy];
}


#pragma mark - Lazy Instantiation
- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.delegate = self;
    }
    return _searchBar;
}
@end
