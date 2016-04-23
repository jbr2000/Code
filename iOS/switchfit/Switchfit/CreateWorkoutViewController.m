//
//  CreateWorkoutViewController.m
//  Switchfit
//
//  Created by Spencer McWilliams on 8/24/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import "CreateWorkoutViewController.h"
#import "MuscleGroupCollectionViewCell.h"
#import "PresentWorkoutViewController.h"
#import "DatabaseManager.h"
#import "SaveDataManager.h"
#import "NetworkActivityIndicator.h"

@interface CreateWorkoutViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *selectedMuscleGroups;
@property (strong, nonatomic) NSArray *availableMuscleGroups;
@property (strong, nonatomic) NSMutableArray *workout;
@property (strong, atomic) UIButton *continueButton;
@property (strong, atomic) UISlider *exerciseCountSlider;
@property (strong, atomic) UILabel *exerciseCountLabel;

@end

@implementation CreateWorkoutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    float viewWidth = self.view.frame.size.width;
    float viewHeight = self.view.frame.size.height;
    
    
    NSMutableDictionary *userPreferences = [[SaveDataManager sharedInstance] userPreferences];
    
    //self.collectionView setup
    [self.collectionView setFrame:CGRectMake(20, 10, viewWidth - 40, viewHeight - 150)];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundView = [UIView new];
    self.selectedMuscleGroups = [NSMutableArray new];
    UIView *colorView = [UIView new];
    colorView.backgroundColor = [UIColor whiteColor];
    
    //self.collectionView layout
    [self.collectionView.backgroundView removeFromSuperview];
    self.collectionView.backgroundView = colorView;
    
    //self.continueButton layout
    self.continueButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [self.continueButton setCenter:CGPointMake(viewWidth/2, viewHeight - 120)];
    [self.continueButton setImage:[UIImage imageNamed:@"right_arrow.png"] forState:UIControlStateNormal];
    [self.continueButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.continueButton addTarget:self action:@selector(continuePressed:) forControlEvents:UIControlEventTouchUpInside];
    self.continueButton.titleLabel.font = [UIFont fontWithName:@"Colaborate-Thin" size:25.0];
    [self.view addSubview:self.continueButton];
    
    //self.exerciseCountSlider setup
    self.exerciseCountSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, viewWidth - 60, 44)];
    [self.exerciseCountSlider setCenter:CGPointMake(viewWidth/2, self.continueButton.center.y - 55)];
    [self.exerciseCountSlider setTintColor:[UIColor redColor]];
    [self.exerciseCountSlider addTarget:self action:@selector(sliderStateChanged:) forControlEvents:UIControlEventValueChanged];
    [self.exerciseCountSlider setMinimumValue:3.0];
    [self.exerciseCountSlider setMaximumValue:10.0];
    [self.view addSubview:self.exerciseCountSlider];
    
    //self.exerciseCountLabel setup
    self.exerciseCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
    [self.exerciseCountLabel setCenter:CGPointMake(viewWidth - 40, self.continueButton.center.y)];
    self.exerciseCountLabel.font = [UIFont fontWithName:@"Colaborate-Thin" size:25.0];
    self.exerciseCountLabel.text = [NSString stringWithFormat:@"%0.0f", [self.exerciseCountSlider value]];
    [self.view addSubview:self.exerciseCountLabel];
    
    
    //initalize array holding ALL muscle groups
    self.availableMuscleGroups = @[@"chest",@"upper back",@"core",@"triceps",
                                   @"shoulders",@"biceps",@"glutes",@"quads",@"calves",@"abs",
                                   @"lower back",@"hamstrings",@"forearms",@"cardio",@"flexibility",@"obliques"];
    
    //user aid
    if ([[userPreferences objectForKey:@"Help Wand"] boolValue]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            UIImage *wand = [UIImage new];
            wand = [UIImage imageNamed:@"magic_wand.png"];
            UIImageView *wandView = [[UIImageView alloc] initWithImage:wand];
            [wandView setFrame:CGRectMake(self.view.frame.size.width - 80, 200, 60, 60)];
            wandView.alpha = 0.0;
            [self.view addSubview:wandView];
            
            [UIView animateKeyframesWithDuration:2.0
                                           delay:0.7
                                         options:0
                                      animations:^{
                                          [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.1 animations:^{
                                              wandView.alpha = 1.0;
                                          }];
                                          [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.2 animations:^{
                                              wandView.transform = CGAffineTransformMakeScale(0.65, 0.70);
                                          }];
                                          [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.6 animations:^{
                                              [wandView setFrame:CGRectMake(wandView.frame.origin.x,
                                                                            wandView.frame.origin.y-150,
                                                                            wandView.frame.size.width*0.65,
                                                                            wandView.frame.size.height*0.65)];
                                          }];
                                          [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
                                              wandView.transform = CGAffineTransformMakeScale(1, 1);
                                          }];
                                          [UIView addKeyframeWithRelativeStartTime:0.9 relativeDuration:0.1 animations:^{
                                              wandView.alpha = 0.0;
                                          }];
                                      }
                                      completion:nil];
            [userPreferences setObject:[NSNumber numberWithBool:NO] forKey:@"Help Wand"];
            [[SaveDataManager sharedInstance] saveUserPreferences:userPreferences];
        });
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)continuePressed:(UIButton *)button
{
    if ([self.selectedMuscleGroups count] <= 0)
    {
        UILabel *needInputLabel = [UILabel new];
        needInputLabel.frame = CGRectMake(0, 0, 250, 65);
        needInputLabel.center = CGPointMake(self.view.frame.size.width/2, self.continueButton.center.y);
        needInputLabel.font = [UIFont fontWithName:@"Colaborate-Thin" size:12.0];
        needInputLabel.textColor = [UIColor whiteColor];
        needInputLabel.backgroundColor = [UIColor blackColor];
        needInputLabel.layer.cornerRadius = 20.f;
        needInputLabel.alpha = 1.0;
        needInputLabel.textAlignment = NSTextAlignmentCenter;
        needInputLabel.text = @"Must select minimum of 1 muscle group.";
        [self.view addSubview:needInputLabel];
        [UIView animateWithDuration:1.3
                              delay:1
                            options:0
                         animations:^{needInputLabel.alpha = 0.0;}
                         completion:nil];
    }
    else
        [self performSelectorInBackground:@selector(workoutCall) withObject:nil];

}

