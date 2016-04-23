//
//  BrowseWorkoutsViewController.m
//  Switchfit
//
//  Created by Brendan Mcmahon on 8/20/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import "BrowseSelectionViewController.h"

@interface BrowseSelectionViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *choicesTableView;
@property (strong, nonatomic) NSArray *options;
@property (strong, nonatomic) IBOutlet UIView *ChoicesView;



@end

@implementation BrowseSelectionViewController


- (void)viewDidLoad
{
    self.options = @[@"Browse Exercises",@"Browse Workouts",@"Browse Saved Workouts"];
    self.choicesTableView.delegate = self;
    self.choicesTableView.dataSource = self;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.options count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([self.options[indexPath.row]  isEqual: @"Browse Exercises"])
    {
        [self performSegueWithIdentifier:@"viewExercises" sender:self];
    }
    if([self.options[indexPath.row]  isEqual: @"Browse Workouts"])
    {
//        [self performSegueWithIdentifier:@"viewWorkouts" sender:self];
    }
    if([self.options[indexPath.row] isEqual: @"Browse Saved Workouts"])
    {
        [self performSegueWithIdentifier:@"viewSavedWorkouts" sender:self];
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    BrowseWorkoutsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.optionLabel.font = [UIFont fontWithName:@"Lane-Narrow" size:20.0];
    cell.optionLabel.textColor = [UIColor blackColor];
    cell.optionLabel.text = self.options[indexPath.row];
 
    return cell;
}

@end
