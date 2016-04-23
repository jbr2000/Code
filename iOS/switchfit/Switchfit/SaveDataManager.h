//
//  SaveDataManager.h
//  Switchfit
//
//  Created by Spencer McWilliams on 9/1/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"

@interface SaveDataManager : UICollectionViewCell
+ (SaveDataManager *)sharedInstance;
- (NSArray *)allSavedWorkouts;
- (void)deleteAllWorkouts;
- (void)deleteWorkout:(Workout *)workout;
- (void)saveWorkout:(Workout *)workout;
- (void)saveUserPreferences:(NSMutableDictionary *)userPreferences;
// DEBUG only
- (void)debugDelete;
@property (strong, nonatomic) NSMutableDictionary *userPreferences;
@end
