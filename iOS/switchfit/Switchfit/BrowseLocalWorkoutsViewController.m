//
//  WorkoutViewController.m
//  Switchfit
//
//  Created by Brendan Mcmahon on 8/20/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import "BrowseLocalWorkoutsViewController.h"
#import "SaveDataManager.h"

@interface BrowseLocalWorkoutsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *workouts;

@end

@implementation BrowseLocalWorkoutsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.workouts = [[SaveDataManager sharedInstance] allSavedWorkouts];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self noWorkouts];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [[SaveDataManager sharedInstance] deleteWorkout:[self.workouts objectAtIndex:indexPath.row]];
        NSMutableArray *tempArr = [self.workouts mutableCopy];
        [tempArr removeObjectAtIndex:indexPath.row];
        self.workouts = [tempArr copy];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
        [self noWorkouts];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.workouts count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    WorkoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.workoutNameLabel.font = [UIFont fontWithName:@"Lane-Narrow" size:20.0];
    cell.workoutNameLabel.textColor = [UIColor blackColor];
    cell.workoutNameLabel.text = [self.workouts[indexPath.row] name];
    
    cell.workoutSummaryLabel.frame = CGRectMake(10, 38, cell.frame.size.width-10, cell.frame.size.height-76);
    cell.workoutSummaryLabel.text = [self.workouts[indexPath.row] summary];
    cell.workoutSummaryLabel.font = [UIFont fontWithName:@"Colaborate-Light" size:12.0];;
    cell.workoutSummaryLabel.textColor = [UIColor blackColor];
    
    cell.creatorNameLabel.font = [UIFont fontWithName:@"Colaborae-Thin" size:12.0];
    cell.creatorNameLabel.textColor = [UIColor blackColor];
    cell.creatorNameLabel.text = [NSString stringWithFormat:@"created by %@ @",[self.workouts[indexPath.row] creator]];
    
    cell.workoutLikesLabel.font = [UIFont fontWithName:@"Museo-300" size:12.0];
    cell.workoutLikesLabel.text = [NSString stringWithFormat:@"%i",(int)[self.workouts[indexPath.row] likes]];
    cell.workoutLikesLabel.textColor = [UIColor blackColor];
    cell.workoutCommentsLabel.textColor = [UIColor blackColor];
    cell.workoutCommentsLabel.font = [UIFont fontWithName:@"Museo-300" size:12.0];
    cell.workoutCommentsLabel.textColor = [UIColor blackColor];
    cell.workoutCommentsLabel.text = [NSString stringWithFormat:@"%i",(int)[self.workouts[indexPath.row] comments]];
    
    cell.workoutTagLabel.font = [UIFont fontWithName:@"Colaborate-Light" size:12.0];
    cell.workoutTagLabel.textColor = [UIColor blackColor];
    cell.workoutTagLabel.text = [self.workouts[indexPath.row] tags];
    
    return cell;
}
-(void)noWorkouts
{
    if([self.workouts count] == 0)
    {
        
        UILabel *noWorkouts = [[UILabel alloc] initWithFrame:CGRectMake(0,0,200,30)];
        noWorkouts.text = @"No workouts saved.";
        noWorkouts.center = CGPointMake(self.view.frame.size.width/2, 30);
        noWorkouts.font = [UIFont fontWithName:@"Lane-Narrow" size:21];
        noWorkouts.textColor = [UIColor blackColor];
        [self.view addSubview:noWorkouts];
        
    }
}
@end
