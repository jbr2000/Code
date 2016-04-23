//
//  ImageViewController.m
//  theCHIVE
//
//  Created by Spencer McWilliams on 5/15/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "ImageViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ImageViewController () <UIScrollViewDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, strong) UIPasteboard *pasteBoard;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;
@end

@implementation ImageViewController

#pragma mark View LifeCycle
- (void)viewDidAppear:(BOOL)animated
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UILabel *teachingLabel            = [[UILabel alloc] init];
        teachingLabel.frame           = CGRectMake(0, 0, 200, 40);
        teachingLabel.layer.cornerRadius = 20.f;
        teachingLabel.center          = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        teachingLabel.textColor       = [UIColor whiteColor];
        teachingLabel.backgroundColor = [UIColor blackColor];
        teachingLabel.textAlignment   = NSTextAlignmentCenter;
        teachingLabel.text            = @"Swipe Down To Close";
        teachingLabel.alpha           = 0.8;
        [self.scrollView addSubview:teachingLabel];
        
        [UIView animateWithDuration:2.5
                              delay:0.5
                            options:0
                         animations:^{
                             teachingLabel.alpha = 0;
                         }
                         completion:NULL];

    });

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize viewableSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
        
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, viewableSize.width, viewableSize.height)];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewableSize.width, viewableSize.height)];
    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressOccured:)];
    self.pasteBoard = [UIPasteboard generalPasteboard];
    
    
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 2.0;

    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = self.image;
    
    [self.scrollView addSubview:self.imageView];
    [self.scrollView addGestureRecognizer:self.longPressGestureRecognizer];
    [self.view addSubview:self.scrollView];
}



#pragma mark - Actions
- (IBAction)longPressOccured:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Save Photo", @"Copy Photo", nil];
        
        [actionSheet showInView:self.imageView];
    } 
}



#pragma mark - UIScrollView Delegate Methods
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}



#pragma mark - UIActionSheet Delegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
#define COPY_PHOTO 1
#define SAVE_PHOTO 2
    
    switch (buttonIndex) {
        case COPY_PHOTO:
            self.pasteBoard.image = self.image;
            break;
        case SAVE_PHOTO:
            UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);
            break;
            
        default:
            break;
    }
}

@end
