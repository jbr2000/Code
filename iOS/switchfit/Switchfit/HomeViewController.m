//
//  HomeViewController.m
//  Switchfit
//
//  Created by Spencer McWilliams on 8/19/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import "HomeViewController.h"
#import "BrowseExercisesViewController.h"
#import "NavigationController.h"
//used for delete
#import "SaveDataManager.h"

@interface HomeViewController ()
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
    float viewWidth = self.view.frame.size.width;
    float viewHeight = self.view.frame.size.height;
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [[SaveDataManager sharedInstance] debugDelete];
    
    NSMutableDictionary *userPreferences = [[SaveDataManager sharedInstance] userPreferences];
    
    //Switchfit Logo
    UILabel *switchfitLabel = [[UILabel alloc] initWithFrame:CGRectMake(33, viewHeight/2-39, viewWidth, 80.0)];
    switchfitLabel.attributedText = [[NSAttributedString alloc] initWithString:@"switchfit."];
    NSMutableAttributedString *switchfitString = [[NSMutableAttributedString alloc] initWithAttributedString:switchfitLabel.attributedText];
    [switchfitString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.9 green:0 blue:0 alpha:1] range:NSMakeRange(6, 4)];
    [switchfitString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Museo-700" size:60] range:NSMakeRange(0, 6)];
    [switchfitString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Museo-300" size:60] range:NSMakeRange(6, 4)];
    [switchfitLabel setAttributedText:switchfitString];
    
    // Quote Label
    UILabel *quoteLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, viewHeight/2-100, 260, 150.0)];
    quoteLabel.text = @"Don't forget leg day!";
    quoteLabel.textColor = [UIColor blackColor];
    quoteLabel.alpha = 0.0;
    quoteLabel.textAlignment = NSTextAlignmentCenter;
    quoteLabel.font = [UIFont fontWithName:@"Colaborate-Light" size:20.0];
    quoteLabel.numberOfLines = 5;
    quoteLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view addSubview:quoteLabel];
    
    // Button Creation
    UIButton *createButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [createButton setCenter:CGPointMake(viewWidth*0.25, viewHeight-110)];
    [createButton setBackgroundImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
    [createButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    createButton.alpha = 0.0;
    createButton.tag = 0;
    [self.view addSubview:createButton];
    
    UIButton *viewButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    viewButton.center = CGPointMake(viewWidth*0.5, viewHeight-110);
    [viewButton setBackgroundImage:[UIImage imageNamed:@"database.png"] forState:UIControlStateNormal];
    [viewButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    viewButton.alpha = 0.0;
    viewButton.tag = 1;
    [self.view addSubview:viewButton];
    
    UIButton *settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    settingsButton.center = CGPointMake(viewWidth*0.75, viewHeight-110);
    [settingsButton setBackgroundImage:[UIImage imageNamed:@"tools.png"] forState:UIControlStateNormal];
    [settingsButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    settingsButton.alpha = 0.0;
    settingsButton.tag = 2;
    [self.view addSubview:settingsButton];
    
    // Button/Quote fade in animation
    if ([[userPreferences objectForKey:@"Intro Animation"] boolValue]) {
        [self.view addSubview:switchfitLabel];
        [UIView animateWithDuration:1.0
                              delay:0.5
                            options:0
                         animations:^{switchfitLabel.frame = CGRectMake(33, 60, viewWidth, 80.0);}
                         completion:nil];
        [UIView animateWithDuration:0.5 delay:1.5 options:0 animations:^{
            quoteLabel.alpha = 1.0;
            createButton.alpha = 1.0;
            viewButton.alpha = 1.0;
            settingsButton.alpha = 1.0;
        }
                         completion:nil];
    }
    else
    {
        [switchfitLabel setFrame:CGRectMake(33, 60, viewWidth, 80.0)];
        [self.view addSubview:switchfitLabel];
        quoteLabel.alpha = 1.0;
        createButton.alpha = 1.0;
        viewButton.alpha = 1.0;
        settingsButton.alpha = 1.0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)buttonPressed:(UIButton *)button
{
    switch (button.tag) {
        case 0:
            [self performSegueWithIdentifier:@"createSegue" sender:button];
            break;
        case 1:
            [self performSegueWithIdentifier:@"viewSegue" sender:button];
            break;
        case 2:
            [self performSegueWithIdentifier:@"settingsSegue" sender:button];
            break;
        default:
            NSLog(@"Error\n");
            break;
    }
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

@end
