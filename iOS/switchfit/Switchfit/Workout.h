//
//  Workout.h
//  Switchfit
//
//  Created by Brendan Mcmahon on 8/20/14.
//  Copyright (c) 2014 Spencer McWilliams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Workout : NSObject

@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *creator;
@property (nonatomic,strong) NSString *timestamp;
@property (nonatomic,strong) NSString *summary;
@property (nonatomic,strong) NSString *tags;
@property (nonatomic,strong) NSArray  *exercises;
@property int likes;
@property int comments;
@property int num;

-(id)initWorkoutWithDictionary:(NSDictionary*)workoutAttributes;

@end
