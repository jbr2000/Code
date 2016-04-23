//
//  NavigationController.m
//  ChartToppers
//
//  Created by Spencer McWilliams on 3/29/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end

@implementation NavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.tintColor = [UIColor redColor];
}

@end
