//
//  PhotoGridViewController.m
//  PhotoPicker
//
//  Created by Spencer McWilliams on 2/28/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "PhotoGridViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoLibrary.h"
#import "SectionHeaderReusableView.h"

@interface PhotoGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) PhotoLibrary *photoLibrary;

@end

@implementation PhotoGridViewController

- (PhotoLibrary *) photoLibrary
{
    if (!_photoLibrary) {
        _photoLibrary = [[PhotoLibrary alloc] init];
    }
    return _photoLibrary;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.photoLibrary numberOfPhotosInCategory:section];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.photoLibrary numberOfCategories];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell"
                                                                              forIndexPath:indexPath];
    cell.cellImage.image = [self.photoLibrary imageForPhotoInCategory:indexPath.section atPosition:indexPath.item];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    SectionHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                  withReuseIdentifier:@"sectionHeader"
                                                                         forIndexPath:indexPath];
    headerView.sectionHeaderLabel.text = [self.photoLibrary nameForCategory:indexPath.section];
    
    return headerView;
}

- (void)updateSelectedPokemonLabel:(NSInteger)section atIndex:(NSInteger)item;
{
    self.selectedPokemonLabel.text = [self.photoLibrary nameForPhotoInCategory:section atPosition:item];
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self updateSelectedPokemonLabel:indexPath.section atIndex:indexPath.item];
}

@end
