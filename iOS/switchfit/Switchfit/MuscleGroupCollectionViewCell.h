//
//  MuscleGroupCollectionViewCell.h
//  Switchfit
//
//  Created by Spencer McWilliams on 8/24/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MuscleGroupCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) UILabel *muscleGroupLabel;
@property (nonatomic) bool isCurrentlySelected;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end
