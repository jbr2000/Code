//
//  PresentWorkoutViewController.m
//  Switchfit
//
//  Created by Brendan Mcmahon on 8/24/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import "PresentWorkoutViewController.h"
#import "DatabaseManager.h"
#import "ExerciseTableViewCell.h"
#import "Workout.h"
#import "NavigationController.h"
#import "SaveDataManager.h"

@interface PresentWorkoutViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *expanded;
@property (strong, nonatomic) UILabel *difficultyLabel;
@property (strong, nonatomic) UITextView *workoutLabel;
@property (strong, nonatomic) UIButton *saveButton;
@property float viewWidth;
@end

@implementation PresentWorkoutViewController

-(NSMutableArray*)expanded
{
    if(!_expanded)
    {
        _expanded = [[NSMutableArray alloc] initWithCapacity:[self.exercises count]];
        
        for(int i = 0;i < [self.exercises count];i++)
        {
            [_expanded addObject:[NSNumber numberWithBool:NO]];
        }
    }
    return _expanded;
}

- (void)viewDidLoad
{
    self.viewWidth = self.view.frame.size.width;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.workoutLabel.textColor = [UIColor blackColor];
    self.workoutLabel.font = [UIFont fontWithName:@"Lane-Narrow" size:21];
    self.tableView.backgroundColor = [UIColor whiteColor];

    float difficulty = 0.0;
    for (Exercise *exercise in self.exercises){
        difficulty += exercise.difficulty;
    }
    difficulty = difficulty/[self.exercises count];
    
    //SaveWorkoutButton
    self.saveButton = [[UIButton alloc] initWithFrame:CGRectMake(self.viewWidth-52, 0, 35, 35)];
    [self.saveButton setBackgroundImage:[UIImage imageNamed:@"up_arrow.png"] forState:UIControlStateNormal];
    [self.saveButton addTarget:self action:@selector(saveTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.saveButton setImage:[UIImage imageNamed:@"checkmark.png"] forState:UIControlStateDisabled];
    [self.navigationController.navigationBar addSubview:self.saveButton];
    
    //Workout Name Label
    self.workoutLabel = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    self.workoutLabel.center     = CGPointMake(self.viewWidth/2, 24);
    self.workoutLabel.text       = @"Workout Name";
    self.workoutLabel.textColor  = [UIColor blackColor];
    self.workoutLabel.font       = [UIFont fontWithName:@"Lane-Narrow" size:21];
    self.workoutLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.workoutLabel];
    
    //Workout Difficulty Label
    {
        self.difficultyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.viewWidth, 44)];
        self.difficultyLabel.center = CGPointMake(self.viewWidth/2, self.workoutLabel.center.y + 30);
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init] ;
        [paragraphStyle setAlignment:NSTextAlignmentCenter];
        
        //set text
        if (difficulty < 1.0)
            self.difficultyLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Difficulty : Beginner : (%0.2f)", difficulty]];
        else if ((difficulty > 1.0) && (difficulty < 2.0))
            self.difficultyLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Difficulty : Moderate : (%0.2f)", difficulty]];
        else if (difficulty > 2.0)
            self.difficultyLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Difficulty : Difficult : (%0.2f)", difficulty]];
        
        //set text color/center
        NSMutableAttributedString *difficultyText = [[NSMutableAttributedString alloc] initWithAttributedString:self.difficultyLabel.attributedText];
        [difficultyText addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [difficultyText length])];
        [difficultyText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Colaborate-Light" size:20.0] range:NSMakeRange(0, [difficultyText length])];
        [difficultyText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [difficultyText length])];
        
        //change difficulty color
        if (difficulty < 1.0)
            [difficultyText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0 green:0.85 blue:0 alpha:1] range:NSMakeRange(13, 8)];
        else if ((difficulty > 1.0) && (difficulty < 2.0))
            [difficultyText addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(13, 8)];
        else if (difficulty > 2.0)
            [difficultyText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.9 green:0 blue:0 alpha:1] range:NSMakeRange(13, 9)];
        
        self.difficultyLabel.attributedText = difficultyText;
        [self.view addSubview:self.difficultyLabel];
    }
    [self updateTableViewFrame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.saveButton removeFromSuperview];
}

#pragma mark - Actions

