//
//  PhotoSubmissionViewController.m
//  theCHIVE
//
//  Created by Spencer McWilliams on 5/16/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "PhotoSubmissionViewController.h"
//#import "CameraViewController.h"
#import <MessageUI/MessageUI.h>

@interface PhotoSubmissionViewController () <UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, strong) MFMailComposeViewController *mailComposerViewController;
@property (atomic   , strong) NSOperationQueue *opQ;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
- (IBAction)sumbitPhotoButtonTapped:(UIButton *)sender;
@end

@implementation PhotoSubmissionViewController
#pragma mark - View LifeCycle
- (void)viewDidLoad
{
#define TAB_BAR_CONTROLLER_HEIGHT 44
    self.backgroundImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-TAB_BAR_CONTROLLER_HEIGHT);
    self.backgroundImageView.image = [UIImage imageNamed:@"Background.jpg"];
    self.submitButton.center = CGPointMake(self.view.center.x, self.view.center.y-TAB_BAR_CONTROLLER_HEIGHT);
}



#pragma mark - UIImagePicker Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.imageData = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage], 1);
    [self dismissViewControllerAnimated:NO completion:NULL];
    [self presentViewController:self.mailComposerViewController animated:NO completion:NULL];
}



#pragma mark - MFMailComposerViewController Delegate Methods
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    self.mailComposerViewController = nil;
}



#pragma mark - Lazy Instantiation
- (UIImagePickerController *)picker
{
    if (!_picker) {
        _picker = [[UIImagePickerController alloc] init];
        _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        _picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        _picker.showsCameraControls = YES;
        _picker.navigationBarHidden = YES;
        _picker.toolbarHidden = YES;
        _picker.wantsFullScreenLayout = YES;
        _picker.delegate = self;
    }
    return _picker;
}

- (NSData *)imageData
{
    if (!_imageData) {
        _imageData = [[NSData alloc] init];
    }
    return _imageData;
}

- (MFMailComposeViewController *)mailComposerViewController
{
    if (!_mailComposerViewController) {
        _mailComposerViewController = [[MFMailComposeViewController alloc] init];
        _mailComposerViewController.delegate = self;
        _mailComposerViewController.mailComposeDelegate = self;
        [_mailComposerViewController setSubject:@"Submitting to CHIVE from my iPhone!"];
        [_mailComposerViewController setToRecipients:@[@"thechivesubmit@gmail.com"]];
        [_mailComposerViewController setMessageBody:@"<3 CHIVE" isHTML:NO];
        [_mailComposerViewController addAttachmentData:self.imageData mimeType:@"jpeg" fileName:@"submission.jpg"];
    }
    return  _mailComposerViewController;
}

- (IBAction)sumbitPhotoButtonTapped:(UIButton *)sender
{
    if ([MFMailComposeViewController canSendMail]) {
        [self presentViewController:self.picker animated:YES completion:NULL];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"The current iOS device does not support email functionality."
                                                       delegate:self
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