- (void)workoutCall
{
    [[NetworkActivityTracker sharedInstance] showActivityIndicator];
    NSMutableArray *tempArray = [[DatabaseManager getWorkoutWithMuscles:self.selectedMuscleGroups] mutableCopy];
    [[NetworkActivityTracker sharedInstance] hideActivityIndicator];
    int randomNumber;
    for (int i = [tempArray count]; i > (int)floorf([self.exerciseCountSlider value]); i--) {
        randomNumber = arc4random() % [tempArray count];
        [tempArray removeObjectAtIndex:randomNumber];
    }
    self.workout = tempArray;
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"createSegue" sender:self];
    });
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PresentWorkoutViewController *newViewController = [segue destinationViewController];
    newViewController.exercises = self.workout;
}

#pragma mark-UISlder Methods

- (void)sliderStateChanged:(UISlider *)slider
{
    self.exerciseCountLabel.text = [NSString stringWithFormat:@"%d", (int)floorf([self.exerciseCountSlider value])];
}

#pragma mark-UICollectionView Delegate/DataSource Methods

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MuscleGroupCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.muscleGroupLabel.text = [self.availableMuscleGroups objectAtIndex:indexPath.row];
    cell.muscleGroupLabel.font = [UIFont fontWithName:@"Colaborate-Thin" size:20.0];
    cell.muscleGroupLabel.textColor = [UIColor blackColor];
    cell.muscleGroupLabel.textAlignment = NSTextAlignmentCenter;
    cell.muscleGroupLabel.numberOfLines = 3;
    cell.muscleGroupLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.muscleGroupLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MuscleGroupCollectionViewCell *cell = (MuscleGroupCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.isCurrentlySelected = !cell.isCurrentlySelected;
    NSString *muscleGroup = [NSString new];
    muscleGroup = cell.muscleGroupLabel.text;
    if (cell.isCurrentlySelected) {
        [self.selectedMuscleGroups addObject:muscleGroup];
    }
    else
    {
        [self.selectedMuscleGroups removeObject:muscleGroup];
    }
    if (cell.isCurrentlySelected) {
        [UIView animateWithDuration:0.3 animations:^{
            cell.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.25];}];
    }
    else
        [UIView animateWithDuration:0.3 animations:^{
            cell.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0];}];
}

- (int)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return (int)[self.availableMuscleGroups count];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // return UIEdgeInsetsMake(0,8,0,8);  // top, left, bottom, right
    return UIEdgeInsetsMake(0,0,0,0);  // top, left, bottom, right
}


@end