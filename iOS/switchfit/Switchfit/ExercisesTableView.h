//
//  ExercisesTableView.h
//  Switchfit
//
//  Created by Spencer McWilliams on 9/3/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExercisesTableView : UITableView <UITableViewDataSource, UITableViewDataSource>

- (void)updateTableViewFrame;

@property (strong, nonatomic) NSArray *exercises;
@property (strong, nonatomic) NSMutableArray *expanded;
@property (nonatomic) int viewHeight;
@property (nonatomic) int viewWidth;

@end
