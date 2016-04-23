//
//  SettingsViewController.m
//  Switchfit
//
//  Created by Spencer McWilliams on 9/5/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import "SettingsViewController.h"
#import "SaveDataManager.h"
#import "SettingsTableViewCell.h"

@interface SettingsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableDictionary *userPreferences;
@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.userPreferences = [[SaveDataManager sharedInstance] userPreferences];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UISwitch *settingSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 51, 31)];
    [settingSwitch setCenter:CGPointMake(self.view.frame.size.width - 30, cell.frame.size.height/2)];
    [settingSwitch setTintColor:[UIColor redColor]];
    [settingSwitch setOn:[[[self.userPreferences allValues] objectAtIndex:indexPath.row] boolValue] animated:NO];
    [settingSwitch addTarget:self action:@selector(settingChanged:) forControlEvents:UIControlEventTouchUpInside];
    [settingSwitch setTag:indexPath.row];
    [cell addSubview:settingSwitch];
    
    UILabel *settingLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, cell.frame.size.width - 75 , 30)];
    [settingLabel setText:[NSString stringWithFormat:@"%@", [[self.userPreferences allKeys] objectAtIndex:indexPath.row]]];
    [settingLabel setFont:[UIFont fontWithName:@"Lane-Narrow" size:20.0]];
    [cell addSubview:settingLabel];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.userPreferences count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (void)settingChanged:(UISlider *)slider
{
    [self.userPreferences setObject:[NSNumber numberWithBool:![[[self.userPreferences allValues] objectAtIndex:slider.tag] boolValue]] forKey:[[self.userPreferences allKeys] objectAtIndex:slider.tag]];
    [[SaveDataManager sharedInstance] saveUserPreferences:self.userPreferences];
}

@end
