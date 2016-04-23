//
//  SettingsNavigationController.m
//  Switchfit
//
//  Created by Spencer McWilliams on 8/18/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import "NavigationController.h"
#import "HomeViewController.h"

@interface NavigationController ()
@end

@implementation NavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationBar setTranslucent:NO];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationBar.barTintColor = [UIColor colorWithRed:0.9 green:0 blue:0 alpha:1];
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIButton *switchfitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, self.navigationBar.frame.size.height)];
    switchfitButton.center = CGPointMake(self.view.frame.size.width/2, self.navigationBar.frame.size.height/2);
    
    UILabel *switchfitLogo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.navigationBar.frame.size.height)];
    switchfitLogo.attributedText = [[NSAttributedString alloc] initWithString:@"switchfit."];
    
    NSMutableAttributedString *switchfitText = [[NSMutableAttributedString alloc] initWithAttributedString:switchfitLogo.attributedText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init] ;
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [switchfitText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,10)];
    [switchfitText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 10)];
    [switchfitText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Museo-700" size:30.0] range:NSMakeRange(0, 6)];
    [switchfitText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Museo-300" size:30.0] range:NSMakeRange(6, 4)];
    switchfitLogo.attributedText = switchfitText;
    
    [switchfitButton addTarget:self action:@selector(homeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBar addSubview:switchfitButton];
    [self.navigationBar addSubview:switchfitLogo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)homeButtonPressed:(UIButton *)button
{
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    redView.backgroundColor = [UIColor colorWithRed:0.9 green:0 blue:0 alpha:1];
    [self.view addSubview:redView];
    
    [UIView animateWithDuration:0.5 animations:^{
        redView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];

    [self performSelector:@selector(segueHome:) withObject:button afterDelay:0.5];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{ }

- (void) segueHome:(UIButton *)button
{
    [self performSegueWithIdentifier:@"homeSegue" sender:button];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
