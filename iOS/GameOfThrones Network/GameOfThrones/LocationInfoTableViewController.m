//
//  LocationInfoTableViewController.m
//  GameOfThrones
//
//  Created by Spencer McWilliams on 5/2/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "LocationInfoTableViewController.h"

@interface LocationInfoTableViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSDictionary *locationsDictionary;
@property (nonatomic, strong) NSString *pageTitle;
@property (nonatomic, strong) UIImageView *pin;
@end

@implementation LocationInfoTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"WesterosAndEssosMap.jpg"];
    
    if (image) {
        self.scrollView.delegate         = self;
        self.scrollView.contentSize      = image.size;
        self.scrollView.minimumZoomScale = 0.12;
        self.scrollView.maximumZoomScale = 1.1;
        self.imageView.image             = image;
        self.imageView.frame             = CGRectMake(0, 0, image.size.width, image.size.height);
        
        [self.scrollView addSubview:self.imageView];
        [self.scrollView setZoomScale:1.1];
        
        self.pin.image                         = [UIImage imageNamed:@"Claymore.png"];
        self.pin.center                        = CGPointMake([self.locationsDictionary[self.pageTitle][@"xCoordinate"] floatValue]+5,
                                                        [self.locationsDictionary[self.pageTitle][@"yCoordinate"] floatValue]-25);

        [self.imageView addSubview:self.pin];
        [self.scrollView setContentOffset:CGPointMake([self.locationsDictionary[self.pageTitle][@"xCoordinate"] floatValue],
                                                      [self.locationsDictionary[self.pageTitle][@"yCoordinate"] floatValue])];
    }
}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


#pragma mark-Lazy Instantiation

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (NSDictionary *)locationsDictionary
{
    if (!_locationsDictionary)
    {
//        _locationsDictionary = [[NSDictionary alloc] init];
        NSString *path       = [[NSBundle mainBundle] pathForResource:@"Locations" ofType:@"plist"];
        _locationsDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _locationsDictionary;
}

- (NSString *)pageTitle
{
    if (!_pageTitle) {
        _pageTitle = [[NSString alloc] init];
        _pageTitle = [WikiFetcher titleOfPage:self.pageID];
    }
    return _pageTitle;
}

- (UIImageView *)pin
{
    if (!_pin) {
        _pin = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 58)];
    }
    return _pin;
}

@end
