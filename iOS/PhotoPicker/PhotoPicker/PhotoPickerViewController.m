//
//  PhotoPickerViewController.m
//  PhotoPicker
//
//  Created by Spencer McWilliams on 2/28/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "PhotoPickerViewController.h"
#import "PhotoLibrary.h"

@interface PhotoPickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *trainerImageView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) PhotoLibrary *photoLibrary;

@end

@implementation PhotoPickerViewController

- (PhotoLibrary *) photoLibrary
{
    if (!_photoLibrary) {
        _photoLibrary = [[PhotoLibrary alloc] init];
    }
    return _photoLibrary;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == 0) {
        return 95;
    }
    else return 200;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.photoLibrary numberOfCategories];
    }
    else return [self.photoLibrary numberOfPhotosInCategory:[self.pickerView selectedRowInComponent:0]];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.photoLibrary nameForCategory:row];
    }
    else {
        return [self.photoLibrary nameForPhotoInCategory:[self.pickerView selectedRowInComponent:0] atPosition:row];
    }
}

- (void) updateImageView:(NSInteger)row
{
    self.pokemonImageView.image = [self.photoLibrary imageForPhotoInCategory:[self.pickerView selectedRowInComponent:0] atPosition:row];
    self.backgroundImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"background%i.jpg",(row%6)]];
    self.trainerImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"hero%i.png",(row%2)]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // changed category
    if (component == 0) {
        [self.pickerView selectRow:0 inComponent:1 animated:NO];
        [self.pickerView reloadComponent:1];
    }
    [self updateImageView:[self.pickerView selectedRowInComponent:1]];
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    self.pokemonImageView.alpha = sender.value;
}

- (void) viewWillAppear:(BOOL)animated
{
    self.slider.minimumTrackTintColor = [UIColor redColor];
    [self.slider setThumbImage:[UIImage imageNamed:@"Pokeballicn.png"] forState:UIControlStateNormal];    
    [self updateImageView:0];
    self.pickerView.delegate = nil;
    self.pickerView.delegate = self;
    [self.pickerView reloadAllComponents];
}

@end
