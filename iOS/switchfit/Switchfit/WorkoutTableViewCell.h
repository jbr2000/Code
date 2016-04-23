//
//  WorkoutTableViewCell.h
//  Switchfit
//
//  Created by Brendan Mcmahon on 8/20/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutTableViewCell.h"
#import "DatabaseManager.h"
#import "Workout.h"

@interface WorkoutTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *workoutSummaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutTagLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutLikesLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutCommentsLabel;

@end
