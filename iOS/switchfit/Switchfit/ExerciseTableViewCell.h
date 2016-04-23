//
//  WorkoutTableViewCell.h
//  Switchfit
//
//  Created by Spencer McWilliams on 8/17/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseTableViewCell : UITableViewCell

@property (strong, nonatomic) UITextView *exerciseSummaryTextView;
@property (strong, nonatomic) UILabel *exerciseTitleLabel;
@property (strong, nonatomic) UILabel *exerciseDifficultyLabel;
@property (strong, nonatomic) UIImageView *cellImageView;

@end
