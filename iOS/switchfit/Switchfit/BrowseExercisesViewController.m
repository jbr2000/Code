//
//  WorkoutTableViewController.m
//  Switchfit
//
//  Created by Spencer McWilliams on 8/17/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import "BrowseExercisesViewController.h"

@interface BrowseExercisesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//Array to hold queried exercises
@property (strong, nonatomic) NSArray *exercises;
@property (strong, nonatomic) NSMutableArray *expanded;
@end

@implementation BrowseExercisesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UIView *colorView = [UIView new];
    colorView.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundView = colorView;
    self.tableView.alpha = 0.0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(done) name:@"finished" object:nil];
    [self performSelectorInBackground:@selector(callExercises) withObject:nil];
    
}
-(void)done
{
    [self.tableView reloadData];
    NSLog(@"Finished Loading");
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.tableView.alpha = 1.0;
                     }];
    
}
-(void)callExercises
{
    
    [[NetworkActivityTracker sharedInstance] showActivityIndicator];
    
    self.exercises = [DatabaseManager getExercises];
    [[NetworkActivityTracker sharedInstance] hideActivityIndicator];
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self done];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view DataSource/Delegate
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
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
        return self.view.frame.size.height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    ExerciseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.exerciseTitleLabel.text = [(Exercise *)[self.exercises objectAtIndex:indexPath.row] name];
    cell.exerciseTitleLabel.font = [UIFont fontWithName:@"Colaborate-Thin" size:20.0];
    cell.exerciseDifficultyLabel.text = [NSString stringWithFormat:@"%.02f",[(Exercise*)[self.exercises objectAtIndex:indexPath.row] difficulty]];
    cell.exerciseDifficultyLabel.font = [UIFont fontWithName:@"Colaborate-Thin" size:20.0];

    if([[self.expanded objectAtIndex:indexPath.row] boolValue] == YES)//if cell is expanded
    {
        cell.exerciseSummaryTextView.hidden = NO;
        cell.exerciseSummaryTextView.font = [UIFont fontWithName:@"Colaborate-Light" size:14.0];
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
    float viewWidth = self.view.frame.size.width;
    float viewHeight = self.view.frame.size.height;
    
    [UIView animateWithDuration:0.2
                          delay:0.1
                        options:0
                     animations:^{
                         self.tableView.frame = CGRectMake(0, 0, viewWidth, viewHeight);}
                     completion:nil];
}

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

@end
