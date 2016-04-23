//
//  ExercisesTableView.m
//  Switchfit
//
//  Created by Spencer McWilliams on 9/3/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import "ExercisesTableView.h"
#import "Exercise.h"
#import "ExerciseTableViewCell.h"

@interface ExercisesTableView ()
@end

@implementation ExercisesTableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.exercises count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self.expanded objectAtIndex:indexPath.row] boolValue] == NO)//if cell is not expanded
    {
        return 50;
    }
    else //bool == YES
    {
        return self.viewHeight-175;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    ExerciseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.exerciseTitleLabel.text = [(Exercise *)[self.exercises objectAtIndex:indexPath.row] name];
    cell.exerciseTitleLabel.font = [UIFont fontWithName:@"Lane-Narrow" size:20.0];
    cell.exerciseTitleLabel.textColor = [UIColor blackColor];
    cell.exerciseDifficultyLabel.text = [NSString stringWithFormat:@"%.02f",[self.exercises[indexPath.row] difficulty]];
    
    cell.exerciseDifficultyLabel.font = [UIFont fontWithName:@"Colaborate-Light" size:20.0];
    cell.exerciseDifficultyLabel.textColor = [UIColor blackColor];
    cell.exerciseSummaryTextView.font = [UIFont fontWithName:@"Colaborate-Thin" size:14.0];
    cell.exerciseSummaryTextView.textColor = [UIColor blackColor];
    [cell.exerciseSummaryTextView setFrame:CGRectMake(20, 54, 213, cell.frame.size.height-175-64)];
    if([[self.expanded objectAtIndex:indexPath.row] boolValue] == YES)//if cell is expanded
    {
        cell.exerciseSummaryTextView.hidden = NO;
        cell.exerciseSummaryTextView.text = [self.exercises[indexPath.row] summary];
    }
    else
    {
        cell.exerciseSummaryTextView.hidden = YES;
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)updateTableViewFrame{
    float viewWidth = self.viewWidth;
    float viewHeight = self.viewHeight;
    
    [UIView animateWithDuration:0.2
                          delay:0.1
                        options:0
                     animations:^{
                         self.frame = CGRectMake(0, 75, viewWidth, viewHeight-75);}
                     completion:nil];
}


@end
