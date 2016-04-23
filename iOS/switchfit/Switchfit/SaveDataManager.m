//
//  SaveDataManager.m
//  Switchfit
//
//  Created by Spencer McWilliams on 9/1/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import "SaveDataManager.h"

@interface SaveDataManager()
@property (nonatomic) NSMutableSet *workouts;
@property (nonatomic, strong) NSString *filePath;
@end

@implementation SaveDataManager

- (void)saveWorkout:(Workout *)workout
{
    [self.workouts addObject:workout];
    [NSKeyedArchiver archiveRootObject:self.workouts toFile:self.filePath];
}

- (void)deleteWorkout:(Workout *)workout
{
    [self.workouts removeObject:workout];
    [NSKeyedArchiver archiveRootObject:self.workouts toFile:self.filePath];
}

- (NSArray *)allSavedWorkouts
{
    if (![self.workouts allObjects]) {
        return [[NSArray alloc] init];
    }
    else{
        NSArray *array = [self.workouts allObjects];
        return array;
    }
}

- (void)deleteAllWorkouts
{
    [self.workouts removeAllObjects];
    [NSKeyedArchiver archiveRootObject:self.workouts toFile:self.filePath];
}

// FOR DEBUG ONLY
- (void)debugDelete
{
    NSMutableString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    self.filePath = [documentsDirectory stringByAppendingString:@"savedWorkouts.list"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.filePath])
        [[NSFileManager defaultManager] removeItemAtPath:self.filePath error:nil];
    documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    self.filePath = [documentsDirectory stringByAppendingString:@"userPrefs.list"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.filePath])
        [[NSFileManager defaultManager] removeItemAtPath:self.filePath error:nil];
}

- (NSMutableSet *)workouts
{
    if (!_workouts)
    {
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        self.filePath = [documentsDirectory stringByAppendingString:@"savedWorkouts.list"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:self.filePath]) {
            _workouts = [NSKeyedUnarchiver unarchiveObjectWithFile:self.filePath];
            return _workouts;
        }
        else {
            _workouts = [NSMutableSet new];
            [NSKeyedArchiver archiveRootObject:self.workouts toFile:self.filePath];
            return _workouts;
        }
    }
    else return _workouts;
}

- (NSMutableDictionary *)userPreferences
{
    if (!_userPreferences) {
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        self.filePath = [documentsDirectory stringByAppendingString:@"userPrefs.list"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:self.filePath]) {
            _userPreferences = [NSKeyedUnarchiver unarchiveObjectWithFile:self.filePath];
            return _userPreferences;
        }
        else {
            _userPreferences = [NSMutableDictionary new];
            [_userPreferences setObject:[NSNumber numberWithBool:YES] forKey:@"Intro Animation"];
            [_userPreferences setObject:[NSNumber numberWithBool:YES] forKey:@"Help Wand"];
            [NSKeyedArchiver archiveRootObject:_userPreferences toFile:self.filePath];
            return _userPreferences;
        }
    }
    else return _userPreferences;
}

- (void)saveUserPreferences:(NSMutableDictionary *)userPreferences
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    self.filePath = [documentsDirectory stringByAppendingString:@"userPrefs.list"];
    [NSKeyedArchiver archiveRootObject:userPreferences toFile:self.filePath];
}

+ (SaveDataManager *)sharedInstance
{
    static SaveDataManager *sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SaveDataManager alloc] init];
    });
    return sharedInstance;
}

@end