- (void)saveTapped:(UIButton *)button
{
    Workout *newWorkout = [Workout new];
    newWorkout.id = @"idPlaceholder";
    newWorkout.creator = @"userPlaceholder";
    newWorkout.timestamp = @"timePlaceholder";
    newWorkout.summary = @"Miusov, as a man man of breeding and deilcacy, could not but feel some inwrd qualms, when he reached the Father Superior's with Ivan: he felt ashamed of havin lost his temper. He felt that he ought to have disdaimed that despicable wretch, Fyodor Pavlovitch, too much to have been upset by him in Father Zossima's cell, and so to have forgotten himself. \"Teh monks were not to blame, in any case,\" he reflceted, on the steps. \"And if they're decent people here (and the Father Superior, I understand, is a nobleman) why not be friendly and courteous withthem? I won't argue, I'll fall in with everything, I'll win them by politness, and show them that I've nothing to do with that Aesop, thta buffoon, that Pierrot, and have merely been takken in over this affair, just as they have.\"";
    newWorkout.tags = @"tagsPlaceholder";
    newWorkout.num = 69;
    newWorkout.likes = 69;
    newWorkout.comments = 69;
    newWorkout.name = [self.workoutLabel.attributedText string];
    newWorkout.exercises = self.exercises;
    [[SaveDataManager sharedInstance] saveWorkout:newWorkout];
    self.saveButton.enabled = NO;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.saveButton.alpha = 0.5;
                     }];
}

#pragma mark - UITextView Methods

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    
}

#pragma mark - UITableView Delegate/DataSource methods

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [[SaveDataManager sharedInstance] deleteWorkout:[self.exercises objectAtIndex:indexPath.row]];
        [self.exercises removeObjectAtIndex:indexPath.row];
        [self.expanded removeObjectAtIndex:indexPath.row];
        if([self.exercises count] > 0)
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
        [self updateDifficultyLabel];
        if([self.exercises count] == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self.expanded objectAtIndex:indexPath.row] boolValue] == NO)//if cell is not expanded
        [self.expanded replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
    else
        [self.expanded replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self updateTableViewFrame];
}

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
        return self.tableView.frame.size.height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    ExerciseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.exerciseTitleLabel.text = [(Exercise *)[self.exercises objectAtIndex:indexPath.row] name];
    cell.exerciseTitleLabel.font = [UIFont fontWithName:@"Colaborate-Thin" size:20.0];
    cell.exerciseTitleLabel.textColor = [UIColor blackColor];
    
    cell.exerciseDifficultyLabel.text = [NSString stringWithFormat:@"%.02f",[self.exercises[indexPath.row] difficulty]];
    cell.exerciseDifficultyLabel.font = [UIFont fontWithName:@"Colaborate-Thin" size:20.0];
    cell.exerciseDifficultyLabel.textColor = [UIColor blackColor];
    
    cell.exerciseSummaryTextView.font = [UIFont fontWithName:@"Colaborate-Light" size:14.0];
    cell.exerciseSummaryTextView.textColor = [UIColor blackColor];
    [cell.exerciseSummaryTextView setFrame:CGRectMake(20, 54, 213, cell.frame.size.height-8)];
    
    cell.cellImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"white-down-gradient.png"]];
    [cell.cellImageView setFrame:CGRectMake(20, cell.exerciseSummaryTextView.frame.origin.y, cell.exerciseSummaryTextView.frame.size.width, 12)];
    [cell addSubview:cell.cellImageView];
    [cell bringSubviewToFront:cell.cellImageView];
    
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
-(void)updateDifficultyLabel
{
    float difficulty = 0.0;
    for (Exercise *exercise in self.exercises){
        difficulty += exercise.difficulty;
    }
    difficulty = difficulty/[self.exercises count];
    
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init] ;
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    
    //set text
    if (difficulty < 1.0)
        self.difficultyLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Difficulty : Beginner : (%0.2f)", difficulty]];
    else if ((difficulty > 1.0) && (difficulty < 2.0))
        self.difficultyLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Difficulty : Moderate : (%0.2f)", difficulty]];
    else if (difficulty > 2.0)
        self.difficultyLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Difficulty : Difficult : (%0.2f)", difficulty]];
    
    //set text color/center
    NSMutableAttributedString *difficultyText = [[NSMutableAttributedString alloc] initWithAttributedString:self.difficultyLabel.attributedText];
    [difficultyText addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [difficultyText length])];
    [difficultyText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Colaborate-Light" size:20.0] range:NSMakeRange(0, [difficultyText length])];
    [difficultyText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [difficultyText length])];
    
    
    //change difficulty color
    if (difficulty < 1.0)
        [difficultyText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0 green:0.85 blue:0 alpha:1] range:NSMakeRange(13, 8)];
    else if ((difficulty > 1.0) && (difficulty < 2.0))
        [difficultyText addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(13, 8)];
    else if (difficulty > 2.0)
        [difficultyText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.9 green:0 blue:0 alpha:1] range:NSMakeRange(13, 9)];
    
    self.difficultyLabel.attributedText = difficultyText;
    [self updateTableViewFrame];
}

- (void)updateTableViewFrame{
    float viewWidth = self.view.frame.size.width;
    float viewHeight = self.view.frame.size.height;
    
    [UIView animateWithDuration:0.2
                          delay:0.1
                        options:0
                     animations:^{
                         self.tableView.frame = CGRectMake(0, 80, viewWidth, viewHeight-80);}
                     completion:nil];
}

@end
