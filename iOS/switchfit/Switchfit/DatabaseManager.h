//
//  DatabaseManager.h
//  Switchfit
//
//  Created by Spencer McWilliams on 8/17/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Exercise.h"
#import "Workout.h"

@interface DatabaseManager : NSObject

+(NSArray*)getExercises;
+(NSArray*)getWorkouts;
+(NSArray*)getWorkoutWithMuscles:(NSArray*)muscles;

@end
