//
//  CharacterInfoTableViewController.m
//  GameOfThrones
//
//  Created by Spencer McWilliams on 5/2/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "CharacterInfoTableViewController.h"

@interface CharacterInfoTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation CharacterInfoTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageView.image = [WikiFetcher imageForPageID:self.pageID];
}

@end
