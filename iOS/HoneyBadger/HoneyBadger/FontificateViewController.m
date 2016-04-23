//
//  FontificateViewController.m
//  HoneyBadger
//
//  Created by Spencer McWilliams on 2/28/13.
//  Copyright (c) 2013 Spencer McWilliams. All rights reserved.
//

#import "FontificateViewController.h"
#import "ReusableView.h"
#import "FontCell.h"

@interface FontificateViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation FontificateViewController

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    FontCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EvenCell"
                                                               forIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    ReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                  withReuseIdentifier:@"headerView"
                                                                         forIndexPath:indexPath];
    
    headerView.headerLabel.text = [NSString stringWithFormat:@"Section: %d", indexPath.section];
    
    return headerView;
}


@end
